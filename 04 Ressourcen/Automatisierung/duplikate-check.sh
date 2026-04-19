#!/usr/bin/env bash
# duplikate-check.sh — Duplikat-Prüfung per md5-Vergleich
#
# Generisches Werkzeug zur systematischen Duplikat-Sichtung: sortiert einen
# "verdächtigen" Ordner (Dateien mit Mustern wie " 2", " (3)" im Namen) nach
# md5-Vergleich gegen einen oder mehrere Original-Ordner in drei Kategorien.
#
# Usage:
#   duplikate-check.sh [OPTIONS] <duplikat-ordner> <original-ordner> [<weitere-ordner> ...]
#
# Options:
#   --output <pfad>   Zielpfad für Markdown-Report (Default: aktuelles Arbeitsverzeichnis)
#   --verbose, -v     Detaillierte Ausgabe pro Datei während der Verarbeitung
#   --help, -h        Diese Hilfe anzeigen
#
# Beispiele:
#   # Mac-Inventur (Ursprungsfall):
#   duplikate-check.sh ~/Mac-Inventur/04_Moegliche_Duplikate \
#     ~/Mac-Inventur/05_Projekt_Material
#
#   # Downloads-Ordner gegen mehrere Archive prüfen:
#   duplikate-check.sh --output ~/Desktop --verbose \
#     ~/Downloads/mogliche_dubletten ~/Archiv/2024 ~/Archiv/2025
#
#   # WEC-Rollout (Reiners PC):
#   duplikate-check.sh --output ~/WEC-Inventur \
#     ~/WEC-Inventur/04_Moegliche_Duplikate \
#     ~/WEC-Inventur/05_Projekt_Material \
#     "/Volumes/WEC-Spiegel/Projekte"
#
# Vorgehen:
# - Für jede Datei in <duplikat-ordner> den Original-Namen ableiten durch
#   Entfernen von " (N)" oder " N" (N = 1–3 Stellen) vor der Extension
# - Original in den <original-ordner>n rekursiv case-insensitive suchen
# - Bei Fund: md5-Vergleich Byte-genau
# - Einsortieren in Unterordner _identisch/ | _unterschied/ | _kein_original/
# - Markdown-Report mit Tabelle + Zusammenfassung schreiben
#
# Abhängigkeiten: bash 3.2+, BSD find, md5 (macOS). Keine assoziativen Arrays.
# Portierung auf Linux: md5 → md5sum, Argument-Reihenfolge anpassen.
# Portierung auf Windows (PowerShell): siehe Skill-Notiz.

set -u

OUTPUT_DIR=""
VERBOSE=0

print_help() {
  sed -n '2,31p' "$0" | sed 's/^# \{0,1\}//'
}

# Options parsen
while [ $# -gt 0 ]; do
  case "$1" in
    --output)
      [ $# -lt 2 ] && { echo "--output braucht Pfad" >&2; exit 1; }
      OUTPUT_DIR="${2%/}"
      shift 2
      ;;
    --verbose|-v)
      VERBOSE=1
      shift
      ;;
    --help|-h)
      print_help
      exit 0
      ;;
    --) shift; break ;;
    -*)
      echo "Unbekannte Option: $1" >&2
      exit 1
      ;;
    *) break ;;
  esac
done

if [ $# -lt 2 ]; then
  echo "Usage: $0 [--output <pfad>] [--verbose] <duplikat-ordner> <original-ordner> [<weitere-ordner> ...]" >&2
  exit 1
fi

DUP_DIR="${1%/}"
shift
ORIG_DIRS=("$@")

[ -d "$DUP_DIR" ] || { echo "Duplikat-Ordner existiert nicht: $DUP_DIR" >&2; exit 1; }
for d in "${ORIG_DIRS[@]}"; do
  [ -d "$d" ] || { echo "Original-Ordner existiert nicht: $d" >&2; exit 1; }
done

# Report-Zielpfad: --output wenn gesetzt, sonst aktuelles Arbeitsverzeichnis
if [ -n "$OUTPUT_DIR" ]; then
  [ -d "$OUTPUT_DIR" ] || { echo "Output-Pfad existiert nicht: $OUTPUT_DIR" >&2; exit 1; }
  REPORT_DIR="$OUTPUT_DIR"
else
  REPORT_DIR="$PWD"
fi

mkdir -p "$DUP_DIR/_identisch" "$DUP_DIR/_unterschied" "$DUP_DIR/_kein_original"

REPORT="$REPORT_DIR/Duplikate_Report_$(date +%Y-%m-%d).md"

{
  echo "---"
  echo "tags: [inventur, referenz, duplikate]"
  echo "date: $(date +%Y-%m-%d)"
  echo "---"
  echo
  echo "# Duplikate-Report — $(date +%Y-%m-%d)"
  echo
  echo "Duplikat-Ordner: \`$DUP_DIR\`  "
  echo "Durchsuchte Original-Ordner:"
  for d in "${ORIG_DIRS[@]}"; do echo "- \`$d\`"; done
  echo
  echo "## Ergebnis"
  echo
  echo "| Dateiname | Original-Pfad | md5-Match | Entscheidung |"
  echo "|---|---|---|---|"
} > "$REPORT"

count_ident=0
count_diff=0
count_none=0

log() { [ "$VERBOSE" -eq 1 ] && echo "$@"; }

# Ableiten des Original-Namens
derive_original() {
  local full="$1"
  local name ext
  if [[ "$full" == *.* ]]; then
    ext=".${full##*.}"
    name="${full%.*}"
  else
    ext=""
    name="$full"
  fi
  # " (N)" am Ende entfernen
  local stripped
  stripped=$(printf '%s' "$name" | sed -E 's/ \([0-9]{1,3}\)$//')
  # " N" am Ende entfernen (nur falls nicht schon (N) griff)
  stripped=$(printf '%s' "$stripped" | sed -E 's/ [0-9]{1,3}$//')
  printf '%s%s' "$stripped" "$ext"
}

cd "$DUP_DIR" || exit 1

for f in *; do
  [ -f "$f" ] || continue
  case "$f" in _identisch|_unterschied|_kein_original) continue ;; esac

  orig_name=$(derive_original "$f")
  log "Prüfe: $f → Original-Kandidat: $orig_name"

  found=""
  if [ "$orig_name" != "$f" ]; then
    for d in "${ORIG_DIRS[@]}"; do
      cand=$(find "$d" -type f -iname "$orig_name" -print 2>/dev/null | head -n 1)
      if [ -n "$cand" ]; then
        found="$cand"
        break
      fi
    done
  fi

  if [ -z "$found" ]; then
    mv "$f" "_kein_original/"
    printf '| `%s` | — | kein Original | _kein_original/ |\n' "$f" >> "$REPORT"
    count_none=$((count_none + 1))
    log "  → kein Original"
  else
    dup_md5=$(md5 -q "$f")
    orig_md5=$(md5 -q "$found")
    if [ "$dup_md5" = "$orig_md5" ]; then
      mv "$f" "_identisch/"
      printf '| `%s` | `%s` | ✓ identisch | _identisch/ |\n' "$f" "$found" >> "$REPORT"
      count_ident=$((count_ident + 1))
      log "  → identisch ($dup_md5)"
    else
      mv "$f" "_unterschied/"
      printf '| `%s` | `%s` | ✗ anders | _unterschied/ |\n' "$f" "$found" >> "$REPORT"
      count_diff=$((count_diff + 1))
      log "  → anders (dup=$dup_md5 vs orig=$orig_md5)"
    fi
  fi
done

{
  echo
  echo "## Zusammenfassung"
  echo
  echo "- Identisch (sicher löschbar): **$count_ident**"
  echo "- Unterschied (manuelle Prüfung): **$count_diff**"
  echo "- Kein Original gefunden: **$count_none**"
  echo "- **Gesamt: $((count_ident + count_diff + count_none))**"
} >> "$REPORT"

echo "Report:      $REPORT"
echo "Identisch:   $count_ident"
echo "Unterschied: $count_diff"
echo "Kein Orig.:  $count_none"

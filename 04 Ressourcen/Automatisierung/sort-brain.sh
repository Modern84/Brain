#!/bin/bash
# sort-brain — Verschiebt Dateien von Desktop & Downloads ins Gehirn
#
# Regel: Alles landet im Eingang. Kontextualisierung (Kunde? Projekt? Bereich?)
# passiert später im Chat mit Claude — nicht automatisch nach Dateityp.
# Eine STEP-Datei von Bens gehört zu Bens, nicht in einen generischen CAD-Ordner.
#
# Aufruf:
#   sort-brain              → verschiebt alles
#   sort-brain --preview    → zeigt nur was verschoben würde, ohne es zu tun

BRAIN="/Users/sh/Brain"
EINGANG="$BRAIN/01 Inbox/_Eingang Dateien"
SCREENSHOTS="$BRAIN/07 Anhänge/Screenshots"
QUELLEN=("$HOME/Desktop" "$HOME/Downloads")
PREVIEW=${1:-""}
HEUTE=$(date +%Y-%m-%d)
MOVED=0
SKIPPED=0

mkdir -p "$EINGANG"
mkdir -p "$SCREENSHOTS"

for QUELLE in "${QUELLEN[@]}"; do
  [[ -d "$QUELLE" ]] || continue

  while IFS= read -r -d '' DATEI; do
    NAME=$(basename "$DATEI")
    # Versteckte Dateien (.DS_Store etc.) überspringen
    [[ "$NAME" == .* ]] && continue
    # Nur Dateien, keine Ordner
    [[ -f "$DATEI" ]] || continue

    # Screenshots → eigener Ordner (Muster: "Bildschirmfoto ..." oder "Screenshot ...")
    if [[ "$NAME" =~ ^(Bildschirmfoto|Screenshot) ]]; then
      ZIEL="$SCREENSHOTS/$NAME"
      LABEL="Screenshots"
    else
      # Alles andere → Eingang, mit Datumspräfix für Rückverfolgbarkeit
      ZIEL="$EINGANG/${HEUTE} — $NAME"
      LABEL="Eingang"
    fi

    if [[ "$PREVIEW" == "--preview" ]]; then
      echo "📁 $NAME  →  $LABEL"
    else
      if mv "$DATEI" "$ZIEL" 2>/dev/null; then
        echo "✅ $NAME  →  $LABEL"
        ((MOVED++))
      else
        echo "⚠️  $NAME  →  konnte nicht verschoben werden"
        ((SKIPPED++))
      fi
    fi
  done < <(find "$QUELLE" -maxdepth 1 -print0)
done

if [[ "$PREVIEW" != "--preview" ]]; then
  echo ""
  echo "Fertig: $MOVED Dateien verschoben, $SKIPPED Fehler."
  echo "Nächster Schritt: Im Chat sagen welche Dateien wohin gehören."
fi

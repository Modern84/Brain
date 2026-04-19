#!/bin/bash
# brain-lint.sh — Kopfdaten/Tag/Link-Check für Gehirn
# Nutzung: aus Vault-Root ausführen

set -e
cd "$(dirname "$0")/../.."

echo "🔍 Brain-Lint Report — $(date +%Y-%m-%d)"
echo "========================================"
echo ""

# 1. Dateien ohne Kopfdaten
echo "▸ Dateien ohne YAML-Kopfdaten (ignoriert: 07 Anhänge, 06 Archiv, Clippings):"
count=0
while IFS= read -r f; do
  first_line=$(head -1 "$f" 2>/dev/null)
  if [ "$first_line" != "---" ]; then
    echo "  ✗ $f"
    count=$((count + 1))
  fi
done < <(find . -type f -name "*.md" \
  -not -path "./07 Anhänge/*" \
  -not -path "./06 Archiv/*" \
  -not -path "./Clippings/*" \
  -not -path "./.obsidian/*" \
  -not -path "./.trash/*" 2>/dev/null)
echo "  → $count Dateien ohne Kopfdaten"
echo ""

# 2. Tag-Inkonsistenzen (bekannte Fehler)
echo "▸ Bekannte Tag-Fehler:"
for bad_tag in "daily-note" "kunde|norm|standard|bwl"; do
  hits=$(grep -rl "tags:.*$bad_tag" --include="*.md" . 2>/dev/null | wc -l | xargs)
  if [ "$hits" -gt 0 ]; then
    echo "  ✗ '$bad_tag' noch in $hits Datei(en) — sollte behoben werden"
    grep -rl "tags:.*$bad_tag" --include="*.md" . 2>/dev/null | sed 's/^/    /'
  fi
done
echo ""

# 3. Broken Wikilinks (Ziel existiert nicht)
echo "▸ Broken Wikilinks (Stichprobe, erste 20):"
broken=0
while IFS= read -r f; do
  # Extrahiere [[target]] oder [[target|alias]], nimm nur target
  while IFS= read -r link; do
    # Kein Datei-Check wenn Link Anker (#) oder Block (^) enthält — vereinfachte Prüfung
    target="${link%%|*}"
    target="${target%%#*}"
    target="${target%%^*}"
    # Prüfe ob target.md oder target/ existiert (Obsidian matched auf Basename)
    if [ -n "$target" ]; then
      base=$(basename "$target")
      match=$(find . -type f \( -name "$base.md" -o -name "$base" \) \
        -not -path "./.obsidian/*" 2>/dev/null | head -1)
      if [ -z "$match" ]; then
        echo "  ✗ [[$link]] in $f"
        broken=$((broken + 1))
        [ "$broken" -ge 20 ] && break 2
      fi
    fi
  done < <(grep -oE '\[\[[^]]+\]\]' "$f" 2>/dev/null | sed 's/\[\[//;s/\]\]//')
done < <(find . -type f -name "*.md" \
  -not -path "./07 Anhänge/*" \
  -not -path "./.obsidian/*" \
  -not -path "./.trash/*" 2>/dev/null | head -50)
echo "  → $broken broken Links gefunden (Stichprobe)"
echo ""

# 4. Leere Dateien
echo "▸ Leere oder fast leere Dateien (< 100 Bytes):"
find . -type f -name "*.md" -size -100c \
  -not -path "./.obsidian/*" 2>/dev/null | sed 's/^/  /'
echo ""

echo "========================================"
echo "✅ Lint fertig."

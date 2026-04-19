#!/bin/bash
# brain-stats.sh — Schnelle Übersicht über Vault-Inhalt
# Nutzung: aus Vault-Root ausführen

cd "$(dirname "$0")/../.."

echo "📊 Brain-Stats — $(date +%Y-%m-%d)"
echo "===================================="
echo ""

# 1. Dateien pro Top-Level
echo "▸ Markdown-Dateien pro Bereich:"
for dir in "00 Kontext" "01 Inbox" "02 Projekte" "03 Bereiche" "04 Ressourcen" "05 Daily Notes" "06 Archiv" "Clippings"; do
  if [ -d "$dir" ]; then
    count=$(find "$dir" -type f -name "*.md" 2>/dev/null | wc -l | xargs)
    printf "  %-20s %4d\n" "$dir" "$count"
  fi
done
echo ""

# 2. Projekte nach Status
echo "▸ Projekte nach Status (02 Projekte/, nur Top-Level):"
declare -A status_count
for f in "02 Projekte"/*.md; do
  [ -f "$f" ] || continue
  st=$(grep -m1 "^status:" "$f" 2>/dev/null | cut -d: -f2 | xargs)
  [ -z "$st" ] && st="(kein)"
  status_count[$st]=$((${status_count[$st]:-0} + 1))
done
for key in "${!status_count[@]}"; do
  printf "  %-15s %d\n" "$key" "${status_count[$key]}"
done
echo ""

# 3. Daily Notes — letzte 7 Tage
echo "▸ Daily Notes — letzte 7 Tage:"
for i in 0 1 2 3 4 5 6; do
  d=$(date -v-${i}d +%Y-%m-%d 2>/dev/null || date -d "$i days ago" +%Y-%m-%d)
  if [ -f "05 Daily Notes/$d.md" ]; then
    printf "  %s ✅\n" "$d"
  else
    printf "  %s ✗ fehlt\n" "$d"
  fi
done
echo ""

# 4. Eingang-Alter (älteste Inbox-Datei)
echo "▸ 01 Inbox — älteste Notiz:"
oldest=$(find "01 Inbox" -type f -name "*.md" -not -name ".obsidian*" 2>/dev/null | \
  xargs stat -f "%Sm %N" -t "%Y-%m-%d" 2>/dev/null | sort | head -1)
[ -n "$oldest" ] && echo "  $oldest" || echo "  (leer)"
echo ""

# 5. WEC raw-Wachstum
if [ -d "03 Bereiche/WEC/raw" ]; then
  echo "▸ WEC raw/ — Dateimenge:"
  raw_count=$(find "03 Bereiche/WEC/raw" -type f 2>/dev/null | wc -l | xargs)
  raw_size=$(du -sh "03 Bereiche/WEC/raw" 2>/dev/null | cut -f1)
  echo "  $raw_count Dateien, $raw_size"
fi
echo ""

# 6. Anhänge-Größe
if [ -d "07 Anhänge" ]; then
  echo "▸ 07 Anhänge — Größe:"
  du -sh "07 Anhänge" 2>/dev/null | sed 's/^/  /'
fi

echo ""
echo "===================================="

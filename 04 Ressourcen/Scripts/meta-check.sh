#!/bin/bash
# meta-check.sh — Interaktive Meta-Retro für Sebastian
# Nutzung: aus Vault-Root ausführen

cd "$(dirname "$0")/../.."

today=$(date +%Y-%m-%d)
target="00 Kontext/Meta/Retro $today.md"

if [ -f "$target" ]; then
  echo "ℹ️  Retro für $today existiert schon: $target"
  open "obsidian://open?file=Retro $today" 2>/dev/null
  exit 0
fi

echo "🔄 Meta-Check für $today"
echo "=========================="
echo ""
echo "Ich lege jetzt eine neue Retro-Datei an und fülle zur Hilfe automatische Felder."
echo ""

# Automatische Felder ziehen
echo "▸ Brain-Stats-Auszug..."
inbox_count=$(find "01 Inbox" -type f -name "*.md" 2>/dev/null | wc -l | xargs)
daily_latest=$(ls -1 "05 Daily Notes"/*.md 2>/dev/null | tail -1 | xargs basename 2>/dev/null)
daily_today=$([ -f "05 Daily Notes/$today.md" ] && echo "✅" || echo "❌")

# Template kopieren und ausfüllen
cp "00 Kontext/Meta/Retrospektive-Template.md" "$target"

# Datum in Kopfdaten anpassen
if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i "" "s/date: 2026-04-19/date: $today/" "$target"
  sed -i "" "s/# Retrospektive — Vorlage/# Retrospektive $today/" "$target"
else
  sed -i "s/date: 2026-04-19/date: $today/" "$target"
  sed -i "s/# Retrospektive — Vorlage/# Retrospektive $today/" "$target"
fi

# Automatische Zahlen in Abschnitt 5 einfügen
cat >> "$target" <<EOF

---

## Automatische Zahlen (gezogen $today)

- Inbox-Dateien: $inbox_count
- Neueste Daily Note: $daily_latest
- Heutige Daily Note vorhanden: $daily_today
EOF

echo "✅ Retro angelegt: $target"
echo ""
echo "Öffne in Obsidian zum Ausfüllen..."
open "obsidian://open?file=Retro $today" 2>/dev/null

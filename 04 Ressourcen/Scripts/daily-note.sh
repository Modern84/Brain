#!/bin/bash
# daily-note.sh — Heutige Daily Note anlegen (nur wenn nicht existiert)
# Nutzung: aus Vault-Root ausführen

cd "$(dirname "$0")/../.."

today=$(date +%Y-%m-%d)
file="05 Daily Notes/$today.md"

if [ -f "$file" ]; then
  echo "ℹ️  Daily Note für $today existiert bereits: $file"
  # In Obsidian öffnen (macOS)
  open "obsidian://open?file=$today" 2>/dev/null
  exit 0
fi

cat > "$file" <<EOF
---
tags: [tagesbuch]
date: $today
---

# $today

## Was heute

-

## Erkenntnisse / Lessons Learned

-

## Offen / Morgen

-

## Verknüpfungen

-
EOF

echo "✅ Daily Note angelegt: $file"
open "obsidian://open?file=$today" 2>/dev/null

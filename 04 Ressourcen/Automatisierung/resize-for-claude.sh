#!/bin/bash
# resize-for-claude.sh
# Verkleinert Bilder auf max. 1920px bevor sie an Claude gesendet werden.
# Verhindert den "Request too large (max 20MB)" Fehler.
#
# USAGE:
#   resize-for-claude          → alle Bildschirmfotos auf dem Desktop
#   resize-for-claude bild.png → einzelne Datei
#   resize-for-claude ~/Pfad/zur/datei.png → beliebige Datei

TARGET_SIZE=1920

if [ -z "$1" ]; then
  # Kein Argument → alle Bildschirmfotos auf dem Desktop
  FILES=$(ls ~/Desktop/Bildschirmfoto*.png 2>/dev/null)
  if [ -z "$FILES" ]; then
    echo "Keine Bildschirmfotos auf dem Desktop gefunden."
    exit 1
  fi
  COUNT=$(echo "$FILES" | wc -l | tr -d ' ')
  echo "🔄 Resize $COUNT Screenshot(s) auf max. ${TARGET_SIZE}px..."
  sips -Z $TARGET_SIZE ~/Desktop/Bildschirmfoto*.png
  echo "✅ Fertig. Alle Bildschirmfotos bereit für Claude."
else
  # Argument = bestimmte Datei oder Muster
  if [ ! -f "$1" ]; then
    echo "❌ Datei nicht gefunden: $1"
    exit 1
  fi
  BEFORE=$(du -sh "$1" | cut -f1)
  sips -Z $TARGET_SIZE "$1"
  AFTER=$(du -sh "$1" | cut -f1)
  echo "✅ $1 — vorher: $BEFORE → nachher: $AFTER"
fi

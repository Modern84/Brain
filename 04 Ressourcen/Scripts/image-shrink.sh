#!/bin/bash
# image-shrink.sh — Desktop-Screenshots auf 1920px verkleinern (für Claude-Upload)
# Nutzung: ./image-shrink.sh              → alle Bildschirmfoto-PNGs auf Desktop
#          ./image-shrink.sh datei.png    → gezielte Datei
#          ./image-shrink.sh *.png        → Wildcard

max_size=1920

shrink() {
  local f="$1"
  if [ ! -f "$f" ]; then
    echo "  ✗ $f (nicht gefunden)"
    return
  fi
  size_before=$(stat -f%z "$f" 2>/dev/null || stat -c%s "$f")
  sips -Z "$max_size" "$f" >/dev/null 2>&1
  size_after=$(stat -f%z "$f" 2>/dev/null || stat -c%s "$f")
  mb_before=$(echo "scale=2; $size_before / 1048576" | bc)
  mb_after=$(echo "scale=2; $size_after / 1048576" | bc)
  echo "  ✅ $(basename "$f"): ${mb_before}MB → ${mb_after}MB"
}

if [ $# -eq 0 ]; then
  echo "📐 Verkleinere alle Desktop-Screenshots auf max ${max_size}px..."
  shopt -s nullglob 2>/dev/null
  for f in ~/Desktop/Bildschirmfoto*.png ~/Desktop/Screenshot*.png; do
    [ -f "$f" ] && shrink "$f"
  done
else
  echo "📐 Verkleinere $# Datei(en) auf max ${max_size}px..."
  for f in "$@"; do
    shrink "$f"
  done
fi

echo "Fertig."

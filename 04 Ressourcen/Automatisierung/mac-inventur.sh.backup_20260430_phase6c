#!/bin/bash
# mac-inventur.sh — Einmalige Sichtung von Desktop & Downloads
#
# Zweck: Gewachsenen Mac aufräumen. Sortiert alles aus Desktop und Downloads
# in ~/Mac-Inventur/ vor, damit Sebastian in Ruhe durchgehen kann — Stapel
# für Stapel. Nur Screenshots gehen direkt ins Gehirn.
#
# Wichtig: Dieses Skript löscht NICHTS. Es verschiebt nur. Müll muss Sebastian
# selbst in den Papierkorb ziehen nachdem er den Stapel gesichtet hat.
#
# Hinweis: Bewusst bash-3.2-kompatibel (macOS-Default), daher keine
# assoziativen Arrays.
#
# Aufruf:
#   mac-inventur              → verschiebt alles
#   mac-inventur --preview    → zeigt Zusammenfassung ohne zu verschieben

BRAIN="/Users/sh/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain"
SCREENSHOTS="$BRAIN/07 Anhänge/Screenshots"
INVENTUR="$HOME/Mac-Inventur"
QUELLEN=("$HOME/Desktop" "$HOME/Downloads")
PREVIEW=${1:-""}
HEUTE=$(date +%Y-%m-%d_%H%M)

# Zähler (einfache Variablen, bash-3.2-kompatibel)
ZAEHLER_MUELL=0
ZAEHLER_INSTALLER=0
ZAEHLER_IPHONE=0
ZAEHLER_DUPLIKAT=0
ZAEHLER_PROJEKT=0
ZAEHLER_SCREENSHOT=0
ZAEHLER_KOLLISION=0

zaehler_plus() {
  case "$1" in
    Muell)      ZAEHLER_MUELL=$((ZAEHLER_MUELL + 1)) ;;
    Installer)  ZAEHLER_INSTALLER=$((ZAEHLER_INSTALLER + 1)) ;;
    iPhone)     ZAEHLER_IPHONE=$((ZAEHLER_IPHONE + 1)) ;;
    Duplikat)   ZAEHLER_DUPLIKAT=$((ZAEHLER_DUPLIKAT + 1)) ;;
    Projekt)    ZAEHLER_PROJEKT=$((ZAEHLER_PROJEKT + 1)) ;;
    Screenshot) ZAEHLER_SCREENSHOT=$((ZAEHLER_SCREENSHOT + 1)) ;;
    Kollision)  ZAEHLER_KOLLISION=$((ZAEHLER_KOLLISION + 1)) ;;
  esac
}

# Zielordner anlegen (außer Preview)
if [ "$PREVIEW" != "--preview" ]; then
  mkdir -p "$INVENTUR/01_Muell"
  mkdir -p "$INVENTUR/02_Installer"
  mkdir -p "$INVENTUR/03_iPhone_Fotos_Videos"
  mkdir -p "$INVENTUR/04_Moegliche_Duplikate"
  mkdir -p "$INVENTUR/05_Projekt_Material"
  mkdir -p "$INVENTUR/_Kollisionen"
  mkdir -p "$SCREENSHOTS"
fi

MANIFEST="$INVENTUR/Manifest_${HEUTE}.md"

if [ "$PREVIEW" != "--preview" ]; then
  cat > "$MANIFEST" << EOF
---
tags: [inventur, log]
date: $(date +%Y-%m-%d)
---

# Mac-Inventur — Lauf $HEUTE

Dateien aus Desktop und Downloads vorsortiert nach \`~/Mac-Inventur/\`.

EOF
fi

# Kategorisierung einer Datei
# Gibt Kategorie-Key zurück: Muell, Installer, iPhone, Duplikat, Projekt, Screenshot
kategorie_bestimmen() {
  local NAME="$1"
  local BASENAME_OHNE_EXT="${NAME%.*}"
  local EXT_LOWER
  EXT_LOWER=$(echo "${NAME##*.}" | tr '[:upper:]' '[:lower:]')

  # 1. Duplikate (höchste Priorität — erkennt Namen mit " 2", " 3", " (1)" vor der Endung)
  if [[ "$BASENAME_OHNE_EXT" =~ \ [0-9]+$ ]] || [[ "$BASENAME_OHNE_EXT" =~ \ \([0-9]+\)$ ]]; then
    echo "Duplikat"
    return
  fi

  # 2. Müll (unvollständige Downloads, Logs, Diagnose-Files)
  case "$EXT_LOWER" in
    crdownload|log|1pdiagnostics) echo "Muell"; return ;;
  esac
  if [ "$NAME" = "md5sums" ] || [ "$NAME" = "md5sums_" ]; then
    echo "Muell"; return
  fi

  # 3. Installer und Software-Setups
  case "$EXT_LOWER" in
    exe|msi|dmg|pkg|iso|apk|udfu|vsixpackage|raisepack) echo "Installer"; return ;;
  esac
  case "$NAME" in
    *.img.xz|*.sfx.exe|*.tar.gz|*.tgz) echo "Installer"; return ;;
  esac

  # 4. Screenshots → direkt ins Gehirn
  case "$NAME" in
    Bildschirmfoto*|Screenshot*) echo "Screenshot"; return ;;
  esac

  # 5. iPhone-Fotos/Videos (IMG_XXXX-Muster und generische Namen aus der Fotos-App)
  if [[ "$NAME" =~ ^IMG_[0-9]+ ]]; then
    echo "iPhone"; return
  fi
  case "$NAME" in
    "Neueste Fotos anzeigen"*) echo "iPhone"; return ;;
  esac

  # 6. Alles andere = Projekt-Material
  echo "Projekt"
}

# Zielordner für Kategorie
ziel_ordner() {
  case "$1" in
    Muell)      echo "$INVENTUR/01_Muell" ;;
    Installer)  echo "$INVENTUR/02_Installer" ;;
    iPhone)     echo "$INVENTUR/03_iPhone_Fotos_Videos" ;;
    Duplikat)   echo "$INVENTUR/04_Moegliche_Duplikate" ;;
    Projekt)    echo "$INVENTUR/05_Projekt_Material" ;;
    Screenshot) echo "$SCREENSHOTS" ;;
  esac
}

# Hauptschleife
for QUELLE in "${QUELLEN[@]}"; do
  [ -d "$QUELLE" ] || continue
  QUELLE_NAME=$(basename "$QUELLE")

  while IFS= read -r -d '' DATEI; do
    NAME=$(basename "$DATEI")
    case "$NAME" in .*) continue ;; esac
    [ -f "$DATEI" ] || continue

    KAT=$(kategorie_bestimmen "$NAME")
    ZIELDIR=$(ziel_ordner "$KAT")
    ZIEL="$ZIELDIR/$NAME"

    if [ "$PREVIEW" = "--preview" ]; then
      zaehler_plus "$KAT"
      continue
    fi

    # Kollisions-Schutz
    if [ -e "$ZIEL" ]; then
      ZIEL="$INVENTUR/_Kollisionen/${QUELLE_NAME}_${NAME}"
      zaehler_plus "Kollision"
    fi

    if mv "$DATEI" "$ZIEL" 2>/dev/null; then
      zaehler_plus "$KAT"
      echo "- [$KAT] $NAME" >> "$MANIFEST"
    fi
  done < <(find "$QUELLE" -maxdepth 1 -print0)
done

# Zusammenfassung
echo ""
echo "═══════════════════════════════════════════════════"
if [ "$PREVIEW" = "--preview" ]; then
  echo "  Mac-Inventur (PREVIEW — nichts bewegt)"
else
  echo "  Mac-Inventur"
fi
echo "═══════════════════════════════════════════════════"
printf "  %-35s %s\n" "Screenshots → Gehirn:"        "$ZAEHLER_SCREENSHOT"
printf "  %-35s %s\n" "01 Müll:"                     "$ZAEHLER_MUELL"
printf "  %-35s %s\n" "02 Installer:"                "$ZAEHLER_INSTALLER"
printf "  %-35s %s\n" "03 iPhone Fotos/Videos:"      "$ZAEHLER_IPHONE"
printf "  %-35s %s\n" "04 Mögliche Duplikate:"       "$ZAEHLER_DUPLIKAT"
printf "  %-35s %s\n" "05 Projekt-Material:"         "$ZAEHLER_PROJEKT"
if [ "$ZAEHLER_KOLLISION" -gt 0 ]; then
  printf "  %-35s %s\n" "⚠ Namenskollisionen:"       "$ZAEHLER_KOLLISION"
fi
echo "═══════════════════════════════════════════════════"

if [ "$PREVIEW" != "--preview" ]; then
  echo ""
  echo "Arbeitsordner: $INVENTUR"
  echo "Manifest:      $MANIFEST"
  echo ""
  echo "Nächste Schritte:"
  echo "  1. 01_Muell durchschauen → Papierkorb"
  echo "  2. 02_Installer durchschauen → behalten oder weg"
  echo "  3. 03_iPhone_Fotos_Videos → Apple Fotos importieren, dann weg"
  echo "  4. 04_Moegliche_Duplikate → gegen Original vergleichen"
  echo "  5. 05_Projekt_Material → themenweise ins Gehirn (mit Claude)"
fi

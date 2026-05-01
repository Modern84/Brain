#!/usr/bin/env bash
# ──────────────────────────────────────────────────────────────
# populate-reiner-gehirn-2026-04-21.sh
#
# Füllt die Basis-Struktur von prepare-reiner-gehirn.sh mit den
# aktuellen WEC-Arbeitsinhalten auf (Stand 21.04.2026 abends):
#   - Bens-Lagerschalenhalter-Lieferung komplett
#   - Volker-Bens-Nummernregister
#   - v4/v5 Patcher-Scripts
#   - Muster-Analyse Reiner-Standard
#   - Reiner-taugliche WEC-Bereichs-CLAUDE.md (ohne BWL-Filter-Sektion)
#
# Nutzung:  ./populate-reiner-gehirn-2026-04-21.sh /Volumes/INTENSO
# ──────────────────────────────────────────────────────────────

set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Verwendung: $0 <Pfad-zur-SSD>"
  echo "Beispiel:   $0 /Volumes/INTENSO"
  exit 1
fi

STICK="$1"
if [ ! -d "$STICK" ]; then
  echo "❌ Stick-Pfad existiert nicht: $STICK"
  exit 1
fi

VAULT="/Users/sh/Brain"
SCRIPT_DIR="$VAULT/02 Projekte/WEC Neustart mit Reiner"
STAGING="$VAULT/04 Ressourcen/Reiner-Setup-2026-04-21"

# ── 1. Alter Gehirn-Ordner als Backup sichern ──
DATE=$(date +%Y-%m-%d)
if [ -d "$STICK/Gehirn" ]; then
  if [ -d "$STICK/Gehirn_alt_$DATE" ]; then
    echo "⚠️  Gehirn_alt_$DATE existiert bereits — Abbruch zur Sicherheit."
    exit 1
  fi
  mv "$STICK/Gehirn" "$STICK/Gehirn_alt_$DATE"
  echo "✅ Alter Gehirn-Ordner gesichert als: $STICK/Gehirn_alt_$DATE"
fi

# ── 2. Basis-Setup via prepare-reiner-gehirn.sh ──
echo ""
echo "── Basis-Setup ──"
bash "$SCRIPT_DIR/prepare-reiner-gehirn.sh" "$STICK"

# Ziel-Vault liegt jetzt unter $STICK/02_Reiner-Gehirn/Gehirn/
VAULT_ZIEL="$STICK/02_Reiner-Gehirn/Gehirn"

if [ ! -d "$VAULT_ZIEL" ]; then
  echo "❌ Basis-Setup hat nicht das erwartete Verzeichnis angelegt: $VAULT_ZIEL"
  exit 1
fi

# ── 3. WEC-Bereichs-CLAUDE.md (Reiner-Version) ──
echo ""
echo "── WEC-Bereichs-Regeln ──"
cp "$STAGING/WEC-CLAUDE-fuer-Reiner.md" "$VAULT_ZIEL/03 Bereiche/WEC/CLAUDE.md"
echo "✅ WEC-CLAUDE.md für Reiner abgelegt"

# ── 4. Scripts ──
echo ""
echo "── Patcher-Scripts ──"
mkdir -p "$VAULT_ZIEL/02 Projekte/WEC"
cp -R "$VAULT/02 Projekte/WEC/scripts" "$VAULT_ZIEL/02 Projekte/WEC/"
echo "✅ v4/v5 Scripts kopiert nach 02 Projekte/WEC/scripts/"

# ── 5. Volker-Bens-Lieferung (komplett) ──
echo ""
echo "── Volker-Bens-Lieferung ──"
mkdir -p "$VAULT_ZIEL/03 Bereiche/WEC/Lieferung"
cp -R "$VAULT/03 Bereiche/WEC/Lieferung/Volker Bens" "$VAULT_ZIEL/03 Bereiche/WEC/Lieferung/"
echo "✅ Volker-Bens-Projekt kopiert (inkl. Register, Projekt, Paket, Staging-Historie)"

# ── 6. Muster-Analyse ──
echo ""
echo "── Muster-Analyse ──"
mkdir -p "$VAULT_ZIEL/04 Wissen/Musterbeispiele-Reiner"
cp "$VAULT/04 Ressourcen/Musterbeispiele-Reiner/Muster-Analyse_Reiner-Standard.md" \
   "$VAULT_ZIEL/04 Wissen/Musterbeispiele-Reiner/"
echo "✅ Muster-Analyse_Reiner-Standard.md kopiert"

# ── 7. README im Root des Gehirns ergänzen ──
cat > "$VAULT_ZIEL/README_Stand_21-04-2026.md" <<EOF
---
tags: [system]
date: 2026-04-21
---

# Stand 21.04.2026 — was bereits drin ist

Dieses Gehirn wurde am 21.04.2026 aktualisiert. Der alte Stand liegt als Backup unter \`Gehirn_alt_${DATE}/\` auf dem Stick (nicht in diesem Vault).

## Was dazugekommen ist

### Volker-Bens-Projekt (03 Bereiche/WEC/Lieferung/Volker Bens/)
- **Nummernregister** unter \`_Register/\` — aktiv verwaltete und verbrannte Zeichnungsnummern für Bens, Schema \`BE-LS-202603-XYZ-R\`
- **Lagerschalenhalter Lebensmittelindustrie** — komplettes Projekt:
  - \`mapping_lagerschalenhalter.yaml\` — v5-Regel-Definitionen
  - \`2026-04-21 Montag-Session/Aenderungsprotokoll.md\` — lückenlose Historie
  - \`2026-04-21 Montag-Session/_Paket_fuer_Reiner/\` — fertige Liefer-ZIPs (v1 ist raus, v2 liegt als Backup bereit)
  - \`_v5_staging/\` — die drei v5-Runs als Audit-History

### Patcher-Scripts (02 Projekte/WEC/scripts/)
- \`v5_patcher.py\` — Stufe 1: Nummern, White-Label, Material-Fixes
- \`v4_patcher.py\` — Stufe 2: Info-Block (EHEDG-Standard)
- \`v4_patcher_v2.py\` — Stufe 2 erweitert (Reiner-Schriftfeld-Standard)
- \`run_v5.sh\`, \`run_v4.sh\`, \`run_v4_v2.sh\` — Wrapper mit venv-Verwaltung
- \`md2pdf.py\` — Markdown → PDF (falls gebraucht)

### WEC-Bereichs-Regeln (03 Bereiche/WEC/CLAUDE.md)
- Kunden-spezifische Regeln (Bens-White-Label, Knauf)
- Nummernschema-Konvention (Reiner-Standard mit MMYY)
- Liefer-Standards (Schriftfeld, Lebensmittel-Notizen, Paket-Build)
- Datenschutz (Patente, NDA)

### Muster-Analyse (04 Wissen/Musterbeispiele-Reiner/)
- \`Muster-Analyse_Reiner-Standard.md\` — Referenz-Analyse der drei Muster-Projekte (Hebehilfe Cavanna, Schwenkteilsicherung, Sprühlanze). Dokumentiert Nummernschema, Schriftfeld-Layout, Ordnerstruktur.

## Was fehlt (vom alten Gehirn ggf. zu übernehmen)

Falls im \`Gehirn_alt_${DATE}/\` noch eigene Notizen stehen (Tagesbuch-Einträge, persönliche Kontext-Files), diese bei Bedarf manuell übernehmen.

## Stand der Volker-Bens-Lieferung

- v1-Paket: heute raus an Reiner → Volker per E-Mail (8 Zeichnungen, EHEDG-Info-Block)
- v2-Paket: zusätzlich im Vault bereitgestellt (erweiterter Info-Block nach Reiner-Schriftfeld-Standard), nicht versandt
- Fusion-TODOs: V1-only-Zusammenbau, Schweißgruppe V2, Title-Tippfehler \`Lagerschalehalter\`, Steg-Zeichnung klären

Details: siehe Aenderungsprotokoll im Projekt.
EOF

echo "✅ README_Stand_21-04-2026.md angelegt"

# ── 8. Zusammenfassung ──
echo ""
echo "──────────────────────────────────────────────────────────────"
echo "✅ Fertig. Stand des Reiner-Gehirns:"
echo "──────────────────────────────────────────────────────────────"
find "$VAULT_ZIEL" -maxdepth 3 -type d | sort
echo ""
echo "──────────────────────────────────────────────────────────────"
echo "Nächste manuelle Schritte:"
echo "  1. Installer in $STICK/02_Reiner-Gehirn/Installer/ ablegen"
echo "     - Obsidian Windows-Installer"
echo "     - Claude Desktop Windows-Installer"
echo "  2. Stick sicher auswerfen (Finder → Auswerfen oder 'diskutil eject')"
echo "──────────────────────────────────────────────────────────────"

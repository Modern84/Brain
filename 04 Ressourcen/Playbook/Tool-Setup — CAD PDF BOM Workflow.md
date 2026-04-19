---
tags: [playbook, tool-setup, claude-code, cad, pdf, bom, bens, wec]
status: aktiv
date: 2026-04-18
aliases: [Tool-Setup CAD PDF BOM, Tool-Check Claude Code Konstruktions-Workflow]
---

# Tool-Setup — CAD/PDF/BOM Workflow

> **Zweck:** Claude Code arbeitsfähig machen für Datei-Operationen rund um Konstruktions-Daten (CAD, PDF-Zeichnungen, Excel-BOMs). Einmal pro System durchführen — Sebastian-Mac (heute), Reiner-PC (August 2026), künftige Kunden-Systeme.

## Tool-Stack

### Pflicht (A — hoch)

| Tool | Zweck | Install |
|---|---|---|
| `ocrmypdf` | OCR für gescannte PDFs (Reiner-Korrekturen) | `brew install ocrmypdf tesseract tesseract-lang` |
| `pdftotext` | PDF-Text-Extraktion | `brew install poppler` |
| `qpdf` | PDF-Strukturanalyse | `brew install qpdf` |
| `pdfplumber` (Python) | Strukturierte PDF-Daten (Tabellen, Bemaßung) | `pip3 install --user pdfplumber` |
| `pypdf` (Python) | Basis-PDF-Operationen | `pip3 install --user pypdf` |
| `openpyxl` (Python) | Excel-BOMs lesen/schreiben | `pip3 install --user openpyxl` |
| `ezdxf` (Python) | DXF-Dateien (2D-CAD) | `pip3 install --user ezdxf` |
| `steputils` (Python) | STEP-Dateien (3D-CAD), Schema-Erkennung | `pip3 install --user steputils` |

### Optional (B — mittel)

| Tool | Zweck | Wann installieren |
|---|---|---|
| ODA File Converter | DWG → DXF (kostenlos, https://www.opendesign.com/guestfiles/oda_file_converter) | Wenn Reiner DWG-Dateien liefert |
| FreeCAD Python-API | Erweiterte STEP-Analyse, Baugruppen-Struktur | Wenn `steputils` nicht ausreicht |
| `cadquery` / `OCP` (Python) | OpenCASCADE-Binding für komplexe CAD-Operationen | Späterer Ausbau |

## Prompt für Claude Code

Der folgende Block ist der Arbeitsauftrag. Sebastian sagt zu Claude Code: *"Lies und führe aus: [[04 Ressourcen/Playbook/Tool-Setup — CAD PDF BOM Workflow]]"* — oder paste direkt:

```
Tool-Setup für Konstruktions-Workflow (CAD/PDF/BOM) auf diesem Mac.

Lies zuerst:
1. CLAUDE.md im Vault-Root
2. 04 Ressourcen/Playbook/Claude Code — Meta-Regeln
3. 03 Bereiche/WEC/CLAUDE.md (Drei-Layer-Disziplin, White-Label-Prinzip)

## Schritt 1 — Inventur

Teste was schon da ist. Gib pro Punkt "✅ vorhanden (Version)" oder "❌ fehlt" aus:

- `which ocrmypdf`
- `which pdftotext`
- `which qpdf`
- `python3 -c "import pdfplumber; print(pdfplumber.__version__)"`
- `python3 -c "import pypdf; print(pypdf.__version__)"`
- `python3 -c "import openpyxl; print(openpyxl.__version__)"`
- `python3 -c "import ezdxf; print(ezdxf.__version__)"`
- `python3 -c "import steputils; print(steputils.__version__)"`
- `brew list --formula | grep -iE "(poppler|tesseract|qpdf|ocrmypdf)"`

## Schritt 2 — Fehlendes installieren

Nur was in Schritt 1 als ❌ markiert wurde:

```bash
# Homebrew (falls nötig):
brew install ocrmypdf tesseract tesseract-lang poppler qpdf

# Python (User-Install):
pip3 install --user pdfplumber pypdf openpyxl ezdxf steputils
```

Nicht mehr, nicht weniger. Bei `brew` Problemen: Sebastian melden, nicht improvisieren.

## Schritt 3 — Smoke-Test mit Lagerschalenhalter-Dateien

Arbeitsverzeichnis:
```bash
cd "03 Bereiche/WEC/raw/Kunden/Volker Bens/aktuelle Projekte/Lagerschalenhalter Lebensmittelindustrie"
```

Test 1 — PDF mit OCR-Layer:
```bash
pdftotext "Lagerhalter Zeichnung.pdf" - | head -30
```
Erwartet: lesbare Textausgabe (Titelfeld, Bemaßungen, Notizen).

Test 2 — PDF ohne OCR-Layer (Scan-Kandidat prüfen):
```bash
for f in *.pdf; do
  chars=$(pdftotext "$f" - 2>/dev/null | wc -c | tr -d ' ')
  echo "$chars chars — $f"
done
```
Erwartet: Dateien mit <100 Zeichen sind reine Bild-Scans und brauchen OCR.

Test 3 — Excel-BOM:
```bash
python3 <<'EOF'
import openpyxl
wb = openpyxl.load_workbook('Zusammenbau_Lagerschalehalter_10_24_16042026.xlsx')
for s in wb.sheetnames:
    ws = wb[s]
    print(f"Sheet '{s}': {ws.max_row} Zeilen × {ws.max_column} Spalten")
    for i, row in enumerate(ws.iter_rows(min_row=1, max_row=5, values_only=True)):
        print(f"  Row {i+1}: {row}")
EOF
```
Erwartet: Kopfzeile + Positions-Reihen (Pos./Benennung/Material/Menge).

Test 4 — STEP-Schema identifizieren:
```bash
head -20 "Lagerhalter.stp" | grep -i "FILE_SCHEMA"
```
Erwartet: Ausgabe mit einem dieser Werte:
- `CONFIG_CONTROL_DESIGN` → **STEP AP203** (alt, breit kompatibel, Volker-Kandidat)
- `AUTOMOTIVE_DESIGN` → **STEP AP214**
- `AP242` → **STEP AP242** (neuester Standard)

Das Ergebnis direkt notieren — es ist Input für [[CAD-Datenuebergabe Standard - Bens Edelstahl]].

## Schritt 4 — Bens-Datei-Bestandsaufnahme

Prüfe wo auf dem Mac noch Bens-relevante Dateien rumliegen (die Montag in raw/ gehören):

```bash
# Im Vault (sollte schon sortiert sein):
find "03 Bereiche/WEC/raw/Kunden/Volker Bens" -type f | wc -l
ls -la "03 Bereiche/WEC/raw/Kunden/Volker Bens/aktuelle Projekte/Lagerschalenhalter Lebensmittelindustrie/"

# Außerhalb des Vaults (vielleicht noch Reste):
find ~/Desktop ~/Downloads ~/Documents -type f \
  \( -iname "*bens*" -o -iname "*lagerscha*" -o -iname "*sachsenmil*" -o -iname "*AM_Lager*" \) \
  2>/dev/null | head -30
```

Falls Treffer außerhalb des Vaults: **NICHT automatisch verschieben**. Sebastian bestätigt vor jeder Verschiebung.

## Schritt 5 — Protokoll schreiben

Neue Notiz: `04 Ressourcen/Playbook/Sessions/2026-04-18 Tool-Setup Sebastian-Mac.md`

Inhalt:
- Frontmatter mit tags, date, status
- Was war vorhanden (mit Versionen)
- Was wurde installiert
- Smoke-Test-Ergebnisse (Tests 1–4, inkl. STEP-Schema-Befund!)
- Bens-Datei-Bestandsaufnahme (was liegt wo)
- Offene Punkte für Montag (fehlende Tools, Fragen an Reiner)
- Pilot-Erkenntnisse falls welche entstanden (nach A/B/C-Priorität)

## Wichtig

- KEINE Original-Dateien in `raw/` verändern (WEC-CLAUDE.md: raw/ ist unantastbar)
- Bei Installationsproblemen: stoppen, Sebastian melden, nicht weiter-improvisieren
- White-Label-Prinzip gilt auch für Tool-Setup: keine WEC-Artefakte in Bens-Dateien, keine Kommentare die Claude/WEC als Urheber zeigen
- Nach Abschluss: Sebastian kurz Bilanz melden (3–5 Zeilen), dann Feierabend
```

## Erwartetes Ergebnis

- Protokoll-Notiz in `04 Ressourcen/Playbook/Sessions/`
- Alle Pflicht-Tools verifiziert lauffähig, Versionen dokumentiert
- Smoke-Test mit Lagerschalenhalter-Dateien erfolgreich — inklusive STEP-Schema-Identifikation
- Bens-Datei-Bestandsaufnahme: wissen was im Vault liegt und was noch einzusammeln ist
- Montag-Blocker-Liste (falls welche): klar benannt, damit Sebastian morgen beheben kann

## Rollover für andere Systeme

Für Reiner-Pilot (Windows, August 2026):
- `brew` wird zu `winget` oder `chocolatey`
- Pfade wechseln von macOS zu Windows-Style
- `ocrmypdf` auf Windows ist komplizierter — ggf. Docker-Alternative
- ODA File Converter läuft auch auf Windows
- Python-Pakete identisch

Die Struktur dieses Playbooks bleibt. Nur die OS-Details ändern sich.

## Verknüpfungen

- [[CLAUDE]] — Root-Regeln
- [[04 Ressourcen/Playbook/Claude Code — Meta-Regeln]] — universelle Arbeitsregeln
- [[03 Bereiche/WEC/CLAUDE]] — WEC-Drei-Layer + White-Label
- [[03 Bereiche/WEC/wiki/Kunden/Volker Bens - Lagerschalenhalter Lebensmittelindustrie]] — Session-Testdaten
- [[04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl]] — Empfänger des STEP-Schema-Befunds
- [[TASKS#Termine]] — Bens-Termin Montag

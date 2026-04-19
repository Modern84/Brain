---
tags: [playbook, bens, zeichnung, montag, abgleich, claude-code]
status: aktiv
date: 2026-04-18
aliases: [Bens Montag Vorbereitung, Zeichnungsnummer Abgleich]
---

# Montag-Vorbereitung — Bens Zeichnungsabgleich

> **Zweck:** Vollständige Vorbereitung für den Reiner-Termin 2026-04-21. Drei Aufgaben in einem Lauf: (1) DWG-Templates in WEC-Struktur, (2) alle Zeichnungsnummern aus PDFs extrahieren, (3) Solid Edge Profil registrieren. Ergebnis: Sebastian und Reiner haben Montag alles auf einen Blick.

## Prompt für Claude Code

```
Montag-Vorbereitung Bens-Termin 2026-04-21. Drei Schritte, kein Stop dazwischen außer bei echten Problemen.

Lies zuerst:
1. CLAUDE.md im Vault-Root
2. 04 Ressourcen/Playbook/Claude Code — Meta-Regeln
3. 03 Bereiche/WEC/CLAUDE.md (White-Label + Drei-Layer!)

## Schritt 1 — DWG/DFT-Templates in WEC-Struktur verschieben

Quelle: "07 Anhänge/" (bereits lokal verfügbar)
Ziel: WEC raw-Layer

VAULT="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain"

### 1a — Bens-Vordrucke → Standards & Vorlagen
Ordner anlegen falls nicht da:
mkdir -p "$VAULT/03 Bereiche/WEC/raw/Kunden/Volker Bens/Standards & Vorlagen"

Verschieben (nur wenn Datei >0 Byte und noch nicht dort):
Bens_Vordruck.dwg     → raw/Kunden/Volker Bens/Standards & Vorlagen/
Vordruck_A4.dwg       → raw/Kunden/Volker Bens/Standards & Vorlagen/
Vordruck.dwg          → raw/Kunden/Volker Bens/Standards & Vorlagen/
Vordruck.dft          → raw/Kunden/Volker Bens/Standards & Vorlagen/

Dateinamen VOR dem Verschieben prüfen:
for f in "Bens_Vordruck.dwg" "Vordruck_A4.dwg" "Vordruck.dwg" "Vordruck.dft"; do
  size=$(stat -f%z "$VAULT/07 Anhänge/$f" 2>/dev/null || echo 0)
  echo "$size bytes — $f"
done
Nur Dateien >1000 Byte verschieben. 0-Byte-Dateien = iCloud-Platzhalter, stehen lassen.

### 1b — WEC-Templates → Standards WEC
mkdir -p "$VAULT/03 Bereiche/WEC/raw/Standards WEC/Templates"

WEC.dwg               → raw/Standards WEC/Templates/
WEC.bak               → raw/Standards WEC/Templates/
Zeichnungsvordrucke.dft → raw/Standards WEC/Templates/  (4.92 MB, Solid Edge)
Zeichnungsblöcke_neu Ausführung.dft → raw/Standards WEC/Templates/

Quelle für die letzten beiden: "07 Anhänge/Allgemein/Profil/"

### 1c — md5 jeder verschobenen Datei protokollieren
md5 [datei] für jede Datei, die wirklich verschoben wurde.

## Schritt 2 — Alle Zeichnungsnummern aus Fusion360-PDFs extrahieren

Alle PDFs in "07 Anhänge/Fusion360/Baugruppen_Einzelteile_Lagerschalenhalter/" (rekursiv):

python3 <<'EOF'
import pdfplumber
from pathlib import Path
import re

base = Path("/Users/sh/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain/07 Anhänge/Fusion360/Baugruppen_Einzelteile_Lagerschalenhalter")
pdfs = sorted(base.rglob("*.pdf"))

results = []
for pdf_path in pdfs:
    try:
        with pdfplumber.open(str(pdf_path)) as pdf:
            page = pdf.pages[0]
            words = page.extract_words()
            
            # Alle Texte aus Schriftfeld-Bereich (unteres Drittel der Seite)
            page_h = page.height
            lower_words = [w["text"] for w in words if w["top"] > page_h * 0.75]
            full_text = " ".join(lower_words)
            
            # Bens-Zeichnungsnummer-Pattern: BE-XX-XXXXXX-XXX-X
            nummern = re.findall(r'BE-[A-Z]{2}-\d{6}-\d{3}-?\d?', full_text)
            
            # Projektgruppe / SM_ / AM_ suchen
            projekt = re.findall(r'(?:SM_|AM_)\w+', full_text)
            
            # Bearbeitet + Geprüft Namen
            # Suche nach "Hartmann" oder "Woldrich" oder "Sebastian"
            namen = re.findall(r'(?:Hartmann|Woldrich|Sebastian|Bens)', full_text, re.IGNORECASE)
            
            # Maßstab
            massstab = re.findall(r'\d+:\d+', full_text)
            
            rel = pdf_path.relative_to(base)
            results.append({
                "datei": str(rel),
                "zeichnungsnr": nummern,
                "projekt": projekt,
                "namen": namen,
                "massstab": massstab,
                "schriftfeld_raw": full_text[:200]
            })
    except Exception as e:
        results.append({"datei": str(pdf_path.relative_to(base)), "fehler": str(e)})

# Ausgabe als Tabelle
print("\n" + "="*80)
print("ZEICHNUNGSNUMMERN-ÜBERSICHT — Lagerschalenhalter PDFs")
print("="*80)
print(f"{'Datei':<50} {'Nummer':<25} {'Projekt':<20} {'Namen'}")
print("-"*120)
for r in results:
    if "fehler" in r:
        print(f"{r['datei']:<50} FEHLER: {r['fehler']}")
    else:
        nr = ", ".join(r["zeichnungsnr"]) or "(keine BE-Nr gefunden)"
        proj = ", ".join(r["projekt"]) or "-"
        namen = ", ".join(set(r["namen"])) or "-"
        print(f"{r['datei']:<50} {nr:<25} {proj:<20} {namen}")

print(f"\n{len(results)} PDFs verarbeitet.")
print("\n=== BEKANNTE INKONSISTENZ ZU PRÜFEN ===")
print("CSV-Stückliste hat: BE-IS-202631-XXX-X")
print("Zusammenbau-PDF hat: BE-LS-202603-000-0")
print("Montag mit Reiner klären: welches Schema ist korrekt?")
EOF

## Schritt 3 — Solid Edge Profil inventarisieren

Das Profil in "07 Anhänge/Allgemein/Profil/DesignData/" enthält Sabines Solid Edge Setup.
Das ist der historische WEC-CAD-Standard. Kurze Inventur:

echo "=== Solid Edge DesignData Inventur ==="
ls -la "$VAULT/07 Anhänge/Allgemein/Profil/DesignData/" | head -40

echo ""
echo "=== Material-Tabellen ==="
# Erste 10 Zeilen der Materialtabelle — zeigt Werkstoff-Nomenklatur
head -20 "$VAULT/07 Anhänge/Allgemein/Profil/DesignData/Material.mtl" 2>/dev/null | strings | head -20

echo ""
echo "=== Template-Dateien ==="
ls -lh "$VAULT/07 Anhänge/Allgemein/Profil/"*.dft "$VAULT/07 Anhänge/Allgemein/Profil/SEST4/Templates/"* 2>/dev/null | head -20

## Schritt 4 — Ingest-Log + Protokoll schreiben

### 4a — Ingest-Eintrag für verschobene Templates
In "03 Bereiche/WEC/Operationen/Ingest.md" neuen Eintrag oben ergänzen:
Datum: 2026-04-18, Titel: "WEC/Bens Templates + Solid Edge Profil (aus 07 Anhänge/)"

### 4b — Protokoll-Notiz im Liefer-Ordner
Neue Datei:
"03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/2026-04-21 Montag-Session/Zeichnungsnummern-Abgleich.md"

Inhalt:
- Frontmatter (tags: [lieferung, bens, zeichnungsnummer, abgleich], date, status: offen)
- Tabelle aus Schritt 2 (alle PDFs mit Nummern)
- Bekannte Inkonsistenz hervorgehoben
- Agenda-Abschnitt "Montag mit Reiner klären:"
  1. Welche Nummer ist richtig: BE-IS-202631 oder BE-LS-202603?
  2. Was bedeuten IS / LS als Typ-Kürzel?
  3. Fusion-360-Schriftfeld: Bearbeitet/Geprüft/Projektgruppe — Bens-Konvention?
  4. IGES als Liefer-Format bestätigt?
  5. `~recovered`-PDFs: welche sind die finalen Versionen?

### 4c — TASKS.md aktualisieren
Unter Montag-Termin ergänzen: "Zeichnungsnummern-Abgleich vorbereitet: [[03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/2026-04-21 Montag-Session/Zeichnungsnummern-Abgleich]]"

## Wichtig

- raw/ ist unantastbar — verschobene Templates landen in raw/Standards WEC/ oder raw/Kunden/Volker Bens/ (das ist ZIEL, nicht Quelle)
- 07 Anhänge/ ist die QUELLE — Originale dort verschieben (nicht kopieren) um Redundanz zu vermeiden
- Kein rm — bei Unsicherheit Papierkorb via osascript
- Bilanz am Ende: Schritt 1 (X Dateien verschoben), Schritt 2 (X PDFs, Nummern-Tabelle), Schritt 3 (Inventur-Ergebnis)
```

## Erwartetes Ergebnis

Nach diesem Lauf hat Sebastian für Montag:
- Templates an richtiger Stelle in WEC-Struktur (Bens_Vordruck.dwg ist findbar)
- **Zeichnungsnummern-Tabelle** aller 10 PDFs — Inkonsistenz auf einen Blick
- **Montag-Agenda** als Dokument im Lieferordner
- Solid Edge Profil registriert (Basis für späteren Template-Fix)

## Verknüpfungen

- [[04 Ressourcen/Playbook/Claude Code — Meta-Regeln]]
- [[04 Ressourcen/Playbook/White-Label Bereinigung — Bens-Lieferdateien]]
- [[04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl]]
- [[03 Bereiche/WEC/wiki/Kunden/Volker Bens - Lagerschalenhalter Lebensmittelindustrie]]
- [[03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/2026-04-21 Montag-Session/Aenderungsprotokoll]]
- [[TASKS#Termine]]

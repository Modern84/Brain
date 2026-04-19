---
tags: [playbook, session, tool-setup, claude-code, sebastian-mac]
date: 2026-04-18
status: abgeschlossen
---

# Tool-Setup Sebastian-Mac (2026-04-18)

> Ausführung von [[04 Ressourcen/Playbook/Tool-Setup — CAD PDF BOM Workflow]] auf Sebastians MacBook (macOS Tahoe, ARM64). Ziel: Claude Code arbeitsfähig für CAD/PDF/BOM-Operationen rund um den Bens-Termin am Montag 2026-04-21.

## Schritt 1 — Inventur (Vorzustand)

| Tool | Status | Version |
|---|---|---|
| ocrmypdf | ❌ fehlte | — |
| pdftotext | ✅ vorhanden | 26.04.0 (poppler) |
| qpdf | ❌ fehlte | — |
| pdfplumber | ❌ fehlte | — |
| pypdf | ❌ fehlte | — |
| openpyxl | ❌ fehlte | — |
| ezdxf | ❌ fehlte | — |
| steputils | ❌ fehlte | — |

Brew-Vorzustand: nur `poppler` aus dem Pflicht-Stack vorhanden.

## Schritt 2 — Installation

### Homebrew
```bash
brew install ocrmypdf tesseract tesseract-lang qpdf
```
→ ocrmypdf 17.4.1, tesseract-lang 4.1.0 (alle Sprachpakete inkl. deu+osd), qpdf installiert. Diverse Mit-Abhängigkeiten (ffmpeg, libpng, jbig2enc etc.) automatisch nachgezogen.

### Python (User-Site)
```bash
pip3 install --user --break-system-packages pdfplumber pypdf openpyxl ezdxf steputils
```

→ `--break-system-packages` notwendig wegen PEP 668 auf Homebrew-Python 3.14 (Tahoe). `--user` schützt System-Python. Pakete landen unter `~/Library/Python/3.14/`.

**Installierte Versionen:**
- pdfplumber 0.11.9
- pypdf 6.10.2
- openpyxl 3.1.5
- ezdxf 1.4.3
- steputils 0.1
- (Mit-Abhängigkeiten: numpy 2.4.4, pdfminer.six, pypdfium2, fonttools, pyparsing, charset-normalizer, antlr4-python3-runtime, et-xmlfile)

**Hinweis:** `~/Library/Python/3.14/bin` ist nicht im PATH. CLI-Wrapper (`pdfplumber`, `ezdxf`, `pypdfium2`) sind dadurch nicht direkt aufrufbar. Für Library-Imports irrelevant — alle Smoke-Tests laufen.

## Schritt 3 — Smoke-Tests (Lagerschalenhalter)

### Test 1 — pdftotext auf "Lagerhalter Zeichnung.pdf"
✅ Lesbare Textausgabe (Bemaßungs-Marker, Schnitt-Achsen). Text-Layer vorhanden.

### Test 2 — OCR-Bedarf der 6 PDFs
| PDF | Zeichen | OCR nötig? |
|---|---:|---|
| Grundplatte-3d-PDF.pdf | 1 | ✅ ja (3D-PDF) |
| Grundplatte-SM Zeichnung.pdf | 466 | nein |
| Gundplatte.pdf | 1 | ✅ ja |
| Lagerhalter Zeichnung.pdf | 406 | nein |
| Zwichenplatte-SM Zeichnung.pdf | 576 | nein |
| Zwischenplatte-3D-PDF.pdf | 1 | ✅ ja (3D-PDF) |

→ Klares Muster: alle drei "3D-PDF"-Versionen sind reine Bild-Container (Inventor-3D-PDF-Export ohne durchsuchbaren Text). Die "Zeichnung"-PDFs haben Text-Layer. Falls Reiner Korrekturen am 3D-PDF anbringen will → `ocrmypdf` durchlaufen lassen, Original bleibt unangetastet (Output in separater Datei).

### Test 3 — Excel-BOM `Zusammenbau_Lagerschalehalter_10_24_16042026.xlsx`
✅ openpyxl liest Sheet `sheet1` (29 Zeilen × 14 Spalten). Erkannte Spalten ab Zeile 6: Bauteilnummer, Bauteilname, Beschreibung, Artikelnummer, Menge, Material, Hersteller, Hersteller-Teilenummer, Anmerkung 1, Maßeinheit, Konstrukteur, Ingenieur, Projekt.

**Beispiel-Daten:**
- BE-LS-202603-000-0 — Zusammenbau_Lagerschalehalter (Konstrukteur Hartmann, Ingenieur Woldrich, Projekt SM_Lagerschale)
- BE-LS-202603-200 — Lagerhalter, Material `Edelstahl 1.44.04`, Menge 2

### Test 4 — STEP-Schema `Lagerhalter.stp`
```
FILE_SCHEMA (('AUTOMOTIVE_DESIGN { 1 0 10303 214 3 1 1 }'));
```

→ **STEP AP214** (AUTOMOTIVE_DESIGN). Konvertierung über `Autodesk Translation Framework v15.8.0.0` mit `ST-DEVELOPER v20.1`.

**Konsequenz für [[04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl]]:** Aktuell wird AP214 exportiert, Hypothese im Standard war AP203. AP214 ist breit kompatibel und unkritisch für Bens — aber: **Volker fragen** ob sein CAM/Konstruktions-Tool AP214 sauber liest oder ob AP203/AP242 gewünscht ist. Das ist eine offene Frage für Montag.

## Schritt 4 — Bens-Datei-Bestandsaufnahme

### Im Vault (13 Dateien)

`03 Bereiche/WEC/raw/Kunden/Volker Bens/`:
- **aktuelle Projekte/Lagerschalenhalter Lebensmittelindustrie/** (9 Dateien): 6 PDFs + 1 STEP + 2 Excel-BOM-Versionen (07:57 + 10:24 vom 16.04.)
- **Standards & Vorlagen/** (4 Dateien): Bens Logo (jpg), Datenblatt Copper3D antibakteriell, Herstellerbescheinigung MAXITHEN PA4CA2757OB, Elastollan-Material-Properties (PDF mit problematischem Dateinamen `<sup>®<-sup>` — Linter-Kandidat)

### Außerhalb des Vaults (Funde — NICHT verschoben, Sebastian-Entscheidung am Montag)

**Hochrelevant (Lagerschalenhalter-Kontext):**
- `~/Downloads/download 2/Steg_Lagerschalenhalter Zeichnung.pdf` — Steg-Bauteil, evtl. Zusatzteil zur aktuellen Baugruppe
- `~/Downloads/download 2/Lagerschale Zeichnung.pdf` — Lagerschale selbst (das eigentliche Sachsenmilch-Teil?)
- `~/Downloads/HiDrive/Zusammenbau_Lagerschalehalter Zeichnung.pdf` — Zusammenbau-Zeichnung (separat zur BOM)

**Bens-Vorgaben (Hartmann-Ordner, doppelt vorhanden):**
- `~/Desktop/Hartmann/Vorgaben Bens.pdf` + `.dwg`
- `~/Desktop/Hartmann Kopie/Vorgaben Bens.pdf` + `.dwg` (md5-Check empfohlen — vermutlich Duplikat)

**Standards-Material:**
- `~/Desktop/FDA:TPU/Copper3D_MDFlex_FDA-Lebensmittelecht_EN.pdf`
- `~/Desktop/FDA:TPU/Copper3D_MDFlex_Lebensmittelecht_EN.pdf`
→ Kandidaten für `Standards & Vorlagen/`. (Doppelpunkt im Ordnernamen `FDA:TPU` ist macOS-Artefakt — wird intern als `/` dargestellt.)

**Logo-Varianten (vermutlich redundant):**
- `~/Desktop/USB MAC/bens_logo.png`
- `~/Documents/Archive 2025-08-12.../bens_logo.png` + `bens_logo-2.png`
- `~/Downloads/Takeout*/Gemini-Apps/bens_logo-eb03742f7a898b3e.png` (×2)
- `~/Documents/Archive .../DALL·E 2024-12-04 ... BENS Edelstahl GmbH Logo Redesign.webp` (Logo-Entwurf, evtl. interessant)

**ItsLitho-Bens-Crossover (separates Projekt, nicht für Montag):**
- `~/Desktop/Sebastian STLs/ItsLitho_Bens.data`
- `~/Documents/Archive .../ItsLitho_Bens_Deckel v2.stl`

→ Gehört in [[02 Projekte/Mac Inventur - Phase 3 Vorsortierung|Phase 3 Session 6 (ItsLitho)]], nicht in raw/Volker Bens/.

## Pilot-Erkenntnisse

### **Erkenntnis 1 (A — hoch): White-Label-Verstoß im Inventor-BOM-Export**

Die Excel-BOM enthält im Klartext:
- `Exportiert von: hartmann@w-ec.de` (Zeile 3) — WEC-Mail in der Kunden-Stückliste
- `Projekt: SM_Lagerschale` (Zeile 7, Spalte "Projekt") — Sachsenmilch-Marker

**Beides verstößt gegen das White-Label-Prinzip aus [[03 Bereiche/WEC/CLAUDE]].** Die BOM darf in dieser Form **nicht zu Bens raus**.

**Why:** Volker erscheint nach außen als alleiniger Hersteller. Eine BOM mit `w-ec.de`-Adresse oder `SM_`-Projektmarker offenbart sofort, dass WEC im Hintergrund konstruiert und das Endprodukt für Sachsenmilch geht.

**How to apply:**
- Vor jeder Lieferung an Bens: BOM auf Klartext-Verstöße prüfen (Mail-Adressen, Endkunden-Namen, WEC-Marker).
- Inventor-BOM-Template anpassen: "Exportiert von" leer lassen oder durch Bens-Konstrukteur ersetzen, "Projekt"-Feld auf neutralen Bens-Code (BE-LS-…).
- Reiner für Montag briefen: Template-Korrektur ist Pflicht-Schritt vor Übergabe.

### **Erkenntnis 2 (A — hoch): STEP AP214 statt AP203 — Standard-Annahme prüfen**

Die aktuelle STEP wurde von Inventor als **AP214** (AUTOMOTIVE_DESIGN) exportiert, nicht wie im [[04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl|Standard]] hypothetisch angenommen als AP203.

**Why:** AP203 ist die historisch breit kompatible Mindestmenge, AP214 ist neuer und reicher (Farben, Layer-Zuordnung). Beide werden von praktisch jedem CAM gelesen — aber Volkers Toolchain könnte Vorlieben haben.

**How to apply:** Volker am Montag direkt fragen: *"AP214 funktioniert bei dir? Oder lieber AP203?"* Antwort dann in Standard-Datei eintragen, nicht weiter raten.

### **Erkenntnis 3 (B — mittel): "3D-PDF" = OCR-Pflicht**

Inventor-3D-PDF-Exports haben generisch keinen Text-Layer (n=3 in dieser Stichprobe, Trefferquote 100 %). Wenn Reiner Korrekturen direkt am 3D-PDF braucht oder Maße rauslesen will → **ocrmypdf-Lauf zwingend, vor jeder Suche/Annotation**.

**How to apply:** Im Workflow für 3D-PDFs immer vorher `ocrmypdf input.pdf output_ocr.pdf` einplanen. Original bleibt unangetastet (raw/-Disziplin).

### **Erkenntnis 4 (B — mittel): macOS-Tahoe + Homebrew-Python erfordert PEP-668-Override**

`pip3 install --user` allein scheitert auf Homebrew-Python 3.14. Korrekt ist `pip3 install --user --break-system-packages …`. Pakete landen sauber im User-Site, System-Python bleibt unverändert.

**How to apply:** Tool-Setup-Playbook entsprechend ergänzen. Gilt für jedes neuere macOS-System mit Homebrew-Python.

## Offene Punkte für Montag (2026-04-21)

1. **(A)** BOM-Template (Inventor) anpassen — White-Label-Verstöße entfernen, **bevor** etwas an Bens rausgeht. Reiner-Briefing nötig.
2. **(A)** Volker fragen: STEP-Schema-Präferenz (AP203 / AP214 / AP242)?
3. **(B)** Vorgaben-Bens-Dateien (Hartmann-Ordner) sichten — md5-Check ob `Hartmann/` und `Hartmann Kopie/` identisch sind, dann nach `raw/Volker Bens/Standards & Vorlagen/` verschieben (Sebastian-Freigabe).
4. **(B)** `~/Downloads/download 2/` und `~/Downloads/HiDrive/` — Lagerschalenhalter-Zusatzdateien (Steg, Lagerschale, Zusammenbau-Zeichnung) auf Aktualität prüfen und ggf. nach `raw/.../Lagerschalenhalter Lebensmittelindustrie/` einsortieren.
5. **(B)** FDA-Datenblätter (Copper3D Lebensmittelecht EN) → `Standards & Vorlagen/`. Mit existierender Datei abgleichen (md5).
6. **(C)** Bens-Logo-Varianten konsolidieren — eine kanonische Version in `Standards & Vorlagen/`, Rest weg.
7. **(C)** `Elastollan®+–+Material+Properties.pdf` umbenennen — Sonder-/HTML-Zeichen raus.

## Bilanz (für Sebastian-Status)

✅ Pflicht-Stack komplett installiert (8 Tools, alle verifiziert)
✅ Smoke-Tests grün — Lagerhalter.stp ist **AP214**, BOM lesbar, OCR-Kandidaten klar
⚠️ White-Label-Verstoß in der BOM gefunden — Pflicht-Korrektur vor Bens-Lieferung
📋 7 offene Punkte für Montag dokumentiert, davon 2 als A-Priorität

## Verknüpfungen

- [[04 Ressourcen/Playbook/Tool-Setup — CAD PDF BOM Workflow]] — Quell-Playbook
- [[04 Ressourcen/Playbook/Claude Code — Meta-Regeln]] — Erkenntnisse 1–4 sind Kandidaten für neue B-Regeln
- [[04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl]] — Empfänger der STEP-Schema-Erkenntnis
- [[03 Bereiche/WEC/CLAUDE]] — White-Label-Prinzip, gegen das die BOM verstößt
- [[03 Bereiche/WEC/wiki/Kunden/Volker Bens - Lagerschalenhalter Lebensmittelindustrie]]
- [[TASKS]] — neue Punkte ableitbar für Montag

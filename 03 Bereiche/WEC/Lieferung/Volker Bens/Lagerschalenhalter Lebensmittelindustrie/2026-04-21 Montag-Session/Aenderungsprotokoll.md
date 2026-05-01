---
tags: [lieferung, bens, bom, pdf, white-label, intern]
date: 2026-04-18
status: teilweise-bereinigt
letzte-aenderung: 2026-04-21
vertraulichkeit: intern-wec-reiner
nicht-weitergeben: volker-bens
---

# 🔴 INTERN — NICHT AN VOLKER WEITERGEBEN

> **Vertraulichkeitsstufe:** Arbeitsdokument für Reiner ↔ Sebastian. Dokumentiert die interne White-Label-Bereinigung mit konkreten Fundstellen (Hartmann/Woldrich/Sachsenmilch) aus den Ursprungsdateien. Volker darf weder Inhalt noch Existenz dieses Protokolls kennen — würde die White-Label-Position untergraben.
>
> **Liefer-Ordner-Kontext:** Der Oberordner `2026-04-21 Montag-Session/` ist Reiner-Arbeitsmaterial, kein Volker-Lieferordner. Volker bekommt ausschließlich `3D/`, bereinigte PDFs und `BOM_bereinigt.csv` — dieses Protokoll bleibt intern.

---

# Änderungsprotokoll — Bens Lagerschalenhalter White-Label-Bereinigung

> Bereinigung der Lieferdateien für die Bens-Lagerschalenhalter-Übergabe (Montag 2026-04-21). Originale in `raw/` unangetastet (Drei-Layer-Disziplin), Arbeitskopien im neuen `Lieferung/`-Layer bereinigt.
>
> **Status:** BOM komplett bereinigt (0 Restbefunde). PDFs Metadaten-bereinigt, Vektor-Text-Reste als Inventor-Template-TODO offen.

## Teil 1 — Excel-BOM

## Quelle und Ziel

| | Pfad | md5 |
|---|---|---|
| **Quelle** (raw/, unangetastet) | `03 Bereiche/WEC/raw/Kunden/Volker Bens/aktuelle Projekte/Lagerschalenhalter Lebensmittelindustrie/Zusammenbau_Lagerschalehalter_10_24_16042026.xlsx` | `5c0ce1448aa8c83d6707a7e227d4bc87` |
| **Ziel vor Bereinigung** (Kopie) | `03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/2026-04-21 Montag-Session/BOM_bereinigt.xlsx` | `5c0ce1448aa8c83d6707a7e227d4bc87` (identisch zur Quelle) |
| **Ziel nach Bereinigung** | (gleicher Pfad) | `47043e9c48107f1568e04cb3ab514509` |

## Befunde + Änderungen

| # | Sheet / Ort | Alt | Neu | Muster |
|---|---|---|---|---|
| 1 | sheet1 / B3 (Wert „Exportiert von") | `hartmann@w-ec.de` | *(leer)* | email_wec |
| 2 | sheet1 / L7 (Spalte „Konstrukteur") | `Hartmann` | *(leer)* | hartmann |
| 3 | sheet1 / M7 (Spalte „Ingenieur") | `Woldrich` | *(leer)* | woldrich |
| 4 | sheet1 / N7 (Spalte „Projekt") | `SM_Lagerschale` | `AM_Lagerschale` | kuerzel_SM |
| 5 | core-properties / `creator` | `hartmann@w-ec.de` | `Bens Edelstahl GmbH` | email_wec — versteckte Metadaten |
| 6 | core-properties / `lastModifiedBy` | `hartmann@w-ec.de` | `Bens Edelstahl GmbH` | email_wec — versteckte Metadaten |

**Begründung Bens-Platzhalter statt leer (Properties):** Eine leere `creator`-Property kann beim nächsten Speichern in Excel/Inventor automatisch wieder mit dem eingeloggten User gefüllt werden. Ein expliziter Wert `Bens Edelstahl GmbH` bleibt stabil und signalisiert klar den Hersteller — White-Label-konsistent.

**Σ 6 Änderungen.** Verifikations-Rescan mit identischem Suchmuster-Set: **0 Treffer**.

## Suchmuster (Scope)

Case-insensitive Regex gegen alle Sheets, Zellen, Header/Footer, defined_names und core-properties:
- `[\w.-]+@w-ec\.de` (email_wec)
- `[\w.-]+@wec\.de` (email_wec_alt)
- `\bSM_` (Sachsenmilch-Präfix)
- `sachsenmilch`
- `woldrich\s*engineering`
- `\bWEC\b`
- `Hartmann`
- `Woldrich`

Keine Treffer für: Sachsenmilch (Klartext), WEC voll/kurz, email_alt, header/footer, defined_names.

## Offene Punkte für Montag (2026-04-21)

### Konstrukteur/Ingenieur-Felder L7/M7
L7 (Konstrukteur) und M7 (Ingenieur) wurden in dieser Bereinigung leergelassen. Mit Reiner final klären:

1. Setzt Volker/Bens traditionell einen Konstrukteur-Namen im Schriftfeld? Wenn ja: welchen Platzhalter / welche Konvention?
2. Alternative: `VB` (Volker Bens selbst, nach Hersteller-Logik) — das wäre konsistent mit dem White-Label-Prinzip, braucht aber Reiners Bestätigung dass Volker das so akzeptiert.
3. Oder traditionell leer bei Bens-Lieferungen?

Entscheidung fließt ins Inventor-Template (systemische Lösung, separate Skill-Aufgabe nach Montag).

## Hinweise fürs Inventor-Template (systemischer Fix)

Damit künftige BOM-Exports nicht erneut bereinigt werden müssen, sollte das Inventor-Template angepasst werden — separate Skill-Aufgabe, hier nur als Liefer-Input:

1. **„Exportiert von"-Feld** — entweder leer lassen oder durch festen Bens-Konstrukteur-Namen ersetzen (siehe offene Punkte oben). Nie die echte WEC-Mail.
2. **Projekt-Feld** — neutralen Bens-Code verwenden (z.B. `BE-LS-…`), nie Endkunden-Marker (`SM_`, `Sachsenmilch_` etc.).
3. **Konstrukteur/Ingenieur-Spalten** — ebenfalls nach Bens-Konvention füllen, nicht mit WEC-Namen.
4. **Datei-Properties** (sehr wichtig, oft übersehen) — Inventor schreibt den eingeloggten User-Account in die Excel-Core-Properties `creator` und `lastModifiedBy`. Das ist in Excel-UI nicht sichtbar, aber für jeden lesbar, der die `.xlsx` entpackt oder „Datei → Eigenschaften" öffnet. Inventor-Default-Author ändern oder per Post-Processing leeren.

## Teil 2 — PDF-Zeichnungen

Zwei „SM Zeichnung"-PDFs in den Liefer-Ordner kopiert, dabei umbenannt (SM-Marker raus, Tippfehler „Zwichen" → „Zwischen" korrigiert):

| | Quelle (raw/, unangetastet) | Ziel (Lieferung/) |
|---|---|---|
| 1 | `Grundplatte-SM Zeichnung.pdf` | `Grundplatte Zeichnung.pdf` |
| 2 | `Zwichenplatte-SM Zeichnung.pdf` | `Zwischenplatte Zeichnung.pdf` |

| Datei | md5 vor (= raw) | md5 nach Metadaten-Bereinigung |
|---|---|---|
| Grundplatte Zeichnung.pdf | `bbdba9b35979c5ec5bdf2f358c198f43` | `b52393a690b95aa2cb9a1be22b5a0fd7` |
| Zwischenplatte Zeichnung.pdf | `639f6f589450986e8a83dde4f1f13db9` | `fdfec88ad2109de052242760ef613b9b` |

### Metadaten — vorher/nachher

**Grundplatte Zeichnung.pdf** (DocumentInfo `/Info`):
| Feld | Vorher | Nachher |
|---|---|---|
| /Author | (nicht gesetzt) | `Bens Edelstahl GmbH` |
| /Creator | `Fusion Drawings (25.1)` | `Bens Edelstahl GmbH` |
| /Producer | `pdfplot17.bundle 17.01.114.00003` | `Bens Edelstahl GmbH` |
| /Title | `Plan1` | (leer) |

**Zwischenplatte Zeichnung.pdf** (DocumentInfo `/Info`):
| Feld | Vorher | Nachher |
|---|---|---|
| /Author | (nicht gesetzt) | `Bens Edelstahl GmbH` |
| /Creator | `Fusion Drawings (25.1)` | `Bens Edelstahl GmbH` |
| /Producer | `pdfplot17.bundle 17.01.114.00003` | `Bens Edelstahl GmbH` |
| /Title | `Platte_2` | (leer) |

**XMP-Stream** (parallel zu DocumentInfo, beide werden von Acrobat gelesen):
- `dc:creator`: `[Bens Edelstahl GmbH]` ✅
- `xmp:CreatorTool`: `Bens Edelstahl GmbH` ✅
- `pdf:Producer`: `pikepdf 10.5.1` ⚠️ (siehe offener Punkt unten)

### Text-Layer-Status

Re-Scan mit `pdftotext | grep -i "hartmann|w-ec|woldrich|sachsenmilch|SM_"`:

| Datei | Treffer |
|---|---|
| Grundplatte Zeichnung.pdf | `Sebastian Hartmann 2026-02-10` |
| Zwischenplatte Zeichnung.pdf | `Sebastian Hartmann 2026-02-12` |

**Nicht direkt im PDF gepatcht** — Vektor-Text aus dem Inventor/Fusion-Schriftfeld. Direkter String-Replace im Content-Stream wäre riskant (Font-Encoding, Glyph-Positionierung, mögliche Beschädigung der gesamten Zeichnung). → siehe Offene Punkte.

## Offene Punkte für Montag (2026-04-21)

### Konstrukteur/Ingenieur-Felder L7/M7 (Excel-BOM)
L7 (Konstrukteur) und M7 (Ingenieur) wurden in dieser Bereinigung leergelassen. Mit Reiner final klären:

1. Setzt Volker/Bens traditionell einen Konstrukteur-Namen im Schriftfeld? Wenn ja: welchen Platzhalter / welche Konvention?
2. Alternative: `VB` (Volker Bens selbst, nach Hersteller-Logik) — das wäre konsistent mit dem White-Label-Prinzip, braucht aber Reiners Bestätigung dass Volker das so akzeptiert.
3. Oder traditionell leer bei Bens-Lieferungen?

Entscheidung fließt ins Inventor-Template (systemische Lösung, separate Skill-Aufgabe nach Montag).

### „Sebastian Hartmann" im PDF-Vektor-Text (beide Zeichnungen)

Steht im Inventor/Fusion-Schriftfeld, ist beim PDF-Export als Vektor-Text in den Content-Stream gerendert. **Lösungsweg systemisch**, nicht datei-individuell:

- **Inventor/Fusion-Template-Fix:** Im Schriftfeld den Konstrukteur-Eintrag entweder leer lassen, durch Bens-Konvention ersetzen (siehe L7/M7-Frage oben — gleiche Entscheidung), oder per iProperty auf `Bens Edelstahl GmbH` zwingen. Danach betroffene Zeichnungen einmal neu exportieren.
- **Nicht im PDF direkt patchen:** Direkter String-Replace im Vektor-Text birgt Risiko — Glyph-Encoding, Spacing, im Worst Case Beschädigung der Zeichnungs-Geometrie. Reversibilitäts-Regel (Meta-Regel 6): wenn nicht sicher → nicht tun.

**Konsequenz für Montag:** Diese beiden PDFs sind in der aktuellen Form **nicht vollständig white-label-konform** und sollten nach Reiners L7/M7-Entscheidung aus Inventor/Fusion neu exportiert werden, bevor sie zu Volker rausgehen.

### XMP `pdf:Producer` = `pikepdf 10.5.1`

pikepdf setzt beim Speichern den eigenen Tool-Namen in den XMP-Stream `pdf:Producer` (nicht abschaltbar mit `set_pikepdf_as_editor=True`). Die DocumentInfo `/Producer` trägt korrekt `Bens Edelstahl GmbH` — das ist was Acrobat in den „Eigenschaften" zeigt. Aber ein technisch versierter Empfänger, der den XMP-Stream liest, sieht `pikepdf`.

**Optionen für späteren Fix:**
- (a) Post-Processing mit `qpdf --replace-input` und manuell editiertem XMP-Stream
- (b) `exiftool -PDF:Producer="Bens Edelstahl GmbH"` (würde XMP überschreiben, exiftool noch nicht im Tool-Stack)
- (c) Akzeptieren als „Tool-Wasserzeichen" — `pikepdf` verrät keine Person und keine Firma, nur die Bibliothek

**Empfehlung:** (c) für die Montag-Lieferung akzeptieren. (a)/(b) als Skill-Erweiterung nach Montag, falls Volker XMP-strikt prüft.

## Hinweise fürs Inventor-Template (systemischer Fix)

Damit künftige BOM-Exports nicht erneut bereinigt werden müssen, sollte das Inventor-Template angepasst werden — separate Skill-Aufgabe, hier nur als Liefer-Input:

1. **„Exportiert von"-Feld** (Excel-BOM) — entweder leer lassen oder durch festen Bens-Konstrukteur-Namen ersetzen (siehe offene Punkte oben). Nie die echte WEC-Mail.
2. **Projekt-Feld** (Excel-BOM) — neutralen Bens-Code verwenden (z.B. `BE-LS-…`), nie Endkunden-Marker (`SM_`, `Sachsenmilch_` etc.).
3. **Konstrukteur/Ingenieur-Spalten** (Excel-BOM und PDF-Schriftfeld synchron) — nach Bens-Konvention füllen, nicht mit WEC-Namen.
4. **Excel-Datei-Properties** (sehr wichtig, oft übersehen) — Inventor schreibt den eingeloggten User-Account in die Excel-Core-Properties `creator` und `lastModifiedBy`. Das ist in Excel-UI nicht sichtbar, aber für jeden lesbar, der die `.xlsx` entpackt oder „Datei → Eigenschaften" öffnet.
5. **PDF-Schriftfeld** (Inventor/Fusion-Drawing-Template) — Konstrukteur-iProperty per Default auf Bens-Konvention setzen, damit beim Export der Vektor-Text bereits korrekt ist. Verhindert die jetzt offene PDF-Vektor-Text-Lücke.
6. **PDF-Dateinamen** — keine `SM_`/`SM `-Marker im Dateinamen, keine `_SM_`-Endungen. Bens-Code als Dateinamen-Präfix verwenden.

## Teil 3 — Schema-Konsistenz Zeichnungsnummern (2026-04-20)

Die Task „CSV-Umstellung BE-IS-202631 → BE-LS-202603" war bereits durch die White-Label-Bereinigung vom 2026-04-18 erledigt (keine `BE-IS-`-Treffer mehr in BOM_bereinigt.xlsx oder den beiden Raw-Exports). **Bei Nachprüfung am 2026-04-20 wurden aber Schema-Inkonsistenzen im `BE-LS-202603-XXX-X`-Muster gefunden.**

### Befund

Schema-Soll laut Reiner-Scans und restlicher BOM: `BE-LS-202603-<Sachnummer>-<Variante>`, Variante `-0` für Einzelteil-Stamm.

| Zelle | Vor | Nach | Grund |
|---|---|---|---|
| B8 (Lagerhalter) | `BE-LS-202603-200` | `BE-LS-202603-200-0` | Suffix `-0` fehlte, Rest der Einzelteile durchgängig mit `-0` |
| B19 (Welle_V1) | `BE-LS-202603-204` | `BE-LS-202603-204-0` | dto. |
| B26, B29 (Lagerhalter in Schweißgruppe) | `BE-LS-202603-200` | `BE-LS-202603-200-0` | Konsistenz mit B8 |

**Quelle vor Änderung md5:** `47043e9c48107f1568e04cb3ab514509` (gesichert als `BOM_bereinigt.xlsx.backup_20260420`)
**Nach Änderung md5:** `d770bfb3123325a7de27ae20cab1349d`

### Konflikt für Reiner (nicht selbst aufgelöst)

**B16 `BE-LS-202603-203` = Welle_V2** kollidiert mit **B12 `BE-LS-202603-203-0` = Scheibe_t=1**. Beide Basen `203`, unterschiedliche Bauteile. Ein reines Anhängen von `-0` an B16 würde die Dublette `BE-LS-202603-203-0` erzeugen (zwei verschiedene Teile unter derselben Nummer). Muss fachlich geklärt werden — z.B. neue Sachnummer für Welle_V2. Raten wäre falsch, deshalb unberührt gelassen.

**Frage an Reiner:** Welche Sachnummer soll Welle_V2 (B16) bekommen? Vorschlag bei Gleichstand: nächste freie, z.B. `207-0`.

## Teil 4 — 3D-Daten + CSV-Stückliste ergänzt (2026-04-20)

Ziel: Volker-Liefer-Paket so weit wie möglich fertigstellen (STP + PDFs + Stückliste). Realitäts-Check: alle 10 Fusion-PDFs haben Vektor-Text-Leaks (`hartmann|w-ec|woldrich|sachsenmilch|SM_`) — nicht ohne Fusion-Neuexport lieferbar. 3D-Daten und CSV-Stückliste sind dagegen sauber und wurden ergänzt.

### 3D-Daten (White-Label-Check bestanden)

| Format | Herkunft | Author/Organization |
|---|---|---|
| STP (`Lagerhalter.stp` → Zusammenbau) | raw/ | `author=('')`, `organization=('')`, Generator `ST-Developer` |
| IGES (Zusammenbau + Einzelteile) | `07 Anhänge/Fusion360/…/Step/` | `author='unknown'`, `organization='unknown'` |

Regex-Scan `hartmann|w-ec|woldrich|sachsenmilch|SM_|AM_` gegen alle 10 IGES + STP: **0 Treffer**.

**Kopier-Aktionen (Original bleibt unangetastet):**

```
3D/
├── Lagerhalter_Zusammenbau.stp          (Zusammenbau, STP AP214)
├── Zusammenbau_Lagerschalehalter.iges   (Zusammenbau, IGES — Lieferstandard laut CAD-Doku)
├── Schweißgruppe_Halter.iges
└── Einzelteile/
    ├── Lagerhalter.iges
    ├── Lagerschale.iges
    ├── Scheibe_t=1.iges
    ├── Scheibe_t=5.iges
    ├── Welle_V1.iges
    └── Welle_V2.iges
```

**Hinweis Format-Auswahl:** CAD-Standard 2026-04-17 benennt IGES als historisches Bens-Lieferformat (`.iges`-Endung, aus Fusion-Export). Der vorhandene STP-Export ist nur für den Zusammenbau verfügbar. Beides mitgeliefert, Reiner-Entscheidung Montag welches Format final an Volker geht.

### Stückliste als CSV

CSV-Export aus `BOM_bereinigt.xlsx` (bereits white-label-bereinigt durch Teil 1).

| | Datei | md5 | Bemerkung |
|---|---|---|---|
| Quelle | `BOM_bereinigt.xlsx` | `d770bfb3123325a7de27ae20cab1349d` | |
| Export | `BOM_bereinigt.csv` | `3e68bc66a2a7a6f340403b1c87e6a0b7` | Trennzeichen `;`, UTF-8, Leak-Scan 0 Treffer |

### Blocker — PDFs nicht lieferbar ohne Fusion-Neuexport

Alle 10 PDFs aus dem Fusion360-Paket (`07 Anhänge/Fusion360/…/PDF/`) enthalten im Vektor-Text des Schriftfelds den Konstrukteur-Eintrag `Sebastian Hartmann` bzw. Prüfer-Eintrag `Woldrich`. Direkter String-Replace im Content-Stream ist nicht sicher (siehe Teil 2) — Risiko Geometrie-Beschädigung.

| PDF | Hits (hartmann/w-ec/woldrich/sachsenmilch/SM_) |
|---|---|
| Zusammenbau_Lagerschalehalter Zeichnung.pdf | 3 |
| Zusammenbau_Lagerschalehalter Zeichnung lang.pdf | 3 |
| Schweißgruppe_Halter Zeichnung (~recovered).pdf | 1 |
| Lagerhalter Zeichnung (~recovered).pdf | 1 |
| Lagerschale Zeichnung.pdf | 1 |
| Scheibe_t=1 Zeichnung.pdf | 1 |
| Scheibe_t=3 Zeichnung.pdf | 1 |
| Welle_V1 Zeichnung.pdf / Welle_V1 Zeichnung (~recovered).pdf | 1 / 1 |
| Welle_V2 Zeichnung.pdf | 1 |

**Einzige saubere Lösung:** Fusion-Template-Schriftfeld auf Bens-Konvention umstellen (L7/M7-Entscheidung Montag) und alle 10 PDFs neu exportieren. Kann Claude Code **nicht** — Fusion-360-Zugriff nötig. Die zwei bereits im Liefer-Ordner befindlichen PDFs (`Grundplatte Zeichnung.pdf`, `Zwischenplatte Zeichnung.pdf`) sind vom gleichen Blocker betroffen — Metadaten bereinigt, Vektor-Text im Schriftfeld bleibt bis Fusion-Export.

**Konsequenz:** PDF-Teil der Lieferung ist **nicht abgesandt-fertig**, bis Sebastian oder Reiner den Fusion-Neuexport macht. Stückliste + 3D-Daten können jederzeit raus.

## Teil 5 — Werkstoff-Syntax-Fix + LIESMICH komplettiert (2026-04-21)

Sachlicher Norm-Verstoß in der BOM entdeckt und selbst korrigiert (eindeutiger Tippfehler, keine inhaltliche Entscheidung):

### Werkstoff-Nummer DIN EN 10027-2

| | Alt | Neu | Betroffene Zellen |
|---|---|---|---|
| Syntax | `1.44.04` (keine gültige Werkstoff-Nummer) | `1.4404` (X2CrNiMo17-12-2, AISI 316L) | 12 Zellen |

Fix in allen vier Spiegeln durchgezogen: `BOM_bereinigt.xlsx` + `BOM_bereinigt.csv` im Session-Ordner **und** im `_An_Volker/Stueckliste/`-Liefer-Paket. Backup vor Fix: `BOM_bereinigt.xlsx.backup_20260421_werkstofffix`.

Verify: `grep -c "1.44.04"` in allen vier Dateien = 0.

### LIESMICH.txt vervollständigt

War abgeschnitten nach „Bens Edelstahl GmbH" (Zeile 34, kein Kontakt). Neu: ergänzt um Werkstoff-Angabe (1.4404), BOM-Hinweise (B16-Nummernkonflikt transparent gemacht, B11/B12-Duplikat als Absicht erklärt), Hinweis auf direkten Projektkontakt bei Rückfragen. White-Label-sauber, keine WEC-Adresse.

### Offene BOM-Punkte (für Reiner-Entscheidung, nicht selbst korrigiert)

- **B16 Welle_V2 `BE-LS-202603-203`**: Suffix `-0` fehlt, kollidiert mit B5 Scheibe_t=1 `-203-0`. Vorschlag `207-0`. Im LIESMICH transparent als „Abstimmung läuft" ausgewiesen.
- **B11 + B12 identisch** (beide `BE-LS-202603-1-0 Schweißgruppe_Halter`, je Menge 2): vermutlich Absicht (4 Schweißgruppen gesamt), aber Nummern-Schema bricht das dreistellige `XXX-Y`-Muster. Im LIESMICH als „wird mit PDF-Nachlieferung auf `001-0` vereinheitlicht" dokumentiert.

---

## Teil 6 — BOM-Struktur-Bereinigung (2026-04-21 Reiner-Session)

Nach der Reiner-Session am 2026-04-21 wurden die vier entschiedenen Punkte sowie die unter Teil 5 offenen BOM-Befunde umgesetzt. Alle Änderungen im Liefer-Paket `_An_Volker/Stueckliste/` (XLSX + CSV synchron). Backup vor Umsetzung: `BOM_bereinigt.{xlsx,csv}.backup_20260421` (Welle_V2) und `.backup_20260421_b` (Welle_V1 / recovered / Schweißgruppe).

### Zeichnungsnummern und Bauteilnamen

| Ort | Alt | Neu | Grund |
|---|---|---|---|
| R16 / Z16 — Welle_V2 | `BE-LS-202603-203` | `BE-LS-202603-207-0` | Kollision mit Scheibe_t=1 `-203-0` aufgelöst; `-207-0` frei |
| R18, R20 / Z18, Z20 — Welle_V1 | `BE-LS-202603-206-0` | `BE-LS-202603-204-0` | Konsolidierung: Welle_V1 existierte mit zwei Nummern (Haupt-`-204-0` und Recovery-`-206-0`) für dasselbe Bauteil |
| R10 / Z10 — Spalte C | `Steg_Lagerschalenhalter (~recovered)` | `Steg_Lagerschalenhalter` | `~recovered`-Suffix ist Onshape-Export-Artefakt, keine Variante |
| R18, R20 / Z18, Z20 — Spalte C | `Welle_V1 (~recovered)` | `Welle_V1` | dito |
| R24 / Z24 — Schweißgruppe_Halter | `BE-LS-202603-1-0` | `BE-LS-202603-001-0` | dreistelliges Schema `XXX-Y` auf die Baugruppe angewendet (konsistent mit `-000-0` Hauptbaugruppe) |

### Schweißgruppen-Dublette gestrichen

Pos 12 / 12.1 / 12.2 (R27–R29 bzw. CSV Z27–Z29) komplett entfernt. Die Zeilen spiegelten Pos 11 / 11.1 / 11.2 zellenidentisch und waren ein Onshape-Export-Artefakt; die Mengenlogik ist mit Pos 11 × 2 vollständig abgebildet (2 Schweißgruppen, intern je 1× Lagerschale + 1× Lagerhalter). Damit ist das im LIESMICH angekündigte „wird auf `001-0` vereinheitlicht" abschließend umgesetzt.

### Vier Reiner-Entscheidungen zusammengefasst

| # | Punkt | Entscheidung |
|---|---|---|
| 1 | Welle_V2 Zeichnungsnummer | `-203` → `-207-0` (umgesetzt) |
| 2 | Schriftfeld L7/M7 (Hartmann/Woldrich) | bleibt — Fusion-Default, kein Template-Fix nötig |
| 3 | 3D-Format | **IGES primär + STEP AP203 zusätzlich** — beides liefern |
| 4 | Produkt-Kontext | Lebensmittel/EHEDG (Sachsenmilch Käsekarussell), kein Pharma/GMP |

### White-Label-Verify (Schluss-Check)

Rekursiver grep durch `_An_Volker/` gegen `Hartmann|Woldrich|WEC|w-ec|Sachsenmilch|SM_|hartwire|mthreed|Modern3b` (case-insensitive) über IGES, STEP, TXT, CSV, XLSX (entpackt) → **0 Treffer**. Hartmann/Woldrich verbleiben ausschließlich im PDF-Schriftfeld, das entspricht Entscheidung 2.

### Offen für Fusion (außerhalb dieses Protokolls)

- STEP AP203 Re-Export für Schweißgruppe und alle 7 Einzelteile (aktuell liegt nur der Zusammenbau als STEP vor)
- PDF-Re-Export aller 12 Zeichnungsblätter; auf dem Welle_V2-Blatt muss die aktualisierte Nummer `BE-LS-202603-207-0` stehen

### 2026-04-21 nachmittags — v5-Patcher Philosophie-Shift

Die unter [[Umsetzungs-Tabelle_Reiner_v5]] als *"umzusetzen in Fusion 360 (Mo)"* markierten Nummern-Transforms werden ab sofort **nicht mehr in Fusion** nachgezogen, sondern durch den **v5-Patcher** beim Rausgang automatisiert. Fusion bleibt Geometrie-Wahrheit (Geometrie + Roh-Export), v5 ist Liefer-Wahrheit Stufe 1 (Nummern, White-Label, Material-Strings), v4 ist Liefer-Wahrheit Stufe 2 (Info-Block).

Hintergrund: mThreeD-weite Konvention vom 2026-04-21, dass Zeichnungsnummern für externe Lieferungen nicht mehr in Fusion vergeben werden. Register pro Kunde, Nummern nie recycelt.

**Artefakte im Vault:**
- `02 Projekte/WEC/scripts/v5_patcher.py` — pymupdf-basiertes kontext-bewusstes PDF-Text-Replace mit Staging+Audit+Block-Mechanik
- `02 Projekte/WEC/scripts/run_v5.sh` — venv-Wrapper nach mThreeD-Konvention (`~/.local/share/mthreed/v5-patcher/venv`)
- `mapping_lagerschalenhalter.yaml` (im selben Projekt-Ordner wie dieses Protokoll) — konkrete Transforms für die 9 Input-PDFs aus `_An_Volker/PDF/`

**Substring-Bug geschlossen:** kontext-bewusstes Replace verhindert, dass z.B. `SM_Lagerschale` beim Ersetzen von `Lagerschale` mitgetroffen wird. Jede Regel baut Regex aus `context_before + find + context_after` und muss im Seiten-Text exakt einmal matchen — sonst BLOCK. Validierung in zwei Stufen: Text-Ebene + pymupdf-Rect-Ebene. Mehrdeutigkeiten landen im `_blocked/`-Ordner mit Audit-Eintrag samt Fix-Hint.

**Stücklisten-Scope:** Die Zusammenbau-Zeichnungen enthalten alte Nummern mehrfach (Haupt-Zeile + Schweißgruppen-Unterzeilen). Stücklisten-Patches laufen daher bewusst nicht über v5, sondern bleiben in der BOM-Pipeline (`BOM_bereinigt.xlsx` → Re-Export bei finaler Zusammenstellung).

**Nächster Schritt (nicht heute):** erster Dry-Run gegen die 9 PDFs, Audit lesen, Mapping iterativ verfeinern bis 0 blockiert, dann v4 drüber, dann Paket-Build.

**Getestet:** synthetische Fixture in Claude-Sandbox — Bug-Szenario sauber gepatcht, Ambiguitäts-Szenario sauber geblockt, Render visuell geprüft (Positionen sitzen, `AM_Lagerhalter`-Platzhalter unangetastet). Testdaten nicht im Vault — Verifikation nur unter Laborbedingungen notwendig, die echten PDFs bleiben die echte Probe.

### 2026-04-21 nachmittags — Schema-Iteration nach Konsistenz-Review

Review des Nummernregisters förderte zwei Regel-Verletzungen in der Umsetzungs-Tabelle_Reiner_v5 zutage: (a) Ziel-Nummer `-200-0` wäre sowohl verbranntes Lagerhalter-Einzelteil als auch neuer Zusammenbau V2 — direkter Keine-Recycling-Verstoß; (b) Ziel-Nummern `-201-0`, `-202-0` hätten ebenfalls BOM-Altnummern recycelt. Deshalb Schema auf `BE-LS-202603-XYZ-R` mit Y-getrennten Hierarchie-Ebenen umgestellt:

| Stelle | Bedeutung |
|---|---|
| X | Scope: `0`=gemeinsam, `1`=V1, `2`=V2, `7`=Kaufteile |
| Y | Ebene: `1`=Einzelteil, `5`=Schweißgruppe, `9`=Zusammenbau |
| Z | laufende Nummer ab 1 |
| R | Revision (ab 0) |

Neue Zielnummern sind alle frisch (Register gegengeprüft). Hierarchie auf einen Blick lesbar: `Y=1` = Einzelteil, `Y=5` = Schweißgruppe, `Y=9` = Zusammenbau. Konkrete Vergabe für diese Lieferung:

- Einzelteile gemeinsam: `-011-0` Scheibe t=1, `-012-0` Lagerhalter, `-013-0` Lagerschale, `-014-0` Steg
- V1 Einzelteile: `-111-0` Welle V1, `-112-0` Scheibe t=5
- V1 Schweißgruppe: `-151-0` Schweißgruppe_Halter V1
- V1 Zusammenbau: `-191-0`
- V2 Einzelteile: `-211-0` Welle V2, `-212-0` Scheibe t=3
- V2 Schweißgruppe: `-251-0` (neu zu konstruieren)
- V2 Zusammenbau: `-291-0`
- Kaufteile: `-701-0` Lager, `-702-0` Klemmring

Damit sind Umsetzungs-Tabelle_Reiner_v5 und alle darin genannten Zielnummern abgelöst. Diese Tabelle bleibt als historischer Planungsvorschlag im Vault; aktuelle Wahrheit ist [[_Register/Volker-Bens-Nummernregister]]. [[mapping_lagerschalenhalter]] wurde entsprechend aktualisiert.

### 2026-04-21 später Nachmittag — PDF-Inspektion, Mapping-Neufassung, Liefer-Plan

CC hat die neun Fusion-PDFs im Liefer-Staging ausgelesen und den Report [[v5_pdf_inspection]] geschrieben. Ergebnis ändert das Mapping erheblich und schafft Klarheit beim Liefer-Plan.

**Anchor-Realität:** Keine der PDFs enthält wörtliche Feldnamen ("Zeichnungs-Nr.:", "Werkstoff:", "Projekt:"). Fusion exportiert das Schriftfeld als unbeschriftete Tabellen-Tokens. Anchor-Strategie neu: bei Einzelteil-/Schweißgruppe-PDFs wirkt **Bauteilname als `context_after`** (im Schriftfeld folgt nach dem Namen `----`, in der Stückliste folgt das Material-Feld — unterscheidbar); bei Zusammenbau-PDFs wirkt `SM_Lagerschale` als `context_before` vor der Nummer. Damit die globale `SM_`-Regel den Anchor nicht zerstört bevor die drawing-number-Regel feuert, wurde die Regel-Reihenfolge im Script umgedreht (per-file zuerst, global danach).

**Script-Erweiterung `mode: all`:** Der Patcher hatte bisher nur einen Unique-Modus (genau ein Treffer pro Regel, sonst Block). Das scheitert bei globalen Fixes wie `1.44.04 → 1.4404`, die pro Seite mehrfach vorkommen. Neuer Modus `all` ersetzt alle Vorkommen ohne Ambiguitätsprüfung (Audit zählt die Treffer). Erlaubt nur ohne `context_before`/`_after` (der Script hält das als `config_error` an, wenn man's doch kombiniert). Alle vier globalen Regeln (`SM_Lagerschale`, `AM_Lagerschale`, `1.44.04`, ` (~recovered)`) laufen jetzt mit `mode: all`.

**Alt-Nummern in den Schriftfeldern — drei Überraschungen:**

1. *Lagerhalter* trägt `BE-LS-202603-200` **ohne `-0`-Suffix** (Fusion-Inkonsistenz). Gleiches gilt für *Welle_V1* (`-204`). Die anderen Einzelteile haben den Suffix. Mapping muss das pro Datei exakt matchen.
2. *Welle_V2-Zeichnung* trägt im Schriftfeld `BE-LS-202603-206-0` — nicht `-207-0`, wie nach der Reiner-Umnummerierung heute morgen zu erwarten gewesen wäre. Analyse: `-206-0` war parallel als Welle_V1-Recovery-Dublette und als Welle_V2 vergeben (Fusion-Kollision). Reiner hat im Zusammenbau-BOM bereits auf `-207-0` umgestellt, die Einzelteil-Zeichnung wurde aber nicht neu exportiert. v5 patcht `-206-0` direkt auf `-211-0` — kein Fusion-Nachzug nötig. Die Nummer `-206-0` ist damit für beide historischen Verwendungen verbrannt.
3. *Scheibe_t=3 Zeichnung* trägt im Titelblock `Scheibe_t=3` und in ihrer eigenen Stückliste `Scheibe_t=5`. Das ist kein Fusion-Tippfehler, sondern zeigt die Projekt-Iterations-Historie: das Teil ist im Laufe der Änderungen von 3 mm auf 5 mm Dicke gewachsen, der Dateiname hinkt hinterher. Die Scheibe gehört zur Welle-V1-Gruppe (BOM Pos 7.1/8.2), **nicht** zu V2.

**Liefer-Plan Zusammenbau — Auflösung der V1/V2-Frage:**

Die PDF-Inspektion hat gezeigt: `Zusammenbau_Lagerschalehalter Zeichnung.pdf` (kurze Variante) enthält **nur Welle_V2** — das ist der saubere V2-only-Zusammenbau, bekommt `-291-0`. `Zusammenbau_Lagerschalehalter Zeichnung lang.pdf` enthält **Welle_V1 und Welle_V2 gleichzeitig** auf demselben Blatt — das ist der Fehler, den Reiner schon im Scan-Protokoll markiert hatte. Konsequenz:

- V2-Zusammenbau: kurze PDF → `-291-0`, in der Lieferung drin.
- V1-Zusammenbau: muss in Fusion als reiner V1-only-Zusammenbau neu exportiert werden (Ziel `-191-0`). Bis dahin **nicht Bestandteil der Lieferung**.
- Die lange Kombi-PDF fliegt aus der Lieferung raus (Konstruktionsfehler, ist Arbeitsmaterial nicht Liefer-Artefakt).

**Ziel-Nummern-Korrekturen im Register:**

- `-112-0` ist jetzt die Scheibe (5 mm Blech, für Welle V1), Quell-PDF `Scheibe_t=3 Zeichnung.pdf`. Vorher als "noch nicht im Staging" markiert.
- `-212-0` entfällt: V2 hat keine eigene Scheibe. Nummer bleibt frei im Register.
- `-191-0` (Zusammenbau V1) zeigt jetzt "noch nicht als V1-only-PDF vorhanden" mit Fusion-TODO.
- `-291-0` (Zusammenbau V2) zeigt die kurze Variante als bestätigte Quelle, Stückliste ohne eigene Scheibe.
- `-206-0` ergänzt in der Verbrannt-Liste als Welle_V2-Schriftfeld-Stand (parallel zur bestehenden Welle_V1-Recovery-Verwendung).

**Fusion-TODO-Liste nach dieser Session (für spätere Runde mit Reiner):**

- V1-only-Zusammenbau neu exportieren (aktuell nur als V1+V2-Kombi-Blatt vorhanden)
- Schweißgruppe_Halter V2 neu konstruieren (fehlt komplett)
- Steg_Lagerschalenhalter: klären ob eigene Zeichnung nötig oder nur BOM-Eintrag (Ziel `-014-0`, aktuell keine PDF im Staging)
- Welle_V2-Einzelteilzeichnung: BOM nennt `-207-0`, PDF trägt `-206-0` — Fusion-intern konsolidieren, wenn v5 nicht für alle Exporte benutzt wird

**Nächster Schritt (nicht heute):** Erster Dry-Run des v5-Patchers gegen die 8 verbliebenen PDFs (9 im Staging minus die Kombi-Lang-PDF).

### 2026-04-21 später Nachmittag — v5-Runs, Script-Fixes, v4-Info-Block, Paket-Build

**Run 1 (133322):** 8 Input-PDFs — 7 sauber gepatcht, 1 blockiert. Lagerhalter scheiterte an `ambiguous_text`: `BE-LS-202603-200` kommt auf der Seite zweimal vor (Schriftfeld + Stückliste), beides gefolgt von `Lagerhalter`. Die `\s*`-Konstruktion im Pattern matcht sowohl `\n` als auch ` ` — Anchor nicht streng genug. Sieben andere PDFs liefen durch, mit erwartbaren `not_found`-Meldungen für die globalen Regeln `SM_Lagerschale` / `AM_Lagerschale` / `~recovered` in Einzelteil-PDFs (dort nicht vorhanden).

**Mapping-Fix (erster Versuch):** `context_after` für Lagerhalter von `"Lagerhalter"` auf `"Lagerhalter\n----"` erweitert. Nach `Lagerhalter` folgt im Schriftfeld `----`, in der Stückliste `Blech 10` — sollte disambiguieren.

**Run 2 (133706):** Lagerhalter wieder blockiert — diesmal als `ambiguous_rect`. Der Text-Match auf Pattern-Ebene war jetzt eindeutig (1 Treffer statt 2), aber `pymupdf.search_for("BE-LS-202603-200")` liefert weiterhin 2 Rect-Boxen, und der Fallback des Scripts (full-text-Rect suchen) versagt, weil multi-line Strings in `pymupdf.search_for` grundsätzlich nicht als zusammenhängender Rect auffindbar sind.

**Script-Erweiterung `resolve_core_rect_via_words`:** Wenn mehrere core-Rects gefunden werden und Kontext gesetzt ist, nutzt der Patcher nun `page.get_text("words")` in Reading-Order und prüft token-weise, ob die davor/danach folgenden Wörter den Context-Tokens entsprechen. Multi-line Kontext `"Lagerhalter\n----"` wird dabei auf Whitespace/Newline gesplittet und als `["Lagerhalter", "----"]` verglichen. Fallback auf das bisherige full-text-Rect-Verfahren bleibt als zweite Stufe. `config_error` als neuer Status für `mode: all` mit ungewünschtem Kontext (Sicherheits-Leitplanke).

**Run 3 (134154):** Exit 0, Lagerhalter sauber gepatcht. Damit alle 8 PDFs durch v5.

**Konsolidierung:** Die sieben sauberen PDFs aus Run 1 und die eine aus Run 3 nach `_v5_staging/_final/` kopiert. Originale Runs bleiben für Audit-History erhalten. Konsolidiertes Audit unter `_final/AUDIT_KONSOLIDIERT.md` dokumentiert Herkunft jeder Datei, verbleibende `not_found`-Meldungen als bekanntes Rauschen, offene Fusion-TODOs.

**Visuelle Stichprobe v5:** Zwei PDFs (Lagerhalter, Zusammenbau V2) gerendert und im Chat geprüft. Alle Ersetzungen sitzen positions- und größengerecht. Nebenfund: der Title im Zusammenbau heißt `Zusammenbau_Lagerschalehalter` — fehlender `n` im Wort Lagerschalenhalter. Nicht v5-Scope (Fusion-Title-Feld), Fusion-TODO notiert.

**v4-Patcher format-aware gemacht:** Der bisherige v4 hatte hart codierte A3-Block-Koordinaten `(722, 162)-(1128, 202)`. Auf A2 (Zusammenbau V2) hätten die den Block an die falsche Stelle gesetzt. Script umgebaut auf Margin-basierte Geometrie: `RIGHT_MARGIN=63`, `BOTTOM_MARGIN=162`, `BLOCK_WIDTH=406`, `BLOCK_HEIGHT=40`. Daraus wird pro Seite die konkrete Position berechnet. Auf A3-quer ergibt das die historische Position, auf A2-quer (1684×1191) landet der Block bei `(1215, 162)-(1621, 202)` — proportional gleiche Stelle relativ zum Schriftfeld.

**venv-Konvention:** `run_v4.sh` analog zu `run_v5.sh` auf eigenes venv unter `~/.local/share/mthreed/v4-patcher/venv` umgestellt. Erster Lauf scheiterte noch am alten Wrapper (PEP-668-Verletzung). Nach Umstellung läuft das venv idempotent, installiert `pikepdf>=9.0` und `reportlab>=4.0` beim Erststart.

**v4-Lauf:** 8/8 PDFs durch, Info-Block (Ra ≤ 0,8 µm, ISO 2768-m, EHEDG, Edelstahl 1.4404 / AISI 316L) auf allen Zeichnungen, Position in beiden Formaten korrekt. Output in `_v5_staging/_final_v4/` mit `_v4`-Suffix pro Datei.

**Visuelle Stichprobe v4:** Lagerhalter A3 und Zusammenbau V2 A2 final geprüft — Info-Block sitzt exakt über dem Schriftfeld, rechtsbündig, in beiden Formaten identisch positioniert. Drei Zeilen lesbar, keine Überlappung mit Zeichnungselementen, sauberer weißer Fill mit schwarzem Rahmen.

**Paket-Build:** Liefer-Ordner `2026-04-21 Montag-Session/_Paket_fuer_Reiner/` angelegt. Explizite `cp`-Kommandos pro Datei (keine Globs — bewährte Paket-Build-Regel), `_v4`-Suffix beim Kopieren entfernt für Kunden-Sicht (`BE-LS-202603-XXX-X_Bauteilname.pdf`). ZIP gebaut mit `zip -r ... -x "*.DS_Store"`, 1.75 MB, 8 PDFs unter einem sprechenden Wurzelordner. Liefer-Notiz für Reiner mit Inhalt des Pakets, was noch aussteht, Tonalitäts-Vorschlag für die Kunden-Mail, Rollback-Hinweisen bei Rückfragen.

**Stand Ende Montag-Session:** Paket versandfertig in `_Paket_fuer_Reiner/Bens_Lagerschalenhalter_Lieferung_2026-04-21.zip`. Reiner übernimmt den Versand an Volker. Die drei Fusion-TODOs (V1-only-Zusammenbau, Schweißgruppe V2, Title-Tippfehler `Lagerschalehalter`) plus Steg-Einzelzeichnungsfrage stehen zur nächsten Runde mit Reiner an.

**Produktions-Regel bestätigt:** Vor jedem "Raus"-Schritt (Mail, ZIP, BOM-Write) — Staging + Audit-Liste + Mo-Freigabe, nie direkt rausschicken. Diese Session hat das Muster in fünf Iterationen gehalten.

### 2026-04-21 spätnachmittags — v2-Paket mit erweitertem Info-Block (Backup)

Nach Muster-Analyse von Reiners Solid-Edge-Projekten (Hebehilfe Cavanna, Schwenkteilsicherung, Sprühlanze) auf dem heute eingetroffenen INTENSO-Stick ist klar geworden: Reiners eigenes Schriftfeld-Template enthält bereits Allgemeintoleranzen inkl. Schweißnorm `DIN EN ISO 13920-BF`, Oberflächenangabe `DIN EN ISO 1302`, Copyright-Klausel und Lebensmittel-Hygiene-Notizen (gratfrei, ölfrei, gebeizt, passiviert). Unser v1-Info-Block war dagegen minimalistisch (nur EHEDG + ISO 2768-m + Edelstahl-Bezeichnung).

Als präventive Backup-Version wurde ein `v4_patcher_v2.py` mit erweitertem Info-Block (6 Zeilen, Block 450×80 pt statt 406×40) gebaut und gegen die acht v5-Outputs gelegt. Paket `Bens_Lagerschalenhalter_Lieferung_2026-04-21_v2.zip` (1.76 MB) liegt parallel zum v1-Paket im `_Paket_fuer_Reiner/`-Ordner. Nicht versendet, Backup für den Fall dass Reiner bei Durchsicht der v1 auf fehlende Norm-Hinweise oder Hygiene-Anweisungen stößt. Liefer-Notiz mit Hinweis auf beide Versionen aktualisiert.

### 2026-04-21 abends — Reiner-Rückmeldung (Telefonat + kurze E-Mail)

Reiner hat das v1-Paket durchgesehen und zurückgemeldet, dass es **so nicht freigegeben wird**. Zwei harte Punkte:

1. **Zeichnungsnummern stimmen nicht mit den Stücklisten-Einträgen überein.** Die v5-Pipeline hatte nur die Schriftfeld-Nummern umnummeriert; in den Stücklisten standen weiterhin die alten Fusion-Nummern (`-200`, `-201`, `-203`, `-204`, `-205`, `-206`, `-207-0`, `-700`, `-704`, `-1-0`, `-001-0`). Bei Claudes visueller Stichprobe war das zwar sichtbar, wurde aber als "BOM-Pipeline-Scope" weggedefiniert statt als Liefer-Blocker flagged. Das war ein Fehler.
2. **Welle + Scheibe soll als Baugruppe geführt werden, mit eigener Baugruppen-Nummer** — nicht als Einzelteil. "Welle V1 V2 gibt es einmal als Einzelteil und einmal als Baugruppe, jeweils eine kurze und lange Variante" (Reiner-Zitat). Das bedeutet vier Welle-Zeichnungen sollten existieren, nicht zwei.

**Bestätigung aus Fusion-Export-Analyse:** In Fusion existieren tatsächlich vier Welle-Zeichnungen — je eine Einzelteil- und Baugruppen-Zeichnung pro V1 und V2. Im Liefer-Export landeten aber nur zwei, weil **beide Versionen gleich hießen** (`Welle_V1 Zeichnung.pdf` / `Welle_V2 Zeichnung.pdf`) und der Export mit identischen Dateinamen in dasselbe Zielverzeichnis die zweite die erste überschrieben hat. Für V1 landete die Baugruppe im Paket, für V2 das Einzelteil — Namens-Kollisions-Artefakt.

### 2026-04-21 abends — v3-Paket mit Stücklisten-Patches

**Mapping v3** erweitert um ~30 globale Stücklisten-Regeln (alle alten Nummern → neue Schema-Nummern, `mode: all`) plus per-file Kontext-Disambiguierungen für die Mehrdeutigkeiten (`-203` tauchte zweimal auf, einmal als Scheibe_t=1 und einmal als Welle_V2; `-206` einmal als V1-Recovery und einmal als V2). Welle_V1-Zeichnung wurde als Baugruppe interpretiert (Stückliste zeigt 2 Teile) und auf `-152-0` umnummeriert, Dateiname `BE-LS-202603-152-0_Baugruppe_Welle_V1.pdf`. Register entsprechend angepasst: `-111-0` als Einzelteil V1 (PDF fehlt, Fusion-TODO), `-152-0` als Baugruppe V1 (= aktuelle PDF), `-252-0` Baugruppe V2 (Fusion-TODO), `-251-0` Schweißgruppe V2 (Fusion-TODO).

**v5v3-Run** (15:28:56) — 8/8 sauber, 30 von 165 Regeln applied, keine Blocker. Ein `-001-0 → -251-0`-Patch als `not_found` gemeldet (Nummer war bereits durch die vorherige `-1-0 → -251-0`-Regel erfasst oder war tatsächlich nicht im PDF, nicht kritisch). v4v2-Info-Block drübergelegt. Paket v3 (1.76 MB) gebaut, liegt parallel zu v1 und v2 im `_Paket_fuer_Reiner/`-Ordner, nicht versendet — Mo wollte visuellen Check vor Rausgang abwarten.

### 2026-04-21 abends — Reiner-E-Mail, Klärung "Baugruppe", Fusion-Re-Export aller 11 Zeichnungen

Reiners E-Mail präzisierte: *"Bitte mache die Zeichnungsnummern gleich der Bauteilnummer. Mache aus der Welle V mit der Scheibe -112 eine Baugruppe."* Die Tippfehler-Mehrdeutigkeit "Welle V" wurde im Telefonat aufgelöst: beide Varianten brauchen die Baugruppen-Zeichnung (Welle+Scheibe), analog zur Schweißgruppe_Halter.

**Entscheidung:** Statt weiter mit dem zweifach-asymmetrischen v3-Stand zu arbeiten (V1-Baugruppe + V2-Einzelteil), exportiert Mo alle vier Welle-Zeichnungen in Fusion **mit eindeutigen Dateinamen** neu, plus Lagerhalter, Lagerschale und die drei weiteren. Dadurch entfällt die Namens-Kollision und jede Rolle (Einzelteil vs. Baugruppe) ist dateitypisch erkennbar.

**Neuer Liefer-Input:** 11 PDFs im `_An_Volker/PDF/`-Verzeichnis (alter Stand gesichert unter `_archiv_vor_fusion_update_1630/`):

- Lagerhalter Zeichnung.pdf
- Lagerschale Zeichnung.pdf
- Scheibe_t=1 Zeichnung.pdf
- Scheibe_t=3 Zeichnung.pdf
- Schweißgruppe_Halter Zeichnung.pdf
- Welle_V1 einzelteil Zeichnung.pdf
- Welle_V1 Schweisbaugruppe Zeichnung.pdf
- Welle_V2 einzelteil Zeichnung.pdf
- Welle_V2 Schweisbaugruppe Zeichnung.pdf
- Zusammenbau_Lagerschalehalter V1 Zeichnung.pdf
- Zusammenbau_Lagerschalehalter V2 Zeichnung.pdf

Reiners Terminologie ("Schweisbaugruppe") übernommen — entspricht SBG-Suffix aus den heute analysierten Muster-Projekten (Sprühlanze, Hebehilfe, Schwenkteilsicherung).

**Konsolidierungs-Entscheidung:** Heute abend kein Mapping v5 mehr, kein weiterer Paket-Build. Reiner hat angekündigt noch eine ausführlichere Änderungsmail zu schicken, die möglicherweise die Nummern-Logik oder Klassifizierung nochmal anpasst (besonders: Schweißgruppe_Halter als gemeinsam V1+V2 = `-151-0`, vs. varianten-spezifisch `-151-0` + `-251-0` mit identischem Zeichnungsinhalt). Morgen vormittags mit Reiner gemeinsam die finale Nummern-Architektur beschließen, dann Mapping v5 in einem Schuss bauen und Paket v4 rausgeben.

**Stand Ende 21.04. abends:** 11 neue Fusion-PDFs im Liefer-Input. Mapping v1/v2/v3 und die drei Pakete liegen archiviert als Iterationshistorie. Analyse-Lauf auf die 11 neuen PDFs ausstehend (CC-Prompt vorbereitet), liefert `_analyse_11pdfs_v2/ANALYSE.md` mit Schriftfeld-Nummern, Stücklisten-Inhalten und Schweißhinweisen — Grundlage für morgen früh.

**Morgen-Startpunkt:**
1. Reiner-Änderungsmail durchgehen, offene Nummern-Fragen klären
2. Mapping v5 auf Basis der 11 neuen PDFs + finaler Reiner-Logik
3. v5-Run + v4v2-Info-Block + Paket v4
4. Freigabe Reiner, Versand an Volker

**Gehirn-Stick-Update für Reiner** steht noch aus (von Mo heute vormittags gebeten, vor der Fusion-Re-Export-Iteration): Stick enthält Reiners alten Vault-Stand, soll vor morgen mit Mos aktuellem Stand aktualisiert werden damit Reiner direkt im aktuellen Material arbeiten kann. Wird heute Abend noch erledigt.

---

## Verknüpfungen

- [[04 Ressourcen/Playbook/Sessions/2026-04-18 Tool-Setup Sebastian-Mac|Tool-Setup-Session (gleicher Tag)]] — Erstfund des White-Label-Verstoßes
- [[03 Bereiche/WEC/CLAUDE]] — White-Label-Prinzip (verbindlich)
- [[04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl]] — Liefer-Standard
- [[03 Bereiche/WEC/raw/Kunden/Volker Bens/aktuelle Projekte/Lagerschalenhalter Lebensmittelindustrie|raw-Quelle]] (unantastbar)

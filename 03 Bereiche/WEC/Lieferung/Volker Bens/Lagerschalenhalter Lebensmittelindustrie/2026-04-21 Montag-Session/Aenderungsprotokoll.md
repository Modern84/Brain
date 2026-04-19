---
tags: [lieferung, bens, bom, pdf, white-label]
date: 2026-04-18
status: teilweise-bereinigt
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

## Verknüpfungen

- [[04 Ressourcen/Playbook/Sessions/2026-04-18 Tool-Setup Sebastian-Mac|Tool-Setup-Session (gleicher Tag)]] — Erstfund des White-Label-Verstoßes
- [[03 Bereiche/WEC/CLAUDE]] — White-Label-Prinzip (verbindlich)
- [[04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl]] — Liefer-Standard
- [[03 Bereiche/WEC/raw/Kunden/Volker Bens/aktuelle Projekte/Lagerschalenhalter Lebensmittelindustrie|raw-Quelle]] (unantastbar)

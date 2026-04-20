---
tags: [lieferung, bens, bom, pdf, white-label, intern]
date: 2026-04-18
status: teilweise-bereinigt
letzte-aenderung: 2026-04-20
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

## Verknüpfungen

- [[04 Ressourcen/Playbook/Sessions/2026-04-18 Tool-Setup Sebastian-Mac|Tool-Setup-Session (gleicher Tag)]] — Erstfund des White-Label-Verstoßes
- [[03 Bereiche/WEC/CLAUDE]] — White-Label-Prinzip (verbindlich)
- [[04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl]] — Liefer-Standard
- [[03 Bereiche/WEC/raw/Kunden/Volker Bens/aktuelle Projekte/Lagerschalenhalter Lebensmittelindustrie|raw-Quelle]] (unantastbar)

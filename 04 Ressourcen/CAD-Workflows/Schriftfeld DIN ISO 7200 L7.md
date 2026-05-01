---
tags: [ressource, cad, schriftfeld, bens, fusion-360]
date: 2026-05-01
status: aktiv
priorität: A
owner: Sebastian
raum: WEC
---

# Schriftfeld Bens — Layout-Rekonstruktion und ISO-7200-Mapping

## 1. Zweck & Abgrenzung

Diese Datei beschreibt das **visuelle Schriftfeld-Layout** der Bens-Solid-Edge-Vorlagen (`Vordruck.dft`, `Vordruck.dwg`, `Vordruck_A4.dwg`, `Bens_Vordruck.dwg`) als Vorlage für den **Fusion-360-Drawing-Template-Klon** (White-Label-Lieferungen an Bens Edelstahl GmbH). Ziel: Fusion-Zeichnungen sollen optisch identisch zu Solid-Edge-Zeichnungen aus Bens' eigenem Haus aussehen.

`unsicher:` Die Bens-Templates sind binär (Solid-Edge .dft / AutoCAD .dwg) und mit `strings` nicht klartext-lesbar. Das Layout in dieser Datei ist deshalb aus den **gerenderten PDFs** (Fusion-Export 2026-04-16, Sebastian) abgeleitet, nicht direkt aus den Templates. Für das exakte Bens-Original-Layout (Solid Edge) ist eine Sichtprüfung mit Reiner nötig — er hat Solid-Edge-Zugriff.

ISO 7200 (DIN EN ISO 7200:2004-05) definiert **nur Datenfelder** (welche Inhalte das Schriftfeld tragen muss), **kein verbindliches Layout**. Sie ist hier nur als Pflicht-Checkliste relevant.

**Wichtige Klarstellung „L7/M7":** Die Bezeichnungen `L7` und `M7` bezeichnen im Vault-Kontext **zwei verschiedene Dinge**:
- In der **Excel-BOM** (`*_BOM.xlsx`, sheet1): Zellen-Adressen der Spalten „Konstrukteur" (L) und „Ingenieur" (M) in Zeile 7 — siehe `Aenderungsprotokoll.md` Z.39–41.
- Im **PDF-Schriftfeld** der Zeichnung: dieselben logischen Felder (Bearbeiter / Geprüft), aber dort ohne Zell-Notation — Position siehe Skizze unten.

Die Konvention „L7/M7" wird im Vault als **Kurz-Code für die beiden Personen-Felder** verwendet, weil BOM und Schriftfeld synchron befüllt werden (`Aenderungsprotokoll.md` Z.168). Sie ist **keine ISO-7200-Terminologie**.

## 2. Bens-Schriftfeld — visuelles Layout

Quelle: `Zusammenbau_Lagerschalehalter Zeichnung.pdf` (Fusion-Export 2026-04-16), Schriftfeld unten rechts. Layout über `pdftotext -layout` rekonstruiert. Maße in mm sind **unsicher** (aus Fusion-Default abgeleitet, nicht aus Bens-Template gemessen).

```
+---------------+----------------------------+----------------------------+
| Maßstab:      | Technical reference:       | Bearbeitet:                |   <- Zeile 1
| 1:1           |                            | Sebastian Hartmann         |   (entspricht "L7"
|               |                            | 2026-04-16                 |    Konstrukteur)
+---------------+----------------------------+----------------------------+
| Geprüft:                  | Document type: | Anmerkung:                 |   <- Zeile 2
| Woldrich                  |                | Zusammenbau                |   (entspricht "M7"
| 2026-04-16                |                |                            |    Ingenieur)
+---------------------------+----------------+----------------------------+
| Title                                      | Zeichnungsnummer:          |   <- Zeile 3
| Zusammenbau_Lagerschalehalter              | BE-LS-202603-000-0         |
| SM_Lagerschale                             |                            |
+--------------------------------------------+----+--------------+--------+
|                                            |Rev.| Date of issue| Sheet  |   <- Zeile 4
|                                            |    |              |  1/1   |
+--------------------------------------------+----+--------------+--------+
```

**Block-Geometrie** (aus `v4_patcher.py` Z.18–23, gemessen am A3-Fusion-Export):
- Zusatz-Info-Block (Toleranz / Werkstoff / Oberfläche) liegt **oberhalb** des Schriftfelds
- Position relativ zum Blattrand: 63 pt vom rechten Rand, 162 pt vom unteren Rand
- Block-Größe: 406 × 40 pt
- Konstanten gelten für A3-quer (1191×842 pt), A2-quer (1684×1191 pt) und A4 — Fusion skaliert das Schriftfeld nicht mit, sondern hält den Abstand zum Eckpunkt unten-rechts konstant.

`unsicher:` Die in Fusion verwendete Schriftart ist Arial (Fallback-Kette in `v4_patcher.py` Z.31–36). Bens-Original-Schrift in Solid Edge ist nicht verifiziert — visuell aus PDFs sieht es nach einer serifenlosen Standard-Schrift aus, vermutlich Arial oder ISO-CVI. Mit Reiner abgleichen.

## 3. Feld-Inventar Bens

| Feldname (Zeichnung) | Code / Adresse | Pflicht / Optional | Inhalt im Liefer-PDF | Quelle / wie ermittelt |
|---|---|---|---|---|
| Maßstab | Zeile 1, links | Pflicht | `1:1` | PDF-Extrakt Z.74 |
| Technical reference | Zeile 1, mitte | Optional (leer) | *(leer)* | PDF-Extrakt Z.74 |
| Bearbeitet (Konstrukteur) | „L7" / Zeile 1, rechts | Pflicht | `Sebastian Hartmann` + `2026-04-16` | PDF-Extrakt Z.74 + `Aenderungsprotokoll.md` Z.39 |
| Geprüft (Ingenieur) | „M7" / Zeile 2, links | Pflicht | `Woldrich` + `2026-04-16` | PDF-Extrakt Z.74 + `Aenderungsprotokoll.md` Z.40 |
| Document type | Zeile 2, mitte | Optional (leer) | *(leer)* | PDF-Extrakt Z.77 |
| Anmerkung | Zeile 2, rechts | Optional | `Zusammenbau` | PDF-Extrakt Z.77 |
| Title | Zeile 3, links | Pflicht | `Zusammenbau_Lagerschalehalter` + Untertitel `SM_Lagerschale` | PDF-Extrakt Z.80–82 |
| Zeichnungsnummer | Zeile 3, rechts | Pflicht | `BE-LS-202603-000-0` | PDF-Extrakt Z.80 |
| Rev. | Zeile 4, mitte-links | Pflicht | *(leer)* | PDF-Extrakt Z.83 |
| Date of issue | Zeile 4, mitte | Pflicht | *(leer im PDF)* | PDF-Extrakt Z.83 |
| Sheet | Zeile 4, rechts | Pflicht | `1/1` | PDF-Extrakt Z.84 |
| Allgemein-Oberfläche | Zusatz-Block (Patcher-Overlay) | Bens-Konvention | `Ra ≤ 0,8 µm (Rz 6,3) nach DIN ISO 1302` | `v4_patcher.py` Z.27 |
| Toleranz / Kanten | Zusatz-Block (Patcher-Overlay) | Bens-Konvention | `ISO 2768-m  \|  Kanten gebrochen, Radien R ≥ 6 mm (EHEDG)` | `v4_patcher.py` Z.28 |
| Werkstoff | Zusatz-Block (Patcher-Overlay) | Bens-Konvention | `Edelstahl 1.4404 / AISI 316L` | `v4_patcher.py` Z.29 |
| Logo (Bens) | links unten | Pflicht (White-Label) | `Bens Logo.jpg` | `Standards & Vorlagen/Bens Logo.jpg` |

## 4. ISO 7200 — Pflicht-Datenfelder als Checkliste

DIN EN ISO 7200:2004 definiert **8 Pflichtfelder**, gegliedert in drei Gruppen: identifizierende, beschreibende und verwaltende Datenfelder. Quelle: ISO 7200:2004(E) sowie deutsche Beuth-Übersetzung (siehe Quellen unten). Mapping auf das Bens-Layout:

- [x] **Gesetzlicher Eigentümer** (legal owner) — pflicht. Bens-Mapping: Logo-Block links unten + ggf. „Bens Edelstahl GmbH" als Textzeile. ✅ vorhanden via Logo, **Textzeile mit Firma fehlt** im aktuellen Fusion-Export.
- [x] **Identifikationsnummer / Sachnummer** (identification number) — pflicht. Bens-Mapping: `Zeichnungsnummer` (z. B. `BE-LS-202603-000-0`). ✅
- [x] **Titel / Bezeichnung** (title) — pflicht. Bens-Mapping: `Title`-Feld. ✅
- [x] **Ausgabedatum** (date of issue) — pflicht. Bens-Mapping: `Date of issue` Zeile 4. ❌ aktuell leer im Liefer-PDF — Pflichtverstoß, muss befüllt werden.
- [x] **Blatt / Anzahl Blätter** (sheet number / total sheets) — pflicht. Bens-Mapping: `Sheet` (`1/1`). ✅
- [x] **Änderungsindex / Revision** (revision index) — pflicht. Bens-Mapping: `Rev.` Zeile 4. ❌ aktuell leer im Liefer-PDF (Erstausgabe = Index `0` oder `-` setzen, nicht leer).
- [x] **Bearbeiter / Ersteller** (creator / drawn by) — pflicht (administrativ). Bens-Mapping: `Bearbeitet` („L7"). ✅ vorhanden, aber **White-Label-Konflikt** (Sebastian Hartmann statt Bens-Konvention).
- [x] **Genehmiger / Prüfer** (approver) — pflicht (administrativ). Bens-Mapping: `Geprüft` („M7"). ✅ vorhanden, **White-Label-Konflikt** (Woldrich = WEC-intern).

**Im Bens-Layout fehlt explizit:**
- **Sprachenzeichen** (language code, optional/empfohlen) — nirgends im Layout. Da Liefer-Sprache durchgehend Deutsch ist, kann das im Fusion-Klon weggelassen oder als unsichtbares iProperty mitgeführt werden.
- **Klassifikation / Schlüsselwörter** (optional) — nicht vorhanden, nicht nötig.
- **Format-Angabe** (A3, A2, …) — nicht vorhanden im sichtbaren Schriftfeld; Fusion bringt es als Blatt-Eigenschaft.

## 5. White-Label-Konsequenzen

Bei Lieferungen an Bens dürfen **niemals** WEC-/Sebastian-/Reiner-Identitäten extern sichtbar sein. Diese Felder müssen Bens-Inhalt zeigen:

- **Bearbeitet („L7")** — derzeit `Sebastian Hartmann` → Reiner-Entscheidung (leer / `VB` / Bens-interne Konvention). Quelle der Lücke: `Aenderungsprotokoll.md` Z.149 + Z.252.
- **Geprüft („M7")** — derzeit `Woldrich` → analog Reiner-Entscheidung. Reiner ist im Stahlbau-Kontext der natürliche Prüfer, sein Name ist nach außen unproblematisch — aber die Konvention muss in Bens' Hand liegen.
- **PDF-Metadaten** (Author/Producer im PDF-Header) — beim Fusion-Export auf `Bens Edelstahl GmbH` setzen, nicht leer (siehe Pilot-Erkenntnis 2026-04-18, Daily Note Z.270–274: leere Properties füllen sich beim nächsten Speichern automatisch wieder mit User-Account).
- **Excel-BOM L7 / M7 / N7** synchron zum PDF-Schriftfeld halten (Konstrukteur, Ingenieur, Projekt-Kürzel). `Aenderungsprotokoll.md` Z.168.
- **Logo-Block** muss `Bens Logo.jpg` zeigen, nicht WEC-Logo.

Verweis: White-Label-Regel im WEC-Raum — siehe [[03 Bereiche/WEC/CLAUDE.md]] (Master-Dokument für die Bens-Lieferdisziplin). `unsicher:` Datei nicht in dieser Recherche gelesen, aber im Brain-CLAUDE.md als Raum-Einstieg referenziert.

## 6. Offene Punkte / TODO

- TODO: **L7/M7 final klären** — Reiner-Termin (Montag-Session 2026-04-21 oder folgender Termin). Optionen: leer / `VB` / Bens-interne Konvention. Direkt im Solid-Edge-Template (`BENS Edelstahl - ET.dft` / `BENS Edelstahl-ET- BG.dft`) festlegen, dann in Fusion-Klon spiegeln. Quelle: Wiki-Eintrag Z.157.
- TODO: **Solid-Edge-Sichtprüfung** mit Reiner — exakte Maße (mm), Schriftart, Linienstärken aus dem Original-Vordruck.dft auslesen. `strings`-Scan ergibt nichts, weil Solid-Edge-Format komprimiert ist.
- TODO: **Format-Probe Fusion-Klon** — A3-quer, A2-quer, A4-hoch, A4-quer durchspielen. Patcher-Konstanten in `v4_patcher.py` zeigen, dass die Position vom Eckpunkt unten-rechts berechnet wird (nicht skaliert) — dieses Verhalten muss der Fusion-Template übernehmen.
- TODO: **Pflichtfeld-Lücken schließen** — `Date of issue` und `Rev.` werden in den aktuellen Fusion-Exports leer ausgegeben (PDF-Extrakt Z.83). Im Template iProperty-Bindings setzen.
- TODO: **„Quality for Pharmacy"-Slogan-Phantom** — laut Wiki-Eintrag Z.158 in Brain-Notizen vermutet, in keinem Bens-Template oder Logo nachweisbar. Nicht in Fusion-Klon übernehmen, bevor Reiner bestätigt.
- TODO: **PDF-Producer-Metadaten** — beim Fusion-Export `Author = Bens Edelstahl GmbH` setzen (nicht über `hartmann@w-ec.de`).
- TODO: **Inventor-Variante** — falls parallel ein Inventor-Template gepflegt wird, gleiche Schriftfeld-Definition spiegeln (`Aenderungsprotokoll.md` Z.146).
- `unsicher:` Ob „Sprachenzeichen" als ISO-7200-Pflichtfeld zählt oder nur Empfehlung ist — Quellen widersprechen sich teilweise. Beuth-Originaltext einsehen (z. B. über HS-Ruhrwest-PDF, siehe Quellen).

## 7. Quellen

**Vault-Quellen (gelesen):**
- `/Users/sh/Brain/03 Bereiche/WEC/raw/Kunden/Volker Bens/Standards & Vorlagen/` — Datei-Listing (Bens_Vordruck.dwg, Vordruck.dwg, Vordruck_A4.dwg, Vordruck.dft, Bens Logo.jpg). `strings`-Versuch ergebnislos (Binärformat).
- `/Users/sh/Brain/03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/2026-04-21 Montag-Session/_Fuer_Reiner/Zeichnungen_PDF/Zusammenbau_Lagerschalehalter Zeichnung.pdf` — via `pdftotext -layout`, Schriftfeld-Bereich rekonstruiert.
- `/Users/sh/Brain/02 Projekte/WEC/scripts/v4_patcher.py` — Block-Geometrie (Z.18–23), Bens-Konvention für Toleranz/Werkstoff/Oberfläche (Z.27–29).
- `/Users/sh/Brain/03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/2026-04-21 Montag-Session/Aenderungsprotokoll.md` — L7/M7-Definition (Z.39–41), Schriftfeld-Lücke (Z.146, Z.149, Z.252), White-Label-Synchronität BOM↔PDF (Z.168).
- `/Users/sh/Brain/03 Bereiche/WEC/wiki/Kunden/Volker Bens - Lagerschalenhalter Lebensmittelindustrie.md` — Schriftfeld-Forensik 2026-05-01 (Z.157–158).
- `/Users/sh/Brain/05 Daily Notes/2026-04-18.md` Z.260–275 — White-Label-Bereinigung BOM, Pilot-Erkenntnis Metadaten positiv setzen.
- `/Users/sh/Brain/05 Daily Notes/2026-04-20.md` Z.22 + `2026-04-21.md` Z.27 — offene L7/M7-Frage.

**Web-Quellen (DIN ISO 7200):**
- ISO-Originalfassung: <https://www.iso.org/standard/35446.html>
- ISO-Sample-PDF (Standards iTeh): <https://cdn.standards.iteh.ai/samples/35446/d3b0887cb4fa47f49f8718807d3b8903/ISO-7200-2004.pdf>
- DIN-Media-Eintrag DIN EN ISO 7200:2004-05: <https://www.dinmedia.de/en/standard/din-en-iso-7200/69093619>
- HS-Ruhrwest-Lehrmaterial (Volltext-PDF, Hochschul-Bereitstellung): <https://elearning.hs-ruhrwest.de/pluginfile.php/294487/mod_folder/content/0/DIN%20EN%20ISO%207200_2004%20-%20Technische%20Produktdokumentation%20-%20Datenfelder%20in%20Schriftfeldern%20und%20Dokumentenstammdaten.pdf>
- Wikipedia-Übersicht ISO 7200: <https://en.wikipedia.org/wiki/ISO_7200>

## Verknüpfungen

- [[03 Bereiche/WEC/wiki/Kunden/Volker Bens - Lagerschalenhalter Lebensmittelindustrie]]
- [[03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/2026-04-21 Montag-Session/Aenderungsprotokoll]]
- [[04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl]]
- [[04 Ressourcen/Playbook/Fusion-zu-Liefer-Pipeline]]

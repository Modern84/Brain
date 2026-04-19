---
tags: [ressource, playbook, wec, standard, kundenordner, muster]
date: 2026-04-19
status: aktiv
quellen: [Volker Bens Analyse 2026-04-19]
---

# WEC Kundenordner — Muster und Ableitungen

Generisches Playbook für alle WEC-Kunden (Bens, Knauf, Pirna, zukünftige). Abgeleitet aus der vollständigen Ist-Soll-Analyse des Bens-Ordners vom 2026-04-19. Bens fungiert als **Leit-Beispiel** — die Muster gelten für jeden Kunden.

## Erkannte Muster

### 1. Drei-Schicht-Disziplin (raw / wiki / Lieferung)

| Schicht | Zweck | Editierbar durch |
|---|---|---|
| **raw/** | Eingangs-Originale unverändert archivieren | nur Reiner/Kunde (Quelle) |
| **wiki/** | Konsolidierte Wahrheit, eine Datei pro Thema | Claude + Sebastian (kontinuierlich) |
| **Lieferung/** | Ausgangs-Artefakte, vor Versand geprüft | Sebastian (Freigabe), Claude (Vorbereitung) |

**Prinzip:** raw ist authoritative für Herkunft, wiki ist authoritative für Inhalt, Lieferung ist authoritative für Außenwirkung. Divergenz zwischen den Schichten ist immer ein Arbeits-Signal.

### 2. Zeichnungsnummern folgen dem Muster `<Kundenkürzel>-<Typkürzel>-<JahrNr>-<Position>[-<Revision>]`

Bens-Beispiel: `BE-LS-202603-206-0` = **BE**ns / **L**ager**S**chale / Jahr 2026 Nr. 03 / Position 206 / Revision 0.

Positionsnummern-Systematik (aus Bens-Scans abgeleitet):
- **000–099** Gesamtbaugruppe / Hauptkomponente
- **100–199** Unterbaugruppen
- **200–299** Einzelteile (Fertigung)
- **700–799** Kaufteile (SKF, DIN, Normteile)

**Ableitung:** Jeder neue Kunde braucht dieses Schema in seinem `03 Bereiche/WEC/wiki/Kunden/<Kunde> - Profil.md` verankert. Abweichungen (z.B. Knauf hat eigenes Schema) dort dokumentieren, nicht erraten.

### 3. Kunden-Branding im Schriftfeld = Positionierungs-Signal

Bens-Scans zeigen: „BENS-EDELSTAHL / Quality for Pharmacy". Das Schriftfeld kommuniziert mehr als Kontaktdaten — es positioniert den Kunden im Markt. Pharma ≠ Lebensmittel (GMP + FDA 21 CFR).

**Ableitung:** Bei jeder neuen Kundenlieferung prüfen:
1. Schriftfeld-Text vollständig dokumentieren (nicht nur Adresse, auch Slogan/Zertifikate)
2. Positionierung daraus ableiten (Lebensmittel / Pharma / Chemie / Maschinenbau)
3. Normen-Stack entsprechend erweitern (EHEDG / GMP / ATEX / DIN-Reihen)

### 4. Stücklisten-Versionierung über Datumsstempel

Bens hat `Zusammenbau_Lagerschalehalter_07_57_15042026.xlsx` + `10_24_16042026.xlsx` — Tag + Uhrzeit im Dateinamen. Erkenntnis: das ist arbeitsgemäß, nicht Chaos.

**Ableitung:** Standard für WEC: Arbeits-Versionen im Format `<Titel>_HH_MM_DDMMYYYY.xlsx`. Lieferversion ohne Stempel im `Lieferung/`-Ordner als `BOM_bereinigt.xlsx`.

### 5. Lücken-Muster (wiederkehrend)

In *jedem* WEC-Kundenordner fehlen erfahrungsgemäß:
- **Zeichnungsindex** (welche Zeichnung welche Revision)
- **Versand-/Empfangsprotokolle** (was ging wann in welcher Version raus)
- **Kontaktblatt** (wer ist technisch / kaufmännisch / QS)
- **Qualitäts-Checkliste vor Versand**
- **Historien-Auswertung** (gelieferte Artikel der letzten Jahre → Portfolio-Erkenntnisse)

Das sind *keine* Individual-Lücken, sondern systemische Leerstellen im PARA-Schema für Ingenieursarbeit.

## Ist-Soll-Kompass

### Soll-Zustand eines reifen WEC-Kundenordners

```
03 Bereiche/WEC/
├── raw/Kunden/<Kunde>/
│   ├── aktuelle Projekte/<Projekt>/
│   ├── historische Lieferungen/<Jahr>/
│   └── Standards & Vorlagen/          ← Logo, Schriftfeld, DWG-Templates
│
├── wiki/Kunden/
│   ├── <Kunde> - Profil.md            ← Kontakte, Positionierung, Normen
│   ├── <Kunde> - Zeichnungsindex.md   ← alle Revisionen in Tabelle
│   └── <Kunde> - <Projekt>.md         ← je Projekt eine konsolidierte Seite
│
└── Lieferung/<Kunde>/<Projekt>/<Datum>/
    ├── BOM_bereinigt.xlsx
    ├── Zeichnungen/*.pdf (ohne Metadaten, ohne persönliche Namen)
    ├── CAD/*.step + *.iges
    └── Versandprotokoll.md            ← was ging raus, wann, an wen, md5
```

### Ist-Zustand Bens (2026-04-19)

| Baustein | Status | Lücke |
|---|---|---|
| raw-Schicht | ✅ vollständig | — |
| wiki-Lagerschalenhalter | ✅ aktuell | — |
| wiki-Profil | 🔴 Stub | 30J Historie fehlt |
| wiki-Zeichnungsindex | ❌ fehlt | erstmalig anlegen |
| Lieferung-BOM | ✅ bereinigt | — |
| Lieferung-PDFs | 🔴 Vektor-Text „Sebastian Hartmann" drin | Inventor-Template-Fix nötig |
| Versandprotokoll | ❌ fehlt | neu anlegen |
| CSV-Stückliste | 🔴 falsche Nummern BE-IS-202631 | global ersetzen → BE-LS-202603 |

## Ableitungen (allgemein für alle WEC-Kunden)

### A — Standard-Ordnerstruktur beim Kunden-Neuzugang

Jeder neue WEC-Kunde bekommt automatisch (Claude legt an, Sebastian füllt):

1. `raw/Kunden/<Kunde>/Standards & Vorlagen/` — sofort mit Platzhaltern
2. `wiki/Kunden/<Kunde> - Profil.md` mit Frontmatter-Template (unten)
3. `wiki/Kunden/<Kunde> - Zeichnungsindex.md` leer
4. `Lieferung/<Kunde>/` als Ordner angelegt
5. Raum-Tabelle in `CLAUDE.md` nur wenn Cluster-Kriterien erfüllt (siehe [[00 Kontext/Gehirn - Organisches Wachstum]])

### B — Profil-Template (Kopfdaten für `<Kunde> - Profil.md`)

```yaml
---
tags: [bereich, wec, kunde, profil, <kundenkuerzel>]
kundenkuerzel: BE                    # 2 Buchstaben
status: aktiv
branche: [lebensmittel, pharma]      # steuert Normen-Stack
positionierung: "Quality for Pharmacy"
schriftfeld_slogan: "…"
normen_relevant: [EHEDG, GMP, FDA 21 CFR, DIN 10516]
zeichnungsnummer_schema: "<BE>-<TT>-<YYNN>-<Pos>[-<Rev>]"
positionsbereich:
  hauptbaugruppe: "000-099"
  unterbaugruppen: "100-199"
  einzelteile: "200-299"
  kaufteile: "700-799"
ansprechpartner:
  technisch: "…"
  kaufmaennisch: "…"
  qs: "…"
lieferformate: [STEP, IGES, PDF]
---
```

### C — Vor-Lieferung-Checkliste (Claude-Routine)

Vor jedem Versand an WEC-Kunden prüft Claude automatisch:

- [ ] Zeichnungsnummern-Konsistenz (grep über Zeichnungen + BOM + CSV)
- [ ] Kein persönlicher Vektor-Text in PDFs (`pdftotext` + grep auf Sebastian, Hartmann, Hamann, VB, etc.)
- [ ] PDF-Metadaten gesäubert (Author, Creator leer oder WEC-Standard)
- [ ] BOM-Artikelnummern + Zeichnungsnummern stimmen überein
- [ ] md5-Prüfsummen aller Lieferdateien protokolliert
- [ ] Versandprotokoll angelegt mit Datum, Empfänger, Datei-Liste, md5

Report: grün/gelb/rot pro Punkt in Daily Note.

### D — Zeichnungsindex als Ressource, nicht als Projekt

`wiki/Kunden/<Kunde> - Zeichnungsindex.md` ist eine **lebende Tabelle**:

| Nr | Bauteil | Version | Datum | Datei | Status |
|---|---|---|---|---|---|
| BE-LS-202603-200-0 | Lagerhalter | 0 | 2026-03-24 | Lagerhalter Zeichnung.pdf | freigegeben |

Jede neue Zeichnung + jede Revision → eine Zeile. Claude aktualisiert beim Ingest. Ohne Zeichnungsindex keine Lieferfähigkeit.

### E — Historien-Ableitung (Portfolio-Erkenntnis)

Jeder WEC-Kunde hat mehrjährige Historie. Reiner bringt sie stückweise ein (SSD/USB-Übergabe). Claude wertet aus:

- Welche Artikel-Kategorien dominieren? (→ Kunden-Portfolio)
- Welche Normen/Spezifikationen wiederholen sich? (→ Kunden-Standard)
- Welche Konstrukteure/Ingenieure tauchen auf? (→ Kontaktblatt)
- Welche Fehler-/Reklamations-Muster? (→ QS-Vermeidungsliste)

Output → `<Kunde> - Profil.md` + `<Kunde> - Portfolio-Analyse.md`.

### F — Pharma/Lebensmittel-Weiche

Bei Kunden mit Pharma-Positionierung (erkennbar am Schriftfeld-Slogan):
- Normen-Stack erweitern: GMP, FDA 21 CFR Part 11, EudraLex Vol. 4
- Dokumentations-Anforderung härter: Chargenrückverfolgung, Material-Zertifikate als Pflicht
- Lieferprozess: jede Lieferung mit unterschriebenem Konformitätszeugnis

Sebastian + Reiner entscheiden pro Kunde einmalig; Claude fixiert im Profil.

## Anwendung auf Bens — konkrete TODOs

→ Überträgt TASKS.md (siehe dort „Bens Montag 2026-04-21").

## Verknüpfungen

- [[00 Kontext/Gehirn - Organisches Wachstum]] — Wachstumsregeln, auf die dieses Playbook aufbaut
- [[04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl]] — Schwester-Standard, wird aus diesen Mustern gespeist
- [[03 Bereiche/WEC/CLAUDE.md]] — WEC-spezifische Claude-Regeln
- [[03 Bereiche/WEC/wiki/Kunden/Volker Bens - Lagerschalenhalter Lebensmittelindustrie]] — Leit-Beispiel aus dem diese Muster abgeleitet wurden

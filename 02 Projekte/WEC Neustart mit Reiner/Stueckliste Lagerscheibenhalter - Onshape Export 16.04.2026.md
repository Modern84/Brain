---
tags: [projekt, wec, konstruktion, stückliste]
date: 2026-04-17
status: aktiv
quelle: Onshape Export via hartwire.me
export_datum: 2026-04-16 10:24 UTC
---

# Stückliste — Zusammenbau Lagerscheibenhalter

> Onshape-Export vom 16.04.2026, 10:24 UTC
> Exportiert von: hartwire.me
> Konstrukteur: Hartmann | Ingenieur: Wöhrich
> Projekt: SM_Lagerscheibe

---

## Baugruppe

| Pos | Bauteilnummer | Bauteilname | Beschreibung | Menge | Material | Anmerkung |
|-----|---------------|-------------|--------------|:-----:|----------|-----------|
| 1 | BE-LS-202601-000 | Zusammenbau_Lagerscheibenhalter | Lagerscheiben_Baugruppe | 1 | — | Zusammenbau |

---

## Einzelteile

| Pos | Bauteilnummer | Bauteilname | Beschreibung | Menge | Material | Anmerkung |
|-----|---------------|-------------|--------------|:-----:|----------|-----------|
| 2 | BE-LS-202601-200 | Lagerhalter | Blech 10 | 2 | Edelstahl 1.4404 | Einzelteil |
| 3 | BE-LS-202601-201-0 | Lagerscheibe | Rundstahl | 2 | Edelstahl 1.4404 | Einzelteil |
| 4 | BE-LS-202601-202-0 | Steg_Lagerscheibenhalter | Blech 5 | 2 | Edelstahl 1.4404 | Einzelteil, *recovered |
| 6 | BE-LS-202601-203-0 | Scheibe_x1 | Blech 3 | 1 | Edelstahl 1.4404 | Einzelteil |
| 7 | BE-LS-202601-203 | Welle_V5 | Rundstahl | 1 | Edelstahl 1.4404 | — |
| 7.1 | BE-LS-202601-205-0 | Scheibe_x3 | Blech 3 | 1 | Edelstahl 1.4404 | Einzelteil |
| 7.2 | BE-LS-202601-206-0 | Welle_V1 | Rundstahl | 1 | Edelstahl 1.4404 | V1, *recovered |
| 8 | BE-LS-202601-204 | Welle_V2 | Rundstahl | 1 | Edelstahl 1.4404 | — |
| 8.1 | BE-LS-202601-205-0 | Welle_V1 | Rundstahl | 1 | Edelstahl 1.4404 | V4, *recovered |
| 8.2 | — | Scheibe_x3 | Blech 3 | 1 | Edelstahl 1.4404 | Einzelteil |

---

## Kaufteile

| Pos | Bauteilnummer | Bauteilname | Beschreibung | Menge | Material | Hersteller | Artikelnr. |
|-----|---------------|-------------|--------------|:-----:|----------|------------|------------|
| 5 | BE-LS-202601-700-0 | Lager_64773026 | SKF Pendelkugellager 2302 E-2RS1TN9, zweireihig, Innen-Ø 15mm | 2 | Stahl - Edelstahl | [Mädler](https://www.maedler.de/Artikel/647) | 64773026 |
| 7 | BE-LS-202601-704-0 | Klemmring_62399115 | Geschlitzter Klemmring Edelstahl 1.4305, Bohrung 15mm | 1 | Stahl - Edelstahl | [Mädler](https://www.maedler.de/Artikel/623) | 62399115 |

### Klemmring-Unterpositionen

| Pos | Bauteilnummer | Bezeichnung | Menge | Material | Anmerkung |
|-----|---------------|-------------|:-----:|----------|-----------|
| 6.1 | 62399115_1 | 62399115 | 1 | Stahl - Edelstahl | — |
| 6.2 | 62399115_2 | 62399115_2 | 1 | Stahl - Edelstahl | V2 |

---

## Normteile

| Pos | Bezeichnung | Norm | Menge | Material | Anmerkung |
|-----|-------------|------|:-----:|----------|-----------|
| 9 | Innensechskantschraube M8 x 40 | DIN EN ISO 4762 | 1 | Edelstahl A4 | — |
| 10 | Hutmutter M8 x 1,25 | DIN 986 | 3 | Stahl 6 | ⚠️ Lebensmittel → A4-80 |

---

## Schweißgruppen

| Pos | Bauteilnummer | Bauteilname | Inhalt | Anmerkung |
|-----|---------------|-------------|--------|-----------|
| 11 | BE-LS-202601-1_0 | Schweißgruppe_Halter | 11.1 Lagerscheibe 2×, 11.2 Lagerhalter Blech 10 1× | Einzelteil |
| 12 | BE-LS-202601-1_0 | Schweißgruppe_Halter | 12.1 Lagerscheibe Rundstahl 1× (1.4404), 12.2 Lagerhalter Blech 10 1× (1.4404) | Einzelteil |

---

## Bekannte Probleme — Lebensmittelindustrie

> Vollständige Analyse: [[Mail Reiner - Lagerschalenhalter Überarbeitung]]

| Priorität | Pos | Problem | Maßnahme |
|-----------|-----|---------|----------|
| 🔴 MUSS | 10 | Hutmutter Stahl 6 — nicht zulässig | → **A4-80** |
| 🔴 MUSS | 8 | Welle — Material nicht spezifiziert | → **1.4404** |
| 🔴 MUSS | 5 | SKF-Standardlager = Chromstahl | → **SS2202-2RS Edelstahl** |
| 🟡 SOLLTE | 7 | Klemmring 1.4305 (Schwefelzusatz) | → **1.4404** |
| 🟡 SOLLTE | 9 | Innensechskant = Reinigungsproblem | → **Hygienic Design, glatter Kopf** |
| 🟡 SOLLTE | alle | Ra-Werte fehlen | → **Ra ≤ 0,8 µm** in Zeichnungen |
| 🟡 SOLLTE | alle | Radien nicht spezifiziert | → **min. R6 (EHEDG)** |
| ✅ erledigt | 5 | Artikelnummer war 64773006 | → korrigiert: **64773026** |
| ✅ erledigt | alle | Links moodfer.de defekt | → korrigiert: **maedler.de** |

---

## Pilot: Zeichnungsnummern-Abgleich (Volker Bens)

- **Status:** wartet auf Reiners kommentierte Scans (per Mail/Stick)
- **IST:** Desktop-Ordner `Fusion 360` auf Mos Mac — aktuelle Zeichnungen + STEP-Dateien (Format: STEP AP203)
- **SOLL:** Reiners eingeschannte, kommentierte Versionen kommen noch
- **Ziel:** Fix-Prozess für Zeichnungs-/BOM-Inkonsistenzen → Grundlage für MThreeD.io-Automatisierung

---

## Dateien

- `Stueckliste_Lagerscheibenhalter.xlsx` — Excel-Export (erstellt 17.04.2026)
- Onshape-Quelle: hartwire.me, Export 16.04.2026

## Verknüpfungen

- [[Mail Reiner - Lagerschalenhalter Überarbeitung]]
- [[WEC Neustart mit Reiner]]
- [[Sachsenmilch Käsekarussell]]
- [[04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl]]

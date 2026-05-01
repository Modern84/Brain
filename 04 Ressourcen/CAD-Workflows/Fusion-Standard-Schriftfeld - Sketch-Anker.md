---
tags: [ressource, cad, fusion, template, anleitung, zeichnungs-generator]
date: 2026-05-01
status: anleitung-phase-1
verknuepft:
  - "[[02 Projekte/WEC/Zeichnungs-Generator/Konzept]]"
  - "[[04 Ressourcen/CAD-Workflows/Sidecar-Schema]]"
  - "[[04 Ressourcen/CAD-Workflows/Template L7 Build-Anleitung]]"
  - "[[04 Ressourcen/CAD-Workflows/Schriftfeld DIN ISO 7200 L7]]"
---

# Fusion-Standard-Schriftfeld — Sketch-Anker für Generator

Phase-1-Pfad für [[02 Projekte/WEC/Zeichnungs-Generator/Konzept|Zeichnungs-Generator]] Schritt 2. Statt WEC.dwg in ein Template zu übersetzen (zu aufwendig, jetzt Phase 2 — siehe [[04 Ressourcen/CAD-Workflows/Template L7 Build-Anleitung]]), nutzen wir das **Fusion-Standard-Schriftfeld** als Basis und benennen die vorhandenen Sketch-Texte so, dass der Generator sie per API findet.

**Look:** Phase 1 = Fusion-Standard. Sieht nicht nach WEC aus, ist aber für den Pilot ausreichend. WEC-Optik kommt in Phase 2.

**Hauptziel:** Anker existieren mit Pflicht-Namen (`tb_<feldname>`). Ohne Anker keine API-Befüllung — Generator kann nichts ersetzen, was er nicht findet.

---

## 1. Fusion-Standard-Schriftfeld bei A3 ISO

Bei einem neuen Drawing → Format **A3 (ISO) Querformat** liefert Fusion ein Standard-Schriftfeld in der unteren rechten Ecke. Die genaue Feld-Liste hängt von der Fusion-Version ab; aus dem heutigen R_Blech_Klein-Drawing sind diese Standard-Felder belegt:

| Standard-Feld (Fusion) | Inhalt im heutigen R_Blech_Klein |
|---|---|
| Created by | Sebastian Hartmann |
| Title | (Bauteil-Name aus Design) |
| DWG No. | (manuell) |
| Rev. | 00 |
| Date of issue | (Datum) |
| Sheet | 1 / 1 |

**Verifikations-Auftrag an Sebastian** (Phase-1-Bau): leeres A3-Querformat-Drawing anlegen, Title-Block-Edit-Modus öffnen, **alle vorhandenen Sketch-Texte abscannen** und in [§4](#4-verifikations-tabelle---sebastian-fuellt-aus) eintragen. Erst danach steht fest, welche Felder umbenannt werden können und welche neu angelegt werden müssen.

---

## 2. Mapping — Sidecar-Feld → Fusion-Standard → Sketch-Anker

Ziel-Spalte „Sketch-Anker" ist verbindlich. Spalte „Fusion-Standard" ist Hypothese und wird in §4 von Sebastian verifiziert.

| Sidecar-Feld (Pflicht) | Fusion-Standard-Feld (vermutet) | Sketch-Anker (verbindlich) | Phase-1-Strategie |
|---|---|---|---|
| `zeichnungsnr` | DWG No. | `tb_zeichnungsnr` | vorhandenes Feld umbenennen |
| `benennung` | Title | `tb_benennung` | vorhandenes Feld umbenennen |
| `bearbeiter` | Created by | `tb_bearbeiter` | vorhandenes Feld umbenennen, Default `Sebastian Hartmann` direkt rein |
| `geprueft` | (kein Standard) | `tb_geprueft` | **neu anlegen** (Sketch-Text), Default leer |
| `rev` | Rev. | `tb_rev` | vorhandenes Feld umbenennen |
| `kunde` | (kein Standard) | `tb_kunde` | **neu anlegen** |
| `werkstoff` | (kein Standard) | `tb_werkstoff` | **neu anlegen** |
| `datum` | Date of issue | `tb_datum` | vorhandenes Feld umbenennen |

| Sidecar-Feld (optional) | Fusion-Standard-Feld | Sketch-Anker | Phase-1-Strategie |
|---|---|---|---|
| `toleranzklasse` | (kein Standard) | `tb_toleranzklasse` | **neu anlegen**, Default `ISO 2768-mK` |
| `oberflaeche` | (kein Standard) | `tb_oberflaeche` | **neu anlegen** |
| `bemerkung` | (kein Standard) | `tb_bemerkung` | **neu anlegen** |
| `gewicht_kg` | (kein Standard) | `tb_gewicht` | **neu anlegen** |
| `massstab_overrides.front` | Sheet (teilweise) | `tb_massstab` | **neu anlegen** (oder Sheet-Feld umbenennen, falls möglich) |

**Faustregel:** Felder die Fusion-Standard nicht kennt (Werkstoff, Kunde, Toleranzklasse, Oberfläche, Bemerkung, Gewicht) müssen als neue Sketch-Texte ins Schriftfeld. Position grob nach DIN ISO 7200 ([[04 Ressourcen/CAD-Workflows/Schriftfeld DIN ISO 7200 L7]]) — exaktes Layout ist Phase-2-Veredelung.

---

## 3. Hands-on — Sketch-Texte benennen + ergänzen

Identische Logik wie Phase 1 in [[04 Ressourcen/CAD-Workflows/Template L7 Build-Anleitung]] — nur **ohne DWG-Import-Vorstufe**.

### 3.1 In den Title-Block-Edit-Modus

1. Neues Drawing → A3 (ISO) Querformat
2. Im Sheet das Title-Block-Element (untere rechte Ecke) anklicken
3. Doppelklick → **Edit Title Block** (Sketch-Modus öffnet sich)

### 3.2 Vorhandene Sketch-Texte umbenennen

1. Browser-Tree links → Title-Block-Untergruppe ausklappen
2. Pro Sketch (z.B. `Sketch1` mit Inhalt „Created by") → Rechtsklick → **Umbenennen**
3. Neuer Name **exakt** nach §2-Tabelle: `tb_bearbeiter`, `tb_zeichnungsnr` etc.
4. Format-Strenge ist Pflicht: alle Kleinschreibung, Underscore, kein Leerzeichen, kein Bindestrich. Generator wird per Name suchen.

### 3.3 Fehlende Sketch-Texte neu anlegen

Für Felder mit Strategie „neu anlegen" in §2:

1. Im Title-Block-Sketch → Skizze → **Skizze-Text**
2. Position grob in freier Zelle (Layout = Phase-2-Veredelung, hier reicht „nicht im Weg")
3. Text-Inhalt = Default-Platzhalter (`[WERKSTOFF]`, `[KUNDE]`, etc.) oder Default-Wert (`ISO 2768-mK`, `Sebastian Hartmann`)
4. Sketch im Browser-Tree umbenennen → exakter `tb_<feldname>`

### 3.4 Duplikat-Check

Fusion hängt automatisch `(2)` an, wenn Sketch-Name doppelt → Generator-Suche bricht. Vor dem Speichern Browser-Tree scannen.

### 3.5 Speichern

- Datei → **Speichern als → Drawing Template**
- Name: `WEC Generator A3 Querformat`
- Speicherort: lokal **und** Cloud (Showstopper-Check in Schritt 3 testet `Drawings.add(<lokaler .f2d Pfad>)` — siehe [[02 Projekte/WEC/Zeichnungs-Generator/Konzept]] Punkt 6)
- Lokaler Pfad in TASKS.md notieren

---

## 4. Verifikations-Tabelle — Sebastian füllt aus

Bei Phase-1-Bau (Sketch-Anker setzen) füllt Sebastian diese Tabelle aus, damit das §2-Mapping gegen die Fusion-Realität abgeglichen ist.

| Was Fusion-Standard zeigt (Original-Sketch-Name) | Inhalt vor Umbenennung | Neuer Sketch-Anker | Notizen |
|---|---|---|---|
| | | | |
| | | | |
| | | | |

Nach dem Bau zurück an CC: ausgefüllte Tabelle + lokaler `.f2d`-Pfad. Schritt 3 (Hello-World-Add-In) startet daraus.

---

## 5. Output dieser Phase

- **Datei:** `WEC Generator A3 Querformat.f2d` mit benannten Sketch-Ankern (`tb_<feldname>`) für alle Sidecar-Pflichtfelder + relevante optionale Felder
- **Lokaler Pfad** in TASKS.md notiert (Showstopper-Check in Schritt 3)
- **Verifikations-Tabelle §4** ausgefüllt zurück an CC

---

## 6. Out-of-Scope (Phase 1)

- WEC-Schriftfeld-Optik / DIN-ISO-7200-pixelgenaues Layout → Phase 2, [[04 Ressourcen/CAD-Workflows/Template L7 Build-Anleitung]]
- Stückliste / BOM-Block
- Multi-Sheet-Templates
- Bens-Klon-Variante
- API-Befüllung der Sketch-Texte (Schritt 4+ im Konzept)

---

## Überlegung wert — Generator-Strategie A vs. B

Frage offen für Sebastians Entscheidung **nach Schritt 3** (Hello-World-Add-In, wenn die API-Realität steht):

**Variante A — Generator füllt nur was Fusion-Standard hat (minimal-Set):**
- Nur die Anker, die Standard-Fusion-Schriftfeld bereits hat (`tb_zeichnungsnr`, `tb_benennung`, `tb_bearbeiter`, `tb_rev`, `tb_datum`)
- Sidecar-Felder ohne Standard-Pendant (Werkstoff, Toleranzklasse, Oberfläche, Bemerkung, Kunde, Gewicht) bleiben **ungenutzt** im Schriftfeld
- Pro: minimaler, schneller Pilot. API-Pfad nur „Sketch finden + Text ersetzen"
- Contra: Schriftfeld zeigt Werkstoff/Toleranz nicht — Sebastian müsste das manuell nachpflegen, was den Klick-Marathon nur halb wegnimmt

**Variante B — Generator legt fehlende Sketch-Texte selbst an (vollständig):**
- API legt zur Laufzeit neue Sketch-Texte für alle Sidecar-Felder an, die das Template nicht hat
- Pro: vollständige Schriftfeld-Befüllung, Klick-Marathon komplett weg
- Contra: API-aufwendiger (Sketch-Erstellung, Position-Berechnung, Schriftgrößen-Auswahl). Mehr Bruch-Kanten beim Code.

**Empfehlung (vorläufig, vor Schritt 3):** Phase-1-Template enthält **alle** Anker als bereits angelegte Sketch-Texte (siehe §3.3). Damit kann Generator in Variante A bleiben (nur ersetzen, nie anlegen) und trotzdem alle Sidecar-Felder befüllen. Das verschiebt die Komplexität von Code (Generator) ins Template (einmal manuell). Beste Hebelwirkung: Template-Bau ist 30 Min einmalig, Code-Komplexität wäre dauerhaft.

**Entscheidung:** nicht jetzt. Erst nach Schritt 3, wenn klar ist, was die API tatsächlich kann (Sketch-Text-Mutation, Sketch-Anlage zur Laufzeit, Position-Setzung).

---

## Status

Bereit für Sebastian. Nach Sketch-Anker-Bau + Verifikations-Tabelle §4 zurück → Schritt 3 (Hello-World-Add-In mit Showstopper-Check) als nächster CC-Prompt.

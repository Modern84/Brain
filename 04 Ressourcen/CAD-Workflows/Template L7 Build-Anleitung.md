---
tags: [ressource, cad, fusion, template, anleitung]
date: 2026-05-01
status: verschoben-phase-2
verknuepft:
  - "[[02 Projekte/WEC/Zeichnungs-Generator/Konzept]]"
  - "[[04 Ressourcen/CAD-Workflows/Sidecar-Schema]]"
  - "[[04 Ressourcen/CAD-Workflows/Schriftfeld DIN ISO 7200 L7]]"
  - "[[04 Ressourcen/CAD-Workflows/Fusion 360 Drawing Template L7]]"
---

# Template L7 Build-Anleitung — `WEC L7 A3 Querformat.f2d`

> [!warning] Diese Anleitung ist Phase-2-Veredelung — nicht jetzt umsetzen
> **Revision 2026-05-01 (Vorgabe N im Konzept):** Phase 1 nutzt das **Fusion-Standard-Schriftfeld** als Template-Basis. Sketch-Text-Anker werden dort benannt, nicht aus DWG-Import von Null gebaut.
>
> Diese Anleitung (WEC.dwg → Fusion-Title-Block) ist **Phase-2-Veredelung** für den WEC-Look — relevant erst, wenn der Generator in Phase 1 stabil läuft.
>
> **Aktueller Schritt 2:** [[04 Ressourcen/CAD-Workflows/Fusion-Standard-Schriftfeld - Sketch-Anker]]
> **Konzept-Revision:** [[02 Projekte/WEC/Zeichnungs-Generator/Konzept]] §1.5 Vorgabe N + §5 Schritt 2 NEU

Hands-on-Anleitung für Sebastian. **CC kann nicht in Fusion klicken** — diese Datei ist Checkliste + Erwartungs-Management, kein Code-Auftrag.

**Kontext:** Ursprünglich Schritt 2 aus [[02 Projekte/WEC/Zeichnungs-Generator/Konzept|Generator-Konzept]]. Vorgabe K (Recherche-Schritt 1): **Schriftfeld-Felder als benannte Sketch-Texte**, weil ATTDEF-API defekt ist. Generator wird später diese Sketch-Texte per Name finden und ersetzen.

---

## Voraussetzungen

- **Quell-DWG:** `/Users/sh/Brain/03 Bereiche/WEC/raw/Standards WEC/Templates/WEC.dwg` (120 KB)
- **Layout-Referenz:** [[04 Ressourcen/CAD-Workflows/Schriftfeld DIN ISO 7200 L7]] (Feld-Positionen, L7=Hartmann, M7=Woldrich)
- **Felderliste:** [[04 Ressourcen/CAD-Workflows/Sidecar-Schema|Sidecar-Schema]] §2 + §3
- Fusion 360 offen, leeres Bauteil oder R_Blech_Klein verfügbar (für Phase-D-Pilot-Test)

---

## Schritt-für-Schritt

### 1. WEC.dwg in Fusion importieren als Drawing-Template

- Datei → Hochladen → `WEC.dwg` in Sebastians Cloud-Projekt-Ordner („WEC-Templates")
- Neues Drawing → Format **A3 Querformat** wählen
- Sheet Settings → Title Block → **New → From DWG** → `WEC.dwg` wählen
- Untere rechte Ecke der DWG auf **Sheet-Origin (0,0)** ausrichten — sonst ragt das Schriftfeld über den Blattrand

### 2. Schriftfeld-Bereich identifizieren

- Im Drawing-Sheet das eingefügte Title-Block-Element anklicken
- Doppelklick → Edit Title Block (Skizzen-Modus)
- Schriftfeld-Raster wird sichtbar — Zellen L7, M7, etc. nach DIN ISO 7200

### 3. Pro Feld: benannten Sketch-Text anlegen

**Vorgabe K (verbindlich):** Sketch-Name = `tb_<feldname>` (alle Kleinschreibung, Underscore). Format-Strenge ist Pflicht — Generator-Code wird diese Namen exakt suchen.

| Sketch-Name | Inhalt (Default-Platzhalter) | Position (DIN ISO 7200) |
|---|---|---|
| `tb_zeichnungsnr` | `[ZEICHNUNGSNR]` | Feld 1 (oben rechts, groß) |
| `tb_benennung` | `[BENENNUNG]` | Feld 2 (Titel-Bereich) |
| `tb_werkstoff` | `[WERKSTOFF]` | Werkstoff-Zelle |
| `tb_bearbeiter` | `Hartmann` (Default-Wert direkt rein) | L7 |
| `tb_geprueft` | `Woldrich` (Default-Wert direkt rein) | M7 |
| `tb_rev` | `00` | Rev-Zelle |
| `tb_datum` | `[DATUM]` (Date of issue) | Datum-Zelle |
| `tb_kunde` | `[KUNDE]` | Kunden-Zelle |
| `tb_toleranzklasse` | `ISO 2768-mK` | Allgemeintoleranzen-Bereich |
| `tb_oberflaeche` | `[OBERFLÄCHE]` | Oberflächen-Bereich |
| `tb_bemerkung` | `[BEMERKUNG]` | Freitext-Feld |
| `tb_gewicht` | `[GEWICHT_KG]` | Masse-Zelle |
| `tb_massstab` | `[MASSSTAB]` | Maßstab-Zelle |

**Pro Sketch-Text:**
- Sketch erstellen (Skizze → Skizze-Text)
- Position aus L7-Layout (siehe Schriftfeld-DIN-Notiz)
- Schriftgröße passend zur Zelle (ISO-Standard: meist 3.5 mm für Inhalt, 5 mm für Zeichnungsnr)
- Sketch im Browser-Tree umbenennen → exakter `tb_<feldname>` (Punkt 1 unten zur Umbenennung)

### 4. Template als `.f2d` speichern

- Datei → Speichern als → **Drawing Template**
- Name: `WEC L7 A3 Querformat`
- Speicherort: Sebastians Fusion-Templates-Ordner (lokal **und** Cloud — beides probieren, weil Punkt 6 des Recherche-Schrittes offen ist; lokal-Pfad wird im Hello-World-Add-In als Showstopper-Check getestet)
- **Lokaler Fallback-Pfad notieren:** absoluter Mac-Pfad ins TASKS.md eintragen, damit Schritt 3 ihn findet.

### 5. Pilot-Test mit R_Blech_Klein

- Neues Drawing → **From Design** → R_Blech_Klein wählen
- Template-Auswahl → `WEC L7 A3 Querformat`
- Erwartung: Schriftfeld erscheint mit Platzhaltern `[ZEICHNUNGSNR]`, `[BENENNUNG]` etc.; Defaults `Hartmann`, `Woldrich`, `ISO 2768-mK`, `00` sind direkt sichtbar.
- **Manueller Sketch-Text-Test:** Doppelklick auf `[ZEICHNUNGSNR]` → Text auf `WEC-2026-05-001` ändern → speichern. Wenn das funktioniert, ist die Sketch-Text-Befüllung später per API möglich.

---

## Erwartete Probleme + Lösungs-Pfade

**P1 — DWG-Import skaliert/rotiert das Schriftfeld falsch.**
- Ursache: Einheiten-Mismatch (DWG mm vs. Fusion-Default), oder Insertion-Point ist nicht (0,0).
- Lösung: vor Import in einer DWG-Vorbereitung (AutoCAD/LibreCAD/QCAD) die Origin auf untere rechte Ecke setzen, Einheit auf mm fixieren. Re-Import.
- Falls keine DWG-Editor-Software: Fusion-Sketch-Skalierung manuell anpassen (Skizze → Skalieren), aber das ist tricky.

**P2 — Sketch-Texte sind anfangs unbenannt (`Sketch1`, `Sketch2`, ...).**
- Lösung: Browser-Tree → Title-Block-Untergruppe ausklappen → Rechtsklick auf Sketch → **Umbenennen**. Exakt `tb_<feldname>` tippen, kein Leerzeichen, kein Bindestrich, alles klein.
- **Wichtig:** Fusion-Sketch-Namen sind eindeutig pro Drawing. Wenn ein Name doppelt → Fusion hängt automatisch `(2)` an, was Generator-Suche kaputt macht. Vor jedem Speichern Browser-Tree auf Duplikate scannen.

**P3 — Title-Block-Layer vs. Sheet-Layer — wo gehört der Inhalt hin?**
- Schriftfeld-Sketches **müssen im Title-Block-Element** liegen (Edit Title Block-Modus), **nicht im Sheet**. Sonst verschwinden sie beim Sheet-Wechsel oder werden pro Sheet dupliziert.
- Verifikation: Title-Block schließen, Sheet 1 schauen → Schriftfeld sichtbar. Sheet 2 hinzufügen → gleiches Schriftfeld auf Sheet 2 sichtbar (gleiche Sketches, eine Quelle).

**P4 — Default-Werte (`Hartmann`, `Woldrich`, `00`) auch als Platzhalter behandeln?**
- Entscheidung Phase 1: Defaults sind **echte Texte**, keine Platzhalter. Wenn Sidecar-Wert vom Default abweicht (z.B. `geprueft: ""` leer), überschreibt Generator den Default. Wenn Sidecar das Feld weglässt → Default bleibt stehen.

---

## Output dieser Phase

- **Datei:** `WEC L7 A3 Querformat.f2d` in Sebastians Fusion-Templates-Ordner
- **Lokaler Pfad notiert** in TASKS.md für Hello-World-Showstopper-Check
- **R_Blech_Klein als Pilot-Drawing** mit dem Template einmal angelegt (für späteren Phase-D-Vergleich)

---

## Out-of-Scope

- Stückliste / BOM-Block (Phase 2)
- Multi-Sheet-Templates (Phase 2)
- Bens-Klon-Variante (`Bens_Vordruck.dwg`) — analog später, wenn WEC-Variante stabil
- Generator-Code (Schritt 3+)
- API-Befüllung der Sketch-Texte (Schritt 4+)

---

## Status

Bereit für Sebastian. Nach Template-Bau + Pilot-Test → Rückmeldung an CC mit:
1. Lokalem `.f2d`-Pfad
2. Liste tatsächlicher Sketch-Namen (Verifikation gegen Tabelle oben)
3. Probleme aus P1–P3 (was ist aufgetreten, wie gelöst)

Dann startet Schritt 3 (Hello-World-Add-In mit Showstopper-Check) als nächster CC-Prompt.

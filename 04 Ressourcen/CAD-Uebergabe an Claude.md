---
tags: [ressource, cad, workflow, claude]
status: aktiv
date: 2026-05-01
priorität: A
owner: gemeinsam
---

# CAD-Übergabe an Claude — Format-Standard

> **Zweck:** Welche CAD-Formate Mo (oder Reiner) an Claude weitergibt, damit Claude daraus Zeichnungen, Analysen oder Lieferpakete bauen kann.
>
> **Abgrenzung:** Das hier ist **nicht** das Liefer-Format an Kunden. Für Bens-Lieferungen gilt weiterhin der eigene Standard → [[CAD-Datenuebergabe Standard - Bens Edelstahl]] (IGES).

---

## Verbindliche Reihenfolge

**Pflicht (mindestens eines):**
1. **STEP** (AP214 oder AP242) — bevorzugtes 3D-Format. Offen, Standard, von allen relevanten Tools lesbar. Aus Fusion 360: `File → Export → STEP`.
2. **DXF (Flat Pattern / Abwicklung)** — Pflicht für Blechteile zusätzlich zu STEP. Aus Fusion 360 Sheet Metal: `Modify → Create Flat Pattern → Right-click → Export DXF`.

**Sehr nützlich zusätzlich:**
3. **DXF der drei Ansichten** (Vorder/Drauf/Seite) — falls keine Sheet-Metal-Abwicklung möglich.
4. **PDF** der bisherigen Zeichnung (falls vorhanden) — als Referenz für Bemaßungsstil, nicht zur Geometrie-Extraktion.

**Bedingt:**
5. **STL** — nur für Iso-Bilder als Notlösung, keine Maße ablesbar.

---

## Nicht akzeptiert (Zeitverschwendung)

- **F3D** (Fusion-360-Archiv) — proprietäres zstd-komprimiertes Format. Claude kann nur das Vorschau-PNG extrahieren, keine Geometrie. Entschieden 2026-05-01 nach erfolglosem `L_Blech_Klein.f3d`-Versuch.
- **IPT, SLDPRT, etc.** (proprietäre Native-Formate) — gleiche Begründung wie F3D.

**Warum:** Claude hat keine Lizenz für proprietäre CAD-Reader. Offene Formate (STEP/DXF) sind in Sekunden parsebar; proprietäre Formate kosten eine Stunde Werkzeug-Setup für ein einzelnes Vorschau-Bild.

---

## Begleit-Infos (für fertigungstaugliche Zeichnung)

Bei der Übergabe sollte Mo dazu sagen, sonst rät Claude:

- **Materialdicke** (z.B. Bl. 1,5 mm)
- **Werkstoff** (z.B. 1.4301 / 1.4404)
- **Biegeradius innen** (typisch t bei dünnem Blech, 1,5×t bei dickerem)
- **Bohrungs-Durchmesser** (falls nicht aus DXF eindeutig)
- **EHEDG-Relevanz** (ja → Ra ≤ 0,8 µm + Radien R6 + 1.4404; nein → Standard)
- **Funktion / Zweck** des Bauteils — bestimmt was toleranz-kritisch ist
- **Stückzahl**

---

## Konkrete Fusion-360-Schritte (für Mo)

**Für ein Blechteil:**
1. Bauteil als Sheet Metal interpretiert (falls noch Solid)
2. `Modify → Create Flat Pattern`
3. Im Browser auf Flat Pattern → `Right-click → Export DXF`
4. Zusätzlich: `File → Export → STEP` (für 3D-Kontext und Iso-Ansicht)

**Für ein Frästeil oder Drehteil:**
1. `File → Export → STEP`
2. Optional: PDF der bestehenden Fusion-Zeichnung als Stil-Referenz

---

## Verknüpfungen

- [[04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl]] — Liefer-Standard an Volker (IGES, davon getrennt)
- [[00 Kontext/Claude Code - Brain Context]]
- [[CLAUDE]] — Root-Regeln

---

## Changelog

| Datum | Änderung | Anlass |
|---|---|---|
| 2026-05-01 | Datei angelegt, F3D verworfen, STEP + DXF als Standard | Mo-Entscheidung beim L_Blech_Klein-Pilot |

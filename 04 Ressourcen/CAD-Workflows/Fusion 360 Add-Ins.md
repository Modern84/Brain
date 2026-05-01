---
tags: [ressource, cad, fusion-360, add-ins]
date: 2026-05-01
status: aktiv
priorität: B
owner: Sebastian
raum: Konstruktion
---

# Fusion 360 — Add-Ins für die Liefer-Pipeline

> **Zweck:** Workflow-Beschleuniger für die Tomasz-/Bens-Pipeline (DXF-Export Blechabwicklung, Stücklisten-Export). Installation parallel zum Schriftfeld-Pilot, unabhängig davon.

---

## Empfohlen — installieren

### 1. Sheet Metal DXF Creator (free)

- **Was:** erzeugt DXF-Datei je Sheet-Metal-Flat-Pattern in einem Rutsch, statt jeden Flat-Pattern einzeln per Rechtsklick → Export DXF zu öffnen.
- **Settings:** Datei-Benennung nach `Part Number` oder `Component Name`, Bend-Lines optional, STEP-Beigabe optional.
- **Quelle:** [Sheet Metal DXF Creator — Autodesk App Store](https://apps.autodesk.com/FUSION/en/Detail/Index?id=2659537975078634838)
- **Kosten:** kostenlos (Stand 2026-05-01).
- **Workflow-Wert:** spart bei mehrteiligen Bens-Lieferungen (z.B. Lagerschalenhalter-BG mit 6+ Blechteilen) jedes Mal 5–10 Min Klick-Arbeit.

---

## BOM-Workflow — Entscheidung 2026-05-01

**Fusion-natives BOM zuerst.** Kein Add-In jetzt.

- Fusion liefert nativen CSV/Excel-BOM-Export — ist bereits Memory-Regel als primärer Analyse-Input für die Patcher-Pipeline.
- Reiner-Workflow ist papier-basiert, simple BOM reicht.
- Add-In-Bedarf erst dokumentieren, wenn nativ nicht reicht.

**Trigger für Re-Recherche** (BOM Creator / `Bommer` / OpenBOM):
- Batch-Export über mehrere Designs hinweg
- Sub-Assembly-Aggregation mit Mengenrollup
- Custom-Felder, die Fusion nativ nicht unterstützt

Nur wenn einer dieser Schmerzen real auftaucht: Add-In gegen native Fusion-Möglichkeiten benchmarken. Vorher = Werkzeug-Suche statt Problem-Lösung.

---

## Installations-Vorgehen (für Mo, am eigenen Mac)

1. Fusion 360 öffnen
2. Toolbar → `Utilities` → `Scripts and Add-Ins` (oder Tastenkürzel `Shift+S`)
3. Tab **„Add-Ins"** → Symbol `+` → bzw. direkt im Fusion-Browser: `Tools → App Store`
4. Im App Store: Add-In suchen → `Get` / `Install`. Macht macOS- und Win-Variante automatisch.
5. Nach Install: Add-In im Tab aktivieren, „Run on Startup" anhaken.

---

## Verknüpfungen

- [[04 Ressourcen/CAD-Workflows/Schriftfeld DIN ISO 7200 L7]]
- [[04 Ressourcen/CAD-Uebergabe an Claude]]
- [[04 Ressourcen/Playbook/Fusion-zu-Liefer-Pipeline]]

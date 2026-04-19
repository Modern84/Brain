---
tags: [bereich, wec, raw, regeln]
date: 2026-04-17
---

# raw/ — Rohdaten (UNANTASTBAR)

> **Regel #1: Hier wird nichts geändert. Nur reingelegt und gelesen.**

---

## Was hier reinkommt

- **NAS-Spiegel** von Reiners Projekten (via T9-SSD)
- **CAD-Dateien**: STEP, IGES, X_T, native SolidWorks (.sldprt, .sldasm, .slddrw)
- **Zeichnungen** (PDF, DXF)
- **Stücklisten** (Excel, CSV, PDF)
- **Kunden-Korrespondenz** (PDF, Mail-Exporte)
- **Alte Projektordner** komplett (Archiv aus 30 Jahren WEC)
- **Spezifikationen, Datenblätter** (PDF)

## Was hier NICHT rein darf

- ❌ Notizen / Kommentare (gehören ins `wiki/`)
- ❌ Claude-generierte Zusammenfassungen (gehören ins `wiki/`)
- ❌ Markdown-Artikel (gehören ins `wiki/`)
- ❌ Bearbeitete Versionen von Originaldateien (Original muss erhalten bleiben)

---

## Ordnerstruktur

```
raw/
└── Kunden/
    ├── Volker Bens/
    │   ├── aktuelle Projekte/
    │   ├── Archiv/
    │   ├── Standards & Vorlagen/
    │   └── Korrespondenz/
    └── Knauf/
        └── (analog)
```

Bei neuem Kunden: Ordner unter `raw/Kunden/` anlegen, Claude in `wiki/` informieren.

---

## Wer schreibt hier rein

- **Sebastian** — bei T9-Übergaben oder direkten NAS-Zugriff
- **Reiner** — kopiert seine Daten via T9 hier rein
- **Claude** — NIE direkt. Nur lesen.

---

## Was passiert nach Ingest

1. Neue Datei landet in `raw/Kunden/[Kunde]/...`
2. Sebastian markiert in `Operationen/Ingest.md` was neu ist
3. Claude liest, kompiliert nach `wiki/`
4. Claude verlinkt im Wiki-Artikel zurück auf die Quelldatei

→ Detaillierter Ablauf: [[03 Bereiche/WEC/Operationen/Ingest]]

---

## Sicherheit

- raw/ wird **mit-gebackupt** über iCloud (Sebastian) bzw. T9-SSD (Reiner)
- Bei Patentpflichtigem: NICHT in raw/ ablegen wenn nicht zwingend nötig — Apple iCloud ist verschlüsselt, aber Vorsicht ist Pflicht
- Original-Daten auf NAS bleiben unangetastet — raw/ ist Kopie

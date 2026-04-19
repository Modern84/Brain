---
tags: [eingang, überblick]
date: 2026-04-18
---

# Eingang Dateien

## Zweck

Sammelpunkt für **Rohmaterial** aus Desktop und Downloads — PDFs, STEP, DXF, Bilder, Stücklisten und anderer Kram der noch keinen Kontext hat.

## Wie Dateien hier landen

Per Terminal-Alias `sort-brain`:

```bash
sort-brain              # verschiebt alles aus Desktop + Downloads hierher
sort-brain --preview    # zeigt nur was verschoben würde
```

Das Skript fasst die Dateien nicht nach Typ zusammen — alles landet pauschal hier mit Datumspräfix (`YYYY-MM-DD — dateiname.ext`). Screenshots sind die einzige Ausnahme, die gehen automatisch nach `07 Anhänge/Screenshots/`.

## Was danach passiert

**Kontextualisierung im Chat mit Claude.** Sebastian sagt zum Beispiel:

- *„Die STEP-Datei von heute ist für Bens"* → Claude verschiebt nach `03 Bereiche/WEC/raw/Bens/`
- *„Das PDF gehört zum ProForge"* → Verlinkung oder Verschiebung in `02 Projekte/ProForge5 Build.md`
- *„Das Bild brauche ich für die Tagesnotiz"* → nach `07 Anhänge/` und in die Daily Note eingebettet

**Kein automatisches Sortieren nach Dateiendung.** Das wäre falsch: Eine STEP-Datei von Bens gehört zu Bens, nicht in einen generischen CAD-Ordner. Der Kontext entscheidet wohin eine Datei gehört, nicht ihr Typ.

## Regel für diesen Ordner

- **Datumspräfix bleibt** bis die Datei endgültig einsortiert ist — so sieht man auf einen Blick wie alt der Eingang-Rückstand ist
- **Leeren als Arbeitsziel:** Idealerweise ist dieser Ordner am Ende jeder Session wieder leer
- **Nie löschen ohne Kontext** — erst verstehen woher die Datei kam, dann entscheiden

## Für Reiners Gehirn (Windows)

Gleiche Logik, anderes Skript. PowerShell-Variante folgt beim Setup von Reiners Gehirn. Ordnerstruktur ist identisch: `01 Inbox/_Eingang Dateien/`.

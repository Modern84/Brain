---
tags: [ressource, standards, dataview]
date: 2026-04-19
---

# Kopfdaten-Standard — Maschinenlesbare Felder

> **Zweck:** Dataview + Claude können nur abfragen was strukturiert ist. Je reicher die Kopfdaten, desto mächtiger das Gehirn.

---

## Pflicht (jede Datei)

```yaml
---
tags: [kategorie, weitere, schlagworte]
date: YYYY-MM-DD
---
```

- **`tags`**: mindestens ein Haupttag nach Ordner (`kontext` / `projekt` / `bereich` / `ressource` / `inbox` / `tagesbuch` / `ausschnitt`) + beliebig viele beschreibende
- **`date`**: Erstelldatum im ISO-Format

---

## Projekte (`02 Projekte/`)

```yaml
---
tags: [projekt, weitere]
date: YYYY-MM-DD
status: aktiv | geplant | pausiert | abgeschlossen | vorbereitung
priorität: A | B | C          # A = hoch, C = niedrig
due: YYYY-MM-DD               # Zieltermin, optional
owner: Sebastian | Reiner | Ildikó | gemeinsam
raum: WEC | ProForge5 | MThreeD | Finanzen | Konstruktion | KI
---
```

**Warum:** Das Home-Dashboard listet aktive Projekte, Fristen und Owner. Ohne diese Felder sind Projekte unsichtbar für die Query.

---

## WEC-Kunden-Aufträge (`03 Bereiche/WEC/wiki/Kunden/` + `Lieferung/`)

```yaml
---
tags: [bereich, wec, kunde]
date: YYYY-MM-DD
status: aktiv | laufend | abgeschlossen | gestoppt
kunde: "Volker Bens" | "Knauf" | "..."
projekt: "Lagerschalenhalter Lebensmittelindustrie"
endkunde: "Sachsenmilch"      # White-Label: bleibt intern, NIE in Lieferdokumenten
white-label: true | false     # Volker-Bens-Standard: immer true
risiko: niedrig | mittel | hoch
bwl-check: bestanden | pending | warnung
EHEDG: ja | nein | teilweise
---
```

**Warum:** Der BWL-Filter und Risiko-Queries arbeiten mit diesen Feldern. White-Label ist ein **struktureller Schutz** — ohne Feld kann Claude nicht automatisch warnen wenn eine Bens-Zeichnung versehentlich WEC-Branding enthält.

---

## Bereiche (`03 Bereiche/*/`)

```yaml
---
tags: [bereich, weitere]
date: YYYY-MM-DD
status: aktiv | pausiert
raum: WEC | MThreeD | ...
---
```

---

## Ressourcen (`04 Ressourcen/`)

```yaml
---
tags: [ressource, thema]
date: YYYY-MM-DD
status: aktuell | veraltet | in-arbeit    # nur wenn relevant
source: URL oder Quellen-Referenz         # optional
---
```

---

## Daily Notes (`05 Daily Notes/`)

```yaml
---
tags: [tagesbuch]
date: YYYY-MM-DD
---
```

*Keine weiteren Felder — Daily Notes sind unstrukturierte Zeitachse.*

---

## Querable Fields — Was Dataview damit macht

### Beispiel 1: Alle aktiven WEC-Kunden-Aufträge

```dataview
TABLE kunde, status, risiko, due
FROM "03 Bereiche/WEC"
WHERE kunde AND status = "aktiv"
```

### Beispiel 2: Fristen diese Woche

```dataview
TABLE due, owner
FROM ""
WHERE due AND due >= date(today) AND due <= date(today) + dur(7 days)
SORT due ASC
```

### Beispiel 3: Warnsignale

```dataview
TABLE kunde, risiko, "bwl-check" AS BWL
FROM "03 Bereiche/WEC"
WHERE risiko = "hoch" OR "bwl-check" = "warnung"
```

### Beispiel 4: Reiners Projekte

```dataview
LIST
FROM "02 Projekte" OR "03 Bereiche/WEC"
WHERE owner = "Reiner" OR owner = "gemeinsam"
```

---

## Migration — Was tun mit bestehenden Dateien?

**Nicht alles auf einmal nachrüsten.** Stattdessen:

1. **Neue Projekte** bekommen Vollkopf ab sofort
2. **Bestehende aktive Projekte** erweitert wenn sie angefasst werden (Lazy-Migration)
3. **Archivierte Dateien** bleiben wie sie sind — Aufwand lohnt nicht

**Pilot-Migration (heute durchgeführt):** ProForge5 Build, WEC-Bens-Lagerschalenhalter, Mac-Inventur — als Referenz-Beispiele.

---

## Verknüpfungen

- [[00 Kontext/Home]] — Dashboard nutzt diese Felder
- [[CLAUDE]] — Grundregeln für Kopfdaten (Minimum)
- [[04 Ressourcen/Scripts/brain-lint.sh]] — Findet Dateien ohne Kopfdaten

---
tags: [bereich, wec, operation, lint]
date: 2026-04-17
---

# Operation: Lint — Wiki-Konsistenz prüfen

> **Zweck:** Regelmäßiger Selbstcheck — tote Links, veraltete Infos, fehlende Querverweise, Inkonsistenzen.

---

## Wann Lint läuft

- **Manuell:** Sebastian sagt "Lint das Wiki" (z.B. monatlich oder vor wichtigem Termin)
- **Automatisch:** Bei jedem Ingest-Vorgang prüft Claude die betroffenen Artikel
- **Trigger:** Wenn Sebastian/Reiner einen Wiki-Artikel direkt korrigiert hat

---

## Was Claude prüft

### Strukturell
- [ ] Hat jede Wiki-Datei korrekte Kopfdaten (tags, date, status, quellen)?
- [ ] Sind alle Quellen-Verweise in `quellen:` noch existent in raw/?
- [ ] Sind alle internen Wikilinks `[[...]]` valide?
- [ ] Folgen Dateinamen der Konvention?

### Inhaltlich
- [ ] Gibt es Widersprüche zwischen Wiki-Artikeln? (z.B. Zwei verschiedene Lieferstandards für Bens)
- [ ] Sind Datums-Angaben aktuell? (z.B. "Stand 2024" → wahrscheinlich veraltet)
- [ ] Haben offene TODO-Marker noch ihre Berechtigung?
- [ ] Fehlen Querverweise zwischen verwandten Artikeln?

### Vollständigkeit
- [ ] Gibt es raw/-Dateien die noch nicht ins Wiki eingearbeitet sind?
- [ ] Gibt es Wiki-Artikel ohne Quellverweise (= Phantomwissen)?
- [ ] Fehlen Standards die in mehreren Kundenprofilen auftauchen → Konsolidierung nach Standards/?

---

## Ablauf

1. **Claude scannt** alle Dateien im wiki/-Bereich
2. **Findings sammeln** in temporärem Bericht
3. **Klassifizieren:**
   - 🔴 **Kritisch** (toter Link, Widerspruch zu CLAUDE.md, falsche Kundenangabe) → sofort melden
   - 🟡 **Wichtig** (veraltetes Datum, fehlender Querverweis) → Vorschlag zur Korrektur
   - 🟢 **Hinweis** (Optimierung, Konsolidierungs-Idee) → sammeln, später diskutieren
4. **Sebastian entscheidet** welche Korrekturen durchgeführt werden
5. **Claude führt aus**, dokumentiert im Lint-Log unten

---

## Lint-Log

> Hier nach jedem Lint-Lauf ein Eintrag (neueste oben):

### YYYY-MM-DD — Erster Lint nach Schritt-1-Setup
- Status: noch keine Wiki-Inhalte zu prüfen
- Erste Aufgabe: nach erstem Ingest-Vorgang ausführen

*(Weitere Einträge nach Bedarf)*

---

## Verknüpfungen

- [[03 Bereiche/WEC/Operationen/Ingest]]
- [[03 Bereiche/WEC/Operationen/Query]]
- [[03 Bereiche/WEC/wiki/README]]

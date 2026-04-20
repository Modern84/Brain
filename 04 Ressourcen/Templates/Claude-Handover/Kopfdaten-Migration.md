---
tags: [ressource, template, handover, claudecode]
date: 2026-04-19
---

# Handover an Claude Code — Kopfdaten-Migration starten

> **Zweck:** Claude Code rüstet alle aktiven Projekte + WEC-Dateien mit den neuen Kopfdaten-Feldern nach, damit das [[00 Kontext/Home|Home-Dashboard]] echte Daten anzeigt.

---

## Prompt — in Terminal kopieren

```
Stand heute (2026-04-19): Vault-Schema erweitert um maschinenlesbare Kopfdaten-Felder.
Referenz: 04 Ressourcen/Kopfdaten-Standard.md
Home-Dashboard: 00 Kontext/Home.md (Dataview-Queries)

Auftrag — Kopfdaten-Migration für das Home-Dashboard:

1. Alle aktiven Projekte in 02 Projekte/ (inkl. Unterordner-Hauptdateien
   wie "ProForge5 Build/ProForge5 Build.md", "Stone Wolf Build/Stone Wolf Build.md"):
   - status: (falls fehlt) setzen auf "aktiv" | "geplant" | "pausiert" | "abgeschlossen"
   - priorität: A | B | C abschätzen (A für ProForge5, WEC-Auftrag; B für Pflege; C für Spielerei)
   - owner: "Sebastian" | "Reiner" | "Ildikó" | "gemeinsam" (aus Kontext ableiten)
   - raum: "WEC" | "ProForge5" | "MThreeD" | "Finanzen" | "Konstruktion" | "KI"
   - due: nur setzen wenn ein konkretes Datum bekannt oder in TASKS.md steht
   - Bei Unsicherheit: Feld weglassen, nicht raten

2. Alle WEC-Wiki-Kunden-Artikel in 03 Bereiche/WEC/wiki/Kunden/:
   - kunde: "Volker Bens" | "Knauf" | ...
   - projekt: konkreter Projektname als String
   - endkunde: falls bekannt (z.B. "Sachsenmilch" bei Bens-Aufträgen)
   - white-label: true | false (bei Bens IMMER true)
   - EHEDG: ja | nein | teilweise (bei Lebensmittel/Pharma)
   - risiko: niedrig | mittel | hoch
   - bwl-check: bestanden | pending | warnung

3. Alle WEC-Lieferungen in 03 Bereiche/WEC/Lieferung/:
   - Gleiche Felder wie Kunden-Wiki, zusätzlich:
   - status: aktiv | in-vorbereitung | ausgeliefert

Referenz-Beispiele (heute migriert — als Template nehmen):
- 02 Projekte/ProForge5 Build/ProForge5 Build.md
- 02 Projekte/Mac Inventur.md
- 03 Bereiche/WEC/wiki/Kunden/Volker Bens - Lagerschalenhalter Lebensmittelindustrie.md

Qualitätsregeln:
- NUR Kopfdaten anfassen. Body-Inhalt UNVERÄNDERT lassen.
- Bestehende tags nicht überschreiben — ergänzen wenn sinnvoll.
- Bei jedem File kurzen Diff-Log: "→ added: priorität, owner, raum"
- Am Ende: Report wie viele Dateien migriert, welche Felder am häufigsten,
  welche Dateien bewusst NICHT migriert wurden (und warum).

Tabu:
- Keine Dateien in 06 Archiv/ anfassen.
- Keine Dateien in 07 Anhänge/ anfassen.
- Keine Dateien in Clippings/ anfassen.
- Keine Dateien in 04 Ressourcen/ (außer auf Rückfrage).
- Bei einzelnen Dateien die komplett chaotisch aussehen: stoppen und
  in Report als "manuell klären" markieren.

Arbeitsweise:
- Eine Datei nach der anderen, nicht parallel.
- Nach jeweils 5 Dateien kurzer Zwischenstand (falls viele).
- Keine Rückfragen zu Details die aus Kontext ableitbar sind.
- Bei wirklich offenen Entscheidungen (z.B. owner unklar): Feld weglassen
  statt raten.

Start: Liste mir zuerst alle Dateien die du migrieren willst (Pfad + 
geplante neue Felder), BEVOR du anfängst zu ändern. Ich gebe grünes Licht
oder korrigiere dann.
```

---

## Warum dieses Script

- **Lazy-Migration** beschleunigt auf einen Rutsch — statt bei jedem Anfassen
- **Home-Dashboard** wird sofort von "leer" zu "voll" mit echten Daten
- **Claude Code hat bessere Filesystem-Performance** für Batch-Operations
- **Manuelle Kontrolle** eingebaut (Plan-Vorlage vor Ausführung)

---

## Verknüpfungen

- [[04 Ressourcen/Kopfdaten-Standard]] — Feld-Schema (Referenz)
- [[00 Kontext/Home]] — Dashboard das davon lebt
- [[04 Ressourcen/Templates/Claude-Handover/]] — weitere Handover-Templates

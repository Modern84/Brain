---
tags: [ressource, template, handover, claudecode, direkt-start]
date: 2026-04-20
---

# Direkt-Start für Claude Code — Pick a Fix

> Kürzester Handover: Kontext ziehen, A-Pool sichten, eigenständig den nächsten Fix wählen und anfangen. Keine Rückfrage-Schleife. Selbstwahl laut CLAUDE-Regel "Brain wie eigenes nutzen".

---

## Prompt — in Terminal kopieren

```
Direkt-Start. Keine lange Einleitung.

Lies in dieser Reihenfolge:
1. CLAUDE.md — insbesondere Format-Disziplin (R1-R6) und Entscheidungs-Heuristik
2. 05 Daily Notes/$(date +%Y-%m-%d).md — heutige Agenda + Priorität
3. TASKS.md — Termine-Abschnitt oben
4. ~/.claude/projects/.../memory/MEMORY.md — technischer Stand

Dann:
- Aus dem A-Block der heutigen Daily Note wähle eine Aufgabe die DU
  mit Filesystem / Terminal lösen kannst (keine Hardware, keine UI).
- Benenne die Wahl in einer Zeile: "Ich fixe jetzt X, weil Y."
- Dann direkt anfangen. Keine Zwischenfrage.

Kandidaten die typischerweise für Code geeignet sind:
- CSV-Nummernsystem (BE-IS → BE-LS-202603) in raw-BOM korrigieren
- PDF-Metadaten bereinigen mit exiftool (Grundplatte + Zwischenplatte)
- Git-Backup nach Handover-Vorlage initialisieren
  (siehe 04 Ressourcen/Templates/Claude-Handover/Git-Backup-Setup.md)
- brain-lint.sh Baseline erzeugen und Report ablegen
- WEC-Wiki-Kunden-Artikel Kopfdaten-Migration fortsetzen
  (siehe Kopfdaten-Migration.md im selben Ordner)
- Pi-Tailscale-Diagnose vorbereiten (SSH-Probe, Status-Check-Skript)

Nicht für dich: physische Hardware-Arbeit, Obsidian-UI-Aktionen,
Dinge die Sebastian-Hand brauchen.

Regeln:
- Format-Disziplin R1–R6 einhalten (max eine Tabelle, keine a/b/c-Fragen)
- Bei Unsicherheit einmal fragen, dann handeln
- Nach jedem größeren Schritt Zwischenstand in die heutige Daily Note
- Am Ende: Ein-Satz-Report + erledigt ins TASKS.md

Start: Was fixt du?
```

---

## Warum dieses Format

Nicht ein spezifischer Auftrag, sondern **Selbstwahl mit Leitplanken**. Code sieht die Prioritäten, kennt seine Werkzeuge, wählt. Das ist "Brain wie eigenes" in Reinkultur — nicht Sebastian muss alles vorbeten.

Die Kandidaten-Liste ist Orientierung, nicht Vorschrift. Code darf auch was anderes wählen wenn er bessere Gründe hat.

---

## Variante — harte Aufgabe statt Selbstwahl

Wenn Sebastian präziser sein will, statt "pick a fix" die konkrete Aufgabe ans Ende hängen:

```
[...obige Kontextladung...]

Konkreter Auftrag: [z.B. "CSV-Nummernsystem BE-IS → BE-LS-202603 in
03 Bereiche/WEC/raw/Kunden/Volker Bens/... korrigieren. Backup vorher,
Diff-Log nach Commit."]

Keine Selbstwahl, direkt starten.
```

---

## Verknüpfungen

- [[04 Ressourcen/Templates/Claude-Handover/Kopfdaten-Migration]]
- [[04 Ressourcen/Templates/Claude-Handover/Git-Backup-Setup]]
- [[CLAUDE]] — Format-Disziplin
- [[05 Daily Notes/2026-04-20]] — aktuelle Agenda

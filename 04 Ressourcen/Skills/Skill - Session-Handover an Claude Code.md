---
tags: [skill, arbeitssystem, handover, claudecode]
status: in-entwicklung
date: 2026-04-18
---

# Skill — Session-Handover an Claude Code

## Was das ist

Eine Handover-Notiz ist ein vorgefertigter Prompt-Block in `02 Projekte/`, den Sebastian ins Terminal kopiert, damit Claude Code ohne Rückfrage genau das tut was in der Session geplant ist. Claude.ai bereitet die Arbeit vor (Analyse, Zielpfade, Entscheidungen), Claude Code führt aus — ohne erneut nachdenken zu müssen.

## Wann anwenden

- **Vor einer Claude-Code-Session mit klarem Ziel** (Dateien verschieben, Firmware flashen, Config anpassen, Aufräumsession)
- Wenn die Analyse bereits in claude.ai gemacht wurde und nur noch ausgeführt werden muss
- Immer wenn eine Aufgabe auf **mehrere physische Dateien/Schritte** an Sebastians Rechner zugreifen muss
- Auslösende Begriffe: „Handover", „Claude Code vorbereiten", „für die nächste Session", „Prompt zum Kopieren"

## Wie (Kurzanleitung)

### 1. Notiz anlegen
`02 Projekte/<Projektname> - Handover <Session-Name>.md` — im gleichen Ordner wie das Projekt, damit alles zusammenbleibt.

### 2. Frontmatter
```yaml
---
tags: [projekt, handover, claudecode]
date: YYYY-MM-DD
---
```

### 3. Aufbau der Notiz
1. **Kurze Einleitung** — Zweck in einem Satz, Verweis auf vorbereitende Notiz (Vorsortierung, Analyse, Plan).
2. **Vorab-Entscheidungen** — Fragen die Sebastian vor Start beantworten muss (z.B. Strukturänderung, Risiko-Abwägung). Jede Option mit Konsequenz.
3. **Prompt-Block in ```…``` Codeblock** — so dass Sebastian genau diesen Block kopieren kann. Enthält:
   - **Kontext laden** — explizite Liste der Dateien die Claude Code lesen soll (CLAUDE.md, MEMORY.md, Projektdatei, vorbereitende Notiz)
   - **Aufgabe** — was konkret zu tun ist, in ausführbarer Sprache
   - **Regeln** — was NICHT passieren darf (nicht blind verschieben, nicht löschen, bei Konflikt stoppen)
   - **Protokoll** — wann Zwischenstände kommen sollen
   - **Nach Abschluss** — welche Dateien zu aktualisieren sind (TASKS.md, Daily Note, Projekt-Changelog, Ingest.md)
   - **Zeitbudget** — Obergrenze mit Stopp-Regel
4. **Anweisung für Sebastian** — Schritte 1-5 was er machen muss (Terminal öffnen, brain-Alias, kopieren, abwarten).
5. **Verknüpfungen** — andere Handover-Notizen, Projekt, relevante Skills und Ressourcen.

### 4. Prinzipien guter Prompts
- **Explizite Pfade, keine Interpretation** — „nach `04 Ressourcen/Klipper/Transkripte/`", nicht „an einen passenden Ort".
- **Stopp-Regeln bei Unsicherheit** — „Bei unerwartetem Zustand STOPPEN und fragen." Nicht darauf hoffen, dass Claude Code alleine richtig entscheidet.
- **Konkrete Bestätigungsschritte** — bei Löschungen/Duplikaten: „md5 vergleichen, bei identisch löschen, bei unterschiedlich Sebastian zeigen". Nie blindes Löschen.
- **Kein Roman** — kein Marketing, keine Erklärungen warum. Claude Code hat keinen Kontext außer dem was im Prompt und den angegebenen Dateien steht.
- **Nach Abschluss immer Vault-Pflege einfordern** — TASKS.md, Daily Note, MEMORY.md, Projekt-Datei. Sonst geht die Kontinuität zwischen den Instanzen verloren.

## Stand der Beherrschung

- `in-entwicklung` — zwei Handover-Notizen bisher erfolgreich gefahren (Phase 3 Vorsortierung, ProForge5 Session). Muster trägt, aber noch nicht genug Wiederholungen, um es als vollständig beherrscht zu bezeichnen.

## Abhängigkeiten

- [[Skill - Claude Code CLI Setup]] — `brain`-Alias und funktionierende Claude-Code-Umgebung
- [[Skill - Obsidian Brain pflegen]] — korrekte Frontmatter, Ordnerstruktur, Verknüpfungen
- Klares Verständnis der Arbeitsteilung claude.ai ↔ Claude Code (siehe CLAUDE.md)

## Referenzen

- [[02 Projekte/Mac Inventur - Handover Claude Code]] — erste Handover-Notiz (Mac-Inventur Start)
- [[02 Projekte/Mac Inventur - Handover Phase 3 Vorsortierung]] — Vorsortierungs-Handover
- [[02 Projekte/Mac Inventur - Handover ProForge5 Session]] — ProForge5-Handover mit Vorab-Entscheidung
- [[CLAUDE]] — Arbeitsweise-Abschnitt „claude.ai = Kopf, Claude Code = Hände"
- [[04 Ressourcen/Workflow - Sebastian und Claude]]

## Lessons Learned

- **Vorab-Entscheidungen getrennt stellen:** Fragen die Sebastians Zustimmung brauchen, NICHT in den Prompt-Block selbst. Sonst muss Claude Code interaktiv nachfragen — und das zerstört den Flow.
- **Zielpfade immer absolut formulieren** (ab Vault-Root), nie relativ. Claude Code springt zwischen Vault-Pfad und `~/Mac-Inventur/` — relative Pfade werden mehrdeutig.
- **Stopp-Regeln explizit machen** — „bei unklarem Zustand: stoppen und fragen". Ohne das versucht Claude Code zu interpretieren und macht im Zweifel einen Fehler.
- **Handover-Notizen sind wiederverwendbar als Vorlage** — die Struktur (Kontext laden → Aufgabe → Regeln → Protokoll → Nach Abschluss → Zeitbudget) hat sich etabliert und sollte in kommenden Sessions übernommen werden.

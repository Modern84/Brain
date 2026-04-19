---
tags: [ressource, workflow, claude]
date: 2026-04-16
---

# Workflow — Sebastian & Claude zusammenarbeiten

## Das Grundprinzip

Sebastian diktiert in claude.ai (Sprache → Chat). Claude gibt strukturierte Befehle zurück die Sebastian in Claude Code kopiert. Kurze Rückmeldung per Screenshot oder Text — dann weiter.

**claude.ai = Kopf** — Planung, Entscheidungen, Befehle formulieren, Vault pflegen
**Claude Code = Hände** — ausführen, Dateien anfassen, Terminal, Pi, Desktop

---

## Optimaler Session-Ablauf

### Session-Start (claude.ai)
1. Kurz sagen was heute dran ist
2. Ich lese TASKS.md + letzte Daily Note → kurzes Briefing
3. Gemeinsam priorisieren: Was zuerst?

### Während der Session
- Sebastian diktiert → ich formuliere den Befehl → Sebastian kopiert in Claude Code
- Ergebnis per Screenshot oder Text zurück → ich gebe nächsten Befehl
- **Frage-Gegenfrage-Prinzip:** Eine Frage, eine Antwort, dann weiter — kein Roman

### Vor dem Löschen / Destruktiven Aktionen
**Immer zuerst anschauen, dann entscheiden:**
```
Zeig mir was in [Ordner/Datei] drin ist bevor wir löschen.
```

### Session-Ende
Ich aktualisiere: Daily Note, TASKS.md, CLAUDE.md (falls neue Regeln).

---

## Für Reiner (gleiche Regeln)

- Claude Code auf Windows läuft in **Windows Terminal** (nicht cmd.exe)
- Befehle mit `sudo` → mit `!` Prefix in Claude Code
- Reiner ist neu → Schritt für Schritt, eine Sache auf einmal

---

## Verknüpfungen

- [[CLAUDE]]
- [[04 Ressourcen/Automatisierung/Automatisierung]]

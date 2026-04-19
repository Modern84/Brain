---
tags: [ressource, prompt, session-starter]
date: 2026-04-19
---

# Session-Starter — Neuen claude.ai-Tab hochfahren

> **Zweck:** In einen frischen claude.ai-Tab einfügen, damit Claude sofort auf dem aktuellen Stand ist — ohne alles neu zu erklären.

---

## Prompt (kopieren)

```
Hallo, ich arbeite im Gehirn-Vault "Brain".

Bitte lies in dieser Reihenfolge:
1. CLAUDE.md — Arbeitsweise, Räume, Regeln
2. TASKS.md — offene Aufgaben
3. Letzte Daily Note in 05 Daily Notes/ — was gestern lief
4. MEMORY.md in ~/.claude/projects/.../memory/ — technischer Zustand (IPs, Firmware, Workarounds)

Danach: kurzes Briefing (max 5 Zeilen):
- In welchem Raum arbeiten wir wahrscheinlich?
- Was ist offen / wo war ich zuletzt?
- Gibt es Inkonsistenzen zwischen Memory und Projektdateien?

Nicht mehr lesen bis ich eine konkrete Frage stelle. Lazy loading.
```

---

## Varianten

### Variante A — Raum ist bekannt

```
Ich arbeite im Raum [WEC / MThreeD.io / ProForge5 / ...].
Lies CLAUDE.md + README.md des Raums + letzte Daily Note. Dann Briefing.
```

### Variante B — Nur schnelle Frage, keine Sessions

```
Eine schnelle Frage — keine Daily Note, kein TASKS-Update.
Frage: [...]
```

### Variante C — Session-Ende vorbereiten

```
Wir beenden die Session. Bitte:
1. Daily Note ergänzen/anlegen
2. TASKS.md updaten
3. MEMORY.md prüfen bei Hardware-Arbeit
4. Kurz zusammenfassen was heute lief

Wenn Claude Code parallel läuft: Erinnerung mit Abschluss-Befehl.
```

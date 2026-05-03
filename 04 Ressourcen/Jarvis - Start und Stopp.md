---
tags: [runbook, jarvis]
date: 2026-05-03
---

# Jarvis — Start und Stopp

## Starten
Terminal öffnen, `jarvis` tippen, Enter.

## Stoppen
Ctrl+C im Terminal, oder Terminal-Fenster schließen.

## Was passiert beim Start
1. cd ~/jarvis
2. source .venv/bin/activate
3. python3 jarvis.py
4. Wartet auf Wake-Word "hey jarvis" (threshold 0.65)

## Auto-Start
Aktuell bewusst NICHT aktiv. Privacy-Entscheidung — Mikro lauscht nur wenn Sebastian es startet. Falls später gewünscht: launchd-Job in ~/Library/LaunchAgents/ einrichten.

## Verwandt
- ~/jarvis/README.md — Code-Doku
- TASKS.md — Phase 1.6, 1.7, 1.8 offene Items

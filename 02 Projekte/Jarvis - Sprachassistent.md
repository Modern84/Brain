---
tags: [projekt, ki, voice, automatisierung, mac, iphone]
date: 2026-04-30
status: geplant
priorität: B
owner: Sebastian
raum: KI-Anwendungen
due: —
---

# Jarvis — Persönlicher Sprachassistent

> **Kontext-Lead:** Sebastian baut einen Vollassistenten à la Iron-Man-Jarvis: hört zu, redet zurück, kennt das Gehirn, führt Aufgaben aus. Mac als Server, iPhone via Siri-Shortcut. Inspiration: YouTube Julian Ivanov (08.04.2026, Repo `jarvis-voice-assistant`). Eigenes Konzept aber, weil Sebastians Use-Cases (Drucker, WEC, Mail-Triage, Briefing-Trigger) anders sind als das Generikum aus dem Video.

## Constraints (unantastbar)

1. **Klipper/Hardware niemals autonom.** Jarvis schlägt vor, Sebastian aktiviert per Voice. Kein automatisches `FIRMWARE_RESTART`, `G28`, `EXTRUDE`. Lese-Tools ok.
2. **Brain-First mit Datum-Prio.** Bei Hardware-Fragen immer letzte 3 Daily Notes lesen, nicht Master-Datei (siehe [[CLAUDE]] Regel 17/19).
3. **Secrets niemals in TTS.** Regex-Filter (`password|token|key|ssh|recovery`) → Skip statt Vorlesen. Apple-Schlüsselbund bleibt einzige Wahrheit für Credentials.
4. **Constraint-First-Regel** als System-Prompt. Erste Frage bei neuem Auftrag: „Was darf sich nicht ändern?"
5. **Zeitstempel absolut**, nie „vorhin" / „gestern". Format `YYYY-MM-DD HH:MM`.
6. **Multi-User später.** Phase 1 nur Sebastian. Reiner/Ildi sind Phase 4.

## Use-Cases (priorisiert nach Sebastians realem Alltag)

### Priorität A — kommt jeden Tag vor

| # | Use-Case | Beispiel-Sprachbefehl | Tools |
|---|---|---|---|
| A1 | Drucker-Status & Stabilphase | „Jarvis, wie läuft die Stabilphase?" | Klipper REST (read-only), Bridge-Stability-Log, dmesg ENOBUFS-Counter |
| A2 | Briefing-Trigger | „Jarvis, wo war ich?" / „Jarvis, briefing" | TASKS.md, letzte Daily Note, Eingang |
| A3 | Mail-Eingang Bens/Knauf/Reiner melden + Raum laden | „Jarvis, neue Mails?" | Apple Mail (AppleScript), Brain-Fulltext, Raum-Tabelle aus CLAUDE.md |

### Priorität B — mehrmals pro Woche

| # | Use-Case | Beispiel-Sprachbefehl | Tools |
|---|---|---|---|
| B1 | Feierabend-Routine sprechen | „Jarvis, ende" | Daily Note finalisieren, TASKS-Update, MEMORY-Sync |
| B2 | Recherche mit Quellencheck | „Jarvis, was sagt Klipper-Doku zu CAN-Termination?" | Web-Search, Klipper-Discourse, GitHub-Issues, Brain-Verknüpfungen |

### Priorität C — wertvoll aber nicht dringend

| # | Use-Case | Beispiel-Sprachbefehl | Tools |
|---|---|---|---|
| C1 | Hardware-Bestellung tracken | „Jarvis, wo ist das UBEC?" | Amazon/AliExpress-Tracking, Brain-Hardware-Status |
| C2 | Kalender-Block für Drucker-Session | „Jarvis, block mir 1 h für Servo-Test Dienstag" | Apple Calendar (AppleScript), Energie-Realismus-Check |

## Architektur

```
Mac (immer an) ─────────────────────────────────────────
  ├─ Wake-Word "Jarvis" (openWakeWord, lokal, 24/7 mic)
  ├─ Whisper.cpp (STT, lokal, Deutsch, kein Cloud-Mic)
  ├─ FastAPI :8765
  │    └─ Claude Agent SDK (Opus 4.7 für Aufgaben, Sonnet 4.6 für Smalltalk)
  │         ├─ MCP Filesystem → Gehirn (read+write)
  │         ├─ MCP Obsidian (Datum-Prio-Read)
  │         ├─ Tool: Klipper-API READ-ONLY (Whitelist)
  │         ├─ Tool: AppleScript (Mail, Kalender, Notes)
  │         ├─ Tool: Playwright (Browser)
  │         └─ Guards: Secret-Regex, Hardware-Confirm-Wall
  └─ ElevenLabs TTS → Lautsprecher (Cloud, ~5 €/Monat)

iPhone (Phase 2) ───────────────────────────────────────
  └─ Siri-Shortcut "Hey Jarvis" → Tailscale → Mac:8765
```

**Privacy-Mix:** Mic-Audio bleibt lokal (Whisper). Text geht zu Claude. Antwort-Text geht zu ElevenLabs für TTS, Audio kommt zurück. Kein Always-Stream zu Cloud.

## Phasen-Plan

### Phase 1 — Solo Mac, Read-Only (1–2 Abende)
- Wake-Word + Whisper + Claude + ElevenLabs Pipeline
- Use-Cases A1, A2 (Status + Briefing)
- Nur Lese-Tools. Keine Aktionen.
- **Akzeptanzkriterium:** „Jarvis, briefing" → spricht innerhalb 3 s das Briefing.

### Phase 2 — Aktionen + iPhone (1 Abend)
- Mail-AppleScript, Kalender-AppleScript
- Use-Cases A3, B1, B2, C2
- Siri-Shortcut für iPhone
- **Akzeptanzkriterium:** Mail-Trigger funktioniert vom iPhone aus.

### Phase 3 — Proaktiv (offen, 2–3 Abende)
- Drucker-Milestone-Push („Stabilphase 25 % erreicht")
- Mail-Watcher (Bens/Knauf neu)
- Hardware-Lieferung-Tracking
- **Risiko:** Notification-Flut. Quotas + Stillzeiten zwingend.

### Phase 4 — Multi-User (später, nicht eingeplant)
- Reiner: eigenes Wake-Word, eigenes Brain
- Ildi: Ungarisch-Mode (Whisper kann beides)

## Offene Entscheidungen

- [ ] Wake-Word „Jarvis" oder eigenes? (Lizenz openWakeWord prüfen)
- [ ] ElevenLabs-Stimme: Welche? Deutsch, männlich, ruhig
- [ ] Quotas für proaktive Pushes (Phase 3)
- [ ] Logging: Was wird mitgeschnitten? Datenschutz-Linie ziehen

## Verknüpfungen

- Inspiration: YouTube Julian Ivanov, Repo `jarvis-voice-assistant` — als Vorlage, nicht als Kopie
- [[CLAUDE]] Regeln 17–22 sind Architektur-Pflicht
- [[03 Bereiche/KI-Anwendungen/KI-Anwendungen]]
- [[04 Ressourcen/Workflow - Sebastian und Claude]]

## Lessons / Changelog

- **2026-04-30:** Projekt angelegt nach claude.ai-Sitzung. Konzept basiert auf Brain-Analyse durch Explore-Agent (Use-Cases aus letzten 5 Daily Notes + TASKS.md abgeleitet). Phase 1 startet in eigener CC-Session.

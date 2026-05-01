---
tags: [projekt, ki, managed-agents, brain]
status: verworfen
priorität: B
date: 2026-05-01
owner: Sebastian
raum: ki-anwendungen
verknuepft:
  - "[[02 Projekte/MThreeD.io/Analyse - Klipper KI-Debug-Tunnel]]"
---

# Brain-Pflege-Agent — Managed-Agents-Pilot

> **Pilot** für Anthropic Managed Agents (Beta `managed-agents-2026-04-01`). Klein, ohne Produktionsdruck, um die Mechanik (Agent → Environment → Session → Events) zu lernen, bevor sie auf Klipper-Debug-Tunnel oder CAD-Pipeline angewendet wird.

## Idee

Ein gehosteter Agent, der nachts (oder auf Knopfdruck) den Vault prüft und kleine Pflege-Aufgaben übernimmt — Dinge, die heute manuell hängenbleiben.

## Constraints — vor Code zu klären

1. **Scope** — was soll der Agent in V1 wirklich tun? Optionen:
   - (a) Inbox-Triage: Notizen aus `01 Inbox/` lesen, Vorschlag für Zielordner + Schlagwörter (nur Vorschlag, kein Move)
   - (b) TASKS-Konsistenz: TASKS.md gegen Projektdateien prüfen, Widersprüche melden
   - (c) Daily-Note-Lücken: fehlende Tage seit letzter Note flaggen
   - → V1 = **eines davon**, nicht alle drei
2. **Schreibrechte** — read-only Report (Markdown nach `01 Inbox/Agent-Reports/`) oder darf er Dateien anfassen? Pilot-Empfehlung: read-only.
3. **MCP-Zugriff** — Filesystem-MCP gegen `~/Brain/`. Read-only Mount. Welche Pfade ausschließen? (`07 Anhänge/`, `.obsidian/`, `.claude/` definitiv)
4. **Trigger** — manuell (`ant beta:sessions create ...`) oder Cron? Pilot: manuell.
5. **Modell** — Haiku 4.5 reicht für Triage-Aufgaben; Opus nur wenn semantisch tief. Default: Haiku.
6. **Key** — neuer Anthropic-Key nötig (`~/jarvis/.env` ungültig nach Rotation am 2026-05-01).

## Offene Fragen für Mo

- Welche Scope-Variante (a/b/c) für V1?
- Read-only Reports OK als Start?
- Soll der Agent eine eigene Identität bekommen (Name, System-Prompt-Persönlichkeit) oder neutral „Brain-Pflege-Bot"?

## Nächste Schritte (nach Constraint-Antworten)

1. Anthropic-Key neu (Mo manuell)
2. Agent-Definition schreiben (System-Prompt + Tool-Liste)
3. Environment definieren (Filesystem-MCP-Config)
4. Erstes `sessions.create` + `events.send` von Hand testen
5. Wrapper-Skript falls Cron gewünscht

## Verknüpfungen

- [[03 Bereiche/KI-Anwendungen/KI-Anwendungen]]
- [[02 Projekte/MThreeD.io/Analyse - Klipper KI-Debug-Tunnel]] — der eigentlich passende Use-Case
- Doku: https://platform.claude.com/docs/en/managed-agents/sessions

---

## Befund 2026-05-01 — verworfen

Nach Lesen der Docs (overview, environments, agent-setup) klar: Pilot passt architektonisch nicht.

**Drei Befunde:**

1. **Filesystem-Isolation hart.** Environment = Cloud-Container, konfigurierbar nur über `packages` und `networking` (allowlist). Kein Volume-Mount, kein lokaler Zugriff auf Mo's Mac. Vault liegt in iCloud auf dem Mac — der Container kann nicht direkt ran.
2. **Multi-Tenant-Positionierung.** Overview wörtlich: „Best for long-running tasks and asynchronous work". `vault_ids` für OAuth-Refresh, Agent-Versionierung, Session-Sharing — das ist SaaS-Infrastruktur, nicht Single-User-Local-Tooling.
3. **Pre-built Tools sind container-intern.** Bash, File-Ops, Web-Search — alle gegen Container-FS. Externer Zugriff nur über MCP-Server mit öffentlichem Endpoint.

**Begründung Verwerfung:** Pilot wäre nur über git-clone-Workaround machbar (Brain liegt auf GitHub, Container clont, Linter läuft, Report kommt via Event zurück). Das funktioniert, ist aber eine künstliche Konstruktion — nicht das Pattern (MCP-für-externe-Systeme), das später für Klipper-Tunnel gebraucht wird. Lerneffekt geschätzt ~30 % von dem, was Klipper braucht.

**Konsequenz:** Managed Agents bleibt im Auge — aber als Werkzeug für [[02 Projekte/MThreeD.io/Analyse - Klipper KI-Debug-Tunnel|Klipper KI-Debug-Tunnel]], wo die Architektur (long-running, multi-tenant, Hosting durch Anthropic) exakt passt. Pilot wird nicht ersatzweise gebaut — der echte Lerneffekt kommt mit dem echten Use-Case.

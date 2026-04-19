---
tags: [ressource, tool, fusion360, cad, workflow]
date: 2026-04-17
---

# Fusion 360 — Arbeiten mit Claude

## Was funktioniert (indirekte Zusammenarbeit)

Claude hat **keinen direkten Zugriff** auf Fusion 360 — keine App-Steuerung, keine Live-Bearbeitung.

Effektiv nutzbar:

- **Parametric Design beraten** — Maße, Constraints, Feature-Reihenfolge durchdenken
- **Formeln & Parameter** — Spreadsheet-driven Design, Variable-Strukturen
- **Scripts & Add-ins** — Python-basierte Fusion-API-Skripte schreiben und debuggen
- **Screenshots analysieren** — Mo schickt Screenshot → Claude analysiert, gibt Feedback
- **Fehler debuggen** — Fehlermeldungen einfügen, Claude erklärt und löst
- **Workflow planen** — Bodies, Components, Joints sinnvoll strukturieren
- **CAM-Strategien** — Toolpaths, Feeds & Speeds für ProForge 5

## Typischer Workflow

1. In Fusion 360 arbeiten
2. Bei Frage oder Problem: Screenshot oder Fehlermeldung an Claude (claude.ai)
3. Claude gibt strukturierte Antwort / Code / Strategie
4. Mo setzt um

## Hinweis MCP-Connector

Wenn der Filesystem-Connector nicht antwortet (Timeout) → Claude Desktop neu starten (Cmd+Q → neu öffnen). Vault-Writes schlagen dann fehl.

## Verknüpfungen

- [[01 Inbox/Vision - Automatisierte Konstruktions-Pipeline]]
- [[01 Inbox/Idee - Claude SolidWorks Integration]]

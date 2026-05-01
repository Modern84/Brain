---
tags: [kontext, claude-code, handover]
date: 2026-04-24
---

# Brain Context für Claude Code

> **Kopiere diesen Text in deine erste Message an Claude Code**, wenn du ihn über das Brain-System informieren willst.

---

## Mein Second Brain System

Ich (Mo/Sebastian) nutze **Obsidian** als Second Brain im "Brain"-Vault.

**Pfad:** `/Users/sh/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain/`

**Struktur:**
```
Brain/
├── 00 Kontext/          # Wer ich bin, System-Kontext
├── 01 Inbox/            # Neue Gedanken, unsortiert
├── 02 Projekte/         # Aktive Projekte mit Deadline
├── 03 Bereiche/         # Laufende Verantwortung (WEC, Finanzen, etc.)
├── 04 Ressourcen/       # Wissen, Scripts, Prompts, Standards
├── 05 Daily Notes/      # Tagesbuch (YYYY-MM-DD.md)
├── 06 Archiv/           # Erledigtes
├── 07 Anhänge/          # Bilder, Dokumente
├── CLAUDE.md            # Regeln für Claude (lies das!)
└── TASKS.md             # Zentrale Aufgabenliste
```

## Wie Claude (Web) damit arbeitet

**Claude.ai (Web-Chat)** hat via **Filesystem MCP Connector** direkten Zugriff auf mein Brain.

**Wichtigste Regeln:**
- Claude liest **CLAUDE.md** im Root als Basis-Kontext
- Claude schreibt **direkt in den Vault** (kein Download-Dialog)
- Claude nutzt **Filesystem-Tools** (nicht bash wegen iCloud-Pfad mit Leerzeichen)
- Neue Notizen → strukturiert einsortieren (nicht alles in Inbox kippen)
- **Niemals sensible Code-Inhalte im Vault** (Secrets → Schlüsselbund, nicht Markdown)

**Session-Start-Verhalten:**
- Bei substantiven Fragen: Claude liest Daily Note + relevante Projekt/Bereich-Files BEVOR er antwortet
- Bei Quick Queries (<5 Wörter): direkt antworten

## WEC-Kontext (wichtig!)

**WEC** = WOLDRICH ENGINEERING + CONSULTING (Reiner Woldrich)

Ich (Mo/Sebastian) arbeite eng mit **Reiner** zusammen:
- Reiner: 30 Jahre Konstruktions-Erfahrung (Solid Edge), Praktiker
- Mo: CAD-Automation, Fusion 360, Claude-Integration, Digital-Layer
- Gemeinsame Projekte: Konstruktionsaufträge, Lebensmittelindustrie (Bens Edelstahl)

**WEC-Bereich im Brain:**
`03 Bereiche/WEC/` = Operationszentrale nach Karpathy-Pattern
- `raw/` = Originaldaten (UNANTASTBAR, nur lesen)
- `wiki/` = Claude pflegt Wissen-Artikel
- `Operationen/` = Query, Ingest, Lint
- Eigene `CLAUDE.md` mit WEC-spezifischen Regeln

**Shared Brain Architektur (geplant):**
- Ein Vault (mein Brain)
- Beide (Mo + Reiner) über **Obsidian Sync** verbunden (96€/Jahr, noch nicht aktiviert)
- Claude filtert Kontext:
  - Für **Reiner** (über Claude Web): nur WEC-Bereiche zeigen
  - Für **Mo**: voller Zugriff auf alles

## Was Claude Code wissen sollte

**Du (Claude Code) hast KEINEN direkten Brain-Zugriff** - du arbeitest lokal im Terminal.

**Wenn ich dir sage "schau im Brain nach":**
1. Ich gebe dir den Pfad: `/Users/sh/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain/`
2. Du nutzt `cat`, `grep`, `find` normal (bash funktioniert hier, anders als bei Claude Web)
3. Oder ich kopiere dir relevante Infos rüber

**Wenn ich sage "schreib das ins Brain":**
1. Du erstellst die Datei lokal mit korrektem Pfad
2. Obsidian synct automatisch (iCloud)
3. Frontmatter-Format beachten:
   ```markdown
   ---
   tags: [kategorie]
   date: YYYY-MM-DD
   status: aktiv|geplant|erledigt
   ---
   ```

**Typische Workflows:**
- **Scripts schreiben** → `04 Ressourcen/Scripts/`
- **Projekt-Sessions** → `02 Projekte/<projekt>/Sessions/`
- **WEC-Wiki-Artikel** → `03 Bereiche/WEC/wiki/`
- **TASKS.md updaten** → direkt im Root

## Hardware-Kontext (aktuell)

**Mein Setup:**
- MacBook Pro 2021 M1 (mobil, aktuell)
- Mac Studio M5 Ultra 256GB (geplant, nach WWDC Juni 2026, ~8.000€)

**Reiners Setup:**
- Windows PC (WEC, kein Admin - IT-Problem)
- Mac Mini M5 (geplant, nach WWDC, ~1.200-2.000€)

**Aktuelles Projekt:**
- ProForge 5 (3D-Drucker, Pi 5 + Klipper)
- WEC Konstruktionsaufträge (Lagerschalenhalter für Bens Edelstahl)
- MThreeD.io Geschäftsaufbau

## Do's and Don'ts

✅ **DO:**
- Brain-Pfad verwenden wenn ich dir sage "ins Brain schreiben"
- Frontmatter-Format einhalten
- WEC-Regeln beachten (White-Label, EHEDG, Bens-Standards)
- Deutsche Begriffe im Brain (nicht "Vault" sondern "Gehirn" in Notizen)

❌ **DON'T:**
- Nicht einfach alles in `01 Inbox/` kippen - strukturiert einsortieren
- Keine Secrets/Passwörter in Markdown (Schlüsselbund nutzen)
- Nicht in `raw/` schreiben (nur lesen!)
- Nicht vergessen: iCloud-Pfad hat Leerzeichen → Anführungszeichen in bash

## Wenn du mehr brauchst

Relevante Dateien zum Lesen:
- `CLAUDE.md` (Root-Regeln)
- `03 Bereiche/WEC/CLAUDE.md` (WEC-spezifische Regeln)
- `TASKS.md` (Was läuft aktuell)
- `05 Daily Notes/YYYY-MM-DD.md` (Heutiges Tagesbuch)

## Verwandte Dokumente

- [[00 Kontext/Cowork - Brain Context]] — Handover für Cowork (Desktop-Automation)
- [[00 Kontext/Wo ist alles gespeichert - Überblick für Reiner]] — Systemüberblick ohne IT-Jargon
- [[CLAUDE]] — Root-Regeln des Gehirns

Einfach fragen: "Zeig mir CLAUDE.md" oder "Was steht in TASKS.md?"

---
tags: [projekt, mcp, obsidian, claude, ai-first]
date: 2026-04-19
status: geplant
priorität: A
owner: Sebastian
raum: KI
due: 2026-05-17
---

# Obsidian-MCP Einrichtung — Hebel 2 AI-First

Setup eines MCP-Servers für Obsidian, damit Claude (Desktop, Code, claude.ai) strukturiert auf den Vault zugreift — nicht über File-Read, sondern über Queries. Teil der [[00 Kontext/Meta/AI-First]] Richtungsentscheidung.

---

## Warum das der größte Hebel ist

Aktuell muss Claude File für File lesen. Bei 200+ Dateien kostet das Kontext und verpasst semantische Zusammenhänge. Mit MCP-Server kann Claude Queries stellen wie:

- "Alle aktiven Projekte mit Owner Reiner und Frist dieser Woche"
- "Finde alle Notizen zu Volker Bens die nach dem 2026-04-15 erstellt wurden"
- "Welche Wiki-Artikel verweisen auf BWL-Filter?"

Das ist **10x effizienter** und erschließt den Vault als Datenbank.

---

## Kandidaten (2026-04-19)

Zwei etablierte MCP-Server für Obsidian:

**A) `mcp-server-obsidian` (smithery-ai / jacksteamdev)**
- REST-API-basiert — nutzt das **Local REST API** Community-Plugin
- Stabil, gut dokumentiert
- Funktionen: read/list/search notes, append, patch
- Installation via npm oder smithery.ai

**B) `obsidian-mcp` (markbolinger oder ähnlich)**
- Direkter Filesystem-Zugriff
- Benötigt kein Obsidian-Plugin
- Funktionen: search, read, create, update

**Empfehlung:** **A)** weil REST-API-basiert sauberer ist (Obsidian-Plugin kontrolliert was zugänglich ist) und besser in Claude Desktop integriert.

Vor Entscheidung: aktuelle Versionen + GitHub-Stars prüfen, ggf. beide kurz testen.

---

## Setup-Schritte (wenn A gewählt)

### 1. Local REST API Plugin in Obsidian

- Einstellungen → Community-Plugins → Browse → "Local REST API"
- Installieren → Aktivieren
- Plugin-Einstellungen: API-Key generieren, sichere Kopie (Schlüsselbund!)
- HTTPS auf Port 27124 aktivieren (SSL-Zertifikat wird vom Plugin generiert)

### 2. MCP-Server installieren

```bash
# Global installieren
npm install -g @jacksteamdev/mcp-server-obsidian

# Test
OBSIDIAN_API_KEY=<dein-key> npx @jacksteamdev/mcp-server-obsidian
```

### 3. Claude Desktop / Code konfigurieren

In `~/Library/Application Support/Claude/claude_desktop_config.json` (Claude Desktop)
oder `~/.claude/.mcp.json` (Claude Code):

```json
{
  "mcpServers": {
    "obsidian": {
      "command": "npx",
      "args": ["-y", "@jacksteamdev/mcp-server-obsidian"],
      "env": {
        "OBSIDIAN_API_KEY": "<key-aus-schritt-1>",
        "OBSIDIAN_HOST": "127.0.0.1",
        "OBSIDIAN_PORT": "27124"
      }
    }
  }
}
```

### 4. Neustart + Test

- Claude Desktop / Code neustarten
- Test: *"Zeig mir alle Dateien in 02 Projekte/ mit Status aktiv"*
- Erwartung: Claude nutzt MCP-Tool (sichtbar als Tool-Call) statt File-Read

---

## Integration mit Dataview

Nach MCP-Setup bleibt Dataview das Interface für **Menschen** (Home-Dashboard), MCP wird das Interface für **Claude**. Beide arbeiten über das gleiche Feld-Schema ([[04 Ressourcen/Kopfdaten-Standard]]).

---

## Risiken

- **API-Key-Leak:** Der Key gibt vollen Vault-Zugriff. Nur im Apple-Schlüsselbund, niemals im Vault speichern, niemals in Git committen.
- **Port 27124 offen:** nur auf `127.0.0.1` binden, keine Weiterleitung nach extern.
- **Plugin-Abhängigkeit:** Wenn Local REST API-Plugin bricht (Obsidian-Update), bricht MCP. Alternative B als Backup-Plan im Kopf.

---

## Erfolgsmessung

- [ ] Local REST API Plugin läuft
- [ ] MCP-Server antwortet auf Ping
- [ ] Claude Desktop zeigt MCP-Server als verbunden
- [ ] Test-Query liefert korrekte Datei-Liste
- [ ] Mindestens 3 echte Arbeits-Queries erfolgreich (z.B. "aktive WEC-Aufträge")

Erfolg: **Claude greift in normaler Session via Query zu, nicht via File-Read.**

---

## Verknüpfungen

- [[00 Kontext/Meta/AI-First]] — Kontext
- [[04 Ressourcen/Kopfdaten-Standard]] — Feld-Schema das MCP abfragt
- [[00 Kontext/Home]] — menschliches Gegenstück (Dataview)
- [[03 Bereiche/KI-Anwendungen/KI-Anwendungen]] — Raum

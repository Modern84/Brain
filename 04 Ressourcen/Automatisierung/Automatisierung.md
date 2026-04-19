---
tags: [ressource, automatisierung]
date: 2026-04-04
---

# Automatisierung

Tools, Workflows und Skripte die Arbeitsprozesse vereinfachen.

## Im Einsatz

- **klipper-mcp** — KI-Zugriff auf Klipper/Moonraker via MCP-Server → [[04 Ressourcen/Klipper/Klipper]]
- **Claude (claude.ai + Claude Code)** — Zweites Gehirn, Schreibassistent, Vault-Pflege
- **Obsidian Web Clipper** — Artikel & Links sammeln

## Skripte

### resize-for-claude.sh

Verkleinert Screenshots auf max. 1920px um das Anthropic 20-MB-Upload-Limit zu vermeiden.

**Installiert als:** `rfc` (Alias in `~/.zshrc`)

```bash
rfc                        # alle Bildschirmfotos auf dem Desktop
rfc ~/Desktop/bild.png     # einzelne Datei
```

Skript: [[04 Ressourcen/Automatisierung/resize-for-claude.sh]]

### sort-brain.sh

Verschiebt alle Dateien von Desktop und Downloads ins Gehirn. Alles landet pauschal im Eingang (`01 Inbox/_Eingang Dateien/`) mit Datumspräfix — die Kontextualisierung (welcher Kunde, welches Projekt) passiert später im Chat mit Claude. Screenshots sind die einzige Ausnahme, die gehen automatisch nach `07 Anhänge/Screenshots/`.

**Installiert als:** `sort-brain` / `sort-brain --preview` (Alias in `~/.zshrc`)

```bash
sort-brain               # verschiebt alles
sort-brain --preview     # zeigt nur was verschoben würde
```

Skript: [[04 Ressourcen/Automatisierung/sort-brain.sh]]
Eingang-Ordner: [[01 Inbox/_Eingang Dateien/README]]

### mac-inventur.sh

**Einmalige** Vorsortierung des gewachsenen Macs. Schiebt alle Dateien aus Desktop und Downloads in fünf Stapel nach `~/Mac-Inventur/` — Müll, Installer, iPhone-Fotos, Duplikate, Projekt-Material. Screenshots gehen direkt ins Gehirn. Danach arbeitet Sebastian die Stapel einzeln ab. Wenn der Mac einmal leer ist, übernimmt `sort-brain` den laufenden Betrieb.

**Installiert als:** `mac-inventur` / `mac-inventur --preview` (Alias in `~/.zshrc`)

```bash
mac-inventur --preview    # Vorschau: wie viele Dateien pro Kategorie
mac-inventur              # wirklich verschieben
```

Skript: [[04 Ressourcen/Automatisierung/mac-inventur.sh]]
Projektplan: [[02 Projekte/Mac Inventur]]

## Geplant / Ideen

- Obsidian-MCP einrichten — direktes Speichern in den Vault aus Claude heraus
- klipper-mcp in Workspace Assistant einbauen
- Automatische Vault-Pflege (Rückverlinkungen, Frontmatter-Checks)
- Screenshot-Speicherort auf Brain umstellen: `07 Anhänge/Screenshots/` (→ `defaults write com.apple.screencapture`)
- `sort-brain.sh` als PowerShell-Variante für Reiners Gehirn (Windows)

## Links

- [[03 Bereiche/KI-Anwendungen/KI-Anwendungen]]
- [[04 Ressourcen/Klipper/Klipper]]

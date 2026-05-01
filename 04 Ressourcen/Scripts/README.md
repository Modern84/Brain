---
tags: [ressource, scripts]
date: 2026-04-19
---

# Scripts — Werkzeugkasten fürs Gehirn

Bash-Scripts zur Pflege und Automatisierung des Gehirns. Alle aus dem Vault-Root ausführbar (nach `chmod +x`).

## Einmalig aktivieren

```bash
cd /Users/sh/Brain
chmod +x "04 Ressourcen/Scripts"/*.sh
```

## Übersicht

| Script | Zweck | Wann |
|---|---|---|
| `brain-lint.sh` | Findet fehlende Kopfdaten, tote Wikilinks, falsche Tags | Alle 1–2 Wochen |
| `brain-stats.sh` | Ordner-Übersicht mit Dateianzahl, Status-Verteilung | Session-Start |
| `daily-note.sh` | Heutige Daily Note aus Template anlegen | Morgens |
| `image-shrink.sh` | Desktop-Screenshots auf 1920px verkleinern | Vor Upload an Claude |

## Aliase in `~/.zshrc` (optional)

```bash
alias blint='bash "04 Ressourcen/Scripts/brain-lint.sh"'
alias bstats='bash "04 Ressourcen/Scripts/brain-stats.sh"'
alias bdaily='bash "04 Ressourcen/Scripts/daily-note.sh"'
alias rfc='bash "04 Ressourcen/Scripts/image-shrink.sh"'
```

## Prinzipien

- Nur lesend wenn nicht anders nötig (`brain-lint` ändert nichts, nur Report)
- Ausgabe **in Konsole**, keine Auto-Änderungen am Vault
- Fehler laut melden, nicht leise verschlucken

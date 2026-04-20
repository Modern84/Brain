---
tags: [ressource, template, handover, claudecode, git, backup]
date: 2026-04-19
---

# Handover an Claude Code — Git-Backup initialisieren

> **Zweck:** Vault gegen Datenverlust absichern. Status: 121 uncommitted changes, letzter Commit "first commit" — kein echtes Backup seit Start. **Kritisch** vor Reiner-Session Montag.

---

## Kontext vorab

- **Risiko:** iCloud-Sync ersetzt kein Backup. Versehentlich gelöschte Datei ist weg.
- **Lokalität:** Vault liegt in `~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain/`
- **Was NICHT ins Repo darf:** 4,1 GB `Datensatz_SK`, CAD-Binaries, Screenshots, ggf. Passwort-Hinweise, iCloud-Metadata
- **Remote-Ziel:** noch offen — GitHub Private? Gitea selbst-gehostet? Erstmal nur lokal committen, Remote später

---

## Prompt — in Terminal kopieren

```
Kontext: Git-Backup für den Obsidian-Vault einrichten. 121 uncommitted
changes liegen seit Wochen rum. Letzter Commit war "first commit".
Vault-Pfad: ~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain/

Vor JEDER Aktion: aktueller Zustand prüfen, Plan vorlegen, auf Grünes
Licht warten. Nichts push, nichts force.

Phase 1 — Bestandsaufnahme (nur lesen, nicht ändern):
1. `git status` — was uncommitted, welche Pfade dominieren
2. `git log --oneline -10` — bestätigen dass nur "first commit" da ist
3. `du -sh` pro Top-Level-Ordner um Größen-Hotspots zu identifizieren
4. Prüfen ob `.gitignore` existiert und ob sie ausreicht
5. Report: Zusammenfassung Zahlen + erkannte Risiken

Phase 2 — .gitignore bauen (kritisch!):
Minimum-Inhalt:
  # iCloud / macOS
  .DS_Store
  .icloud
  *.icloud
  ._*
  .Trash/

  # Obsidian-lokale State (nicht reproduzierbar)
  .obsidian/workspace.json
  .obsidian/workspace-mobile.json
  .obsidian/workspaces.json
  .obsidian/graph.json        # optional — enthält manuelle Zoom/Scale-Werte
  .obsidian/cache/
  .trash/

  # Große Anhänge — erst NICHT committen, später bewusst entscheiden
  07 Anhänge/Allgemein/Datensatz_SK/
  07 Anhänge/Allgemein/Profil/
  07 Anhänge/Screenshots/
  07 Anhänge/**/*.step
  07 Anhänge/**/*.stp
  07 Anhänge/**/*.dwg
  07 Anhänge/**/*.dft
  07 Anhänge/**/*.dxf
  07 Anhänge/**/*.zip
  07 Anhänge/**/*.rar
  07 Anhänge/**/*.m4a
  07 Anhänge/**/*.mov
  07 Anhänge/**/*.mp4

  # Potenzielle Secrets (präventiv)
  *.key
  *.pem
  *.p12
  .env
  .env.*
  credentials.json
  *secret*.json

Plan vorlegen: zeige die vollständige .gitignore, begründe Abweichungen
falls nötig. Auf Freigabe warten.

Phase 3 — Sensitives-Scan (BEVOR committed wird):
Suche nach gängigen Secret-Patterns im Vault:
- Passwörter im Klartext ("password:", "passwort:", "pw:")
- API-Keys (sk-..., ghp_..., AKIA...)
- Private Keys (-----BEGIN ... KEY-----)
- E-Mail-Passwort-Kombinationen
- Tailscale/Cloudflare Keys
- SSH Private Keys (aber NICHT ~/.ssh/ — der ist außerhalb)

Report als Liste: Datei:Zeile mit Match (ohne den Match selbst in den
Report zu schreiben — nur Hinweis). Sebastian entscheidet ob löschen,
verschieben oder in .gitignore.

Phase 4 — Thematisches Committen (nach Freigabe):
Statt einem Mega-Commit lieber thematisch:
  1. "chore: .gitignore aufgebaut"
  2. "docs: CLAUDE.md + Räume + Auto-Erkennung"
  3. "feat(WEC): Karpathy-Pattern — raw/wiki/Operationen"
  4. "feat: Scripts + Prompts + Kopfdaten-Standard"
  5. "style: Cyber-Overlay CSS, Graph dunkel-neon"
  6. "chore: Struktur-Cleanup (Handovers, SICAT, READMEs)"
  7. Rest als "wip: laufende Projektdaten und Notizen"

Commit-Messages: Deutsch oder Englisch egal, aber konsistent.
Keine Emojis im Commit-Subject (außer Sebastian will).

Phase 5 — Remote vorbereiten (NICHT pushen):
- Schlage 2-3 Remote-Optionen vor (GitHub Private / Gitea-Self-Host /
  lokales Bare-Repo auf externer SSD)
- Für jede: Vor- und Nachteile, Einrichtungsschritte
- Warte auf Sebastian-Entscheidung, pushe nichts

Tabus:
- Kein `git push` ohne explizite Freigabe
- Kein `git reset --hard`
- Kein `git clean -fd` ohne Dry-Run vorher
- Kein `git add -A` ohne vorherigen Blick auf `git status`
- Kein committen von .obsidian/workspace.json (iCloud-Konflikt-Fabrik)

Report am Ende:
- Anzahl Commits, Gesamtgröße Repo
- Anzahl Dateien im Working Tree vs. ignored
- Liste potenzieller Secrets (falls welche)
- Remote-Empfehlung
- Erste Baseline für `du -sh .git/` um Repo-Größe zu prüfen
```

---

## Was danach anliegt (Folgeaufgabe, nicht heute)

- **Remote einrichten** (GitHub Private empfohlen — kostenlos, Zugriff via SSH-Key aus Apple-Schlüsselbund)
- **Auto-Commit täglich** — einfacher Launch-Agent der jeden Abend `git add -A && git commit -m "daily snapshot"` macht, push manuell
- **Reiners Gehirn** später gleich anlegen (zweites Repo)

---

## Verknüpfungen

- [[TASKS]] — Git-Backup als offener Punkt
- [[04 Ressourcen/Kopfdaten-Standard]]
- [[04 Ressourcen/Templates/Claude-Handover/Kopfdaten-Migration]]

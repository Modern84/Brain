---
tags: [ressource, template, handover, claudecode, git, backup]
date: 2026-04-19
updated: 2026-04-20
---

# Handover an Claude Code — Git-Backup initialisieren

> **Zweck:** Vault gegen Datenverlust absichern — lokale Commit-History + optionaler Remote.
>
> **Lessons Learned aus 2026-04-20** (eingebaut unten):
> - Vor jedem Push auf Remote: **Blob-Größen-Scan** auf `origin/main..HEAD`. Bei Repos >1 GB Pflicht.
> - `git push` **niemals** mit `| tail -N` im Hintergrund starten — exit code + Progress gehen verloren, HTTP-500 sieht aus wie „fertig".
> - Bei alten Ordnern mit Binaries (06 Archiv, 07 Anhänge): konservativ adden. Erst `find -size +50M` prüfen, Binaries explizit ausschließen statt „wird schon passen".
> - `git check-ignore` greift **nicht** bei bereits getrackten Dateien. Wenn eine Binary in Commit 1 ist, bringt `.gitignore` in Commit 2 nichts für den Push — es braucht `git filter-repo` oder `git rm --cached` + Rewrite.

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

Phase 4.5 — Pre-Push Blob-Größen-Scan (PFLICHT vor erstem Push):
Wenn `du -sh .git/` > 1 GB oder das Repo alte Commits enthält:
  git rev-list --objects origin/main..HEAD > /tmp/objs.txt
  awk 'NF>=2' /tmp/objs.txt | while IFS=' ' read -r h p; do
    s=$(git cat-file -s "$h" 2>/dev/null)
    [ -n "$s" ] && [ "$s" -gt 50000000 ] && printf "%10d  %s\n" "$s" "$p"
  done | sort -n

GitHub-Limits: 100 MB pro Datei (hard reject), 2 GB pro Push.
Treffer > 50 MB → Report + STOPP. Nicht pushen. Entscheidung:
  (a) filter-repo / BFG, um Blob aus History zu entfernen (destruktiv,
      Hashes ändern sich, Tag muss neu gesetzt werden)
  (b) Git LFS nachrüsten
  (c) Auf Remote verzichten, lokal als Restore-Punkt belassen

Phase 5 — Remote vorbereiten (NICHT pushen):
- Schlage 2-3 Remote-Optionen vor (GitHub Private / Gitea-Self-Host /
  lokales Bare-Repo auf externer SSD)
- Für jede: Vor- und Nachteile, Einrichtungsschritte
- Warte auf Sebastian-Entscheidung

Push-Regeln (wenn Freigabe da):
- Push IMMER interaktiv im Vordergrund starten, nicht mit `| tail` oder `&`
- Bei großen Pushs Progress mitschneiden: `git push --progress 2>&1 | tee /tmp/push.log`
- Bei HTTP 500 / RPC fail / "unexpected disconnect" → Phase 4.5 nachholen

Tabus:
- Kein `git push` ohne Phase 4.5 wenn Repo > 1 GB
- Kein `git reset --hard`
- Kein `git clean -fd` ohne Dry-Run vorher
- Kein `git add -A` ohne vorherigen Blick auf `git status` — **und** ohne Größen-Check der untracked-Datei-Liste (`git status --porcelain | awk '$1=="??"{print $2}' | xargs -I{} du -sh {} | sort -h | tail`)
- Kein committen von .obsidian/workspace.json (iCloud-Konflikt-Fabrik) — falls schon getrackt, `git rm --cached` vor dem ersten neuen Commit
- Keine `git push`-Kommandos im Hintergrund mit geschlucktem stderr (`| tail`, `&>/dev/null`, `2>&1 | head`)

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

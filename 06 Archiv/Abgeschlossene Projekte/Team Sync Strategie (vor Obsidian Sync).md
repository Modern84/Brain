---
tags: [ressource, sync, team, obsidian]
date: 2026-04-24
status: aktiv
---

# Team Sync Strategie

Wie Sebastian und [[Reinhold]] ihre getrennten Obsidian-Vaults so koppeln, dass Austausch funktioniert — über Mac, Windows, iPhone — ohne ein Obsidian-Sync-Abo zu kaufen.

## Ausgangslage

- **Sebastian (Mac)**: Vault unter `~/Brain`. Git-Repo aktiv. Claude Code arbeitet direkt am Vault. Plugins: `claudian`, `obsidian42-brat`, `obsidian-style-settings`.
- **Reinhold (Windows + iPhone)**: Hat sein eigenes Vault. Kernproblem: Notizen vom iPhone landen nicht zuverlässig auf dem Windows-Rechner.
- **Team-Modell**: Getrennte Vaults, gezielter Austausch einzelner Ordner/Notizen.
- **Bezug**: [[Business MThreeD.io|MThreeD.io]] ist ein gemeinsamer Arbeitsbereich; weitere gemeinsame Bereiche (z.B. der von Sebastian genannte „WEC"-Bereich) sind noch zu dokumentieren.

## Schwachstellen im aktuellen Setup

1. **iPhone → Windows bei Reinhold** ist ungelöst. Ohne dedizierte Sync-Lösung landen iPhone-Notizen gar nicht oder nur über Umwege (E-Mail, Screenshot) im Obsidian-Vault.
2. **Zwei Welten getrennt**: Sebastians Git-basierter Workflow (Mac + Claude Code) und Reinholds „normaler" Obsidian-Workflow haben keine Brücke.
3. **Kein definierter Austauschraum**: Unklar, welche Notizen überhaupt geteilt werden. Ohne Struktur wird entweder zu viel oder zu wenig synchronisiert.
4. **Keine Konflikt-Strategie**: Wenn beide an derselben Notiz arbeiten, entscheidet der Zufall.
5. **Kein Plugin bei Reinhold dokumentiert**: Sein Setup ist unbekannt — Grundlage für jede Empfehlung fehlt (→ Folgeaufgabe).

## Architektur-Empfehlung: Hybrid Git + Cloud-Plugin

Der Kern der Lösung: **Ein dedizierter Austausch-Ordner**, der als Brücke zwischen beiden Vaults dient. Nicht das ganze Vault wird geteilt — nur der gezielt freigegebene Teil.

```
Sebastian (Mac)                    GitHub Repo               Reinhold (Windows + iPhone)
┌──────────────────┐              (privat)                    ┌───────────────────────┐
│ ~/Brain          │              ┌───────────┐               │ Vault                 │
│  ├── 02 Projekte │◄──── Git ───►│ brain-    │◄── Git ──────►│  ├── ...              │
│  ├── 03 Bereiche │              │ austausch │               │  └── Austausch/       │
│  └── Austausch/ ─┼─ Submodule ──┴───────────┴── Submodule ──┼──┐                    │
│      (geteilt)   │                                          │  │ ◄── Remotely Save──┤── iPhone
└──────────────────┘                                          └──┴────────────────────┘
                                                                      │
                                                                OneDrive/Dropbox
```

**Komponenten:**

1. **Gemeinsames privates Git-Repo** `brain-austausch` auf GitHub. Enthält nur die geteilten Notizen (nicht die privaten Vaults).
2. **Bei Sebastian**: Austausch-Ordner als Git-Submodule unter `Austausch/` im Vault. Claude Code committet und pusht nach jeder Session. Kein extra Cloud-Dienst nötig.
3. **Bei Reinhold Windows**: Gleiches Repo als Submodule oder separater geklonter Ordner, der in Obsidian als zusätzlicher Vault-Ordner eingebunden ist. Plugin **„Obsidian Git"** übernimmt Auto-Pull/Commit/Push im Intervall (z.B. alle 10 Minuten).
4. **Bei Reinhold iPhone**: Plugin **„Remotely Save"** synct den iPhone-Vault mit OneDrive (oder Dropbox/WebDAV). Auf seinem Windows-PC läuft ein kleiner Hintergrund-Job, der den OneDrive-Ordner mit dem Git-Repo spiegelt — oder er synct manuell einmal am Tag.

**Warum diese Architektur:**

- Sebastian bleibt bei Git → Claude Code, Versionskontrolle, Diff-Historie bleiben erhalten.
- Reinhold bekommt iPhone-Sync, ohne Git auf dem iPhone zu kämpfen (das scheitert für Nicht-Entwickler).
- Austausch ist explizit: Nur was im Austausch-Ordner liegt, wird geteilt. Alles andere bleibt privat.
- Kein Obsidian-Sync-Abo nötig (Ersparnis ~$8/Monat pro Account).
- Konflikte werden durch Git sichtbar (Merge-Konflikt-Marker in der Datei) — lösbar statt stillschweigend verloren.

## Alternative, falls Hybrid zu komplex wird

Wenn Reinhold mit Git nicht klarkommt, Fallback-Plan: **Beide nutzen nur „Remotely Save" + einen gemeinsamen OneDrive-Ordner für Austausch**. Sebastian bindet OneDrive zusätzlich auf dem Mac ein. Einfacher, aber: keine Versionshistorie, Claude Code sieht keine Historie, Konflikte werden überschrieben. Nur als Notnagel.

Wenn auch das zu fummelig ist: **Obsidian Sync Abo** (~$4/Monat Standard pro Account). Offiziell, End-to-End-verschlüsselt, iOS nativ. Teurer, aber null Technikfummelei.

## Vergleich der drei Optionen

| Kriterium | Hybrid Git+Cloud (Empfehlung) | Nur Cloud-Plugin | Obsidian Sync Abo |
|---|---|---|---|
| Kosten/Monat | 0 € | 0 € | ~4–8 € pro Account |
| iPhone-Sync | Ja, über Cloud | Ja | Ja, nativ |
| Versionshistorie | Ja, Git | Nein | 1 Jahr Historie inklusive |
| Claude Code Integration | Voll | Voll (lokal) | Voll (lokal) |
| Konflikte erkennbar | Ja, Git-Merge | Nein, letzter gewinnt | Ja, eingebaut |
| Aufwand Ersteinrichtung | Mittel | Niedrig | Sehr niedrig |
| Technisches Verständnis nötig | Bei Reinhold: gering, wenn einmal eingerichtet | Keine | Keine |

## Austauschordner-Struktur (Vorschlag)

```
Austausch/
├── README.md                  ← Regeln, Wer-macht-was
├── MThreeD.io Gemeinsam/      ← Shared MThreeD.io Material
└── Inbox/                     ← Offene Zettel, noch nicht zugeordnet
```

**Regeln im Austausch-Ordner:**
- Jede Notiz hat Frontmatter `owner: sebastian` oder `owner: reinhold` oder `owner: gemeinsam`.
- Wer „owner" ist, entscheidet bei Unklarheit.
- Große Änderungen ankündigen (Chat, kurzer Satz).
- Keine privaten Notizen hier ablegen.

## Umsetzungsplan (konkrete Schritte)

1. **Leeres privates GitHub-Repo `brain-austausch` anlegen** (Sebastian).
2. **Bei Sebastian**: `Austausch/` als Submodule ins Vault einbinden, leer initialisieren, pushen.
3. **Reinholds Setup erfassen**: Welche Obsidian-Version? Welche Plugins? Welches Cloud-Konto ist verfügbar (OneDrive aus Microsoft-365-Konto, Dropbox, …)?
4. **Bei Reinhold Windows**: GitHub-Account einrichten (falls nicht vorhanden), Repo klonen, „Obsidian Git" Plugin installieren, Auto-Pull 10 Min.
5. **Bei Reinhold iPhone**: Obsidian iOS installieren, Vault öffnen, „Remotely Save" Plugin installieren, mit OneDrive/Dropbox koppeln.
6. **Bridge OneDrive ↔ Git bei Reinhold**: Entweder manuell täglich oder kleines Skript (PowerShell, `git add . && git commit && git push` im Austausch-Ordner nach OneDrive-Sync).
7. **Testlauf**: Sebastian legt Testnotiz im Austausch-Ordner ab, Reinhold sieht sie am Windows. Reinhold erstellt Notiz auf iPhone, Sebastian sieht sie am Mac.
8. **Dokumentieren**: Was funktioniert, was nicht — in diese Datei ergänzen.

## Offene Punkte

- [ ] Reinholds aktuelles Setup erfassen (Plugins, Cloud-Konto)
- [ ] Entscheidung: GitHub oder selbstgehostet (Gitea)?
- [ ] Klären: Wie oft soll Auto-Sync laufen? 10 Min ist default, kann nerven bei schwacher Netzverbindung
- [ ] Konflikt-Playbook schreiben: Was tun, wenn Git-Merge-Konflikt auftaucht? (Reinhold wird das nicht selbst lösen wollen)
- [ ] Backup-Strategie: Austausch ≠ Backup. Separater Backup-Weg nötig?

## Verwandte Notizen

- [[Business MThreeD.io|MThreeD.io]] — gemeinsamer Kontext für Austausch
- [[Obsidian-MCP Setup]] — Connector-Setup, damit Claude direkt ins Vault schreibt
- `.claude/skills/team-sync/SKILL.md` — Regeln für Claude, wenn er im Austausch-Ordner arbeitet

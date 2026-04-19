---
tags: [ressource, skills, uebersicht]
date: 2026-04-18
---

# Skills — was Sebastian und Claude als Team können

## Zweck

Skills sind **wiederverwendbare Fähigkeiten** die Sebastian und Claude (claude.ai + Claude Code) gemeinsam beherrschen. Anders als Projekte oder Ressourcen dokumentieren sie nicht was *einmal gemacht* wurde oder welches Wissen *gesammelt* ist, sondern **was das Team jederzeit wieder anwenden kann**.

**Warum diese Trennung:**
- Projekte = „was gerade läuft" (Mac Inventur, ProForge5 Build)
- Ressourcen = „was ich nachschlagen kann" (Klipper-Doku, WEC-Kontakte)
- **Skills = „was wir schon mal erfolgreich gemacht haben und deshalb wieder tun können"**

Wenn Sebastian sagt *„Cloudflare Tunnel für Reiner einrichten"*, lädt Claude direkt den entsprechenden Skill und das Team ist einsatzbereit — keine Neuerfindung, keine Google-Suche, keine Rätselei.

## Struktur eines Skills

Jede Skill-Datei folgt der Vorlage [[_Vorlage Skill]] mit:

- **Was das ist** — eine klare Beschreibung in ein bis zwei Sätzen
- **Wann anwenden** — konkrete Situationen die diesen Skill auslösen
- **Wie** — Kurzanleitung oder Verweis auf ausführliche Dokumentation
- **Stand der Beherrschung** — `beherrscht` / `in-entwicklung` / `konzept`
- **Abhängigkeiten** — welche anderen Skills man vorher braucht
- **Referenzen** — Verknüpfungen zu verwandten Notizen

## Skill-Katalog

| Skill | Kategorie | Stand | Kurz |
|---|---|---|---|
| [[Skill - Mac-Inventur Methode]] | Gerät-Integration | in-entwicklung | Einmalige Sortierung eines historisch gewachsenen Rechners in 5 Stapel |
| [[Skill - Cloudflare Tunnel]] | Netzwerk | konzept | Externe Erreichbarkeit von Pi/ProForge5/Drucker ohne Portweiterleitung |
| [[Skill - Klipper KI-Debug-Tunnel]] | MThreeD-Produkt | konzept | Eigenes Produkt von Sebastian — KI-Remote-Debug für Klipper/Voron-Drucker |
| [[Skill - Obsidian Brain pflegen]] | Arbeitssystem | beherrscht | Notizen, Verknüpfungen, Struktur, Frontmatter nach Regeln |
| [[Skill - Raspberry Pi headless Setup]] | Hardware | beherrscht | Pi ohne Monitor/Tastatur über SSH, Tailscale, Hotspot einrichten |
| [[Skill - Klipper-Firmware flashen]] | Hardware | beherrscht | Octopus, SO3 und EBB36 Boards flashen — inkl. bekannte Workarounds |
| [[Skill - Claude Code CLI Setup]] | Arbeitssystem | beherrscht | Node/nvm in user-space, brain-Alias, Bildkompression, MCP-Connector |
| [[Skill - Externe SSD als Projektspiegel]] | Daten-Handling | beherrscht | Samsung T9 exFAT-Spiegel für Daten-Transfer zwischen Mac und Windows |
| [[Skill - Duplikat-Pruefung per md5]] | Daten-Handling | beherrscht | md5-basierte Sortierung von Duplikaten in identisch/versioniert/verwaist, mit `duplikate-check.sh` |
| [[Skill - Session-Handover an Claude Code]] | Arbeitssystem | in-entwicklung | Vorgefertigter Prompt-Block in `02 Projekte/`, den Sebastian ins Terminal kopiert — Claude Code führt ohne Rückfragen aus |
| [[Skill - Reiners Gehirn aufbauen]] | Gehirn-Architektur | in-entwicklung | Parallel-Gehirn für Reiner mit identischer Struktur, aber eigener iCloud |

## Kategorien

**Gerät-Integration** — Skills rund um das Integrieren von Computern und Geräten (Inventur, Datenübernahme, Windows-Portierung)

**Hardware** — physische Geräte aufbauen, flashen, konfigurieren (Pi, 3D-Drucker, Elektronik)

**Netzwerk** — Verbindungen aufbauen (VPN, Tunnel, Remote-Zugriff)

**Arbeitssystem** — Tools und Umgebungen die unsere Zusammenarbeit tragen (Obsidian, Claude Code, Shell)

**Daten-Handling** — Speichern, Transferieren, Sichern, Archivieren

**Gehirn-Architektur** — das Gehirn selbst aufbauen und pflegen

**MThreeD-Produkt** — Skills die zu Sebastians eigenem Produktangebot werden (nicht WEC-Gemeinschaft)

## Wie Skills entstehen

Ein Skill wird geboren wenn:

1. Ein wiederkehrendes Muster auftaucht („das hab ich jetzt schon zweimal gemacht")
2. Ein Projekt zu Ende geht und die gewonnene Fähigkeit wiederverwendbar ist
3. Ein Konzept entsteht das später umgesetzt werden soll

Claude darf **eigenständig neue Skills vorschlagen**, wenn beim Arbeiten sichtbar wird: *„das ist ein Muster das wir gerade beherrschen lernen"*. Sebastian entscheidet dann ob daraus eine eigene Datei wird.

## Stand der Beherrschung — Definitionen

- **beherrscht** — wurde mindestens einmal erfolgreich umgesetzt, Anleitung ist erprobt, kann jederzeit wieder angewendet werden
- **in-entwicklung** — gerade dabei es zu lernen, erste Schritte gemacht, Muster kristallisiert sich
- **konzept** — Idee festgehalten, noch nicht umgesetzt, aber geplant und durchdacht

## Verknüpfungen

- [[CLAUDE]] — Vault-Regeln, inklusive Skill-Struktur
- [[04 Ressourcen/Automatisierung/Automatisierung]] — konkrete Skripte die zu Skills gehören
- [[02 Projekte/Mac Inventur]] — aktueller Pilot der einen Skill entstehen lässt
- [[_Vorlage Skill]] — Vorlage für neue Skills

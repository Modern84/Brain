---
tags: [projekt, wec, reiner]
date: 2026-04-17
status: aktiv
---

# Checkliste — Reiner-Gehirn auf T9 vorbereiten

Was ich tun muss, wenn Reiners T9 bei mir landet, bevor sie zurück zu Reiner geht.

## Phase 1 — Wenn SSD bei mir ankommt

- [ ] SSD einstecken, Volume erkannt? (sollte als `WEC-Transfer` auftauchen — sonst Reiner hat nicht formatiert, mach ich dann selbst)
- [ ] `01_WEC-Projekte/` auf meinen Mac übernehmen → `~/Documents/WEC-Projekte-Backup/` (vollständig, nicht verschieben — Kopie bleibt auf SSD)
- [ ] Kurz prüfen: SolidWorks-Ordner vollständig? Zeichnungen-PDF ok? Stücklisten da?

## Phase 2 — `02_Reiner-Gehirn/` befüllen

> **Vorbereitung offen:** Das Script `prepare-reiner-gehirn.sh` gibt es noch nicht — muss von Claude Code gebaut werden, sobald wir wissen wann die SSD kommt. Alternativ kann der Befüll-Schritt auch manuell erledigt werden (Vault-Kopie + Installer-Download + Anleitung-PDF rendern). Script ist nur Automatisierung, nicht Voraussetzung.

- [ ] Script ausführen: `~/Documents/Claude-Projekte/WEC/prepare-reiner-gehirn.sh /Volumes/WEC-Transfer`
- [ ] Script legt an:
  - `02_Reiner-Gehirn/Gehirn/` — kompletter Obsidian-Vault mit CLAUDE.md, AUFGABEN.md, Über mich.md, Ordnerstruktur
  - `02_Reiner-Gehirn/Installer/` — Placeholder-Ordner für Installer
  - `02_Reiner-Gehirn/Einrichtung.md` — Schritt-für-Schritt für Reiner
- [ ] Installer manuell herunterladen und in `Installer/` ablegen:
  - [ ] Obsidian Windows (.exe) — https://obsidian.md/download
  - [ ] Obsidian Mac (.dmg) — https://obsidian.md/download
  - [ ] Claude Desktop Windows (.exe) — https://claude.ai/download
  - [ ] Claude Desktop Mac (.dmg) — https://claude.ai/download
- [ ] Einrichtung.md in PDF konvertieren (für Reiner lesbarer)
- [ ] SSD sicher auswerfen

## Phase 3 — Übergabe an Reiner

- [ ] SSD + kurzer Vor-Ort-Termin (oder Telefon-Begleitung beim Setup)
- [ ] Installer-Pfad und Ablauf erklären
- [ ] Ersten Obsidian-Vault öffnen und gemeinsam testen
- [ ] Claude Desktop Login + Filesystem-Connector einrichten
- [ ] Mit Reiner das "Über mich" befüllen (Win+H Diktat)

## Verknüpfungen

- [[01 Inbox/Anleitung Reiner - Externe SSD Projektspiegel]]
- [[Reiners Gehirn - Setup Plan]]
- [[Konzept Zwei Gehirne]]

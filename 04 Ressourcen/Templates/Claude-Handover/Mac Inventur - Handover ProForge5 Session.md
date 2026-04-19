---
tags: [projekt, handover, claudecode, mac-inventur]
date: 2026-04-18
---

# Handover an Claude Code — Phase 3 Session 2 (ProForge5)

> **Zweck:** Prompt in Claude Code einfügen, um die 22 ProForge5-Dateien aus `~/Mac-Inventur/05_Projekt_Material/` an ihren endgültigen Platz zu bringen. Vorbereitung ist in [[02 Projekte/Mac Inventur - Phase 3 Vorsortierung]] komplett — Zielpfade stehen, Entscheidungen sind durch.

---

## Vor dem Prompt — Entscheidung Sebastian

**Frage:** ProForge5 Build zu Ordner umwandeln, ja oder nein?

- **Ja (empfohlen):** `02 Projekte/ProForge5 Build.md` → `02 Projekte/ProForge5 Build/ProForge5 Build.md`, darunter Unterordner `assets/`, `backups/`, `snapshots/`, `firmware/`, `slicer-profile/`. Alle ProForge5-Artefakte landen strukturiert dort. Bestehende Verknüpfungen bleiben durch Obsidian-Linkupdate intakt.
- **Nein:** ProForge5-Artefakte wandern nach `07 Anhänge/ProForge5/`, `.md`-Notizen an ihren Ort (Klipper-Ressource etc.). `.md`-Hauptdatei bleibt wo sie ist.

Diese Entscheidung vor Start der Session fällen — alle Zielpfade im Prompt sind für Variante „Ja" formuliert.

---

## Prompt für Claude Code

```
Mac-Inventur Phase 3 Session 2 — ProForge5 (22 Dateien).

## Kontext laden
1. CLAUDE.md im Vault-Root
2. 02 Projekte/Mac Inventur.md (Pilot-Plan, aktueller Stand)
3. 02 Projekte/Mac Inventur - Phase 3 Vorsortierung.md (Abschnitt „Ziel-Zuordnung Session 2 (ProForge5)")
4. 02 Projekte/ProForge5 Build.md (bestehendes Projekt)
5. MEMORY.md (Firmware-Stand, Pi-Infos)

## Vorbereitung: Projekt-Ordnerstruktur
Prüfe ob `02 Projekte/ProForge5 Build/` als Ordner existiert.
Falls nein und Sebastian bestätigt hat (Variante Ja):
  - `02 Projekte/ProForge5 Build.md` → `02 Projekte/ProForge5 Build/ProForge5 Build.md`
  - Unterordner anlegen: assets/, backups/, snapshots/, firmware/, slicer-profile/
  - Sebastian kurz informieren, dass Obsidian ggf. Cmd+R braucht, damit Links wiederfinden

## Aufgabe

Verschiebe die 22 Dateien aus ~/Mac-Inventur/05_Projekt_Material/ gemäß
Zielpfad-Tabelle in „Mac Inventur - Phase 3 Vorsortierung" (Abschnitt
„Ziel-Zuordnung Session 2 (ProForge5)").

### Regeln
- NIE blind verschieben. Bei jeder Datei: Zielpfad aus Vorsortierungs-Notiz
  lesen, nötigenfalls Zielordner anlegen, dann `mv` mit klarem Log.
- Duplikat-Verdächtige (`ProForge5_CAN-Bus_Setup_2026-04-04_1.md` vs.
  ohne `_1`) zuerst per `md5 -q` vergleichen. Identisch → `_1` weg,
  unterschiedlich → Sebastian zeigen und fragen.
- Snapshots und P5FW-alt: als weg markiert in der Vorsortierung, aber
  VOR dem Löschen einmal `ls -la` zeigen, Sebastian bestätigt pro Datei.
- `firmware.bin` NICHT löschen. In `firmware/prüfen/` ablegen mit einer
  kurzen `NOTIZ.md` daneben (Größe 42 KB, ARM Cortex-M Klipper/Katapult,
  Reset-Handler auf 0x08027019 → Bootloader-Offset 0x8000). Zuordnung
  offen, Sebastian entscheidet später welches Board.
- Transkripte (EBB36_Gen2_Review, FirstLook_Bigtreetech, FromTheBench
  U2C_CAN) gehen nach `04 Ressourcen/Klipper/Transkripte/` — das sind
  generische YouTube-Reviews, KEINE ProForge5-spezifischen Unterlagen.
  Ordner ggf. anlegen und kurze `README.md` hinzufügen: „Transkripte zu
  Klipper-relevanten YouTube-Videos, als Referenz bei Setup/Debugging".
- `ProForge5_CAN-Bus_Setup_2026-04-04.md` vor Ablage in Klipper/:
  Inhalt gegen `04 Ressourcen/Klipper/Klipper.md` prüfen. Wenn schon
  abgedeckt → weg. Wenn ergänzend → in Klipper/ ablegen.

### Protokoll
Nach jedem Verschiebe-Block (backups, snapshots, firmware, assets,
slicer-profile, Klipper-Ressourcen, weg) kurzer Zwischenstand an
Sebastian. Bei unerwartetem Zustand STOPPEN und fragen.

## Nach Abschluss
1. 02 Projekte/ProForge5 Build/ProForge5 Build.md um Changelog-Eintrag
   ergänzen: welche Assets/Backups/Snapshots jetzt unter dem Projekt
   liegen. Kurze Tabelle reicht.
2. 02 Projekte/Mac Inventur - Phase 3 Vorsortierung.md: die 22 Zeilen
   in der Haupttabelle mit „✓ verschoben" + Ziel markieren, Zählerblock
   oben aktualisieren („Migriert: X von 188").
3. 03 Bereiche/WEC/Operationen/Ingest.md: NICHT anfassen — ProForge5
   ist kein WEC-Thema, kein Ingest-Eintrag.
4. 05 Daily Notes/2026-04-XX.md (heutiges Datum): neuen Abschnitt
   „Phase 3 Session 2 ProForge5" mit Kurz-Bilanz.
5. TASKS.md: Session 2 ProForge5 abhaken, Migrationsstand angleichen.

## Zeitbudget
Ziel: unter 20 Minuten. Sollte machbar sein, da Zielpfade feststehen.
Falls Umwandlung Einzeldatei → Ordner hakt (Obsidian-Links): stoppen
und Sebastian zeigen bevor weitergemacht wird.
```

---

## Anweisung für Sebastian

1. Entscheidung treffen: Ordner-Umwandlung ja/nein (oben beschrieben).
2. Terminal, `brain`-Alias, Claude Code starten.
3. Prompt-Block zwischen den ``` kopieren und einfügen.
4. Zwischenstände abwarten — bei Duplikaten, Snapshots und `firmware.bin` wird explizit gefragt.
5. Nach Abschluss: zu claude.ai zurück, Ergebnis durchgehen und entscheiden ob Session 3 (Finanzen) direkt folgt.

## Verknüpfungen

- [[02 Projekte/Mac Inventur]]
- [[02 Projekte/Mac Inventur - Phase 3 Vorsortierung]]
- [[02 Projekte/Mac Inventur - Handover Phase 3 Vorsortierung]] — vorige Handover-Notiz
- [[02 Projekte/ProForge5 Build]] — Ziel der Migration
- [[04 Ressourcen/Klipper/Klipper]]
- [[04 Ressourcen/Skills/Skill - Mac-Inventur Methode]]

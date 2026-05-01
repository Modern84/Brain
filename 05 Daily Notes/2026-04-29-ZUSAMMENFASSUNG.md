---
tags: [tagesbuch, zusammenfassung, drucker, klipper, octopus, katapult, bridge, lessons]
status: abgeschlossen mit Hybrid-Bridge live
date: 2026-04-29
session-dauer: ~04:00 – 2026-04-30 ~01:15 (mit Pendel-Pause 06:45–17:00)
---

# Session-Zusammenfassung 2026-04-29 — ProForge5 Bridge-Mode-Migration

## TL;DR

**Hauptziel der Session:** ProForge5-Octopus Pro H723 von USBSERIAL+U2C V2 auf eigenständige USB-CAN-Bridge migrieren (Architektur-Review-Top-1).

**Strukturelles Ergebnis:** Katapult-Bootloader sitzt persistent auf Octopus. BTT-Bootloader-Auto-Revert-Mechanik ist eliminiert.

**Funktionales Ergebnis:** **Hybrid-Bridge LIVE** seit 2026-04-30 ~01:15. Octopus-Bridge auf `can1` (`canbus_uuid: 2e8e7efafd9b, canbus_interface: can1`), EBB36 weiter via U2C/`can0`. H1 (txqueuelen 128 + can1 UP) wirksam — initiale Connect-Fehler waren so3_0-Shutdown-State aus voriger Session, kein Bridge-Problem. `FIRMWARE_RESTART` + can1-Wiederhochbringen löste es. Klipper `ready`, 7/7 MCUs. 24-h-Stabilphase läuft bis 2026-05-01 ~01:15. Schritt 6 (U2C-Komplettentfernung) bleibt offen über Blocker 3 (Header-Bauform). Details: [[2026-04-29]] Phase 18.

═══════════════════════════════════════════════════════════════
## Phasen-Chronologie
═══════════════════════════════════════════════════════════════

### Vormittag (04:00–06:45) — Vorbereitung + erster Versuch

**Phase 1–4:** Architektur-Review-Roadmap erstellt, Drei-Stimmen-Validierung mit Gemini + CC-Faktencheck, EBB36 physisch montiert, USB-Disconnect-Forensik klassifiziert (5994 Events HARMLOS, korreliert mit U2C-Wackler 27.04.).

**Phase 5–9:** BEC-Erdungs-Konzept recherchiert, ProForge5 Build.md auf 4 Stellen korrigiert, TTS-Briefing-Template als Workflow-Asset, INDX-Cleanup (verworfen als Architektur), Architektur-Review 2026 mit 30 Quellen erstellt.

**Phase 10:** Vier Verbesserungs-Regeln im Brain verankert (CLAUDE.md + Prinzipien.md + claude.ai-Memory 13–16):
1. Constraint-First-Prinzip
2. Keine Lob-Sätze
3. CC-Faktencheck als Pflicht vor finaler Roadmap
4. Zeitrechnungs-Sorgfalt

**Phase 11–13: Bridge-FW v1-Versuch** — Build mit falschem Kconfig-Symbol (MMENU statt CMENU), Result: RESERVE_PINS_CAN=PB8/PB9 statt PD0/PD1. Flash erfolgreich, Bridge-FW lief im RAM, nach Cold-Boot REVERT auf USBSERIAL. Erste Hypothese: SD-Card-Auto-Flash. Sebastian klärte: keine SD eingelegt → Hypothese widerlegt.

### Pendelphase (06:45–17:00) — Sebastian zur Arbeit

CC-Recherche-Agent lief im Hintergrund mit 30 Quellen Architektur-Review. Brain-Hygiene durch Phase-10-Eintrag.

### Abend (17:00–23:30) — Zweiter Versuch + strukturelle Lösung

**Phase 14:** Pin-Konflikt-Hypothese korrekt diagnostiziert, Bridge-FW v2 gebaut mit `CONFIG_STM32_CMENU_CANBUS_PD0_PD1=y`, klipper.dict-Verifikation: `RESERVE_PINS_CAN: PD0,PD1` ✅.

**Phase 15: Bridge-FW v2-Versuch** — Flash erfolgreich, Bridge-FW lief funktional (UUID `2e8e7efafd9b` auf can1, EBB36 erreichbar), nach Cold-Boot **erneut REVERT** auf USBSERIAL. Pin-Konflikt-Hypothese damit als Revert-Ursache widerlegt. **Forensik-Killer-Befund:** Backup-MD5 vor v1-Flash und vor v2-Flash identisch (`b3f8e2825c5204a6cd15830e5ddec0bb`) — App-Slot wird gespiegelt oder bei Reset überschrieben, egal was reingeflasht wird.

**USB-Topologie-Vorfall:** Cold-Boot-Sequenz (24V aus) hat zusätzlich U2C V2 + USB-Hub stromlos gemacht (Hub-Netzteil mit-getoggelt). Drucker zwischenzeitlich down, nach physischer Wiederherstellung der USB-Kabel automatisch zurück.

**Phase 16: Plan-Korrektur** — STM32H723 hat 128-KiB-Erase-Sektoren, 32-KiB-Offset hardware-unmöglich. Bridge-FW v2 hat korrekten 0x08020000-Offset → keine v3 nötig. Katapult-Build mit 128-KiB-Offset (`CONFIG_STM32_FLASH_START_20000=y`). SWD-Pads dokumentiert (Header J72, Pin-Mapping).

**Phase 17: Katapult-Migration** — DFU-Mode via Software-Pfad (`flash_usb.enter_bootloader`), mass-erase auf `0x08000000`, Katapult geflasht (5652 B, MD5 `786e115c896f0a5334b09029d94761a1`). Anschließend Bridge-FW v2 über Katapult-flashtool ins App-Slot. Cold-Boot-Test: **Bridge-FW v2 persistent** (`1d50:606f` stabil, kein `1d50:614e` USBSERIAL-Recovery mehr). Katapult-Hypothese bestätigt — BTT-Bootloader-Auto-Revert eliminiert.

**ABER:** Klipper-Daemon-Connect zur Bridge-MCU schlug fehl (`Timeout on identify_response`, weder über can1 noch über can0). UUID `2e8e7efafd9b` via fasthash64-Reimplementation aus Chip-UID berechnet (nicht via canbus_query auffindbar — Bridge-MCU ist Bus-Master, antwortet nicht auf admin-queries). printer.cfg auf `canbus_uuid: 2e8e7efafd9b` umgestellt — Connect blieb trotzdem im Timeout. Bridge-Mode-Konfig-Problem identifiziert, nicht hier gelöst.

**Rollback Phase 17b:** USBSERIAL-Klipper (`octopus.bin`, 43300 B, v0.13.0-623) über Katapult ins App-Slot geflasht via DFU-Doppelklick + dfu-util `0x08020000:leave`. Katapult bleibt unangetastet. printer.cfg auf pre-bridge-Backup zurück (`serial:`-Zeile statt `canbus_uuid:`). Klipper-Start: erst „Unable to connect" (Timing/USB-Settle), zweiter Restart → ready, 7/7 MCUs verbunden, `canstat_ebb: bus_state=active`.

═══════════════════════════════════════════════════════════════
## Hypothesen-Status (alle dokumentiert für Wochenende)
═══════════════════════════════════════════════════════════════

| Hypothese | Status | Begründung |
|-----------|--------|------------|
| SD-Card-Auto-Flash | WIDERLEGT | Sebastian: keine SD eingelegt |
| Pin-Konflikt PB8/PB9 | TEILWEISE: Bug v1, NICHT Revert-Ursache | v2 mit PD0/PD1 revertete trotzdem |
| Bootloader-Offset 32 vs 128 KiB | WIDERLEGT | beide v1+v2 hatten 0x8020000 korrekt |
| FLASH_SIZE 256 KiB statt 1 MB | OFFEN, aber unwahrscheinlich | Katapult-Lösung umgeht das eh |
| BTT-Bootloader Recovery-Master-Slot | BESTÄTIGT (indirekt) | Katapult ohne diesen Mechanismus = Bridge-FW persistent |
| Klipper-Connect-Timeout zu Bridge-MCU | OFFEN | wahrscheinlichste Ursachen siehe Wochenende-Sektion |

═══════════════════════════════════════════════════════════════
## Aktueller Hardware/Software-Stand (Stand 23:30)
═══════════════════════════════════════════════════════════════

**Octopus Pro H723:**
- Bootloader: **Katapult v2** (statt BTT-Bootloader)
  - Pfad: `~/klipper-builds/katapult_octopus_h723_v2.bin` (5652 B, MD5 `786e115c896f0a5334b09029d94761a1`)
  - Adresse: `0x08000000`
  - Reset-Doppelklick aktiviert Katapult-DFU (`1d50:614e`)
  - BOOT0-Jumper-DFU funktioniert weiterhin parallel (STM32-ROM-Feature)
- App-Slot `0x08020000`: **USBSERIAL-Klipper v0.13.0-623**
  - Backup auf Pi: `~/klipper-builds/octopus.bin` (43300 B)

**Bridge-FW v2 bereit für Wochenende:**
- `~/klipper-builds/octopus_bridge_20260429_v2.bin` (45676 B)
- MD5: `09c027e45f8c1faa0b91e42d59be5dd7`
- klipper.dict: `RESERVE_PINS_CAN=PD0,PD1`, `CANBUS_BRIDGE=1`, app_start=`0x8020000`
- Octopus-UUID Bridge-Mode: `2e8e7efafd9b` (chipid-stabil, fasthash64-verifiziert)

**Drucker-State:**
- Klipper: ready
- 7/7 MCUs verbunden (mcu, ebb, so3_0..4)
- can0 UP via U2C, EBB36 erreichbar (UUID `71c47e0b85cf`, `bus_state=active`)
- printer.cfg auf pre-bridge-Stand
- Backups: `printer.cfg.backup_pre_bridge_20260429`, `printer.cfg.backup_pre_v2_edit_20260429_2151`

**Pi:**
- stlink-tools v1.8.0 installiert (für SWD-Recovery falls je nötig — ST-Link physisch laut Sebastian vorhanden, lsusb-Verifikation steht aus)
- python3-serial nachinstalliert (für katapult flashtool.py)
- SWD-Header J72 dokumentiert in [[Octopus-Recovery-Pfade]]

═══════════════════════════════════════════════════════════════
## Lessons Learned (kondensiert für nächste Sessions)
═══════════════════════════════════════════════════════════════

1. **Backup-MD5-Vergleich vor jedem Flash machen.** Wenn Backup-Read identisch zum Vor-Vor-Backup ist, ist der App-Slot nicht stabil oder wird gespiegelt. Hätte heute morgen schon Klarheit gebracht.

2. **klipper.dict-Verifikation als Pflicht-Schritt.** Vor jedem Flash `RESERVE_PINS_CAN` und `app_start_address` aus `out/klipper.dict` lesen. `.config` ist nicht authoritativ — `make olddefconfig` kann sie still ändern.

3. **Cold-Boot-Test ohne USB-Hub-Manipulation.** Nur Octopus-Power toggeln, Hub und U2C-Kabel zum Pi unangetastet. Sonst doppelter Befund (Revert + USB-Topologie-Verlust).

4. **Klipper-Kconfig-Choice-Mehrdeutigkeit.** STM32H723 hat MMENU_CANBUS_* (regulär) UND CMENU_CANBUS_* (unter USBCANBUS-Bridge). Nur eine ist je nach Kontext relevant. `make olddefconfig` löst keine Choice-Konflikte sauber.

5. **STM32H723 Hardware-Constraints.** 128-KiB-Erase-Sektoren als kleinste Einheit. Bootloader-Offset MUSS `0x08020000` sein (128 KiB), 32 KiB ist hardware-unmöglich.

6. **BTT-Bootloader hat Auto-Revert-Mechanik** (vermutlich Recovery-Master-Slot bei höherer Adresse). Eliminiert durch Katapult-Bootloader-Tausch. Mass-erase auf `0x08000000` irreversibel ohne SWD-Programmer — aber STM32H723-ROM-DFU ist Hardware-Feature und greift IMMER (BOOT0-Jumper + Power-Cycle), auch nach mass-erase.

7. **Software-DFU-Pfad** (`flash_usb.py enter_bootloader`) braucht USBSERIAL-FW. Mit Bridge-FW im App-Slot nicht verfügbar — nur Katapult-Doppelklick oder DFU-Jumper.

8. **canbus_query.py findet Bridge-MCU nicht.** Die USB-CAN-Bridge-MCU ist Bus-Master und antwortet selbst nicht auf admin-queries `0x3f0`/`0x3f1`. UUID muss aus Chip-UID via fasthash64 (seed `0xA16231A7`, erste 6 Bytes little-endian) berechnet werden — Source: `~/klipper/src/generic/canserial.c` + `chipid.c`.

═══════════════════════════════════════════════════════════════
## Wochenende — Bridge-Mode-Inbetriebnahme (offen)
═══════════════════════════════════════════════════════════════

**Vorbereitung steht (alles auf Pi bereit):**
- Bridge-FW v2 Bin
- Katapult-Bootloader installiert
- Flash über Katapult-Doppelklick + flashtool.py (kein DFU-Jumper-Theater mehr)
- Recovery via `octopus.bin` (USBSERIAL-Backup) im App-Slot

**Klipper-Connect-Problem zu untersuchen (Reihenfolge):**

1. `/etc/network/interfaces.d/can1` mit `allow-hotplug` + `txqueuelen 128` — Klipper-Doku-Empfehlung für Bridge-MCU-Interface.
2. EBB36 `[mcu ebb]` muss explizit `canbus_interface: can1` bekommen (im Bridge-Mode hängt EBB36 am Bridge-CAN, nicht am U2C).
3. U2C-Service / can0 deaktivieren falls Bridge-Mode aktiv (sonst zwei parallele CAN-Welten — Verwirrung).
4. CAN-Termination prüfen (60 Ω stromlos zwischen CANH und CANL).
5. dfu-util-Warnung „Invalid DFU suffix signature" verifizieren — Klipper-FW-Suffix-Pflicht prüfen.
6. Bridge-MCU spezifisch: ist `canbus_uuid` der richtige Mechanismus, oder erwartet Klipper im Bridge-Mode `serial: /dev/ttyACMx`-artigen Zugriff auf die gs_usb-Schnittstelle?

**Recovery-Pfad falls Wochenende-Versuch scheitert:**
- DFU-Doppelklick → Katapult-Mode
- `octopus.bin` (USBSERIAL) ins App-Slot via flashtool.py
- printer.cfg-Backup zurück
- Klipper start → ready
- ~5 Min, kein Risiko

═══════════════════════════════════════════════════════════════
## Brain-Updates dieser Session
═══════════════════════════════════════════════════════════════

**Neu angelegt:**
- [[04 Ressourcen/Klipper/Octopus-CAN-Bridge-Migration]]
- [[04 Ressourcen/Klipper/Katapult-Migration-Plan]]
- [[04 Ressourcen/Klipper/Katapult-Flash-Plan]]
- [[04 Ressourcen/Klipper/Octopus-Recovery-Pfade]]
- [[04 Ressourcen/Klipper/printer-cfg-bridge-diff]]
- [[04 Ressourcen/Klipper/ProForge5-Architektur-Review-2026]]
- [[04 Ressourcen/Klipper/BEC-Erdungs-Konzept]]
- [[04 Ressourcen/Workflow/TTS-Briefing-Template]]
- [[Prinzipien]]

**Erweitert:**
- [[CLAUDE]] — Sektion „Zusammenarbeits-Regeln (verankert 2026-04-29)" mit 4 Regeln
- [[02 Projekte/ProForge5 Build/ProForge5 Build]] — 4 Topologie-Korrekturen
- TASKS.md — „Bridge-FW Auto-Revert-Mechanismus klären" → ABGEHAKT durch Katapult-Lösung; neuer Punkt: „Bridge-Mode-Connect-Debug Wochenende"
- MEMORY.md — Octopus-FW-Stand auf 2026-04-29 mit Katapult+USBSERIAL aktualisiert

**claude.ai-Memory verankert (13–17):**
- Constraint-First-Prinzip
- Keine Lob-Sätze
- CC-Faktencheck als Pflicht vor finaler Roadmap
- Zeitrechnungs-Sorgfalt
- Filesystem-MCP-Connector-Korrektur (claude.ai HAT direkten Brain-Lesezugriff via MCP)

═══════════════════════════════════════════════════════════════
## Verknüpfungen
═══════════════════════════════════════════════════════════════

- [[2026-04-29]] — vollständige Phasen-Doku (Phase 1–17)
- [[CLAUDE]] — Brain-Zentrale + Zusammenarbeits-Regeln
- [[Prinzipien]] — Operations-Grundregeln
- [[04 Ressourcen/Klipper/Katapult-Flash-Plan]] — Wochenende-Wiedereinstieg
- [[04 Ressourcen/Klipper/ProForge5-Architektur-Review-2026]] — strategischer Kontext

---
tags: [ressource, klipper, octopus, h723, katapult, bootloader, migration]
status: vorbereitet
date: 2026-04-29
---

# Katapult-Migration Octopus Pro H723 — Vorbereitungs-Plan

**Zweck:** BTT-Bootloader durch Katapult ersetzen, um den Auto-Revert-Mechanismus zu eliminieren, der die Bridge-FW nach Cold-Boot zurückrollt (zweimal verifiziert 2026-04-29, Backup-MD5 vor v1- und vor v2-Flash identisch).

**Status:** Vorbereitung — KEIN Flash bisher. Voraussetzungen siehe Recovery-Pfade.

## Befund Auto-Revert (Stand 2026-04-29 ~19:30)

- v2-Build-Offsets korrekt: `CONFIG_FLASH_APPLICATION_ADDRESS=0x8020000`, `CONFIG_STM32_FLASH_START_20000=y`, `CONFIG_MACH_STM32H723=y`. Hypothese „falscher 32KiB-Offset" widerlegt.
- Pre-Bridge-Backup `1825` und `1855` md5-identisch (`b3f8e2825c5204a6cd15830e5ddec0bb`). App-Slot wird vom BTT-Bootloader spätestens beim Cold-Boot mit Recovery-Master überschrieben.
- Klipper-Source enthält **keine** STM32H7-Bank-Swap-Logik (`grep BFB2|FLASH_OPTSR|Bank2|bank_swap` → 0 Treffer in `~/klipper/src/stm32/`). Auto-Revert ist BTT-Bootloader-spezifisch, nicht Klipper.

Konsequenz: Solange BTT-Bootloader sitzt, hilft kein Bridge-FW-Build, weil der Bootloader bei Boot zurückspielt.

## Katapult — Build-Config Octopus Pro H723

Quellen-Konsens (Klipper-Discourse, Voron-Klipper-Communities, Katapult-README):

```
Microcontroller Architecture .............. STMicroelectronics STM32
Processor model ........................... STM32H723
Build Katapult deployment application ..... Do not build
Clock Reference ........................... 25 MHz crystal
Communication interface ................... USB (on PA11/PA12)
Application start offset .................. 32 KiB
Support bootloader entry on rapid double click of reset button [Y]
Enable Status LED (optional) .............. PA13 oder Board-LED
```

**Wichtig:** „Application start offset 32 KiB" hier ist Katapult-relativ, nicht zu verwechseln mit dem 128-KiB-Offset des BTT-Bootloaders. Klipper wird danach mit `CONFIG_STM32_FLASH_START_8000=y` (32 KiB) gebaut, NICHT mit `_20000` wie unter BTT.

## Repo-Stand auf Pi

`/home/m3d/katapult` existiert (für EBB36-Flashing schon im Einsatz). `~/katapult/out/canboot.bin` ist ein vorheriger Build (vermutlich EBB36-G0B1) — **nicht für Octopus geeignet**, muss neu konfiguriert und gebaut werden. Vor Build: `make clean` und `make menuconfig` mit Octopus-Profil (siehe oben).

Build-Output: `~/katapult/out/katapult.bin`.

## Flash-Ablauf (NICHT heute Abend ohne Recovery-Vorbereitung)

1. Octopus in DFU (BOOT0-Jumper + Power-Cycle).
2. **BTT-Bootloader komplett ersetzen** mit Katapult-Bin auf `0x08000000` via `dfu-util`:
   ```
   sudo dfu-util --path 1-2 -a 0 -s 0x08000000:force:mass-erase:leave -D ~/katapult/out/katapult.bin
   ```
   `force:mass-erase` löscht den ganzen Flash inkl. BTT-Bootloader + Recovery-Master-Slot (genau das ist das Ziel).
3. Octopus rebootet, präsentiert sich als Katapult-USB-Device (oder USB-CAN-Bridge, je nach Config).
4. Klipper-FW (Bridge-Mode) bauen mit `CONFIG_STM32_FLASH_START_8000=y`, dann via Katapult-Flashtool flashen:
   ```
   python3 ~/katapult/scripts/flashtool.py -d /dev/ttyACM0 -f ~/klipper/out/klipper.bin
   ```
5. Cold-Boot-Test: Bridge-FW MUSS persistent bleiben (kein BTT-Recovery mehr im Bauch des Boards).

## Risiken

- **Mass-erase löscht BTT-Bootloader irreversibel.** Kein Rollback ohne Recovery-Pfad (siehe [[Octopus-Recovery-Pfade]]).
- **DFU-Mode muss vorher zuverlässig funktionieren** (BOOT0-Jumper sitzt korrekt, Octopus erscheint als 0483:DF11). Aktuell verifiziert (heute morgen + abends mehrfach genutzt).
- **Falscher Offset im Klipper-Build nach Katapult-Flash** → Klipper-FW würde nicht starten, aber Katapult bleibt erreichbar → Reflash möglich, kein Brick.

## Verknüpfungen

- [[Octopus-Recovery-Pfade]] — Recovery wenn Flash schiefgeht
- [[Octopus-CAN-Bridge-Migration]] — Hauptmigrations-Doku, Bridge-FW-Builds
- [[05 Daily Notes/2026-04-29]] — Phase 13–15 Auto-Revert-Forensik
- [[BEC-Erdungs-Konzept]] — Servo-EMI-Hardware-Pfad (Parallelthema)

---
tags: [ressource, klipper, octopus, h723, recovery, bootloader, swd]
status: aktiv
date: 2026-04-29
---

# Octopus Pro H723 — Recovery-Pfade

**Zweck:** Wenn ein Bootloader-Flash schiefgeht (Katapult-Migration, Bridge-FW-Versuche), muss klar sein, wie das Board zurückgeholt wird. Diese Datei beschreibt drei Recovery-Stufen in absteigender Realitätsnähe.

## Stufe 1 — DFU via BOOT0-Jumper (Standardweg)

**Voraussetzung:** Octopus geht noch in DFU-Modus. BOOT0-Jumper + Power-Cycle reichen.

1. Octopus stromlos.
2. BOOT0-Jumper setzen.
3. Power an.
4. Verifikation: `lsusb | grep 0483:DF11` zeigt das Board.
5. Original-BTT-Bootloader von BTT-GitHub holen und zurückflashen:
   ```
   sudo dfu-util --path 1-2 -a 0 -s 0x08000000:force:mass-erase:leave -D ~/btt-bootloader-octopus-h723.bin
   ```
6. BOOT0-Jumper raus, Power-Cycle. Octopus präsentiert sich wieder als Stock-BTT.

**Quelle BTT-Bootloader-Bin:** [github.com/bigtreetech/Octopus-Pro](https://github.com/bigtreetech/Octopus-Pro) — Branch `master/Firmware/`, Datei `STM32H723_btt-octopus-pro-h723-bootloader.bin` (oder ähnlich, vor Migration konkreten Pfad verifizieren und lokal sichern).

**Status heute:** DFU funktioniert verifiziert (morgens + abends 2026-04-29 mehrfach genutzt für v1/v2-Flash). Stufe 1 ist die wahrscheinlichste Recovery.

## Stufe 2 — ST-Link via SWD (wenn DFU nicht mehr greift)

**Voraussetzung:** ST-Link V2/V3 physisch vorhanden + stlink-tools auf Pi installiert + SWD-Pads/Header am Octopus zugänglich.

**Stand 2026-04-29 ~21:05:**
- **stlink-tools auf Pi: ✅ installiert** (v1.8.0, `st-info --version` und `st-flash --version`).
- **lsusb zeigt KEIN STLink** (0483:374x) — ST-Link aktuell nicht angesteckt.
- **Brain dokumentiert keinen ST-Link-Besitz** (Grep auf ST-Link/SWD/stlink → 0 relevante Hardware-Treffer). Sebastian-Aussage: ist physisch da.

### SWD-Header am Octopus Pro: J72

Aus Schaltplan `BIGTREETECH Octopus Pro_SCH.pdf` (Page 5, V1.0 — Hinweis: Schaltplan zeigt F446/F429-MCU, H723-Revision nutzt vermutlich denselben SWD-Header; vor Anschluss visuell verifizieren):

**Header J72 — 5-Pin (`SWDIO`-Beschriftung auf Board):**

| Pin | Signal | STM32-Verbindung |
|-----|--------|------------------|
| 1 | V_BUS (5V_USB) | — |
| 2 | SWDIO | PA13 (über R167 10K) |
| 3 | SWCLK | PA14 (über R164 10K) |
| 4 | RESET | NRST |
| 5 | GND | — |

ST-Link-Verbindung (4 Drähte minimum): SWDIO, SWCLK, GND, RESET. **3.3V vom ST-Link NICHT mit V_BUS verbinden** (V_BUS ist 5V vom USB) — Octopus muss separat über 24V oder USB versorgt sein, ST-Link liest/schreibt nur Signal.

Vor jedem riskanten Flash:
```
sudo apt install stlink-tools  # bereits erledigt
st-info --probe                # erwartet: Octopus erkannt nach Anschluss
```

Recovery via ST-Link:
```
st-flash --reset write ~/klipper-builds/octopus.bin 0x08020000   # Klipper USBSERIAL zurück
# oder bei voll-leerem Flash:
st-flash --reset write ~/klipper-builds/katapult_octopus_h723_v2.bin 0x08000000
```

Recovery via ST-Link:
```
st-flash --reset write ~/btt-bootloader-octopus-h723.bin 0x08000000
```

## Stufe 3 — Brick / Hardware-Tausch

Wenn DFU UND SWD nicht greifen: Octopus Pro ist gebrickt. Ersatzteil-Optionen:
- **BTT Octopus Pro H723** ca. 90 € (BTT-Shop, Amazon).
- **Alternative MCU:** Octopus Max EZ, Manta M8P (anderer Formfaktor, Pinout-Anpassung in printer.cfg nötig).

**Drucker-Status während Brick:** SO3-Boards laufen weiter (USB direkt am Pi), EBB36 hängt am U2C-CAN — also Pi+U2C+EBB+SO3 funktional, aber kein Bed-Heater, keine Stepper, kein Endstop-Octopus → Drucker steht.

## Empfehlung Reihenfolge vor jedem Bootloader-Flash

1. Backup aktueller App-Slot (`dfu-util -U`). Erledigt schon mehrfach im Bridge-Mode-Versuch.
2. BTT-Original-Bootloader-Bin lokal **vor** Mass-Erase auf Pi haben (`~/btt-bootloader-octopus-h723.bin`).
3. ST-Link physisch testen + stlink-Tools installieren — auch wenn man ihn nicht braucht, ist das die Versicherung.
4. Erst dann mass-erase auf `0x08000000`.

## Verknüpfungen

- [[Katapult-Migration-Plan]] — primärer Anwendungsfall
- [[Octopus-CAN-Bridge-Migration]] — vorausgegangene v1/v2-Flash-Versuche
- [[ProForge5 Pinout]]

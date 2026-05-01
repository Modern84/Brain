---
tags: [ressource, klipper, octopus, h723, katapult, flash, plan]
status: bereit
date: 2026-04-29
---

# Katapult-Flash-Plan Octopus Pro H723

**Zweck:** Konkrete Schrittfolge für den Bootloader-Tausch BTT → Katapult inkl. Bridge-FW-Reflash und printer.cfg-Umstellung. Voraussetzung: Recovery-Pfade gelesen ([[Octopus-Recovery-Pfade]]) und akzeptiert.

## Artefakte (verifiziert 2026-04-29 ~20:30)

| Datei | Pfad auf Pi | Größe | MD5 | Zweck |
|-------|-------------|-------|-----|-------|
| Katapult | `~/klipper-builds/katapult_octopus_h723_v2.bin` | 5652 B | `786e115c896f0a5334b09029d94761a1` | Bootloader → 0x08000000 |
| Bridge-FW v2 | `~/klipper-builds/octopus_bridge_20260429_v2.bin` | 45676 B | `09c027e45f8c1faa0b91e42d59be5dd7` | Klipper-App → 0x08020000 (über Katapult) |
| Recovery USB-Klipper | `~/klipper-builds/octopus.bin` | — | — | Roll-Forward via DFU falls Bridge-FW nicht startet |

Bridge-FW v2 hat `CONFIG_FLASH_APPLICATION_ADDRESS=0x8020000` — passt zu Katapult-Offset 128 KiB.

## Vorab-Check (5 Min)

1. Recovery-Bin existiert: `ls -la ~/klipper-builds/octopus.bin` → muss vorhanden sein.
2. DFU-Mode reproduzierbar: BOOT0-Jumper + Power-Cycle, dann `lsusb | grep 0483:DF11` → Octopus muss erscheinen.
3. Katapult-Tools: `python3 ~/katapult/scripts/flashtool.py --help` → muss laufen.
4. printer.cfg-Backup vorhanden: `~/printer_data/config/printer.cfg.backup_pre_bridge_20260429`.
5. Drucker druckfrei (kein Job in Queue, Mainsail idle).

## Flash-Sequenz

### Schritt 1 — Klipper stoppen
```
sudo systemctl stop klipper
```

### Schritt 2 — Octopus in DFU
- Power off.
- BOOT0-Jumper setzen.
- Power on.
- Verifikation: `lsusb | grep 0483:DF11`.

### Schritt 3 — Katapult flashen (mass-erase)
```
sudo dfu-util --path 1-2 -a 0 -s 0x08000000:force:mass-erase:leave -D ~/klipper-builds/katapult_octopus_h723_v2.bin
```
`mass-erase` löscht den BTT-Bootloader inkl. Recovery-Master-Slot — irreversibel ohne SWD.

### Schritt 4 — BOOT0 raus, Power-Cycle
- Jumper entfernen.
- Power off → on.
- Verifikation: `lsusb` zeigt Katapult-Device (VID:PID `1d50:6177`, „CanBoot" oder „Katapult").

### Schritt 5 — Bridge-FW v2 über Katapult flashen
```
python3 ~/katapult/scripts/flashtool.py -d /dev/serial/by-id/usb-katapult_stm32h723xx_*-if00 -f ~/klipper-builds/octopus_bridge_20260429_v2.bin
```
(Genauen `by-id`-Pfad nach Schritt 4 aus `ls /dev/serial/by-id/` ablesen.)

### Schritt 6 — Cold-Boot-Test (Persistenz-Beweis)
- Power off, 10 Sekunden warten.
- Power on.
- `ip link show can0` → up.
- `~/klippy-env/bin/python ~/klipper/scripts/canbus_query.py can0` → zwei UUIDs erwartet (Octopus neu + EBB36 `71c47e0b85cf`).
- Wenn Octopus-UUID stabil → Auto-Revert ist eliminiert. Das ist der Beweis.

### Schritt 7 — printer.cfg umstellen
Siehe [[printer-cfg-bridge-diff]]. Kurz:
```
[mcu]
canbus_uuid: <NEU_AUS_SCHRITT_6>
restart_method: command
# serial: /dev/serial/by-id/usb-Klipper_stm32h723xx_1D0015001251313531383332-if00
```

### Schritt 8 — Klipper starten
```
sudo systemctl start klipper
```
Mainsail prüfen: alle 7 MCUs `ready`, kein Versionswarnung-Spam.

## Recovery falls Schritt 3 oder 5 schiefgeht

| Szenario | Reaktion |
|----------|----------|
| Schritt 3 dfu-util-Error | Retry. Wenn DFU-Mode weg: ST-Link/SWD (Stufe 2 in Recovery-Pfade). |
| Schritt 5 flashtool-Timeout | Katapult-Device noch da? Retry. Wenn nicht: zurück in DFU, Recovery-Bin `octopus.bin` auf `0x08020000` flashen + BTT-Bootloader-Restore (sofern lokal gesichert). |
| Schritt 6 keine UUID | Bridge-FW startet nicht. Power-Cycle, dann erneut. Wenn weiter tot: zurück in Katapult-DFU (Double-Reset), Bridge-FW erneut. |
| Schritt 7 Klipper-Start-Fehler | Backup-printer.cfg restoren: `cp printer.cfg.backup_pre_bridge_20260429 printer.cfg`. |

Volle Stufen siehe [[Octopus-Recovery-Pfade]].

## Verknüpfungen

- [[Katapult-Migration-Plan]] — Hintergrund + Build-Config
- [[Octopus-Recovery-Pfade]] — DFU/SWD-Recovery
- [[printer-cfg-bridge-diff]] — UUID-Umstellung
- [[05 Daily Notes/2026-04-29]] — Sessionkontext

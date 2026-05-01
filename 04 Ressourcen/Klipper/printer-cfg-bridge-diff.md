---
tags: [ressource, klipper, octopus, canbus, migration, diff]
status: vorbereitet
date: 2026-04-29
---

# printer.cfg-Diff für Octopus-Bridge-Migration

Template für die `[mcu]`-Sektions-Umstellung beim Octopus-Bridge-Mode-Flash. UUID wird erst nach erfolgreichem Bridge-Flash via `canbus_query.py can0` ermittelt und eingesetzt.

## Aktueller Stand (Backup gesichert)

`~/printer_data/config/printer.cfg.backup_pre_bridge_20260429` (14863 Bytes, 2026-04-29 05:47)

```ini
[mcu]
serial: /dev/serial/by-id/usb-Klipper_stm32h723xx_1D0015001251313531383332-if00
```

## Ziel-Zustand (nach Bridge-Flash)

```ini
[mcu]
canbus_uuid: TBD_AFTER_FLASH
restart_method: command
# serial: /dev/serial/by-id/usb-Klipper_stm32h723xx_1D0015001251313531383332-if00
# ALT-Wert auskommentiert für schnellen Rollback ohne Backup-Restore
```

## Diff-Form

```diff
 [mcu]
-serial: /dev/serial/by-id/usb-Klipper_stm32h723xx_1D0015001251313531383332-if00
+canbus_uuid: TBD_AFTER_FLASH
+restart_method: command
+# serial: /dev/serial/by-id/usb-Klipper_stm32h723xx_1D0015001251313531383332-if00
```

## Begründung der Änderungen

| Zeile | Warum |
|-------|-------|
| `canbus_uuid:` statt `serial:` | Octopus erscheint im Bridge-Mode nicht mehr als USB-Serial-Device. Klipper-Doku: „A USB to CAN bridge board will not appear as a USB serial device…and it can not be configured with a `serial:` parameter." |
| `restart_method: command` | Standard für CAN-MCUs — FIRMWARE_RESTART/RESTART funktionieren ohne USB-Reset-Pfad. Bei `serial:` war dies implizit. |
| ALT-Zeile auskommentiert | Schneller Roll-Forward ohne Backup-Restore: bei Failure Bridge-Mode lediglich Tausch der `#`-Position. Backup-Datei bleibt zusätzliche Sicherheitsebene. |

## Andere `[mcu ...]`-Sektionen — UNVERÄNDERT

- `[mcu ebb]` `canbus_uuid: 71c47e0b85cf` — bleibt
- `[mcu so3_0]` … `[mcu so3_4]` USB-Serial-Pfade — bleiben (SO3 hängen am USB-Hub, nicht am CAN-Bus)

## UUID-Ermittlung (Schritt 3 der Migration)

Nach erfolgreichem Flash:

```bash
~/klippy-env/bin/python ~/klipper/scripts/canbus_query.py can0
```

Erwartete Ausgabe:
```
Found canbus_uuid=<NEU_OCTOPUS>, Application: Klipper
Found canbus_uuid=71c47e0b85cf, Application: Klipper
Total 2 uuids found
```

Den `<NEU_OCTOPUS>`-Hex-String (12 Zeichen, hex) in das Template einsetzen, `TBD_AFTER_FLASH` ersetzen.

## Verknüpfungen

- [[04 Ressourcen/Klipper/Octopus-CAN-Bridge-Migration]] — Hauptanleitung
- Backup: `~/printer_data/config/printer.cfg.backup_pre_bridge_20260429`
- Flash-Skript: `~/scripts/flash_octopus_bridge.sh`
- Rollback-Skript: `~/scripts/rollback_octopus_usb.sh`

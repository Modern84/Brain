---
tags: [ressource, klipper, can, hybrid-bridge, diagnose]
date: 2026-04-30
status: abgeschlossen-rollback
raum: drucker
priorität: erledigt
risiko: gelöst
---

# Hybrid-Bridge — rx_error 104k/s Diagnose

## Auflösung 2026-04-30 ~08:25 — D2-Rollback durchgeführt

**Hypothese bestätigt:** Octopus-CAN-Header floating (Brain-Befund Daily 2026-04-04: nie verkabelt). CAN-Controller im Bridge-FW-Mode auf physisch losen CANH/CANL-Pins → permanente rx_error.

**Aktion:**
1. Klipper stop
2. Katapult-CAN-Flash USBSERIAL-Bin (`octopus.bin` 43300 B, MD5 c97993d5) auf can0/UUID 2e8e7efafd9b → Bridge-FW v2 ersetzt durch USBSERIAL-FW
3. Octopus erscheint als `/dev/serial/by-id/usb-Klipper_stm32h723xx_1D0015001251313531383332-if00` (1d50:614e CDC ACM)
4. U2C V2 wurde alleiniger gs_usb-Adapter, manuell `can1 → can0` umbenannt (deckt Reboot-Realität)
5. `/etc/network/interfaces.d/can1` → `can0` umbenannt + Inhalt korrigiert (Reboot-Persistenz)
6. printer.cfg: `[mcu]` auf `serial:`, `[mcu ebb] canbus_interface: can0`
7. Klipper start → state=ready, EBB rx_error=0, bus_state=active, alle 7 MCUs verbunden

**Backups:** `printer.cfg.backup_20260430_d2_rollback`, alte Bridge-FW v2 als Nachweis weiter dokumentiert in [[Octopus-CAN-Bridge-Migration]].

## Befund (2026-04-30 ~07:45)

## Befund (2026-04-30 ~07:45)

Klipper läuft state=ready, 7/7 MCUs verbunden. Aber:

| Sicht | bus_state | rx_error | tx_error | tx_retries |
|---|---|---|---|---|
| **`canbus_stats mcu`** (Octopus Bridge / can0) | **passive** | **+104.504 / s** (263→266 Mio in 30 s) | 0 | 0 |
| `canbus_stats ebb` (U2C / can1) | active | 0 | 0 | 0 |
| `ip -s -d link can0` (Pi-Kernel) | ERROR-ACTIVE | **0** | 0 | — |
| `ip -s -d link can1` (Pi-Kernel) | ERROR-ACTIVE | 0 | 0 | — |

**Diskrepanz:** Pi-Seite des USB-CAN-Tunnels sieht **null** Fehler. Der Octopus-MCU-CAN-Controller sieht **104k rx_error/s** auf seinen physischen CANH/CANL-Pins und ist dauerhaft in **error-passive**.

## Hypothese

Die Octopus hat einen physischen CAN-Header. In der Hybrid-Bridge-Architektur wurde `[mcu ebb]` logisch auf `can1` (U2C) umgezogen — die Octopus-Bridge hat damit auf ihrem eigenen CAN-Bus (can0-Pin-Seite) **keinen aktiven Klipper-Knoten** mehr.

Mögliche physische Ursachen:
1. **Octopus-CAN-Header hängt noch am alten CAN-Kabel** zu EBB/Toolheads, ohne dass Klipper darüber Pakete schickt → CAN-Controller wartet auf ACKs, sieht nur Bus-Verkehr ohne erwartete Antworten → error-passive
2. **Termination-Problem:** Octopus-CAN-Bus offen / nicht / doppelt terminiert
3. **Bridge-FW v2 Stack-Bug** in Selbstdiagnose oder Tunneling

Pi-Kernel-Counter sind 0 → der USB-Frame-Tunnel zwischen Pi und Octopus läuft fehlerfrei. Das Problem liegt **distal von der USB-Seite**, also im physischen CAN-Frontend der Octopus.

## Was bisher ausschließlich ist

- ❌ Pi-Hub-Probleme (USB-Counter sauber)
- ❌ gs_usb-Treiber (dmesg sauber, RX/TX bytes sauber, errors=0)
- ❌ U2C-Pfad / EBB36 (canbus_stats ebb makellos)
- ❌ Klipper-state-Konsistenz (state=ready, 7/7)

## Was noch unklar

- Ist die Octopus physisch noch am alten CAN-Bus angeschlossen?
- Wenn ja: hängt EBB36 elektrisch weiterhin auf der Octopus-Bus-Linie (parallel zum U2C-Pfad)?
- Termination-Stand am Octopus-Ende?

## Mo-Sichtcheck nötig (vor jeder weiteren Aktion)

1. Octopus-Pro-Board: CAN-Header — ist ein Kabel angesteckt?
2. Wenn ja: wohin geht es? (zu EBB? zu Toolhead-Bus? hängend offen?)
3. Termination-Jumper am Octopus-CAN-Header (üblicherweise 120 Ω-Jumper auf BTT-Octopus)?
4. EBB36-Anschluss: ein CAN-Kabel oder zwei? (von wo nach wo?)

## Wenn Hypothese bestätigt — drei Pfade

| Pfad | Aktion | Risiko |
|---|---|---|
| **D1 — Octopus-CAN-Bus offiziell stilllegen** | CAN-Kabel von Octopus-Header abziehen, ggf. Termination dauerhaft setzen. EBB läuft weiter über U2C/can1. | niedrig — reversibel |
| **D2 — Octopus-Bridge-Mode aufgeben (Rollback)** | USBSERIAL-FW (`octopus.bin` 43300 B) wieder ins App-Slot via Katapult-DFU. printer.cfg `[mcu]` zurück auf `serial: /dev/serial/by-id/...`. U2C macht wieder allein CAN. | mittel — Hardware-DFU + Config-Rollback |
| **D3 — Bridge-Mode behalten + EBB physisch zur Octopus zurück** | EBB-Kabel auf Octopus-CAN-Header umstecken, `[mcu ebb] canbus_interface: can0`, U2C deaktivieren. Hybrid wird zu Single-Adapter. | mittel — Re-Verkabelung |

## Konsequenz für udev-Persistenz

Der CAN-Mapping-Drift (can0/can1-Vertauschung nach Reboot) ist real und durch udev-Rule mit ID_SERIAL_SHORT lösbar. Aber: solange rx_error 104k/s ungeklärt ist, **macht eine Persistierung der aktuellen Topologie keinen Sinn** — wenn Pfad D2 oder D3 gewählt wird, ändert sich die Topologie eh.

→ **udev-Persistenz pausiert**, bis Mo den Hardware-Sichtcheck gemacht und einen der Pfade D1/D2/D3 entschieden hat.

## Verknüpfungen

- [[ProForge5 Build]]
- [[Octopus-CAN-Bridge-Migration]]
- [[printer-cfg-bridge-diff]]
- [[05 Daily Notes/2026-04-30]]

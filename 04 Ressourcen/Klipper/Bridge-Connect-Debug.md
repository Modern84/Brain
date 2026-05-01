---
tags: [ressource, klipper, octopus, bridge, debug, wochenende]
status: aktiv
date: 2026-04-29
session-vorbereitung-für: Wochenende 2026-05-03/04
---

# Bridge-Mode-Connect-Debug — Wochenende-Plan

## Ausgangslage

Katapult-Bootloader sitzt persistent. Bridge-FW v2 lief funktional (UUID `2e8e7efafd9b` auf can1, EBB36 erreichbar via canbus_query). Klipper-Daemon kam nicht durch zur Bridge-MCU — `Timeout on identify_response`. Konfig-Debug, kein FW-Problem.

## Wiedereinstieg

1. Reset-Doppelklick auf Octopus → Katapult-Mode (`lsusb | grep 1d50:6177`).
2. Bridge-FW v2 ins App-Slot:
   ```
   python3 ~/katapult/scripts/flashtool.py \
     -d /dev/serial/by-id/usb-katapult_stm32h723xx_*-if00 \
     -f ~/klipper-builds/octopus_bridge_20260429_v2.bin
   ```
3. Power-Cycle, dann `lsusb | grep 1d50:606f` → Bridge-FW aktiv.
4. `ip link show can1` → erwartet UP nach `sudo ip link set can1 up type can bitrate 1000000` (oder via `/etc/network/interfaces.d/can1`).

## Vor jedem Test sammeln

```
sudo systemctl stop klipper
ip -d link show can0
ip -d link show can1
ls /dev/serial/by-id/
lsusb
ls /etc/network/interfaces.d/
~/klippy-env/bin/python ~/klipper/scripts/canbus_query.py can1
~/klippy-env/bin/python ~/klipper/scripts/canbus_query.py can0
```

Alles in eine Datei loggen: `~/bridge-debug-$(date +%H%M).log`.

═══════════════════════════════════════════════════════════════
## Hypothese 1 — can1-Interface fehlt oder fehlkonfiguriert
═══════════════════════════════════════════════════════════════

**These:** Klipper-Daemon erwartet `can1` als bring-up-fähiges SocketCAN-Interface mit korrekter Bitrate + txqueuelen. Wenn beim Bridge-FW-Start `can1` nicht automatisch hochkommt oder bei zu kleiner txqueuelen Pakete droppt, läuft `identify_response` ins Timeout.

**Test:**
```
cat /etc/network/interfaces.d/can1 2>/dev/null
ip -d link show can1
```

**Fix-Kandidat:** Datei `/etc/network/interfaces.d/can1` anlegen:
```
allow-hotplug can1
iface can1 can static
  bitrate 1000000
  up ip link set $IFACE txqueuelen 1024
```

Dann `sudo systemctl restart systemd-networkd` (oder Pi-Reboot). Verifikation: `ip -d link show can1` zeigt UP, bitrate 1000000, qlen 1024.

═══════════════════════════════════════════════════════════════
## Hypothese 2 — EBB36 hängt im Bridge-Mode an can1, nicht can0
═══════════════════════════════════════════════════════════════

**These:** Im Bridge-Mode ist Octopus-CAN-Header der Bus-Master für can1. EBB36 ist physisch am Octopus-CAN-Header dran (selbe Drähte wie U2C nutzte). Klipper braucht `canbus_interface: can1` für `[mcu ebb]` — `can0` ist im Bridge-Mode irrelevant oder gar nicht da.

**Test:**
```
~/klippy-env/bin/python ~/klipper/scripts/canbus_query.py can1
```
Erwartet: EBB36-UUID `71c47e0b85cf` taucht auf. Wenn ja → Hypothese stützt sich.

**Fix-Kandidat printer.cfg:**
```
[mcu]
canbus_uuid: 2e8e7efafd9b
canbus_interface: can1

[mcu ebb]
canbus_uuid: 71c47e0b85cf
canbus_interface: can1
```

═══════════════════════════════════════════════════════════════
## Hypothese 3 — U2C/can0-Service kollidiert mit Bridge-Mode
═══════════════════════════════════════════════════════════════

**These:** Im Bridge-Mode läuft can1 vom Octopus. U2C bringt zusätzlich can0 hoch. Wenn Klipper auf falschem Interface scannt oder zwei CAN-Welten Adress-Konflikte erzeugen, scheitert Connect.

**Test:** U2C physisch trennen (USB-Kabel ziehen), dann Klipper neu starten.

**Fix-Kandidat:** wenn nur can1-Connect klappt → U2C dauerhaft ab oder can0-Interface deaktivieren:
```
sudo ip link set can0 down
```
Plus `/etc/network/interfaces.d/can0` deaktivieren falls vorhanden.

═══════════════════════════════════════════════════════════════
## Hypothese 4 — CAN-Termination
═══════════════════════════════════════════════════════════════

**These:** Bridge-MCU sitzt selbst nicht auf dem CAN-Bus (sie ist USB↔CAN-Brücke), trotzdem braucht der physische Bus zwischen Octopus-CAN-Header und EBB36 zwei 120-Ω-Terminierungen = 60 Ω stromlos zwischen CANH und CANL.

**Test:** Drucker komplett stromlos, U2C ab. Multimeter zwischen CANH und CANL am Octopus-CAN-Header oder am EBB36-CAN-Stecker:
- 60 Ω → Termination korrekt (zwei 120-Ω parallel).
- 120 Ω → nur eine Terminierung, zweite fehlt.
- ∞ → keine Terminierung, Bus-Reflexionen wahrscheinlich.

**Fix-Kandidat:** CAN-Termination am Octopus per Jumper aktivieren (Header-Position laut [[ProForge5 Pinout]] verifizieren). EBB36-Termination ist onboard und immer aktiv.

═══════════════════════════════════════════════════════════════
## Hypothese 5 — DFU-Suffix-Pflicht
═══════════════════════════════════════════════════════════════

**These:** dfu-util warnte „Invalid DFU suffix signature" beim Flash. Wenn Bridge-FW-Bin nicht das erwartete Suffix-Format hat, könnte der Bootloader/Klipper den Build als invalid markieren.

**Test:** dfu-util-Output beim Flash genau lesen, auf Warnungen achten:
```
dfu-suffix --check ~/klipper-builds/octopus_bridge_20260429_v2.bin
```

**Fix-Kandidat:** Bin mit `dfu-suffix --add` versehen:
```
dfu-suffix --vid 0x1d50 --pid 0x614e --add ~/klipper-builds/octopus_bridge_20260429_v2.bin
```
(Vorher Backup ziehen — `--add` modifiziert die Datei.)

**Wahrscheinlichkeit:** niedrig — Klipper hat Bridge-FW intern erkannt (gs_usb war sichtbar). Eher kosmetisch.

═══════════════════════════════════════════════════════════════
## Hypothese 6 — canbus_uuid vs. serial im Bridge-Mode
═══════════════════════════════════════════════════════════════

**These:** Im Bridge-Mode ist die Octopus-MCU selbst über die gs_usb-Schnittstelle erreichbar, NICHT über einen CAN-Bus-Frame mit eigener UUID. Klipper-Doku-Konvention: Bridge-MCU bekommt `canbus_uuid:` weil die MCU-Identität über CAN-Frames läuft, die intern in der Bridge-FW geroutet werden. Aber: vielleicht erwartet diese Klipper-Version stattdessen `serial:` auf das gs_usb-CDC-Device.

**Test:** in printer.cfg testweise umstellen auf:
```
[mcu]
serial: /dev/serial/by-id/usb-Klipper_stm32h723xx_*-if00
```
Wenn nach Bridge-FW-Flash gar kein `/dev/serial/by-id/`-Eintrag mehr existiert (gs_usb registriert sich nicht als CDC-ACM) → Hypothese widerlegt, `canbus_uuid` ist die richtige Methode.

**Fallback-Recherche:** Klipper-Discourse + GitHub-Issues nach Strings:
- „CANBUS_BRIDGE identify_response timeout"
- „canbus_uuid bridge mcu host"
- „klipper usb-can bridge config"

Klipper-Doku: `~/klipper/docs/CANBUS.md` → Sektion „USB to CAN bus bridge mode".

═══════════════════════════════════════════════════════════════
## Test-Reihenfolge (priorisiert)
═══════════════════════════════════════════════════════════════

1. **H1** (interfaces.d/can1) — wahrscheinlichste Quick-Win, 5 Min.
2. **H2** (canbus_interface explicit) — billig, parallel zu H1.
3. **H3** (U2C-Trennung) — physisch, 2 Min, sauberster Test.
4. **H4** (CAN-Termination) — Multimeter, 5 Min, lohnt vor weiteren Versuchen.
5. **H6** (Doku-Recherche) — wenn 1–4 nicht greifen, dann Klipper-Source/Docs.
6. **H5** (DFU-Suffix) — letzte Karte, niedrige Wahrscheinlichkeit.

═══════════════════════════════════════════════════════════════
## Recovery-Pfad (immer verfügbar)
═══════════════════════════════════════════════════════════════

Wenn Wochenende scheitert oder anderer Termin reinkommt:

```
# 1. Reset-Doppelklick → Katapult-DFU
lsusb | grep 1d50:614e

# 2. USBSERIAL zurück ins App-Slot
sudo dfu-util --path 1-1 -a 0 \
  -s 0x08020000:leave \
  -D ~/klipper-builds/octopus.bin

# 3. printer.cfg-Backup zurück
cd ~/printer_data/config
cp printer.cfg.backup_pre_bridge_20260429 printer.cfg

# 4. Klipper start
sudo systemctl restart klipper
sleep 12
curl -s http://localhost:7125/printer/info | python3 -m json.tool | head -5
```

Erwartung: state=ready, 7/7 MCUs. ~5 Min, kein Risiko (Katapult bleibt unangetastet).

═══════════════════════════════════════════════════════════════
## Wenn alle 6 widerlegt
═══════════════════════════════════════════════════════════════

Klipper-Discourse-Post mit klippy.log-Auszug, vollständiger printer.cfg, Build-Config. Community kennt Bridge-Mode-Stolpersteine.

═══════════════════════════════════════════════════════════════
## Verknüpfungen
═══════════════════════════════════════════════════════════════

- [[2026-04-29-ZUSAMMENFASSUNG]] — Session-Kontext
- [[Octopus-CAN-Bridge-Migration]] — Migrations-Anleitung
- [[Octopus-Recovery-Pfade]] — Tiefen-Recovery falls Katapult bricht
- [[Katapult-Flash-Plan]] — Bootloader-/Flash-Sequenz
- [[printer-cfg-bridge-diff]] — UUID-Umstellung
- [[ProForge5 Pinout]] — CAN-Header + Termination-Jumper
- Klipper-Doku: https://www.klipper3d.org/CANBUS.html
- Klipper-Doku: https://www.klipper3d.org/CANBUS_Troubleshooting.html

---
tags: [ressource, klipper, proforge5]
status: aktiv
date: 2026-04-04
---

# ProForge5 — Klipper Config Status

Zusammenfassung was in der printer.cfg steht, was funktioniert und was noch fehlt.

Vollständiges Projekt: [[02 Projekte/ProForge5 Build]]

Zuletzt aktualisiert: 2026-04-26 (Stage 07.4 Tool-Positionen komplett, Macro-Konflikt _PRE_SELECT_CHECK identifiziert)

---

## Was läuft ✅

- Klipper (MCU Octopus Pro via USB `/dev/ttyACM1`) — Firmware v0.13.0-593 (Versions-Mismatch zum Host v623, funktional)
- EBB36 Gen2 via CAN (`canbus_uuid: 71c47e0b85cf`) — Firmware v0.13.0-623-dirty ⚠️
- 5× SO3 Boards (PH1–PH5) als eigene MCUs — Firmware v0.13.0-623 mit `WANT_BUTTONS+WANT_TMCUART+WANT_NEOPIXEL` ✅ (geflasht 2026-04-26, Pi-Reboot-Persistenz bestätigt)
- **Alle 7 MCUs** starten mit Klipper (Octopus + EBB36 + so3_0 bis so3_4)
- Moonraker + Mainsail
- Tailscale permanent: `http://100.90.34.108`
- mDNS: `mThreeD-IO.local`
- TMC5160 SPI (X, Y) — `DUMP_TMC` alle 6 Treiber OK ✅
- TMC2209 UART (Z0–Z3) — OK ✅
- Homing X ✅ (`G28 X`)
- Homing Y ✅ (`G28 Y`)
- Endstops: X = `^PG6` (Octopus) ✅, Y = `ebb:PA15` (EBB36) ✅
- Dock-Sensor: `ebb:PB6` ✅
- Servo ✅ (`ebb:PB5`, `SET_SERVO SERVO=toolchanger ANGLE=90`)
- CAN-Bus Auto-Start via systemd ✅ (Service mit 5s Delay)
- WLAN Auto-Reconnect Timer ✅ (60s Interval)
- Eddy Coil kalibriert ✅ (i2c3_PA7_PA6, ~100 Punkte, SAVE_CONFIG-Block vorhanden)
- **SO3 Toolheads aktive Features**: gcode_button (t0..4_dock_sensor), filament_switch_sensor (SO3Sensor_0..4), neopixel (SO3RGB_0..4), tmc2209 extruder (uart_pin so3_x:PB5)

## Was nicht geht / Workaround aktiv ⚠️

- **SO3 Lüfter-Tachometer**: 3 Zeilen pro `so3_*.cfg` per `#DISABLED#` deaktiviert (`tachometer_pin`, `tachometer_ppr`, `tachometer_poll_interval`). Grund: `WANT_PULSE_COUNTER` nicht in Build-Config (hätte 5. Reflash-Marathon erfordert). Folge: Hotend-Lüfter-RPM wird nicht in Mainsail angezeigt. Heater-Sicherheit unberührt (Thermistor-Cutoff aktiv). Akzeptierter Trade-off.
- **EBB36 Firmware "-dirty"** — funktioniert, ist aber nicht clean. Clean flash über DFU-Verfahren nötig.
- **Octopus Pro Versions-Mismatch** — läuft v0.13.0-593, Host v0.13.0-623. Funktional kein Problem aktuell. Sauberer wäre Octopus-Reflash auf v623.

---

## Was noch fehlt

### 1. ~~SO3 Boards nochmal flashen~~ ✅ erledigt 2026-04-26

Geflasht mit v4-Bin (`STM32_FLASH_START_0000=y` + `WANT_BUTTONS=y` + `WANT_TMCUART=y` + `WANT_NEOPIXEL=y` + `USB_SERIAL_NUMBER="PHx"`). Bins liegen unter `~/klipper/out_so3_v4/klipper_PHx.bin`. Pi-Reboot-Test bestanden. Workaround in `so3_*.cfg` reduziert auf 3 Zeilen (nur tachometer).

### 2. Stage 07.4 Tool-Positionen ✅ erledigt 2026-04-26

Alle 10 select_*-Werte + alle 10 dock_*-Werte gemessen und in variables.cfg gespeichert. Servo-Winkel DOCK=52° / SELECT=125° in macros.cfg. active_tools=5 gesetzt. Trockentest der SELECT_PHx-Macros offen — blockiert durch Macro-Konflikt (siehe 3).

### 3. Macro-Fix `_PRE_SELECT_CHECK` 🔥 (nächster Schritt)

`carriage_tool_sensor` (Pin ^PG11 Octopus) ist Endstop am Wagen, löst aus wenn Wagen am Dock anfährt. Macro `_PRE_SELECT_CHECK` (macros.cfg L633) interpretiert PRESSED aber als "Tool hängt am Wagen" → jeder SELECT-Versuch endet in `Vorauswahlprüfung fehlgeschlagen`. Patch-Plan: siehe [[05 Daily Notes/2026-04-26]] "Macro-Fix-Plan für nächste Session".

### 4. Tool-Offset-Probe einmessen

Die "kleine Kugel" (Probe) anschließen, alle 5 Düsen gegen die Kugel fahren, Tool-Offsets in `variables.cfg` schreiben. Stage 09 in MakerTech-Doku. Braucht funktionierende SELECT_PHx-Macros → erst nach Macro-Fix.

### 5. EBB36 clean flashen

DFU-Verfahren: USB/CAN Jumper ab → Boot+Reset → `dfu-util` → Jumper wieder drauf. Entfernt `-dirty`-Tag aus Firmware-Version.

### 6. Octopus auf v0.13.0-623 bringen

Aktuell v593 — funktional, aber Versions-Mismatch zum Host. Software-DFU-Methode bekannt (`flash_usb.py` → `dfu-util -s 0x8020000:leave`).

### 7. Input Shaping kalibrieren

ADXL345 am EBB36. Erst nach Tool-Offset und Bed Mesh.

### 8. USB-Webcam + Crowsnest

Noch nicht angeschlossen.

---

## Config-Dateien auf dem Pi (`~/printer_data/config/`)

| Datei | Inhalt | Basis |
|---|---|---|
| `printer.cfg` | Stepper, TMC, Heizung, Sensoren | Offizielle MakerTech GitHub v1.0.0 + EBB36/U2C/Eddy |
| `macros.cfg` | Toolchanger-Macros | Offiziell |
| `eddy.cfg` | Eddy Coil via I2C am EBB36 | Angepasst (Original nutzt USB-MCU) |
| `mainsail.cfg` | Mainsail-Standard | Standard |
| `variables.cfg` | Toolchanger-Positionen | Auto-generiert |
| `so3_0-4.cfg` | 5× Smart Orbiter Toolhead MCUs | ✅ v4-Firmware aktiv, Workaround minimal (nur tachometer) |

---

## Stepper & TMC Konfiguration

| Achse | Treiber | Typ | Pins | Strom |
|---|---|---|---|---|
| X (Slot 1) | TMC5160 | SPI | cs_pin: PC4, spi_bus: spi1 | 2.2A / 1.0A hold |
| Y (Slot 2) | TMC5160 | SPI | cs_pin: PD11, spi_bus: spi1 | 2.2A / 1.0A hold |
| Z0–Z3 (Slot 5-8) | TMC2209 | UART | PF2, PE4, PE1, PD3 | 1.1A / 0.4A hold |

---

## EBB36 Pinout (aktuell)

| Bauteil | Connector | Klipper-Pin | Status |
|---|---|---|---|
| Y-Endstop | ENDSTOP (GND+PA15) | `ebb:PA15` | ✅ verifiziert |
| Dock-Sensor | LIMIT1 | `ebb:PB6` | ✅ |
| Eddy Coil SCL | i2c3 | `PA6` | ✅ kalibriert (i2c3_PA7_PA6) |
| Eddy Coil SDA | i2c3 | `PA7` | ✅ kalibriert (i2c3_PA7_PA6) |
| Eddy Coil VCC | I2C | **3.3V** (nicht 5V!) | |
| Servo Signal | SERVO | `ebb:PB5` | ✅ |
| ADXL345 | SPI | Standard-Pins | noch nicht getestet |

> **Hinweis:** X-Endstop liegt auf dem Octopus (`^PG6`), NICHT am EBB36!

---

## Kalibrierungs-Reihenfolge (nächste Schritte)

1. ~~STEPPER_BUZZ alle Achsen~~ ✅
2. ~~Homing X → Y~~ ✅
3. ~~SO3 Boards flashen (WANT_BUTTONS=y)~~ ✅ (2026-04-26 mit BUTTONS+TMCUART+NEOPIXEL)
4. ~~Stage 07.1 Servo kalibrieren~~ ✅ (DOCK=52°, SELECT=125°)
5. ~~Stage 07.4 Tool-Positionen~~ ✅ (alle 10 select_ + 10 dock_ Werte)
6. **Macro-Fix `_PRE_SELECT_CHECK`** 🔥 als nächstes
7. SELECT_PHx / _DOCK_PHx Trockentest
8. Tool-Offset-Probe einmessen
9. Input Shaping (ADXL345 am EBB36)

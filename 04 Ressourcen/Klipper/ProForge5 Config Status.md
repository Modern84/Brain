---
tags: [ressource, klipper, proforge5]
status: aktiv
date: 2026-04-04
---

# ProForge5 — Klipper Config Status

Zusammenfassung was in der printer.cfg steht, was funktioniert und was noch fehlt.

Vollständiges Projekt: [[02 Projekte/ProForge5 Build]]

Zuletzt aktualisiert: 2026-04-17 (Audit + Korrektur)

---

## Was läuft ✅

- Klipper (MCU Octopus Pro via USB `/dev/ttyACM1`) — Firmware v0.13.0-623
- EBB36 Gen2 via CAN (`canbus_uuid: 71c47e0b85cf`) — Firmware v0.13.0-623-dirty ⚠️
- 5× SO3 Boards (PH1–PH5) als eigene MCUs — Firmware v0.13.0-623 (OHNE WANT_BUTTONS)
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

## Was nicht geht / Workaround aktiv ⚠️

- **SO3 Boards WANT_BUTTONS fehlt** — Firmware ohne `WANT_BUTTONS=y` geflasht. Config-Workaround aktiv: `gcode_button`, `filament_switch_sensor`, `tachometer` in `so3_0-4.cfg` deaktiviert. Muss rückgängig gemacht werden nach erneutem Flash (5× Boot+Reset).
- **EBB36 Firmware "-dirty"** — funktioniert, ist aber nicht clean. Clean flash über DFU-Verfahren nötig.

---

## Was noch fehlt

### 1. SO3 Boards nochmal flashen ⚠️

Neue Firmware mit `WANT_BUTTONS=y` (17.1KB) liegt als `.config.so3_buttons` auf dem Pi. Muss 5× per Boot+Reset geflasht werden. **NICHT `flash_usb.py` verwenden — crasht den Pi!**

Nach dem Flash: Workaround in `so3_0-4.cfg` rückgängig machen (gcode_button, filament_switch_sensor, tachometer wieder aktivieren).

### 2. EBB36 clean flashen

DFU-Verfahren: USB/CAN Jumper ab → Boot+Reset → `dfu-util` → Jumper wieder drauf.

### 3. Input Shaping kalibrieren

ADXL345 am EBB36. Erst nach funktionierendem Eddy/Homing Z.

### 4. USB-Webcam + Crowsnest

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
| `so3_0-4.cfg` | 5× Smart Orbiter Toolhead MCUs | ⚠️ Workaround aktiv |

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
3. SO3 Boards flashen (WANT_BUTTONS=y)
4. Input Shaping (ADXL345 am EBB36)

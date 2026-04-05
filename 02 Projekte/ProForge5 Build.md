---
tags: [projekt, klipper, hardware]
status: aktiv
date: 2026-04-04
---

# ProForge5 Build

## Ziel

Aufbau und Umbau des ProForge5 von MakerTech auf Industrial-High-End-Niveau: 500°C Drucktemperatur, CAN-FD Kommunikation, präzises Bed-Leveling. Der Drucker soll als Hochtemperatur-Werkzeug für MThreeD.io dienen.

## Drucker-Spezifikation (Werkszustand)

| Eigenschaft | Wert |
|---|---|
| Bauraum | 400 × 500 × 500 mm |
| Bett | 7 mm gegossenes Aluminium, 1300W AC-Silikonheizung @ 230V |
| Bett-Steuerung | SSR (Solid State Relay, Xurui 25A) |
| Extruder | 5× Smart Orbiter V3.5 (7,5:1 Übersetzung, 175g, PT1000-fähig) |
| Kinematik XY | AWD — 4 Motoren |
| Kinematik Z | Quad-Z — 4 Motoren |
| Extruder-Motoren | 5 Motoren |
| Gesamt Motoren | 13 |
| Mainboard | BTT Octopus Pro V1.1 (H723) |
| Netzteil 24V | MeanWell LRS-450-24 (24V / 18,8A) — für Elektronik & Heizung |
| Netzteil 48V | MeanWell LRS-150-48 (48V / 3,1A) — für Achsmotoren |
| Controller | Raspberry Pi 5 |
| Leveling | BTT Eddy Coil V1 (LDC1612) |
| CAN | BTT U2C V2 als CAN-Bridge |

## Upgrade-Roadmap (3 Etappen)

### Etappe 1 — CAN-Fundament & Bed-Leveling ✅ ABGESCHLOSSEN (04.04.2026)

**Ziel:** Schlitten (Carriage) digitalisieren, Kabelsalat reduzieren, Rapid Bed Mesh aktivieren.

**Teile:**

| Bauteil | Funktion | Status |
|---|---|---|
| BTT U2C V2 | USB-zu-CAN Adapter (CAN-Bridge zwischen Pi und Bus) | ✅ verbunden |
| BTT EBB36 Gen 2 V1.0 | Schlitten-Board (Carriage) | ✅ geflasht & verbunden |
| BTT Eddy Coil V1 | Bed-Leveling-Sensor, I2C am EBB36 | ✅ in Config |
| BTT EBB USB Adapter (Breakout-Board) | Strom + CAN-Durchleitung + DFU-Flashen | ✅ verkabelt |

**Erledigt:**
- EBB36 Gen2 mit Klipper CAN-Firmware geflasht (STM32G0B1, PB12/PB13, 1M)
- CAN-UUID ermittelt: `71c47e0b85cf`
- printer.cfg aktualisiert
- Klipper läuft mit beiden MCUs (Octopus + EBB36)
- Eddy Coil (LDC1612) in Config eingebunden

**Offen in Etappe 1:**
- TMC-Treiber am Octopus konfigurieren/verkabeln
- Eddy Coil physisch testen und kalibrieren
- Motoren anschließen und Homing testen
- Input Shaping kalibrieren (ADXL345 am EBB36)
- Stepper-Pins an tatsächliche Verkabelung anpassen

---

### Etappe 2 — Toolheads auf CAN-FD

**Ziel:** Alle 5 Köpfe auf EBB36 MAX umrüsten, 500°C freischalten, Kabelsalat an den Köpfen eliminieren.

**Teile:**

| Bauteil | Menge | Funktion | Preis ca. |
|---|---|---|---|
| BTT EBB36 MAX Gen 2 | 5× | Pro Kopf: Extruder, 500°C, PT1000 (MAX31865 Chip) | 145 € |
| PT1000 Sensor (3×15mm, 500°C) | 5× | Ersetzt Standard-NTC im Orbiter | 75 € |
| 80W Heizpatrone 24V (6×20mm) | 5× | Hochleistungs-Heizung für High-Flow | 50 € |

**Montage je Kopf:**
- EBB36 wird direkt auf NEMA-14-Motor des Smart Orbiter geschraubt (36mm passt exakt)
- Kurze Originalkabel vom Orbiter (Motor, Sensor, Lüfter) ins EBB36
- Nur noch ein 4-adriges CAN-Kabel pro Kopf nach außen

**Klipper-Werte Smart Orbiter V3.5:**
```ini
rotation_distance: 4.69
microsteps: 32
run_current: 0.55  # bis 0.85 je nach Bauraumtemp
```

---

### Etappe 3 — AWD Power-Upgrade

**Ziel:** Volle 48V-Beschleunigung für die 4 XY-Achsen freischalten.

**Teile:**

| Bauteil | Menge | Funktion | Preis ca. |
|---|---|---|---|
| BTT TMC5160 Pro | 4× | 48V-fähige Treiber für AWD XY-Achsen | 90 € |

**Verteilung am Octopus Pro:**
- Slot 1–4: TMC5160 Pro → 4× XY (AWD @ 48V)
- Slot 5–8: TMC2209 (vorhanden) → 4× Z (Quad-Z @ 24V)
- Extruder: alle auf CAN (EBB36), kein Treiber am Board nötig

---

## System-Architektur (aktueller Stand)

```
[Raspberry Pi 5]
      |
      ├── USB → [BTT Octopus Pro H723] → /dev/ttyACM0
      |              → 4× XY (AWD, TMC noch ausstehend)
      |              → 4× Z (Quad-Z, TMC noch ausstehend)
      |              → SSR → 1300W Bett
      |
      └── USB → [BTT U2C V2] → can0 (1 MBit/s)
                      |
                      └── CAN (H/L) → [Breakout-Board]
                                           |
                                           └── MX3.0 → [EBB36 Gen2 V1.0]
                                                            → Eddy Coil (I2C, LDC1612)
                                                            → X-Endstopp (PB6)
                                                            → ADXL345 (Input Shaping)
                                                            → Servo (Tool-Lock)
```

**Strom-Aufteilung:**
- 24V (MeanWell LRS-450): Elektronik, Heizpatronen, Lüfter, EBB36-Versorgung
- 48V (MeanWell LRS-150): Nur XY-Motoren am Octopus Pro (Etappe 3)
- 230V AC: Bett via SSR (gesteuert vom Octopus Pro)

---

## Hardware-IDs

| Was | Wert | Status |
|---|---|---|
| EBB36 CAN UUID | `71c47e0b85cf` | ✅ aktiv |
| Octopus USB | `/dev/ttyACM0` | ✅ aktiv |
| U2C USB | `1d50:606f` (gs_usb) | ✅ aktiv |
| Pi Name | Paul | |
| Pi SSH-User | `m3d` | `ssh m3d@<IP>` |
| Pi IP (iPhone-Hotspot) | `172.20.10.2` | |
| Pi IP (Tailscale) | `100.115.207.29` | permanent, netzwerkunabhängig |
| Mainsail (Hotspot) | `http://172.20.10.2` | nur im gleichen Netz |
| Mainsail (Tailscale) | `http://100.115.207.29` | permanent, überall |
| klipper-mcp | `http://100.115.207.29:8000` | permanent via Tailscale |
| Claude Code | v2.1.92 auf Pi installiert | `ssh m3d@100.115.207.29` → `claude` |

**Veraltete IDs (nicht mehr verwenden):**
| Was | Wert | Grund |
|---|---|---|
| EBB36 USB UUID (alt) | `f9aba4b5a918` | War USB-Firmware, jetzt CAN |
| Octopus CAN UUID (alt) | `2e8e7efafd9b` | Octopus läuft jetzt per USB |

---

## Verkabelung

### Stromversorgung
- Mean Well LRS-450-24 → Breakout-Board (VIN/GND Schraubklemmen)
- Breakout-Board → EBB36 (über MX3.0 Kabel, liefert 24V + CAN)
- Wichtig: USB-C am Breakout-Board liefert KEINEN Strom — 24V muss separat anliegen

### CAN-Bus
- U2C CAN_H/CAN_L (Schraubklemmen) → 2 dünne Kabel → Breakout-Board CAN H/L Pins
- 120Ω Termination: U2C (per Software, `termination 120`) + EBB36 (Jumper)
- Bitrate: 1.000.000

### USB
- Pi USB → U2C (USB-C)
- Pi USB → Octopus

---

## Jumper-Einstellungen EBB36 Gen2

| Jumper | Normalbetrieb | DFU-Flashen |
|---|---|---|
| USB/CAN Selection | **DRAUF** (CAN) | **AB** (USB) |
| 120Ω Termination | **DRAUF** | **DRAUF** (egal) |

### DFU-Flash-Anleitung EBB36 Gen2

1. USB/CAN Jumper **ab**
2. 24V am Breakout-Board **an**
3. USB-C vom Pi zum Breakout-Board
4. **BOOT** halten → **RST** drücken → loslassen → 5 Sek → **BOOT** loslassen
5. `lsusb` → muss `0483:df11` zeigen
6. `sudo dfu-util -a 0 -D ~/klipper/out/klipper.bin --dfuse-address 0x08000000:force:mass-erase:leave -d 0483:df11`
7. Danach USB/CAN Jumper wieder **drauf**

### EBB36 Firmware-Einstellungen

```
MCU: STM32G0B1
Clock: 8 MHz Crystal
Communication: CAN bus (on PB12/PB13)
CAN Bitrate: 1000000
Bootloader: Keiner (Flash Start 0x8000000)
```

> **Achtung:** Gen2 nutzt PB12/PB13 für CAN — NICHT PB0/PB1 (das ist die alte V1.2)

---

## Aktuelle printer.cfg

```ini
[mcu]
serial: /dev/ttyACM0

[mcu ebb]
canbus_uuid: 71c47e0b85cf

[printer]
kinematics: cartesian
max_velocity: 300
max_accel: 3000
max_z_velocity: 15
max_z_accel: 100

[stepper_x]
step_pin: PF13
dir_pin: PF12
enable_pin: !PF14
microsteps: 16
rotation_distance: 40
endstop_pin: ebb:PB6
position_endstop: 0
position_max: 200
homing_speed: 50

[tmc2209 stepper_x]
uart_pin: PC4
run_current: 0.800
stealthchop_threshold: 999999

[stepper_y]
step_pin: PG0
dir_pin: PG1
enable_pin: !PF15
microsteps: 16
rotation_distance: 40
endstop_pin: PG9
position_endstop: 0
position_max: 200
homing_speed: 50

[tmc2209 stepper_y]
uart_pin: PD11
run_current: 0.800
stealthchop_threshold: 999999

[stepper_z]
step_pin: PF11
dir_pin: PG3
enable_pin: !PG5
microsteps: 16
rotation_distance: 8
endstop_pin: probe:z_virtual_endstop
position_max: 200
position_min: -5

[tmc2209 stepper_z]
uart_pin: PC6
run_current: 0.800
stealthchop_threshold: 999999

[probe_eddy_current btt_eddy]
sensor_type: ldc1612
i2c_mcu: ebb
i2c_bus: i2c3_PB3_PB4
x_offset: 0
y_offset: 21.42

[virtual_sdcard]
path: ~/printer_data/gcodes

[display_status]

[pause_resume]
```

> **Hinweis:** Stepper-Pins entsprechen noch den Octopus-Pro-Standardwerten und müssen an die tatsächliche Verkabelung angepasst werden. Position_max-Werte sind Platzhalter.

---

## Lessons Learned

- EBB36 Gen2 V1.0 kann **nur** über das Breakout-Board per USB geflasht werden (DFU)
- USB/CAN Jumper muss für DFU **ab** sein, für Betrieb **drauf**
- Das Breakout-Board kann die EBB36 **nicht** über USB-C mit Strom versorgen — 24V muss separat anliegen
- CAN-Kabel (H/L) müssen separat vom U2C zum Breakout-Board verlegt werden (dünne Kabel reichen)
- Bei vertauschten CAN-H/L: Bus geht auf BUS-OFF, einfach Kabel tauschen
- Firmware muss für **CAN (PB12/PB13)** kompiliert werden, nicht USB (PA11/PA12) — sonst keine CAN-Antwort
- Alte USB-UUID ist nach CAN-Flash ungültig — neue UUID per `canbus_query.py` ermitteln
- Cowork-Chats gehen bei Absturz verloren — wichtige Infos immer in Obsidian sichern
- Smart Orbiter V3.5: Sensor-Typ ATC Semitec 104NT-4-R025H42G (muss für 500°C auf PT1000 getauscht werden)
- Extruder-Motorstrom bei Bauraumtemp > 50°C reduzieren: `run_current: 0.55`

---

## Bereiche & Kontext

- [[03 Bereiche/Konstruktion/Konstruktion|Konstruktion]]
- [[03 Bereiche/Business MThreeD.io/Business MThreeD.io|Business MThreeD.io]]
- [[04 Ressourcen/Klipper/Klipper|Klipper]]
- [[04 Ressourcen/Klipper/ProForge5 Config Status|ProForge5 Config Status]]

---

## Changelog

| Datum | Was |
|---|---|
| 2026-04-04 | Step 1 abgeschlossen: EBB36 Gen2 C
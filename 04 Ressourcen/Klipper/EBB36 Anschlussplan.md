---
tags: [ressource, klipper, hardware]
date: 2026-04-05
---

# EBB36 Gen2 V1.0 — Anschlussplan ProForge5

Belegung der EBB36-Boards für den ProForge5 IDEX-Aufbau.

---

## Pinbelegung

```
                    ┌──────────────────────────┐
                    │    POWER & SIGNAL INPUT   │
                    │   H    GND    VIN    L    │
                    │  (CAN)              (CAN) │
                    └──────────┬───────────────┘
                               │
    ┌──────────────────────────┴───────────────────────────┐
    │                    EBB36 Gen2 V1.0                    │
    │                                                       │
    │  ┌─────────────┐                   ┌──────────────┐  │
    │  │ MOTOR DRIVER │                   │     I2C      │  │
    │  │   A2         │                   │  5V     5V   │  │
    │  │   A1         │    ┌─────────┐    │  GND   GND   │  │
    │  │   B1         │    │ STM32   │    │  SCL   PA7   │←── EDDY SCL
    │  │   B2         │    │ G0B1    │    │  SDA   PA6   │←── EDDY SDA
    │  └─────────────┘    └─────────┘    └──────────────┘  │
    │                                                       │
    │  ┌─────────┐  ┌─────────┐  ┌───────────┐            │
    │  │  FAN0   │  │  FAN2   │  │ ENDSTOP   │            │
    │  │ VFAN0   │  │ DET PA4 │  │ GND  PA15 │←── ENDSTOP KOPF
    │  │ FAN0-   │  │ VFAN2   │  └───────────┘  (Werkzeug-
    │  │ 5V/VIN  │  │ FAN2-   │                  aufnahme)
    │  │ PD3     │  │ 5V/VIN  │                            │
    │  └─────────┘  │ PD2     │  ┌───────────┐            │
    │               └─────────┘  │    TH     │            │
    │                            │ GND  PA3  │←── THERMISTOR
    │  ┌───────────┐             └───────────┘             │
    │  │   FIL     │                                       │
    │  │ PD0  GND  │←── Y-ENDSTOP (Alternative 1)         │
    │  └───────────┘                                       │
    │                                                       │
    │  ┌─────────────────────────────────────┐             │
    │  │              PROBE                   │             │
    │  │  GND  VCC  SERVOS  GND  PROBE       │             │
    │  │            PB5          PB8          │             │
    │  │             ↑            ↑           │             │
    │  │          SERVO        Y-ENDSTOP     │             │
    │  │       (Tool-Lock)  (Alternative 2)  │             │
    │  └─────────────────────────────────────┘             │
    │                                                       │
    │  ┌──────────────┐         ┌──────────────┐           │
    │  │   FAN1       │         │     HE       │           │
    │  │ VFAN1 FAN1-  │         │  VIN   PB4   │           │
    │  │ 5V/VIN  PA5  │         └──────────────┘           │
    │  └──────────────┘                                    │
    │                                                       │
    │         ┌──────┐  LIS2DW (Input Shaping)             │
    │         │ ACCEL│  CS=PB1 CLK=PB10                    │
    │         │onboard  MOSI=PB11 MISO=PB2                 │
    │         └──────┘                                     │
    └──────────────────────────────────────────────────────┘
```

---

## Belegung ProForge5

| Funktion | Header | Pin | Kabel | Status |
|---|---|---|---|---|
| **Endstop Werkzeugaufnahme** | ENDSTOP | PA15 + GND | 2-adrig vom Mikroschalter am Dock | ✅ angeschlossen |
| **Y-Endstop** | FIL | PD0 + GND | 2-adrig vom Mikroschalter seitlich am Carriage | ⬜ offen |
| **Servo Tool-Lock** | PROBE | PB5 + VCC + GND | 3-adrig vom Servo — **Probe-Voltage-Jumper auf 5V stellen!** | ⬜ offen |
| **Eddy Coil (LDC1612)** | I2C | PA7 (SCL) + PA6 (SDA) + 3.3V + GND | 4-adrig, Kabel muss umgebaut werden | ⬜ Kabel anpassen |
| **Thermistor** | TH | PA3 + GND | 2-adrig vom Hotend-Sensor | ⬜ offen |
| **Heater** | HE | PB4 + VIN | 2-adrig zur Heizpatrone | ⬜ offen |
| **Part-Cooling Fan** | FAN0 | PD3 | Lüfterkabel | ⬜ offen |
| **Hotend Fan** | FAN1 | PA5 | Lüfterkabel | ⬜ offen |
| **Input Shaping** | onboard | LIS2DW (SPI) | kein Kabel nötig — auf PCB | ✅ onboard |

---

## Klipper-Config (geplant)

```ini
# --- Endstop Werkzeugaufnahme ---
[filament_switch_sensor dock_detect]
switch_pin: ebb:PA15
pause_on_runout: False

# --- Y-Endstop ---
[stepper_y]
endstop_pin: ebb:PD0

# --- Servo Tool-Lock ---
[servo tool_lock]
pin: ebb:PB5
maximum_servo_angle: 180
minimum_pulse_width: 0.001
maximum_pulse_width: 0.002

# --- Eddy Coil ---
[probe_eddy_current btt_eddy]
sensor_type: ldc1612
i2c_mcu: ebb
i2c_bus: i2c3_PB3_PB4   # PRÜFEN: evtl. PA7/PA6 je nach Board-Revision
x_offset: 0
y_offset: 21.42

# --- Thermistor ---
[extruder]
sensor_pin: ebb:PA3
sensor_type: ATC Semitec 104NT-4-R025H42G
heater_pin: ebb:PB4

# --- Lüfter ---
[fan]
pin: ebb:PD3

[heater_fan hotend_fan]
pin: ebb:PA5

# --- Input Shaping (LIS2DW onboard) ---
[lis2dw]
cs_pin: ebb:PB1
spi_software_sclk_pin: ebb:PB10
spi_software_mosi_pin: ebb:PB11
spi_software_miso_pin: ebb:PB2
```

---

## U2C V2.1 Verkabelung

- U2C ersetzt Octopus Pro USB-to-CAN Bridge
- 24V über Schraubklemmen (V+/V-) ins U2C → wird über seitliche Molex Microfit 3.0 an EBB36 weitergeleitet
- **Achtung:** Pin-Belegung U2C-Molex ≠ Breakout-Board-Molex. Mitgeliefertes MX3.0-to-XT30 Kabel (2200mm) ist für Breakout-Board gecrimpt, NICHT für U2C
- **Problem gelöst:** Molex-Stecker hatte keinen Arretierungshaken mehr → saß 180° verdreht → kein Strom. Nach Korrektur: grüne LED, 24V liegt an
- Stecker mit Markierung sichern oder Molex-Gehäuse ersetzen

---

## Hinweise

- **Servo 5V-Versorgung:** VCC am Probe-Header wird über **Probe-Voltage-Jumper** gespeist. Jumper auf **5V** stellen (nicht VIN/24V!). Keine Lötbrücke nötig — siehe [[04 Ressourcen/Klipper/EBB36 Gen2 Board-Wissen#Servo am Probe-Header]]
- **Eddy Coil VCC:** Der I2C-Header hat 5V — Eddy braucht **3.3V**! VCC-Draht umleiten
- **Servo PB5:** Kein Schutz-Circuit — immer **stromlos einstecken**
- **PA6 Konflikt prüfen:** PA6 ist am I2C-Header (SDA) UND am Servo-Block — Board-Revision prüfen ob physisch getrennt
- **Generell:** Alle Stecker **stromlos** ein- und ausstecken — Breakout-Board MOSFET ist bereits durchgebrannt (24V-Brücke als Workaround)
- **Fan-Jumper (Rückseite):** Jeder Fan-Header hat eigenen Jumper VCC↔5V. Nicht mit Servo-Versorgung verwechseln
- **MX3.0-Kabel nicht abschneiden:** USB-Adapter-Board auch im CAN-Modus für Stromversorgung empfohlen (BTT Korrektur)


---

## Eddy Coil — Klipper Konfiguration (verifiziert)

> **Wichtig:** EBB36 Gen2 **v1.0** nutzt  — NICHT  (das ist für v1.2!)

Quelle: [Offizielles BTT Sample Config](https://github.com/bigtreetech/EBB/blob/master/EBB_GEN2/EBB36_GEN2/sample-bigtreetech-ebb36-gen2-v1.0.cfg) + [Eddy Issue #71](https://github.com/bigtreetech/Eddy/issues/71)

### Korrekte printer.cfg

```ini
[probe_eddy_current btt_eddy]
sensor_type: ldc1612
i2c_mcu: ebb
i2c_bus: i2c3_PA7_PA6
x_offset: 0
y_offset: 21.42
z_offset: 1.0
```

### Kalibrierung (Reihenfolge)

1. Drucker homen: `G28 X Y`
2. Toolhead zur Bettmitte, ca. 20mm über Bett
3. Drive Current kalibrieren: `LDC_CALIBRATE_DRIVE_CURRENT CHIP=btt_eddy`
4. Z-Offset kalibrieren: `PROBE_EDDY_CURRENT_CALIBRATE CHIP=btt_eddy`
5. Papiermethode nutzen, dann `SAVE_CONFIG`

### Häufiger Fehler

- Klipper muss auf Branch **master ≥ 0.12.0-297** sein für native Eddy-Unterstützung
- Kein `[mcu eddy]` erstellen — Eddy Coil ist ein Sensor, kein MCU!
- PA6 ist SDA des I2C — und könnte auch am Servo-Block liegen → Board-Revision prüfen
---
tags: [ressource, klipper, proforge5]
status: aktiv
date: 2026-04-04
---

# ProForge5 — Klipper Config Status

Zusammenfassung was in der printer.cfg steht, was funktioniert und was noch fehlt.

Vollständiges Projekt: [[02 Projekte/ProForge5 Build]]

---

## Was läuft ✅

- Klipper (MCU Octopus Pro via USB `/dev/ttyACM0`)
- EBB36 Gen2 via CAN (`canbus_uuid: 71c47e0b85cf`)
- Moonraker + Mainsail
- Tailscale permanent: `http://100.115.207.29`
- klipper-mcp: `http://100.115.207.29:8000`
- Eddy Coil in Config eingebunden (noch nicht kalibriert)

---

## Was noch fehlt / angepasst werden muss

### 1. Servo-Block (fehlt komplett)

```ini
[servo tool_lock]
pin: ebb:PA6
maximum_servo_angle: 180
minimum_pulse_width: 0.001
maximum_pulse_width: 0.002
```

### 2. Stepper-Pins verifizieren

Aktuelle Pins in der Config sind Octopus-Pro-Standardwerte — müssen gegen tatsächliche Verkabelung geprüft werden. Reihenfolge:

```bash
# In Mainsail Console — jeden Motor einzeln testen:
STEPPER_BUZZ STEPPER=stepper_x
STEPPER_BUZZ STEPPER=stepper_y
STEPPER_BUZZ STEPPER=stepper_z
```

Wenn Motor zuckt → Pin stimmt. Wenn nichts → Pin falsch oder dir_pin invertieren.

### 3. Position_max anpassen

Aktuell alle auf `200` als Platzhalter. Reale Werte nach erstem Homing eintragen:
- X: 400 mm
- Y: 500 mm
- Z: 500 mm

### 4. AWD — 4× stepper_x konfigurieren

Aktuell nur ein `[stepper_x]` in der Config. AWD braucht:

```ini
[stepper_x]        # Motor 1
[stepper_x1]       # Motor 2 (stepper_x kopieren, nur dir_pin ggf. invertieren)
[stepper_x2]       # Motor 3
[stepper_x3]       # Motor 4
```

Gleiches für Quad-Z (`stepper_z` bis `stepper_z3`).

→ Erst nach erfolgreichem Einzel-Homing angehen.

---

## EBB36 Pinout (Referenz)

| Bauteil | Connector | Klipper-Pin |
|---|---|---|
| X-Endstop | LIMIT1 | `ebb:PB6` |
| Eddy Coil SCL | I2C | `PB3` |
| Eddy Coil SDA | I2C | `PB4` |
| Eddy Coil VCC | I2C | **3.3V** (nicht 5V!) |
| Servo Signal | SERVO | `ebb:PA6` |

---

## Kalibrierungs-Reihenfolge (wenn Motoren laufen)

1. `STEPPER_BUZZ` alle Achsen — Pins verifizieren
2. Homing X → Y → Z einzeln
3. Eddy Coil physisch stecken
4. `PROBE_EDDY_CURRENT_CALIBRATE CHIP=btt_eddy`
5. Bed Mesh erstellen
6. Input Shaping (ADXL345 am EBB36)

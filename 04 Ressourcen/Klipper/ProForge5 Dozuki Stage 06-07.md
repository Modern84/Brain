---
tags: [ressource, klipper, proforge5]
date: 2026-04-13
---

# ProForge5 — Dozuki Stage 06 & 07

Quelle: [Stage 06 Firmware](https://makertech-3d.dozuki.com/Guide/Stage+06:+Firmware/183) | [Stage 07 Checks](https://makertech-3d.dozuki.com/Guide/Stage+07:+Checks+and+Calibrations/184)

---

## Stage 06 — Firmware

### Toolhead Boards (SO3, STM32F0) — 5× flashen

```bash
cd ~/klipper
make menuconfig
# Microcontroller: STM32F0
# USB Serial: PH1 (dann PH2, PH3, PH4, PH5)
```

**DFU-Modus:**
1. BOOT-Taste halten → RESET drücken → loslassen → BOOT loslassen
2. Weiße Hotend-LED = DFU aktiv
3. `lsusb` → `0483:df11`
4. `make flash FLASH_DEVICE=0483:df11`
5. Verify: `ls /dev/serial/by-id/*` → zeigt PHx ID

**Für jeden Kopf wiederholen (PH1–PH5).**

Nach dem Flashen: jeweilige Config in printer.cfg einkommentieren.

---

## Stage 07 — Checks and Calibrations (43 Schritte)

### 1. Servo Setup

```gcode
CAM_POSITION ANGLE=28    ; Dock-Winkel (~28°) — Nockenwelle horizontal
CAM_POSITION ANGLE=110   ; Select-Winkel (~110°) — ~30° gegen Uhrzeigersinn
```

- Dock-Winkel in `macros.cfg` speichern
- Select-Winkel in `macros.cfg` speichern
- Servo-Arm einölen (Lithiumfett)

### 2. System-Checks

- Alle Thermistoren: Raumtemperatur anzeigen?
- Lüfter: Elektronik-Lüfter (immer an) + Bauteilkühler
- Endstops: `QUERY_ENDSTOPS` → alle "open"
- Motoren testen: `STEPPER_BUZZ STEPPER=stepper_z` (Z-Motoren gegen Uhrzeigersinn)

### 3. Achsen-Homing

```gcode
G28 X Y   ; X und Y homen (Finger auf Notaus!)
```

- Bewegung prüfen: 10mm-Schritte in Mainsail → misst physisch 10mm?
- Nullpunkt: Düse bei X=0, Y=0 → ~5mm vom vorderen linken Bettrand

### 4. Tool Changer kalibrieren

**Select-Position finden (pro Kopf):**
- Nockenstift soll zentriert im Schlüsselloch des Kopfes liegen
- X/Y-Koordinaten in `variables.cfg` eintragen
- Köpfe stehen typisch 102mm auseinander

**Dock-Position:**
- 50mm in X+ fahren → zurück bis Dockpins einrasten
- Dock-X = Select-X + 1mm (typisch)

```gcode
toolchanger_sensor_status    ; alle Sensoren prüfen
SELECT_PH1                   ; Kopf 1 aufnehmen testen
_DOCK_PH1                    ; Kopf 1 ablegen testen
```

### 5. Print Heads setup

- Alle Köpfe auf 250°C heizen
- Düsen festziehen (außer REVO)
- Extruder-Zahnrad dreht gegen Uhrzeigersinn = korrekt

### 6. Eddy-Kalibrierung (Warum erst jetzt: Eddy muss >45°C sein)

```gcode
PROBE_EDDY_NG_SETUP     ; oder für Eddy Coil: bereits erledigt!
```

> ℹ️ Sebastian nutzt **Eddy Coil** (nicht Eddy USB) — `PROBE_EDDY_CURRENT_CALIBRATE` bereits durchgeführt ✅

### 7. Z-Tilt & Bed Mesh

```gcode
Z_TILT_ADJUST
BED_MESH_SCAN            ; oder BED_MESH_CALIBRATE METHOD=rapid_scan
SAVE_CONFIG
```

### 8. Input Shaper

```gcode
SHAPER_CALIBRATE         ; ~10 Minuten, Drucker schwingt X und Y
SAVE_CONFIG
```

### 9. Tool Offsets kalibrieren

- Kalibrier-Probe mit M5×20mm Schraube montieren
- `_CALIBRATE_MOVE_OVER_PROBE`
- Düse über Probe-Kugel positionieren → X/Y in `calibrate-offsets.cfg`
- `Calibrate Tool Offsets` Makro ausführen → auto-kalibriert alle Köpfe

---

## Reihenfolge für Sebastian

- [x] Stage 06: Octopus geflasht ✅
- [x] Stage 06: Eddy Coil kalibriert (statt Eddy USB) ✅
- [x] Stage 06: Toolhead Boards PH1–PH5 geflasht (STM32F042, 8MHz, USB, 15.8KB) ✅
- [x] Stage 06: SO3 Config-Dateien von GitHub geholt, Serial-IDs eingetragen ✅
- [ ] **NÄCHSTE SESSION**: SO3 Firmware mit `WANT_BUTTONS=y` neu bauen + alle 5 reflashen
- [ ] **NÄCHSTE SESSION**: Octopus Firmware updaten v0.13.0-593 → v0.13.0-623 (via SD-Karte)
- [ ] **NÄCHSTE SESSION**: EBB36 sauber via CAN reflashen (dirty → clean)
- [ ] Stage 07: Servo kalibrieren (Dock/Select Winkel)
- [ ] Stage 07: Endstops + Motoren testen
- [ ] Stage 07: Tool Changer kalibrieren (5 Positionen)
- [ ] Stage 07: Düsen festziehen (250°C)
- [ ] Stage 07: Z_TILT + BED_MESH ✅ (bereits erledigt)
- [ ] Stage 07: Input Shaper
- [ ] Stage 07: Tool Offsets kalibrieren
- [ ] Stage 08: Erster Druck 🖨️

---
tags: [projekt, klipper, hardware, vorbereitung]
status: aktiv
priorität: A
date: 2026-04-15
owner: Sebastian
raum: ProForge5
---

# ProForge5 — Hardware-Tag Vorbereitung

Alles was remote vorbereitet wurde und beim nächsten Drucker-Tag sofort einsatzbereit ist. Siehe auch [[ProForge5 Build]] und [[TASKS]].

## SO3 Workaround — was ist deaktiviert?

**Stand 2026-04-15:** Alle 5 SO3-Dateien (`so3_0.cfg` bis `so3_4.cfg`) haben exakt **20 `#DISABLED#` Zeilen**. Symmetrisch, sauber.

### Pro Datei deaktiviert (Beispiel `so3_0.cfg`, identisch 1–4)

**1. Tachometer im Hotend-Lüfter** (3 Zeilen, in `[heater_fan Hotend0_Fan]`):
```
#DISABLED# tachometer_pin: so3_0:PA3
#DISABLED# tachometer_ppr: 2
#DISABLED# tachometer_poll_interval: 0.0005
```

**2. Dock-Sensor** (4 Zeilen, komplette Section):
```
#DISABLED# [gcode_button t0_dock_sensor]
#DISABLED# pin: ^so3_0:PB0
#DISABLED# press_gcode:
#DISABLED# release_gcode:
```

**3. Filament-Runout-Sensor** (7 Zeilen, komplette Section):
```
#DISABLED# [filament_switch_sensor SO3Sensor_0]
#DISABLED# switch_pin: so3_0:PA13
#DISABLED# pause_on_runout: False
#DISABLED# runout_gcode: UPDATE_DELAYED_GCODE ID=runnout_filter_0 DURATION=0.5
#DISABLED# insert_gcode: _filament_load_init_0
#DISABLED# event_delay: 1.0
#DISABLED# pause_delay: 0.1
```

**4. Filament-Unload-Button** (6 Zeilen):
```
#DISABLED# [gcode_button _filament_unload_0]
#DISABLED# pin: !so3_0:PA10
#DISABLED# release_gcode:
#DISABLED#   SET_LED LED=SO3RGB_0 RED=0.0 GREEN=0.5 BLUE=0.5
#DISABLED#   _filament_unload_init_0
#DISABLED# press_gcode:
```

### Warum deaktiviert?
Die SO3-Firmware wurde ohne `WANT_BUTTONS=y` geflasht → Button-Pins sind nicht verfügbar. Ohne Workaround startet Klipper nicht.

### Rückgängig machen nach SO3-Flash
Nach dem 5×-Flash (Boot+Reset mit `.config.so3_buttons`) in allen 5 Dateien **alle** `#DISABLED#` Präfixe entfernen. Einzeiler auf dem Pi:

```bash
for i in 0 1 2 3 4; do
  cp ~/printer_data/config/so3_$i.cfg ~/printer_data/config/so3_$i.cfg.backup_predisable
  sed -i 's/^#DISABLED# //' ~/printer_data/config/so3_$i.cfg
done
```

Danach `RESTART` in Mainsail. Wenn ein SO3-Board noch nicht korrekt geflasht ist, startet Klipper mit einem klaren Fehler — dann weiß man welches Board noch offen ist.

### ⚠️ Achtung — versteckte Abhängigkeit
Der `[delayed_gcode startup_RGB_SET_0]` (NICHT disabled!) referenziert `printer["filament_switch_sensor SO3Sensor_0"].filament_detected`. Wenn das Sensor disabled ist, crasht dieser delayed_gcode beim Start mit `initial_duration: 2`. Dass Klipper aktuell trotzdem `ready` meldet, legt nahe dass Klipper Jinja-Auswertungen mit fehlenden Objects tolerant behandelt — oder der delayed_gcode läuft erst bei Nutzung. **Beim Entfernen des Workarounds darauf achten, ob neue Fehler auftauchen.**

---

## Crowsnest — Status

**Nicht installiert.** Keine Binary in PATH, kein `~/crowsnest` Verzeichnis, keine systemd-Unit, keine `crowsnest.conf` im Config-Ordner.

### Installation (am Hardware-Tag, wenn Webcam physisch dran ist)
```bash
cd ~
git clone https://github.com/mainsail-crew/crowsnest.git
cd crowsnest
sudo make install
```

Der Installer fragt nach der Config und legt systemd + `crowsnest.conf` an. Danach in Mainsail unter Einstellungen → Webcam die URL eintragen (Standard `http://<pi>/webcam/?action=stream`).

### Webcam zuerst anschließen!
Crowsnest-Installer erkennt die angeschlossene Kamera und schreibt automatisch den richtigen Device-Pfad in die Config. Also: **erst USB-Kamera einstecken, dann installieren.**

---

## Input Shaping — Config vorbereitet

**Ziel:** Resonanztest mit ADXL345 am EBB36 Gen2 (onboard).

### Vorbereitete Sections für `printer.cfg`

```ini
############################################################################
# ADXL345 am EBB36 Gen2 (onboard) — Input Shaping
############################################################################

[adxl345]
cs_pin: ebb:PB12
spi_software_sclk_pin: ebb:PB10
spi_software_mosi_pin: ebb:PB11
spi_software_miso_pin: ebb:PB2
axes_map: x, y, z

[resonance_tester]
accel_chip: adxl345
probe_points:
    213, 178, 30
```

### Herleitung probe_points
Bed-Mitte aus den dokumentierten Werten:
- Z-Tilt-Punkte: x 3.8–423.8, y 18.75–338.75 → Mitte ca. **(213, 178)**
- Bed-Mesh: x 40–460, y 40–360 → Mitte ca. (250, 200)
- Gewählt: **213, 178, 30** (konservativ im Z-Tilt-Bereich, 30 mm über Bett)

### ⚠️ Vor dem Einfügen verifizieren
1. **Pin-Belegung EBB36 Gen2 V1.0:** Die Pins oben gelten für BTT EBB36 Gen2 mit onboard **ADXL345**. Einige Gen2-Revisionen nutzen **LIS2DW** (siehe deaktivierte `[lis2dw]`-Sektion in `so3_0.cfg` als Hinweis, dass LIS2DW im SO3-Ökosystem existiert). **Vor Flash BTT-Doku zur EBB36 Gen2 V1.0 prüfen** — im Zweifel `https://github.com/bigtreetech/EBB`.
2. **Adxl-Sensor ist erst bei Etappe 2 physisch zugänglich?** Der aktuelle EBB36 sitzt am Schlitten, der Sensor ist onboard. Sollte direkt nutzbar sein.
3. **Klipper muss mit `ADXL345`-Support compiliert sein** — normal default an.

### Ablauf am Hardware-Tag
1. Sections oben in `printer.cfg` einfügen (z. B. nach `[neopixel Case_Light]`)
2. `RESTART` — prüfen dass `ACCELEROMETER_QUERY` antwortet
3. Drucker muss gehomet sein → `G28`, dann `Z_TILT_ADJUST`
4. `SHAPER_CALIBRATE` — dauert einige Minuten, Drucker rattert hörbar
5. `SAVE_CONFIG` → schreibt `[input_shaper]` mit Freq + Typ in SAVE_CONFIG-Block
6. Ergebnis ins Changelog von [[ProForge5 Build]]

---

## `[force_move]` — rausnehmen?

**Nein, nicht rausnehmen.** `[force_move] enable_force_move: True` ist in `printer.cfg` UND in jeder `so3_*.cfg` gesetzt. In `so3_0.cfg` wird es explizit von der Filament-Load-Makro-Logik genutzt:

```
FORCE_MOVE STEPPER=extruder DISTANCE=15 VELOCITY=10 ACCEL=1000  # load filament inside the gears force move needs to be enabled
```

→ **Bleibt drin.** War nicht nur Eddy-Debugging-Relikt, sondern Teil der MakerTech-Makros. Kommentar im Daily-Note-Audit entsprechend korrigieren.

---

## Zusammengefasst — was noch physisch nötig ist

| Aufgabe | Physisch nötig? | Prep-Status |
|---|---|---|
| SO3 Boards flashen | Ja (Boot+Reset 5×) | Firmware gebaut ✅, Workaround-Entfernungs-Snippet bereit ✅ |
| Octopus Pro re-flashen | Ja (DFU) | Firmware gebaut ✅ |
| EBB36 clean flashen | Ja (Jumper + DFU) | Firmware gebaut ✅ |
| Input Shaping | Ja (Drucker muss homen + fahren) | Config-Sections bereit ✅ |
| Webcam + Crowsnest | Ja (USB anstecken) | Install-Befehl bereit ✅ |
| `force_move` entfernen | — | **Nicht nötig, bleibt drin** ✅ |

---

## Vorgebaute Firmware-Binaries (16.04.2026)

Alle drei Boards wurden vorab gebaut auf `v0.13.0-623-gaea1bcf56` (clean, kein dirty). Liegen auf dem Pi unter `~/klipper-builds/`:

| Board | Binary | Größe | Chip | Besonderheit |
|---|---|---|---|---|
| SO3 (PH1–PH5) | `so3.bin` | 17.116 B | STM32F042 | `WANT_BUTTONS=y`, 5× flashen |
| Octopus Pro | `octopus.bin` | 43.300 B | STM32H723 | via DFU, nach Flash Power-Cycle verifizieren |
| EBB36 Gen2 | `ebb36.bin` | 43.244 B | STM32G0B1 | CAN 1M (PB12/PB13), via DFU |

**SHA-256 Checksums** (`~/klipper-builds/CHECKSUMS.txt`):
```
61c00086641ead7fca9efa7e44d838fc25666f7dd7a0b804cd28ea02615090a3  so3.bin
2f67d4031306509e0f856c1d78a9bcb3be678bd3c3d29045f5f60d6633ad6e51  octopus.bin
a8511175af7ada15ec2cde9b7a135c7920875537c4697de644cb01495bb3f86d  ebb36.bin
```

Backup der vor-Prep-Binary: `~/klipper-builds/_current_before_prep.bin` (falls Rollback nötig).

### Aktive `.config` am Pi
Nach Prep steht `~/klipper/.config` auf `.config.so3_buttons`. Für Flash einfach die Binary aus `~/klipper-builds/` nehmen — **kein** Rebuild nötig. Wer rebuilds will, zuerst entsprechendes `.config.*` kopieren.

### SO3 Config-Backups
Alle 5 `so3_*.cfg` haben jetzt `.backup_predisable_*` Snapshots (so3_0: 15.04., so3_1–4: 16.04.).

---

## Flash-Cheatsheet — Reihenfolge am Hardware-Tag

**Empfohlene Reihenfolge:** Octopus zuerst (riskanteste Regression) → SO3 (5×) → EBB36.

### 0. Vor dem Flash — Log rotieren & zweites SSH-Fenster

**Log rotieren** (damit der Firmware-Mismatch-Moment sauber in frischem Log steht, falls gedebuggt werden muss):
```bash
mv ~/printer_data/logs/klippy.log ~/printer_data/logs/klippy.log.pre-flash-$(date +%Y%m%d)
sudo systemctl restart klipper  # erzeugt frisches klippy.log
```

**Zweites SSH-Fenster für Live-Monitoring** — parallel zum Hauptfenster offenhalten:
```bash
ssh m3d@100.90.34.108
sudo dmesg -w   # zeigt USB-Enumeration in Echtzeit
```
(Alternativ in separatem Terminal: `tail -f ~/printer_data/logs/klippy.log`)

**Baseline-Snapshot** der aktuell sichtbaren Serial-Ports:
```bash
ls -la /dev/serial/by-id/ > ~/by-id.before-flash.txt
```

---

### 1. Octopus Pro — DFU-Flash

> ✅ **Bereits geflasht (16.04.2026)** auf v0.13.0-623. Nur nochmal flashen wenn Regression festgestellt.

```bash
# Software-DFU (bestätigter Weg — NICHT Boot-Button!):
python3 ~/klipper/scripts/flash_usb.py -t stm32h723 -d /dev/serial/by-id/usb-Klipper_stm32h723xx_* ~/klipper-builds/octopus.bin
# Falls DFU-Gerät direkt sichtbar:
sudo dfu-util -d 0483:df11 -s 0x8020000:leave -D ~/klipper-builds/octopus.bin
# ⚠️ NIEMALS 0x08000000:force:mass-erase — zerstört den Bootloader!
```

**Verify Octopus:**
```bash
# (1) Board meldet sich zurück als normaler Klipper-Device?
sleep 5 && ls /dev/serial/by-id/ | grep -i klipper
# Erwartung: mindestens 1 Eintrag usb-Klipper_stm32h723xx_*

# (2) Diff gegen Baseline
ls /dev/serial/by-id/ | diff ~/by-id.before-flash.txt -

# (3) Klipper startet & MCU ist verbunden
sudo systemctl restart klipper
sleep 3 && tail -30 ~/printer_data/logs/klippy.log | grep -iE "mcu|error|version"
```
**Abbruchkriterium:** Wenn nach Reboot + Power-Cycle kein `usb-Klipper_stm32h723xx_*` in `/dev/serial/by-id/` → STOP. Rollback mit `~/klipper-builds/_current_before_prep.bin` bevor SO3 angefasst wird.

---

### 2. SO3 Boards — 5× Boot+Reset
**NICHT `flash_usb.py`!** Crasht den Pi. Für jedes Board einzeln:
```bash
# Board in DFU: BOOT halten + Reset tappen
lsusb | grep 0483:df11
sudo dfu-util -a 0 -D ~/klipper-builds/so3.bin --dfuse-address 0x08000000:force:mass-erase:leave -d 0483:df11
# Board wieder anstecken, nächstes Board
```

**Verify nach jedem einzelnen SO3-Board:**
```bash
# Warten bis USB re-enumeriert hat, dann prüfen ob das Board als so3_N sichtbar ist
sleep 5 && ls /dev/serial/by-id/ | grep -i klipper
# Erwartung: nach Board N sollten N+1 so3-Einträge zusätzlich zu Octopus/EBB existieren
```
**Abbruchkriterium pro Board:** Wenn nach 3 Versuchen (Boot+Reset, Flash, Verify) kein neuer Eintrag erscheint → dieses Board SKIPPEN, Board-Nummer notieren, mit nächstem weitermachen. Nicht blockieren lassen.

**Nach allen 5 Flashes — Workaround rückgängig:**
```bash
for i in 0 1 2 3 4; do
  cp ~/printer_data/config/so3_$i.cfg ~/printer_data/config/so3_$i.cfg.backup_predisable
  sed -i 's/^#DISABLED# //' ~/printer_data/config/so3_$i.cfg
done
sudo systemctl restart klipper
sleep 3 && tail -50 ~/printer_data/logs/klippy.log
```
Klipper muss `ready` melden. Falls ein Board fehlt: Fehler zeigt exakt welches (`mcu 'so3_N' not connected`) — genau das Board erneut versuchen oder als bekanntes Problem notieren.

---

### 3. EBB36 clean — DFU am Breakout-Board
```bash
# USB/CAN Jumper AB, 24V an Breakout, USB-C vom Pi zum Breakout
# BOOT halten → RST drücken → loslassen → 5s → BOOT loslassen
lsusb | grep 0483:df11
sudo dfu-util -a 0 -D ~/klipper-builds/ebb36.bin --dfuse-address 0x08000000:force:mass-erase:leave -d 0483:df11
# USB/CAN Jumper wieder DRAUF, dann Board in CAN-Modus neu starten
```
CAN-UUID bleibt `71c47e0b85cf` (ändert sich nicht durch Re-Flash).

**Verify EBB36:**
```bash
# CAN-Interface zeigt den Node wieder
~/klippy-env/bin/python ~/klipper/scripts/canbus_query.py can0
# Erwartung: UUID 71c47e0b85cf erscheint, Application: Klipper

# Klipper-Restart + Log-Check
sudo systemctl restart klipper
sleep 3 && tail -30 ~/printer_data/logs/klippy.log | grep -iE "ebb|can|error"
```
**Abbruchkriterium:** Wenn `canbus_query.py` die UUID nicht listet → Jumper-Zustand checken (muss wieder DRAUF sein), 24V-Versorgung prüfen. Nicht weiter flashen bevor CAN zurück ist.

---

### 4. Final Verify — alle 3 Boards
```bash
# Versions-Check über Moonraker
curl -s http://100.90.34.108:7125/printer/info | jq '.result'

# In Mainsail: jede MCU-Karte (mcu, ebb, so3_0–so3_4) muss v0.13.0-623-gaea1bcf56 OHNE "dirty" zeigen
# Alternativ per CLI:
grep -E 'mcu.*version' ~/printer_data/logs/klippy.log | tail -10
```

---

## Verknüpfungen
- [[ProForge5 Build]]
- [[TASKS]]
- [[05 Daily Notes/2026-04-15]]
- [[05 Daily Notes/2026-04-16]]

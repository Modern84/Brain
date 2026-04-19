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

### Etappe 1 — CAN-Fundament & Bed-Leveling 🔧 In Bearbeitung

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

**Erledigt (05.04.2026):**

- Endstops und Dock verifiziert ✅
- I2C-Pins PB3/PB4 bestätigt, Servo-Config eingetragen ✅

**Erledigt (06.04.2026):**

- Servo funktioniert ✅ (`SET_SERVO SERVO=toolchanger ANGLE=90/0` über ebb:PB5)
- STEPPER_BUZZ stepper_x → Motor bewegt sich ✅
- CAN-Bus manuell aktiviert und EBB36 reconnected nach Ausfall

**Erledigt (13.04.2026) — Großer Config-Durchbruch:**

- **TMC-Problem gelöst ✅** — War kein Hardware-/Jumper-Problem! Die Treiber sind TMC5160 (SPI), aber die Config hatte `[tmc2209]` (UART). Klipper sprach die falsche Sprache.
- **Config auf offizielle MakerTech GitHub-Basis umgestellt** (v1.0.0, 17.03.2026) + eigene EBB36/U2C/Eddy-Anpassungen
- **DUMP_TMC alle 6 Treiber OK** ✅ (X, Y, Z, Z1, Z2, Z3)
- **STEPPER_BUZZ X und Y OK** ✅
- **Endstop-Zuordnung korrigiert:** X = ^PG6 (Octopus), Y = ebb:PB6 (EBB36) — waren vertauscht
- **X-Endstop verifiziert** ✅ — reagiert auf Druck
- **Neue Config-Dateien:** printer.cfg, macros.cfg, eddy.cfg, mainsail.cfg, variables.cfg
- Pi-IP geändert: 172.20.10.2 (war .3), Hostname `mThreeD-IO.local`

**Erledigt (13.04.2026) — Session 2: Homing & Netzwerk:**

- **Y-Endstop gefixt ✅** — War auf falschem Pin: `^!ebb:PB6` → `ebb:PA15` (kein Pullup/Invertierung nötig, NO-Schalter). Dock-Sensor auf `ebb:PB6` umgestellt.
- **Homing X ✅** — `G28 X` funktioniert sauber
- **Homing Y ✅** — `G28 Y` funktioniert nach Pin-Fix
- **CAN-Bus Auto-Start gefixt ✅** — Systemd-Service mit 5s Delay, überlebt Reboot
- **WLAN Auto-Reconnect ✅** — Systemd-Timer reconnectet alle 60s zum iPhone-Hotspot
- **Tailscale neu eingerichtet ✅** — Pi auf `modern3b@` umgestellt, neue IP: `100.90.34.108`

**Erledigt (13.04.2026) — Session 3: Eddy Coil GELÖST ✅:**

- Eddy Coil via I2C über CAN-Bus → `PROBE_EDDY_CURRENT_CALIBRATE` ursprünglich `MCU 'ebb' I2C request BUS_TIMEOUT`
- **Falsche erste Annahme:** CAN-Bus kann I2C nicht handeln / Pull-Ups nötig (war falsch)
- **Tatsächliche Lösung:** I2C-Bus umgestellt von `i2c1_PB3_PB4` auf `i2c3_PA7_PA6` → läuft stabil, **kein Hardware-Limit**
- **Kalibriert ✅** — `[probe_eddy_current btt_eddy]` im SAVE_CONFIG, `reg_drive_current = 17`, vollständige Calibrate-Kurve 0.05–4.05 mm (~100 Punkte)
- **Bed Mesh gelaufen ✅** — `[bed_mesh default]` 25×20 bicubic, x 40–460, y 40–360

**Firmware-Stand (verifiziert 16.04.2026 nach Software-DFU-Reflash):**

- **Octopus Pro** ✅ `v0.13.0-623-gaea1bcf56` — am 16.04. per Software-DFU erneut geflasht, Persistenz nach Pi-Reboot bestätigt. Der erste Versuch vom 14.04. (v0.13.0-593) hatte nicht persistiert.
- **EBB36** ⚠️ `v0.13.0-623-gaea1bcf56-dirty-20260413_184659` — dirty flag, Funktion OK. Clean-Flash offen.
- **PH1–PH5 SO3 Boards** ❌ `v0.13.0-623-gaea1bcf56` — aber **ohne `WANT_BUTTONS=y`**. Beweis: Workaround-Entfernen in `so3_0.cfg` → `Unknown command: buttons_ack`. Müssen mit `.config.so3_buttons` (liegt unter `~/klipper/.config.so3_buttons` auf Pi, verifiziert enthält `CONFIG_WANT_BUTTONS=y`) neu gebaut und per Boot+Reset geflasht werden.
- **Config-Workaround in `so3_0..4.cfg` ist zwingend nötig** solange SO3-Firmware ohne Buttons läuft. Jeweils 20× `#DISABLED#` pro Datei deaktivieren `gcode_button t*_dock_sensor`, `filament_switch_sensor SO3Sensor_*`, `gcode_button _filament_unload_*`, `tachometer_*`. **Nicht entfernen vor SO3-Flash!**

**Erledigt (15.04.2026) — Moonraker Auth & Config-Audit:**

- **Moonraker Auth gefixt ✅** — Tailscale-Range `100.64.0.0/10` in `moonraker.conf` → `trusted_clients` eingetragen. Backup: `moonraker.conf.backup_20260415`. Moonraker neu gestartet. API per Tailscale erreichbar.
- **Config-Audit ✅** — printer.cfg (live) gegen Doku abgeglichen: Eddy kalibriert, Bed Mesh vorhanden, X/Y/Z/Heizbett/Servo/Dock alles konsistent. Details in [[05 Daily Notes/2026-04-15]].

**Offen in Etappe 1:**

- **SO3 Boards nochmal flashen** — 5× Boot+Reset mit `.config.so3_buttons` Firmware, danach Workaround rückgängig
- **EBB36 clean flashen** — v0.13.0-623 ohne "-dirty"
- ~~**4.7kΩ Pull-Up Widerstände**~~ — nicht nötig, Eddy läuft über `i2c3_PA7_PA6`
- ~~**Eddy Coil kalibrieren**~~ — erledigt ✅
- **Input Shaping kalibrieren** — ADXL345 am EBB36
- **USB-Webcam anschließen & Crowsnest einrichten**

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

## System-Architektur (Stand 14.04.2026)

```
[Raspberry Pi 5]
      |
      ├── USB → [BTT Octopus Pro H723] → /dev/ttyACM1
      |              → 4× XY (AWD, TMC5160 SPI ✅)
      |              → 4× Z (Quad-Z, TMC2209 UART ✅)
      |              → X-Endstop (^PG6 ✅)
      |              → SSR → 1300W Bett
      |
      ├── USB → [BTT U2C V2] → can0 (1 MBit/s)
      |                |
      |                └── CAN (H/L) → [Breakout-Board]
      |                                      |
      |                                      └── MX3.0 → [EBB36 Gen2 V1.0]
      |                                                       → Y-Endstop (PA15 ✅)
      |                                                       → Dock-Sensor (PB6)
      |                                                       → Eddy Coil (I2C PB3/PB4 ⚠️)
      |                                                       → ADXL345 (Input Shaping)
      |                                                       → Servo (PB5 ✅)
      |
      └── USB → [5× SO3 Boards] (so3_0 bis so3_4)
                    → PH1–PH5 Toolhead-MCUs
                    → ⚠️ WANT_BUTTONS fehlt, Config-Workaround aktiv
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
| Octopus USB | `/dev/serial/by-id/usb-Klipper_stm32h723xx_1D0015001251313531383332-if00` | ✅ aktiv (ttyACM1) |
| U2C USB | `1d50:606f` (gs_usb) | ✅ aktiv |
| Pi Name | mThreeD-IO | Hostname |
| Pi SSH-User | `m3d` | `ssh m3d@<IP>` |
| Pi Passwort | gesetzt | M3DistOK |
| Pi IP (iPhone-Hotspot) | `172.20.10.2` | nicht immer stabil |
| Pi IP (Tailscale) | `100.90.34.108` | permanent, netzwerkunabhängig |
| Pi mDNS | `mThreeD-IO.local` | im gleichen Netz |
| Mainsail (Hotspot) | `http://172.20.10.2` | nur im gleichen Netz |
| Mainsail (Tailscale) | `http://100.90.34.108` | permanent, überall |
| Mainsail (Cloudflare Tunnel) | `https://drucker.mthreed.io` | öffentlich, Access E-Mail-OTP, Read-Only-Proxy vorgeschaltet (17.04.) |
| Moonraker Read-Only-Proxy | `127.0.0.1:2096` | nur für externe Gäste, aiohttp-systemd-Service (17.04.) |
| Moonraker API | `http://100.90.34.108:7125` | Tailscale-Range in `trusted_clients` (15.04.) |
| Ollama | `http://100.90.34.108:11434` | lokal installiert, llama3.2:1b |
| Claude Code | auf Pi installiert | `ssh m3d@100.90.34.108` → `claude` |
| Webcam | USB-Kamera geplant, noch nicht angeschlossen | wird `/dev/video0` |

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

## Aktuelle printer.cfg (Stand 13.04.2026)

Basis: [Offizielles MakerTech GitHub](https://github.com/Makertech3D/ProForge-5) v1.0.0 + EBB36/U2C/Eddy-Anpassungen.

Config-Dateien auf dem Pi (`~/printer_data/config/`):
- `printer.cfg` — Hauptconfig (Stepper, TMC, Heizung, Sensoren)
- `macros.cfg` — Offizielle Toolchanger-Macros
- `eddy.cfg` — Eddy Coil via I2C am EBB36 (angepasst, Original nutzt USB-MCU)
- `mainsail.cfg` — Mainsail-Standard
- `variables.cfg` — Gespeicherte Variablen (Toolchanger-Positionen)

**Wichtigste Einstellungen:**

| Achse | Treiber | Typ | Pins | Strom |
|---|---|---|---|---|
| X (Slot 1) | TMC5160 | SPI | cs_pin: PC4, spi_bus: spi1 | 2.2A / 1.0A hold |
| Y (Slot 2) | TMC5160 | SPI | cs_pin: PD11, spi_bus: spi1 | 2.2A / 1.0A hold |
| Z0-Z3 (Slot 5-8) | TMC2209 | UART | PF2, PE4, PE1, PD3 | 1.1A / 0.4A hold |

**Endstop-Zuordnung:**
- X: `^PG6` (Octopus, STOP_0) ✅ verifiziert
- Y: `ebb:PA15` (EBB36, NO-Schalter, kein Pullup) ✅ verifiziert
- Z: `probe:z_virtual_endstop` (Eddy Coil)

**Unsere Umbauten vs. Original:**
- Servo: `ebb:PB5` statt `PE11`
- Y-Endstop: `ebb:PB6` statt `^PG9`
- Eddy: `probe_eddy_current` via I2C am EBB36 statt `probe_eddy_ng` via USB-MCU
- Kinematik korrekt: `corexy` (nicht cartesian wie in alter Config)

---

## Community-Feedback (Facebook-Gruppe)

### Post vom 08.04.2026 — Anderer User, ähnliche Probleme

**Quelle:** ProForge5 Facebook-Gruppe (User hat 5+ Jahre Druckererfahrung, Voron-Selbstbau)

**Seine Probleme:**
- **Mainboard defekt ab Werk** — musste Octopus Pro tauschen (bestätigt defekt out of the box)
- **X/Y Stepper defekt** — einer kam mit seitlich montiertem Heizbett-Stecker, beide fielen beim Test durch. Teilweise am defekten Board gebunden.
- **Y-Motoren drehen gegenläufig** — Pin-Belegung am Stecker falsch gepaart. Rumprobieren ohne Doku ist frustrierend.
- **Z fällt 5mm bei jeder X/Y-Bewegung** — unklare Ursache, möglicherweise Enable-Pin oder `hold_current` Problem
- **Kamera kein Signal** — fehlender Pin am Stecker sichtbar
- **Teillüfter läuft dauerhaft** (auch bei 0%) — vermutlich Erdungsproblem
- **Mainboard-Lüfter läuft gar nicht** — trotz neuem Board, vermutlich defekter Lüfter
- **Toolheads OK** — alle 5 Köpfe programmiert und erkannt, Lichter funktionieren

**Sein Fazit:** Für 4.000$ erwartete er eine schlüsselfertige Maschine, stattdessen Hardware-Probleme ab Unboxing. Verkabelung mehrfach (auch durch zweite Person) überprüft und korrekt — Problem liegt bei defekten Teilen/Kabelbäumen ab Werk.

### Post von Mark Thomas (Top-Beitrag, ~02.04.2026)

**Quelle:** ProForge5 Facebook-Gruppe, Mark Thomas (erfahrener Druckerbauer)

**Sein Weg:**
1. Board defekt ab Werk — SPI funktioniert gar nicht
2. Wechsel auf TMC2209 (wie wir) — X lief, aber **Y-Motoren out of sync** (Timing-Problem)
3. Y-Motoren wurden vom System **zurückgespeist** (backfed)
4. **Star-Grounding** beider Netzteile (24V + 48V) zusammen auf Erdung → hat Backfeed/Dragging behoben
5. Y-Timing blieb trotzdem → **Endlösung:** Neues Octopus Pro + **TMC5160T Pro** Treiber, komplette Neuverkabelung → läuft

**Sein Fazit:** MakerTech liefert defekte Teile, falsche Verkabelung ab Werk, null Support-Reaktion. Fordert Ersatz/Rückerstattung unter Verbraucherschutzgesetzen.

**Takeaways für unseren Build:**
- **Star-Grounding** der PSUs als konkreter Fix falls Y-Sync-Probleme auftreten
- **TMC2209 als Übergang kann weitere Probleme machen** — TMC5160T Pro war bei ihm die Endlösung (bei uns Etappe 3)
- **MakerTech Support reagiert schlecht** — alles dokumentieren für eventuelle Reklamation

**Relevanz für unseren Build:**
- **Defekte Teile ab Werk** scheint ein Muster zu sein → gute Argumentation für Support-Tickets
- **Jumper-Konfiguration ab Werk falsch** passt zu unserem UART-Verdacht (Board kommt mit SPI-Jumpern)
- **Z-Drop bei X/Y-Bewegung** im Hinterkopf behalten wenn wir zum Homing kommen
- **Y-Motor-Richtung** → Pin-Paar im Stecker tauschen falls bei uns auch gegenläufig

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
- Y-Endstop am EBB36: Pin ist `PA15` (nicht PB6!), NO-Schalter, kein Pullup/Invertierung
- Dock-Sensor am EBB36: Pin ist `PB6`
- CAN-Bus Auto-Start: Systemd-Service mit 5s Delay zuverlässiger als `interfaces.d/can0`
- Eddy Coil via I2C über CAN-Bus (i2c1_PB3_PB4) verursacht BUS_TIMEOUT bei Kalibrierung. Lösung: I2C-Bus auf i2c3_PA7_PA6 umgestellt → läuft stabil, keine Pull-Ups nötig. USB-Kalibrierungs-Workaround (Jumper AB, USB-Serial statt CAN-UUID) wurde nie benötigt.
- SO3 Boards (5×) haben eigene MCUs (`so3_0` bis `so3_4`), müssen separat geflasht werden (physischer BOOT0-Zugang am SO3-Board nötig — Hardware-Only Entry!)
- `flash_usb.py` und `enter_bootloader()` für SO3 nicht ausreichend — Board bootet direkt in Klipper-App, kein DFU
- SO3 Flash-Adresse: `0x8002000:leave` (8KB-Bootloader bei 0x8000000, App bei 0x8002000). NIEMALS 0x8000000 — zerstört Bootloader!
- SO3 USB-Serial: `USB_SERIAL_NUMBER_STR="PHx"` pro Board in Build-Config (PH1–PH5), KEIN CHIPID — sonst findet Klipper die MCUs nicht mehr
- **Octopus Pro V1.1**: DFU-Buttons elektrisch wirkungslos (0 USB-Events bei Button-Druck). Software-DFU via `flash_usb.py` → `dfu-util -s 0x8020000:leave` funktioniert zuverlässig
- Octopus Flash-Adresse: `0x8020000:leave` (128KB-Bootloader, App-Slot). Kein mass-erase — Bootloader bleibt erhalten
- Keine SD-Karte im Octopus: verhindert dass `firmware.bin` nach Power-Cycle den App-Slot überschreibt
- `flash_usb.py NIEMALS auf SO3 Boards verwenden` — war zu pauschal. Genauer: `enter_bootloader()` kann SO3 nicht in DFU bringen (Hardware-Only Entry). flash_usb.py voll laufen lassen crasht ggf. den Pi.

---

## Bereiche & Kontext

- [[03 Bereiche/Konstruktion/Konstruktion|Konstruktion]]
- [[03 Bereiche/Business MThreeD.io/Business MThreeD.io|Business MThreeD.io]]
- [[04 Ressourcen/Klipper/Klipper|Klipper]]
- [[04 Ressourcen/Klipper/ProForge5 Config Status|ProForge5 Config Status]]

---

## Changelog

| Datum      | Was |
|------------|-----|
| 2026-04-18 | **Mac-Inventur Phase 3 Session 2 — Projekt auf Ordner umgestellt ✅**: `02 Projekte/ProForge5 Build.md` → `02 Projekte/ProForge5 Build/` mit Unterordnern `assets/`, `backups/`, `snapshots/`, `firmware/`, `slicer-profile/`. 19 ProForge5-Artefakte aus `~/Mac-Inventur/05_Projekt_Material/` strukturiert abgelegt: `backups/` (5: Mainsail-Backups umbenannt nach Datum, Klipper-Config-Zip vom 20.03., Logs vom 22.03., print_history.csv); `firmware/` (P5FW_aktuell_2026-03-19.zip 2,5 GB + Octopus_Pro_stock_2026-03-25_aus_Repo.bin — letztere via md5-Match `c99a226…` als Stock-Firmware aus Snapshot 2026-03-28 identifiziert); `snapshots/` (Repo-Snapshot 2026-03-28); `assets/` (5: Proforge4-Referenzmodell 193 MB, Docking Bracket, Display Case 3mf+stl, Z-OffsetTest); `slicer-profile/` (ProForge 300 + 4.1 Orca-Profile). Klipper-Setup-Notiz vom 04.04. nach `04 Ressourcen/Klipper/ProForge5 CAN-Bus Setup 2026-04-04.md`, drei YouTube-Transkripte (EBB36/BTT EBB Gen 2/U2C-CAN) nach `04 Ressourcen/Klipper/Transkripte/`. Gelöscht (Papierkorb): P5FW_alt_2026-03-19.zip (1,7 GB, ältere Firmware-Revision), Snapshot 2026-03-20 (8 Tage älter als 28.03.), CAN-Bus-Setup-Duplikat `_1` (md5-identisch), LDC-Drive-Current-Clipping (als Notiz in Klipper.md aufgenommen). **Hinweis Sicherheit:** `backup-mainsail_2026-04-06_mobile.json` enthält in `gcodehistory` den Befehl `sudo passwd pi` — kein Passwort, nur Befehlsverlauf. Bei AMOS-Audit (17.04.) berücksichtigen. |
| 2026-04-17 | **Read-Only-Proxy für externe Gäste ✅**: Python-aiohttp-Service `moonraker-readonly-proxy` auf `127.0.0.1:2096`, filtert schreibende JSON-RPC-Methoden (WebSocket) und modifizierende POST/DELETE (REST). `printer.emergency_stop` bleibt aus Sicherheitsgründen erlaubt. nginx macht Split-Routing via `map $http_cf_connecting_ip $moonraker_backend`: CF-Traffic → Proxy, Tailscale/LAN → Moonraker direkt. Externe Besucher sehen Mainsail live, können nichts steuern. Tailscale-Admin-Zugang unverändert. Tests: 5× HTTP + 4× WebSocket, alle grün. Backups angelegt. Lehre: Emergency-Stop-Pass-Through im Live-Test nicht real feuern — `FIRMWARE_RESTART` rettet, aber würde laufende Drucke zerstören. |
| 2026-04-17 | **Cloudflare Tunnel + Access produktionsreif ✅ — `https://drucker.mthreed.io`**: Mainsail + Moonraker öffentlich erreichbar, ohne Port-Forwarding, ohne VPN, abgesichert durch E-Mail-OTP-Login. Tunnel-ID `378a4792-1636-4a40-b97f-b17ae4184755`. Protokoll: `http2` (iPhone-Hotspot blockt QUIC/UDP:7844 — bei echtem WLAN auf QUIC umstellbar). cloudflared v2026.3.0 auf Pi via `.deb` (trixie hat noch kein APT-Release). systemd-Service `cloudflared` persistent, DNS CNAME `drucker.mthreed.io` → `cfargotunnel.com`, proxied. nginx-Backend auf Port 80, vier Forwarded-Header (`X-Forwarded-For`, `X-Real-IP`, `X-Forwarded-Proto`, `Cf-Connecting-Ip`) in beiden Moonraker-Locations geleert, damit `trusted_clients` die 127.0.0.1-Quelle akzeptiert. `moonraker.conf` `cors_domains` um `*://drucker.mthreed.io` erweitert. **Zero-Trust-Team:** `mthreed` → `mthreed.cloudflareaccess.com`. **Access-App** `ProForge 5 Mainsail` (ID `f4ff7e08-d44b-4a28-a4c3-cc30d8c04ec7`, Session 24 h, IdP `onetimepin`), **Policy** `Nur Sebastian` (ID `35da1cb2-1105-470b-87ee-81c6761d9478`, allow nur `modern3b@icloud.com`). Browser-Test bestanden: Login-Screen → E-Mail-Code → Mainsail lädt ✅. Gäste (z.B. Ildiko) durch temporäres Eintragen in die Policy. Pi Stromversorgung intern gelöst ✅ (USB-C aus ProForge5, `vcgencmd get_throttled=0x0`). Details: [[05 Daily Notes/2026-04-17]], [[02 Projekte/Cloudflare Tunnel Setup — ProForge 5]]. |
| 2026-04-16 | **Hardware-Tag: Octopus geflasht ✅, SO3 blockiert**: Octopus Pro via Software-DFU auf v0.13.0-623 gebracht (`flash_usb.py` triggert DFU → `dfu-util -s 0x8020000:leave`). Persistenz nach Pi-Reboot bestätigt. SO3: `enter_bootloader()` + 1200-Baud-DTR wirkungslos — MakerTech-Bootloader hat Hardware-Only Entry (BOOT0-Pin physisch nötig). SO3-Flash-Adresse: `0x8002000:leave`. so3.bin war falsch mit CHIPID statt `USB_SERIAL_NUMBER_STR="PHx"` gebaut. EBB36 unberührt. Workaround läuft. |
| 2026-04-15 | **Reality-Check am Drucker:** Phase-A'-Test der Toolhead-Kalibrierung aufgedeckt: SO3-Firmware hat doch KEIN `WANT_BUTTONS=y` (Unknown command: buttons_ack), Octopus Pro läuft auf v0.13.0-593 statt 623 (14.04.-Flash hat nicht persistiert). Config-Workaround in `so3_*.cfg` ist kein Altlast sondern aktuell zwingend nötig. Rollback sauber, Klipper wieder `ready`. Servo-Winkel 28° und 110° getestet ✅. `.config.so3_buttons` auf Pi verifiziert. Toolhead-Kalibrierung blockiert bis SO3-Reflash + Octopus-Reflash. Details: [[05 Daily Notes/2026-04-15]]. |
| 2026-04-15 | **Moonraker Auth gefixt:** Tailscale-Range `100.64.0.0/10` in `trusted_clients` eingetragen, Backup vorher. API per Tailscale erreichbar. **Config-Audit:** Live-printer.cfg gegen Doku abgeglichen — **Eddy Coil ist kalibriert** (i2c3_PA7_PA6, ~100 Punkte Calibrate-Kurve im SAVE_CONFIG), **Bed Mesh existiert** (25×20 bicubic). Eddy-Blocker und Pull-Up-Plan gestrichen. Drucker-Status: Klipper `ready`, v0.13.0-623-gaea1bcf56, Hotend 24,5 °C, Bett 22,7 °C, nicht gehomet. |
| 2026-04-14 | **Firmware-Update:** Octopus Pro v0.13.0-623 ✅ via USB DFU. EBB36 v0.13.0-623-dirty ⚠️. SO3 PH1-5 ohne WANT_BUTTONS ❌ → Config-Workaround aktiv (gcode_button, filament_switch_sensor, tachometer deaktiviert). Neue SO3-Firmware mit WANT_BUTTONS=y liegt bereit auf Pi. |
| 2026-04-13 | **Session 1 — Config-Durchbruch:** TMC-Problem war Config (TMC2209 statt TMC5160). Offizielle GitHub-Config als Basis übernommen. Alle 6 Treiber kommunizieren. Endstops korrigiert: X=^PG6 (Octopus) ✅. **Session 2:** Y-Endstop gefixt: ebb:PA15 ✅. Homing X+Y ✅. CAN-Bus Auto-Start systemd ✅. Tailscale neu: 100.90.34.108 ✅. **Session 3:** Eddy Coil blockiert durch I2C BUS_TIMEOUT über CAN → braucht Pull-Up Widerstände. |
| 2026-04-06 | SSH, Tailscale, Ollama, KlipperScreen (TFT50), Klipper in Betrieb. Servo ✅. TMC UART auf allen 3 Achsen defekt — vermutlich falsche Jumper (SPI statt UART). CAN-Verbindung instabil. |
| 2026-04-05 | Endstops X/Y/Dock verifiziert, Servo-Block eingetragen (ebb:PB5), VPROBE-Jumper-Problem identifiziert, position_max auf echte Werte gesetzt |
| 2026-04-04 | Step 1 abgeschlossen: EBB36 Gen2 C
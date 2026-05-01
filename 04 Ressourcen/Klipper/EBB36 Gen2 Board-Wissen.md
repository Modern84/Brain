---
tags: [ressource, klipper, hardware, ebb36]
date: 2026-04-05
---

# EBB36 Gen2 V1.0 — Board-Wissen

Gesammelte Erkenntnisse aus offizieller Doku, Video-Reviews und eigener Recherche.

---

## Quellen

- **Stacking Layers** — "First Look Bigtreetech EBB GEN2" (05.10.2025, Beta-Tester-Review) — [YouTube](https://www.youtube.com/watch?v=IqWxSF5fDMc)
- **The Motion Bench** — "BigTreeTech EBB36 Gen 2 Review + Setup & Flashing Guide" (01.03.2026) — [YouTube](https://www.youtube.com/watch?v=DHPfkw8YIAs)
- **BTT Wiki** — [EBB36 GEN2 V1.0](https://global.bttwiki.com/EBB36_GEN2.html)
- **BTT GitHub** — [EBB Repo](https://github.com/bigtreetech/EBB)
- **Esoterical CANbus Guide** — [EBB36 Gen2](https://canbus.esoterical.online/toolhead_flashing/common_hardware/BigTreeTech%20EBB36%20Gen2/README.html)

---

## Hardware-Eckdaten

| Eigenschaft | Gen1 V1.2 | Gen2 V1.0 |
|---|---|---|
| MCU | STM32G0B1 | STM32G0B1 (identisch) |
| Motor Driver | TMC 2209 | TMC 2209 (identisch) |
| Accelerometer | ADXL345 | LIS2DW (neuer, weniger dokumentiert) |
| Kommunikation | CAN only | CAN + USB umschaltbar per Jumper |
| Power-Connector | MX3.0 direkt | XT30 auf Board, MX3.0 auf USB-Adapter |
| Fan-Header | 2x 2-Pin | 2x 2-Pin + 1x 3-Pin (mit Tacho) |
| Fan-Spannung | fest | individuell 5V/24V per Jumper (Rückseite) |
| Thermistor | NTC + PT100/PT1000 getrennt | Ein Header, automatische Umschaltung NTC/PT1000 |
| Motor-Connector | nach oben | 90° seitlich (besseres Kabelmanagement) |
| Schutzschaltung | minimal | massiv ausgebaut, quasi kurzschlusssicher |
| I2C-Port | nein | ja (BME-Sensoren, Displays, etc.) |
| USB-Hub-Chip | nein | FE1S USB 2.0 Hub (für Beacon/Cartographer) |
| Max. Heater | k.A. | 120W |
| Breakout-Header | nein | ja (USB oder CAN je nach Modus) |
| Max. 5V-Strom | 1A | 1.5A Peak |

---

## CAN/USB Umschaltung

- **Jumper auf Board:** Drauf = CAN-Modus, Ab = USB-Modus
- **Zweiter Jumper:** 120R CAN-Terminierung (nur am letzten Gerät in der CAN-Kette)
- **Breakout-Header:** 4 Pins — im USB-Modus: D+/D-/5V/GND, im CAN-Modus: CANH/CANL/VCC/GND
- Umschaltung erfordert neues Firmware-Flashen (andere Communication Interface)

---

## Spannungsversorgung & 5V

### Fan-Voltage-Jumper (Rückseite)
- Jeder Fan-Header (FAN0, FAN1, FAN2) hat eigenen Jumper auf der Board-Rückseite
- Wahl zwischen **VCC (24V)** und **5V**
- Gut beschriftet auf dem Board

### Probe-Header Spannung
- Probe-Port hat **Hardware-Jumper** zur Spannungswahl: **VIN (24V) oder 5V**
- VCC-Pin am Probe-Header wird mit der gewählten Spannung versorgt
- Servo am Probe-Header braucht diesen Jumper auf **5V**

### Neopixel/RGB-Header
- Oberer Pin: +5V, Mitte: Signal, Unten: GND
- Level Shifter für vollen 5V-Swing
- ESD-Schutz vorhanden
- Kann als 5V-Quelle für andere Geräte genutzt werden

### I2C-Header
- Liefert **5V** — Achtung bei 3.3V-Geräten (z.B. Eddy Coil)!

### Interner DC-DC
- 5V max. 1.5A Peak
- Wenn Fans auf 5V laufen, teilen sie sich dieses Budget

---

## Servo am Probe-Header

**Keine Lötbrücke nötig!** Die VCC-Spannung am Probe-Header wird per Jumper gewählt.

- **Servo-Pin PB5:** Direkter MCU-Anschluss, KEIN Schutz-Circuit
- **VCC:** Per Probe-Voltage-Jumper auf 5V stellen
- **GND:** Standard-Masse
- Immer **stromlos** einstecken
- Servo-Stromaufnahme muss unter dem 5V-Budget (1.5A Peak minus andere 5V-Verbraucher) bleiben

### Lötbrücke-Mythos
Intensive Recherche (BTT Wiki, GitHub Docs, KB3D Wiki, RatOS, Klipper CANbus Guide, zwei Video-Reviews) ergibt: Es gibt **keine dokumentierte Lötbrücke "+5V → VCC" auf der Rückseite** des EBB36 Gen2 V1.0. Die Verwechslung kam wahrscheinlich von den Fan-Voltage-Jumpern auf der Rückseite, die zwischen VCC und 5V umschalten.

---

## Schutzschaltungen (laut Beta-Tester)

- Board überlebt Kurzschlüsse und Verpolung weitgehend
- Doppelte Sicherung auf USB-Adapter-Board (Überstrom + Rückstrom)
- Probe-Port: ESD-Schutz + Optokoppler
- Servo-Pin: EINZIGER Pin ohne Schutz (bewusst für Flexibilität)
- Connector-Design (MX3.0/XT30): Power-Pins greifen vor Datenpins — verhindert 24V auf USB-Leitungen bei Wackelkontakt
- USB-Adapter-Board: Eigener USB-Hub + Fuse-Protection, empfohlen auch im CAN-Modus für Stromversorgung

---

## Flashing-Kurzreferenz (CAN-Modus)

### Katapult Bootloader
```
MCU: STM32G0B1
Bootloader: 8 KiB offset
Clock: 8 MHz crystal
Communication: CAN bus on PB12/PB13
CAN speed: 1000000
LED-Pin (optional): PA2
```

### Klipper Firmware
```
Extra low-level config: enabled
MCU: STM32 → STM32G0B1
Bootloader offset: 8 KiB
Clock: 8 MHz crystal
Communication: CAN bus on PB12/PB13
CAN speed: 1000000
```

### Flashing-Ablauf
1. USB-Adapter anschließen, Board per USB mit Host verbinden
2. BOOT halten → RESET drücken → BOOT loslassen → rote LED = DFU-Modus
3. `sudo dfu-util -l` — Device ID: 0483:DF11
4. Katapult flashen: `sudo dfu-util -a 0 -d 0483:DF11 -D ~/katapult/out/katapult.bin --dfuse-address 0x08000000:force:mass-erase:leave`
5. Board abstecken, CAN-Jumper + 120R-Jumper setzen, CAN-Kabel anschließen
6. UUID abfragen: `python3 ~/katapult/scripts/flashtool.py -i can0 -q`
7. Klipper flashen: `python3 ~/katapult/scripts/flashtool.py -i can0 -f ~/klipper/out/klipper.bin -u <UUID>`
8. Nochmal UUID abfragen — sollte "Application: Klipper" zeigen

### Wichtig
- `error during download get_status` nach DFU-Flash ist **normal** (Board resettet aus DFU)
- Klipper-Service vor dem Flashen stoppen: `sudo service klipper stop`
- Nach dem Flashen wieder starten: `sudo service klipper start`
- Alle CAN-Geräte müssen die **gleiche CAN-Speed** verwenden

---

## Klipper Pin-Referenz

| Funktion | Pin |
|---|---|
| Extruder Step | PB14 |
| Extruder Dir | PA8 |
| Extruder Enable | PB6 |
| TMC2209 UART | PB3 |
| Heater | PB4 |
| Thermistor | PA3 |
| FAN0 (Part Cooling) | PD3 |
| FAN1 (Hotend) | PA5 |
| FAN2 (Tacho) | PD2 |
| FAN2 Tacho-Detect | PA4 |
| Endstop | PA15 |
| Filament Sensor | PD0 |
| Servo (Probe-Header) | PB5 |
| Probe | PB8 |
| RGB/Neopixel | PD3 (shared mit FAN0!) |
| I2C SCL | PA7 |
| I2C SDA | PA6 |
| LIS2DW CS | PB1 |
| LIS2DW SCLK | PB10 |
| LIS2DW MOSI | PB11 |
| LIS2DW MISO | PB2 |
| MCU Temp | onboard |
| TMC Temp (NTC) | onboard (unter TMC) |
| Status LED | PA2 |

---

## U2C V2.1 als CAN-Adapter

### Aufbau ohne Breakout-Board
- U2C V2.1 ersetzt die USB-to-CAN Bridge-Funktion des Octopus Pro
- Pi → USB → U2C → CAN-Bus → EBB36
- 24V vom Netzteil über Schraubklemmen (V+/V-) ins U2C einspeisen
- U2C verteilt 24V + CAN-Signale über die seitlichen Molex Microfit 3.0 Stecker (4-polig: CAN_L, CAN_H, GND, VIN)

### Mitgeliefertes MX3.0-to-XT30 Kabel (2200mm)
- Dieses Kabel ist für **Breakout-Board → EBB36** gecrimpt
- Pin-Belegung U2C-Molex und Breakout-Board-Molex sind **gespiegelt** (180°-Symmetrie) — das Originalkabel passt elektrisch in beide, im U2C jedoch um 180° gedreht eingesteckt
- Community-Konsens "The BTT stuff is not the same on both sides" (VoronTools Guide) gilt — aber elektrisch lösbar durch 180°-Drehung, nicht zwingend Eigen-Crimp nötig
- Verpolung kann die EBB36 sofort zerstören → vor erstem Power-Up Polarität verifizieren (Multimeter oder schrittweises Vorgehen mit grüner LED als Indikator)

### Molex-Stecker ohne Arretierungshaken
- **Problem gefunden (ProForge5):** Arretierungshaken am MX3.0-Stecker war abgebrochen
- Stecker saß **180° verdreht** im U2C → kein Strom am EBB36
- Nach Drehen auf korrekte Position: Grüne LED auf EBB36, 24V liegt an
- **Fix:** Korrekte Orientierung mit Permanentmarker markieren, Molex-Gehäuse ersetzen (Molex Microfit 3.0, 4-polig)

### Empfehlung für U2C → EBB36 Verbindung
1. **Eigenes 4-adriges Kabel crimpen** — Molex Microfit 3.0 auf beiden Seiten
2. CAN_H + CAN_L als verdrilltes Paar (22-24 AWG)
3. 24V + GND mindestens 20 AWG
4. **Immer mit Multimeter prüfen** — welcher Pin am U2C-Molex 24V führt, welcher GND, dann Kabel entsprechend crimpen
5. Alternativ: CAN über DuPont-Pins am EBB36, 24V separat über XT30

**Praxis ProForge5 (2026-04-04 bis heute):** nicht selbst gecrimpt. Original-MX3.0-Kabel funktioniert im U2C-Molex bei 180°-Drehung — gespiegelte Pin-Belegung ist elektrisch kompatibel, mechanische Kodierung greift nicht zwingend. Eigen-Crimp wäre Alternative falls mechanische Verpolungs-Sicherheit gewünscht. Beim ProForge5 zusätzlich vorhanden: Kabel mit MX3.0 EBB-seitig + offenen Litzen U2C-seitig — erlaubt freie Pin-Zuordnung (Split 24V/CAN aus unterschiedlichen Quellen, oder Anschluss an einen Mainboard-CAN-Header statt U2C).

---

## Bekannte Eigenheiten

- **Dokumentation mangelhaft:** Pinout-Diagramm zeigt keine MCU-Pins für Extruder-Motor (nur A1/A2/B1/B2) — Pins stehen nur in der Sample-Config
- **Flashing-Doku:** Quasi nicht vorhanden für Gen2 — Community-Guides nutzen (Esoterical, Stacking Layers, The Motion Bench)
- **MX3.0-Kabel:** Laut BTT Korrektur NICHT abschneiden im CAN-Modus — USB-Adapter-Board für Stromversorgung weiterhin empfohlen
- **PD3 Doppelbelegung:** FAN0 und Neopixel teilen sich PD3 — nicht beides gleichzeitig nutzen
- **LIS2DW statt ADXL345:** Weniger Community-Support, andere Klipper-Config nötig

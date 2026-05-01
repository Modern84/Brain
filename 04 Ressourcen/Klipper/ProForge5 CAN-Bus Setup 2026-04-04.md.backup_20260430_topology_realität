---
tags: [ressource, klipper, can-bus, proforge5, setup]
date: 2026-04-04
---

# ProForge 5 – CAN-Bus Setup (04.04.2026)

## Status: Step 1 ABGESCHLOSSEN ✅

---

## Hardware

| Komponente | Modell | Verbindung | Status |
|---|---|---|---|
| Raspberry Pi 5 | 2GB, Debian 13 Trixie | Zentrale | ✅ läuft |
| BTT Octopus | STM32H723 | USB → Pi | ✅ verbunden |
| BTT U2C V2 | CAN-Bridge | USB → Pi | ✅ verbunden |
| EBB36 Gen2 V1.0 | STM32G0B1 | CAN → U2C → Pi | ✅ verbunden |
| Eddy Coil | LDC1612 | I2C über EBB36 | ✅ in Config |

---

## Netzwerk-Topologie

```
Raspberry Pi 5
├── USB → BTT Octopus (STM32H723) → /dev/ttyACM0
└── USB → BTT U2C V2 → can0 (1 MBit/s)
                └── CAN (H/L) → Breakout-Board → EBB36 Gen2
                                                    └── I2C → Eddy Coil (LDC1612)
```

---

## UUIDs & IDs

| Gerät | UUID / ID |
|---|---|
| EBB36 (CAN) | `71c47e0b85cf` |
| EBB36 (alte USB-UUID, ungültig) | `f9aba4b5a918` |
| Octopus | `/dev/ttyACM0` |
| U2C | `1d50:606f` (gs_usb) |

---

## Verkabelung

### Stromversorgung
- Mean Well LRS-450-24 (24V, 18.8A)
- 24V → Breakout-Board (VIN/GND Schraubklemmen)
- Breakout-Board → EBB36 (über MX3.0 Kabel, liefert 24V + CAN)

### CAN-Bus
- U2C CAN_H/CAN_L (Schraubklemmen) → 2 dünne Kabel → Breakout-Board CAN H/L Pins
- 120Ω Termination: U2C (per Software) + EBB36 (Jumper)
- Bitrate: 1.000.000

### USB
- Pi USB → U2C (USB-C)
- Pi USB → Octopus (USB)

---

## Jumper-Einstellungen EBB36 Gen2

| Jumper | Stellung | Bedeutung |
|---|---|---|
| USB/CAN Selection | **DRAUF** | CAN-Modus (für normalen Betrieb) |
| 120Ω Termination | **DRAUF** | Abschlusswiderstand aktiv (Bus-Ende) |

> **Zum Flashen (DFU):** USB/CAN Jumper **AB**, USB-C ins Breakout-Board, 24V an, BOOT halten → RST drücken → loslassen → 5 Sek → BOOT loslassen

---

## Firmware EBB36

| Parameter | Wert |
|---|---|
| MCU | STM32G0B1 |
| Clock | 8 MHz Crystal |
| Communication | CAN bus (PB12/PB13) |
| CAN Bitrate | 1.000.000 |
| Bootloader | Keiner (Flash Start 0x8000000) |

---

## Erledigtes heute

1. ✅ Mainsail (Port 80) und Fluidd (Port 81) online
2. ✅ Octopus per USB erkannt
3. ✅ U2C V2 als CAN-Bridge eingerichtet
4. ✅ CAN-Verkabelung: U2C → Breakout-Board → EBB36
5. ✅ EBB36 Klipper-Firmware kompiliert (CAN-Modus, PB12/PB13, 1M)
6. ✅ EBB36 per DFU über Breakout-Board geflasht
7. ✅ EBB36 UUID in printer.cfg aktualisiert (71c47e0b85cf)
8. ✅ Klipper gestartet – beide MCUs verbunden

---

## Bekannte offene Punkte

- **TMC-Fehler** für Stepper X/Y/Z: `Unable to read tmc uart register IFCNT` → Motoren am Octopus noch nicht angeschlossen/konfiguriert
- **Eddy Coil** konfiguriert aber noch nicht physisch getestet
- **Obsidian-Integration** mit Claude noch nicht fertig eingerichtet
- **Cowork-Chats** gehen bei Absturz verloren – wichtige Infos immer hier oder in Obsidian sichern

---

## Nächste Schritte (Step 2)

1. TMC-Treiber am Octopus konfigurieren/verkabeln
2. Eddy Coil testen und kalibrieren
3. Motoren anschließen und Homing testen
4. Obsidian-Integration fertig einrichten

---

## Lessons Learned

- EBB36 Gen2 V1.0 kann **nur** über das Breakout-Board per USB geflasht werden (DFU)
- USB/CAN Jumper muss für DFU **ab** sein, für Betrieb **drauf**
- Das Breakout-Board kann die EBB36 **nicht** über USB-C mit Strom versorgen – 24V muss separat anliegen
- CAN-Kabel (H/L) müssen separat vom U2C zum Breakout-Board verlegt werden
- Bei vertauschten CAN-H/L: Bus geht auf BUS-OFF, einfach Kabel tauschen
- Firmware muss für **CAN (PB12/PB13)** kompiliert werden, nicht USB (PA11/PA12)

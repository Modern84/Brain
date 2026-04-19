---
tags: [clippings, klipper]
date: 2026-04-04
source: "http://100.90.34.108/"
---

# Mainsail

Mainsail ist das Web-Interface für [[04 Ressourcen/Klipper/Klipper|Klipper]]. Zugriff über `http://100.90.34.108` (Tailscale) oder `http://172.20.10.2` (Hotspot).

Wird genutzt für den [[02 Projekte/ProForge5 Build|ProForge5]].

## Zugriff

| Weg | URL | Voraussetzung |
|---|---|---|
| Hotspot (iPhone) | `http://172.20.10.2` | Gleicher Hotspot, nur `http://` |
| Tailscale | `http://100.90.34.108` | Tailscale aktiv auf Mac |

> **Wichtig:** Immer `http://`, kein `https://` — sonst Verbindungsfehler.

## Nützliche Konsolen-Befehle

```
QUERY_ENDSTOPS              # Endstop-Status prüfen
SET_SERVO SERVO=toolchanger ANGLE=180   # Servo testen
G28 X                       # X-Achse homen
G28 Y                       # Y-Achse homen
PROBE_EDDY_CURRENT_CALIBRATE CHIP=btt_eddy   # Eddy kalibrieren
STEPPER_BUZZ STEPPER=stepper_x   # Motor-Pin verifizieren
```

---
tags: [ressource]
date: 2026-04-04
---

# Klipper

## Überblick

Klipper ist eine 3D-Drucker-Firmware die auf einem Raspberry Pi läuft und die Steuerung des Druckers übernimmt. Ermöglicht fortgeschrittene Konfigurationen, Makros und Automatisierungen.

## klipper-mcp

MCP-Server der 100+ Klipper-Tools bereitstellt. Läuft auf dem Pi und erlaubt externen Zugriff auf Klipper/Moonraker.

| Was | Wert |
|---|---|
| Host (Hotspot) | `172.20.10.2:8000` |
| Host (Tailscale) | `http://100.90.34.108:8000` |
| Status | ✅ aktiv, Moonraker verbunden |

## Links und Quellen

- [Klipper Dokumentation](https://www.klipper3d.org/Overview.html)
- [[04 Ressourcen/Klipper/ProForge5 Config Status|ProForge5 Config Status]]
- [[02 Projekte/ProForge5 Build]]

- [[03 Bereiche/KI-Anwendungen/KI-Anwendungen|KI-Anwendungen]] (klipper-mcp)
- [[04 Ressourcen/Automatisierung/Automatisierung|Automatisierung]]

## Notizen

- **Eddy Coil Drive Current kalibrieren:** `LDC_CALIBRATE_DRIVE_CURRENT CHIP=btt_eddy` (einmalig nach Verkabelung/Montagewechsel)

## Setup-Notizen

- [[ProForge5 CAN-Bus Setup 2026-04-04]] — vollständige Doku Hardware/Topologie/UUIDs/Verkabelung für ProForge5 CAN-Fundament
- [[ProForge5 Config Status]]

## Transkripte (YouTube-Referenzen)

Externe Tutorials/Reviews als Referenz bei Setup/Debugging in `Transkripte/`.


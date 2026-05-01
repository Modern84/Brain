---
tags: [ressource, klipper, proforge5, journal]
date: 2026-04-27
status: aktiv
raum: drucker
---

# ProForge5 Build Journal

> Chronologischer Index aller Build-Sessions. Wächst mit jeder Session — ein Eintrag pro Tag mit Kernergebnis und Link zur Daily Note.
> **Primärquelle:** [[02 Projekte/ProForge5 Build/ProForge5 Build]] — Status, Tasks, Etappen.

---

## 2026

### April 2026

| Datum | Was | Ergebnis |
|---|---|---|
| 2026-04-04 | Vault aufgesetzt, erste Struktur | Gehirn angelegt ✅ |
| 2026-04-05–06 | Pi SSH + Tailscale + Ollama | Grundzugang ✅ |
| 2026-04-13 | TMC5160 SPI Config, X/Y-Endstops, Homing | X/Y Homing verifiziert ✅ |
| 2026-04-14 | CAN-Bus Auto-Start (systemd), Tailscale-Account | can0 persistent ✅ |
| 2026-04-15 | Eddy Coil kalibriert, Bed Mesh, Moonraker Auth | Leveling-Basis ✅ |
| 2026-04-16 | SO3 Config-Audit, Diktierfunktion, Obsidian-Optimierung | Workflow-Setup ✅ |
| 2026-04-17 | Pi Stromversorgung intern, Cloudflare Tunnel live | Remote-Zugriff ✅ |
| 2026-04-18 | Cloudflare Access (Zero-Trust), Read-Only-Proxy für Gäste | Sicherheits-Schicht ✅ |
| 2026-04-26 | SO3 Boards (PH1–PH5) alle 5 geflasht | Firmware-Basis ✅ |
| 2026-04-27 | Toolhead Pickup ✅, Park-Crash diagnostiziert (EBB-MCU-Self-Shutdown bei ~87°), Hotend-Auto-Heating-Sicherheitspatch, Pi-Kernel CVE-2025-68307, Watchdogs, Recovery vereinfacht | Marathon-Session — [[05 Daily Notes/2026-04-27]] |

### Nächste Schritte (Stand 2026-04-27)

1. **Klappferrit** am MX3.0-Kabel (EBB↔Schlitten) — Park-EMI-Mitigation
2. **Hotend-4-Nase** richten oder ersetzen
3. **Stage 07.4** alle 5 Tools sequenziell (Pickup + Park)
4. **Stage 09** Tool-Offset-Probe-Kalibrierung
5. **Erster Test-Print** (Benchy)

---

## Wichtige Erkenntnisse (destilliert)

### Crash-Muster — zwei separate Pfade

| Pfad | Symptom | Ursache | Fix |
|---|---|---|---|
| **gs_usb USB-EMI** | ENOBUFS, kernel-events, USB-Disconnect | TX-Pool-Exhaustion unter USB-Stress | Soft-Ramp eliminiert ✅, CVE-Patch ✅ |
| **EBB-MCU Self-Shutdown** | CAN-Frame-Loss, kein Kernel-Event, Klipper shutdown | Stromspike bei ~87° Servo (Lock-Engagement gegen Feder) | Klappferrit / separate 5V-Servo-Versorgung |

### Pinout — Single Source of Truth

→ [[04 Ressourcen/Klipper/ProForge5 Pinout]]

### Recovery-Pfade

→ [[04 Ressourcen/Klipper/Recovery-Pfade]]

### Servo-EMI Mitigation

→ [[04 Ressourcen/Klipper/Servo-EMI-Mitigation]]

### Sicherheit Filament-Sensor Auto-Heating

→ [[04 Ressourcen/Klipper/SAFETY-Filament-Sensor-AutoHeating]]

---

## Verknüpfungen

- [[02 Projekte/ProForge5 Build/ProForge5 Build]] — Projektdatei mit Tasks
- [[04 Ressourcen/Klipper/ProForge5 Pinout]] — aktuelle Pin-Wahrheit
- [[TASKS]] — offene Hardware-Tasks

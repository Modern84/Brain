---
tags: [ressource, klipper, proforge5, safety, lesson]
status: aktiv
date: 2026-04-27
---

# SAFETY — Filament-Sensor Auto-Heating beim Klipper-Boot

**Befund vom 2026-04-27: `[gcode_button _filament_unload_X]` triggerte beim Klipper-Boot ungewollt Hotend-Heating, ohne dass ein User-Command abgesetzt wurde. Patch installiert.**

## Beobachtetes Symptom

Mainsail-Konsole zeigte beim Klipper-Boot ungefragt:

```
Activating extruder extruder4
Hotend 4 heating!
Filament loading!
SET_HEATER_TEMPERATURE HEATER=extruder4 TARGET=...
Filament load complete!
Clear filament spaghetti and press resume to continue printing.
```

Niemand hatte `M104` / `LOAD_FILAMENT` / `SET_HEATER_TEMPERATURE` / `ACTIVATE_EXTRUDER` aufgerufen. Klipper hatte heute 11+ Restarts (Crash-Debug-Marathon) — bei jedem Start drohte Auto-Heating bei stehendem Drucker.

## Root-Cause

In `so3_X.cfg` (X=0..4) Zeile ~177:

```
[gcode_button _filament_unload_X]
pin: !so3_X:PA10
release_gcode:
  SET_LED LED=SO3RGB_X RED=0.0 GREEN=0.5 BLUE=0.5
  _filament_unload_init_X     ← heizt Hotend hoch
press_gcode: # do not add any macro call here
```

`PA10` ist der physische Filament-Switch-Sensor an PHX. **Beim Klipper-Boot liest Klipper einmal den Pin-State.** Wenn der Sensor RELEASED ist (kein Filament eingelegt) → `release_gcode` feuert → `_filament_unload_init_X` → Heater hoch.

**Konsequenz:** Bei jedem Pi-Boot oder `systemctl restart klipper` heizt Klipper jedes PHx ohne Filament automatisch auf — auch wenn Drucker offen, Hände drin, Wartungsarbeit.

## Patch (installiert 2026-04-27)

Variante A — `release_gcode` neutralisiert, nur Hinweis-Message:

```
[gcode_button _filament_unload_X]
pin: !so3_X:PA10
release_gcode:
  # SAFETY 2026-04-27: Auto-Heating disabled. Manueller LOAD_FILAMENT TOOL=X noetig.
  M118 PH(X+1) Filament-Sensor RELEASED — manuell laden mit LOAD_FILAMENT TOOL=X
press_gcode: # do not add any macro call here
```

Macro-Definitionen `_filament_unload_init_X` und `_filament_unload_X` bleiben im File — manueller Aufruf via Mainsail-Console weiterhin möglich.

Backup vor Patch: `/home/m3d/printer_data/config/backup_filament_safety_<TIMESTAMP>/`

## Re-Enable wenn später gewünscht

Zwei Wege:

- **(A) State-Lock:** `release_gcode` nur ausführen wenn Klipper >60s ready ist (delayed_gcode + variable). Verhindert Boot-Trigger, behält Run-Time-Sensor-Funktion.
- **(B) Komplett zurück:** `_filament_unload_init_X` wieder einsetzen. Vor jedem Pi-Boot Filament aus allen Sensoren ziehen.

Für Stage 07.4 / Toolchanger-Tests ist die Auto-Heating-Funktion **nicht nötig** — Tools werden ohne Filament getestet.

## Lesson — gcode_button im Boot-Verhalten

Klipper feuert `release_gcode` beim ersten Pin-Read nach Boot wenn Pin im Released-State ist. Das ist **nicht** dokumentiert als „nur on transition". `event_delay` hilft nicht (es entkoppelt nur Mehrfach-Events, nicht den Boot-Read).

**Regel:** `release_gcode` und `press_gcode` sollten NIE Hardware-Aktionen mit Verletzungs-/Schaden-Potenzial enthalten ohne State-Lock. Heating, Bewegung, Servo — nicht ohne Boot-Schutz.

## Verknüpfungen

- [[04 Ressourcen/Klipper/ProForge5 Config Status]]
- [[04 Ressourcen/Klipper/Recovery-Pfade]]
- [[05 Daily Notes/2026-04-27]]

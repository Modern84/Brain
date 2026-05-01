---
tags: [ressource, klipper, proforge5, hardware, pinout]
status: aktiv
date: 2026-04-27
---

# ProForge5 — Pinout (Single Source of Truth)

**Aktuelle Pin-Wahrheit für Mos Custom-Build (EBB36 + U2C + CAN). Nichts anderes ist Wahrheit. Bei jeder Hardware-Änderung sofort hier pflegen.**

Daily Notes erzählen die Geschichte. Diese Datei ist der Stand JETZT.

---

## Konvention

| Spalte | Bedeutung |
|---|---|
| **Funktion** | Was die Verkabelung physisch tut |
| **MCU** | octopus / ebb (EBB36 Gen2 V1.0 via CAN) |
| **Pin** | wie in printer.cfg geschrieben |
| **Header** | physischer Header am Board |
| **Polarität** | NO/NC + Klipper-Notation (`^`, `!`, `^!`) |
| **Verifiziert am** | letzter erfolgreicher Test mit Datum |
| **Status** | ✅ verifiziert / 🟡 unsicher / 🔴 defekt |

---

## Octopus Pro (Mainboard)

| Funktion | Pin | Header | Polarität | Verifiziert am | Status |
|---|---|---|---|---|---|
| X-Endstop | `^PG6` | DIAG-Header | NO mit Pullup | 2026-04-13 | ✅ |
| **Tool-Offset-Probe** (Bett, Stahlkugel) | `^PG10` | PROBE-Header | NO mit Pullup, schließt bei Kugel-Kontakt | 2026-04-30 (`gcode_button probe_pin_test`, State `RELEASED` idle) | ✅ elektrisch erkannt, Klipper liest Pin — Schalter-Funktionstest am Drucker noch offen, `[probe]`-Sektion in `calibrate-offsets.cfg` noch deaktiviert |

*Carriage-Tool-Sensor liegt am EBB36 (`^!ebb:PB8`), nicht am Octopus. Frühere Annahme PG11 war falsch.*

*Probe-Hardware: Aluminium-Sockel + Stahlkugel + Schalter, mit M5×20 Button-Head am Bett-Hinterkante verschraubt. Probe-Test-Config: `~/printer_data/config/stage09-prep/probe-pin-test.cfg` (gcode_button auf PG10 ohne `[probe]`-Sektion, erlaubt Live-Status-Abfrage ohne Stage-09-Aktivierung). Aktivierung für produktive Tool-Offset-Kalibrierung erfolgt später via `[include calibrate-offsets.cfg]` in `printer.cfg` (aktuell auskommentiert).*

---

## EBB36 Gen2 V1.0 (am Wagen, via CAN)

| Funktion | Pin | Header | Polarität | Verifiziert am | Status |
|---|---|---|---|---|---|
| Y-Endstop | `ebb:PA15` | ENDSTOP | NO ohne Pullup | 2026-04-27 (QUERY_ENDSTOPS) | ✅ |
| Servo Toolchanger | `ebb:PB5` | PROBE (PB5) | — | 2026-04-26 (DOCK=52°, SELECT=125°) | ✅ |
| Eddy Coil SCL | `ebb:PA7` | I2C | — | 2026-04-13 | ✅ kalibriert |
| Eddy Coil SDA | `ebb:PA6` | I2C | — | 2026-04-13 | ✅ kalibriert |
| **Tool-Change-Sensor** (am Wagen) | `^!ebb:PB8` | PROBE-Header (zusammen mit Servo PB5) | **NC** mit Pullup, invertiert | 2026-04-27 (Live-Watch + Plunger drücken) | ✅ |

---

## Tool-Change-Sensor — Stand 2026-04-27 — GELÖST ✅

**Lösung:** Pin `^!ebb:PB8` (PROBE-Header, gemeinsam mit Servo). Schalter ist NC (normally closed) → daher Invert mit `!`. Live-Watch zeigte saubere Wechsel: idle = RELEASED, Plunger gedrückt = PRESSED.

**Eigentliche Ursache des heutigen Pin-Roulettes:** Kalte Lötstelle bzw. Crimp-Wackler im Sensor-Kabel/Stecker. Über Stunden lieferte der Sensor unzuverlässige bzw. konstante Werte auf jedem getesteten Pin. Erst nach physischer Demontage des Schalters und neuem Reinstecken des Steckers am EBB36 lief er sauber. Diagnose war ohne Multimeter erschwert.

**Nicht ein Hardware-Defekt am Schalter** — der ist intakt. Nur die Verbindung war zeitweise unterbrochen.

**Plan B (Macro-Patch) bleibt im Brain als Reserve:** [[02 Projekte/ProForge5 Build/snapshots/macros.cfg.snapshot_20260427_carriage_workaround_PATCH]] — falls der Schalter in Zukunft wieder Probleme macht, Patch ist sofort einsetzbar.

**Lessons learned:**
- Erste Annahme "Hardware defekt" war falsch — Verbindungsproblem ist ohne Multimeter ähnlich symptomatisch
- Ohne Multimeter: bei stabilen Klipper-Readings über 30s+ Live-Watch IMMER Stecker einmal abziehen + neu reinstecken bevor Hardware-Tausch in Erwägung gezogen wird
- Schalter-Polarität (NO vs NC) lässt sich live verifizieren: idle-State + Plunger-State manuell testen, dann ggf. `!` setzen

**Pin-Tests die heute alle nichts brachten (zur Doku, alle nutzlos durch den Wackler):**

| Versuch | Pin | Erwartet jetzt mit funktionierendem Kabel |
|---|---|---|
| `^PG11` (Octopus) | falscher Pin, Schalter hängt am EBB36 | n/a |
| `^ebb:PB6` | nicht der Sensor-Pin | wäre Dock-Sensor wenn dort verkabelt |
| `^ebb:PD0` | nicht der Sensor-Pin | n/a |
| `^!ebb:PB8` | **richtig** | ✅ funktioniert mit Invert für NC-Schalter |

---

## So3 Toolhead Boards (PH1–PH5, je STM32F042 via USB)

Jeder Toolhead hat eigene Sensor-Buttons:

| Funktion | Pin | Status |
|---|---|---|
| `t0_dock_sensor` | so3_0:button-pin (PH1, y=8) | ✅ Pin-Swap 2026-04-27 |
| `t1_dock_sensor` | so3_1:button-pin (PH2, y=109.5) | ✅ |
| `t2_dock_sensor` | so3_2:button-pin (PH3, y=211) | ✅ unverändert |
| `t3_dock_sensor` | so3_3:button-pin (PH4, y=312.5) | ✅ |
| `t4_dock_sensor` | so3_4:button-pin (PH5, y=414) | ✅ Pin-Swap 2026-04-27 |

**Pin-Swap Status FINAL VERIFIZIERT (2026-04-27, Pickup + Park beide getestet):**
- t0 ↔ t4 getauscht, t1 ↔ t3 getauscht, t2 unverändert
- SELECT_PH1: carriage→PRESSED + t0_dock→RELEASED ✅
- _DOCK_PH1: carriage→RELEASED + t0_dock→PRESSED ✅
- Beide Richtungen sauber, Mapping konsistent mit Macro-Konvention
| Hotend-LED je Kopf | so3_x:neopixel | ✅ |
| TMC2209 UART je Extruder | so3_x:PB5 | ✅ |
| Tachometer je Hotend-Lüfter | (deaktiviert) | 🟡 Workaround — `WANT_PULSE_COUNTER` fehlt in Build-Config |

---

## Pflege-Regel

Diese Datei ist **die einzige Wahrheit** für die Verkabelung. Beim:
- Hardware-Umbau → vor dem Test hier eintragen mit "🟡 in Klärung"
- Erfolgreichen Test → Datum eintragen, Status auf ✅
- Fehler → Status auf 🔴 mit Notiz

Alte/widersprüchliche Einträge in Daily Notes oder anderen Brain-Dateien sind Geschichte. Bei Konflikt gilt: **diese Datei.**

---

## Verknüpfungen

- [[04 Ressourcen/Klipper/EBB36 Anschlussplan]] — Original-Plan vor Mos Anpassungen (nicht 1:1 umgesetzt!)
- [[04 Ressourcen/Klipper/EBB36 Gen2 Board-Wissen]] — Board-Spezifikation
- [[04 Ressourcen/Klipper/ProForge5 Config Status]] — Config-Stand
- [[02 Projekte/ProForge5 Build/ProForge5 Build]] — Projekt-Übersicht

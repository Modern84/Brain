---
tags: [ressource, klipper, proforge5, servo, emi, lesson]
status: aktiv
date: 2026-04-27
---

# Servo-EMI-Mitigation (ProForge5 Toolchanger)

**Soft-Ramping als Software-Lösung gegen gs_usb-Crashes unter Servo-Last. Verifiziert wirksam, mit Caveat zum Lock-Timing.**

## Problem

Servo am EBB36 PROBE-Header (`ebb:PB5`, MG996R-Klasse) zieht beim Anriss aus stehendem Zustand kurzzeitig hohen Strom. In Kombination mit AWD-Bewegung (alle 4 Z-Stepper + X/Y aktiv) löst das EMI-Spikes auf dem USB-Pfad zum U2C V2 (gs_usb-Treiber) aus → Klipper-Shutdown mit `EPIPE/EPROTO/echo id`-Storm im Kernel-Log oder `ENOBUFS` im Klipper-Log.

3× heute (2026-04-27) reproduziert beim SELECT_PHx mit harten Servo-Sprüngen 52°↔125°.

## Lösung — Soft-Ramping + WIDTH=0

```
[gcode_macro _SERVO_DOCK]
gcode:
  {% for a in range(125, 51, -5) %}
  SET_SERVO SERVO=toolchanger ANGLE={a}
  G4 P50
  {% endfor %}
  SET_SERVO SERVO=toolchanger ANGLE=52
  G4 P1000
  SET_SERVO SERVO=toolchanger WIDTH=0

[gcode_macro _SERVO_SELECT]
gcode:
  {% for a in range(52, 126, 5) %}
  SET_SERVO SERVO=toolchanger ANGLE={a}
  G4 P50
  {% endfor %}
  SET_SERVO SERVO=toolchanger ANGLE=125
  G4 P1000
  SET_SERVO SERVO=toolchanger WIDTH=0
```

**Mechanismus:**
- 5°-Schritte mit 50ms Pause spreizen den Stromzug über ~700ms statt einer Lastspitze
- Final-Dwell vor `WIDTH=0` gibt der Servo-Mechanik Zeit, die letzte Position vollständig einzunehmen
- `WIDTH=0` schaltet PWM komplett ab → kein Halte-Stromzug → Servo-Lock GEN2 V1.0 hält formschlüssig

## Verifizierte Wirksamkeit (gegen gs_usb-Pfad)

Stage 07.4 v2 Lauf am 2026-04-27 17:49:
- ✅ **Klipper überlebt SELECT_PH1 ohne Shutdown** (active am Ende)
- ✅ **0 EMI-Events** im Kernel-Log während des Servo-Moves
- ✅ **0 Watchdog-Trigger**

Erste Bestätigung dass das **gs_usb-USB-Crash-Pattern** unter Servo-Last softwareseitig adressierbar ist.

## Schwäche — Verlängerte Verweildauer in kritischen Servo-Phasen

**Live-Diag-Befund 2026-04-27 18:57** (Tracker 200 ms, Korrelation `bytes_retransmit` ↔ Servo-Position):

- Soft-Ramp friert bei **ANGLE 87°** ein (Klipper sendet keine weiteren `SET_SERVO`)
- 500 ms später beginnen EBB-Retransmits (212 → 300 → 400 → 518)
- **Kein Kernel-Event, kein ENOBUFS** — `srtt` bleibt 0.001, aber `rto` eskaliert exponentiell (0.025→5.0)
- Crash-Reason: `MCU 'ebb' shutdown: shutdown clock=X static_string_id=Command request`

**ANGLE 87° ist mechanisch kritischer Übergang** zwischen „Federn entspannt" und „Lock-Ring klemmt formschlüssig". Servo zieht maximalen Strom gegen Federspannung → Stromspike auf EBB-Versorgung → CAN-Frame-Loss.

**Konsequenz:** Soft-Ramp verlängert die Verweildauer bei kritischen Winkeln auf das 5-fache (700 ms statt ~100 ms Hartsprung). Während der Verweildauer baut sich CAN-Stress auf bis EBB-MCU sich shutdownt.

## Zwei separate Crash-Pfade

| Pfad | Trigger | Symptom | Watchdog | Mitigation |
|---|---|---|---|---|
| **gs_usb USB-EMI** | Stromspike kurzzeitig hoch | ENOBUFS / EPIPE / EPROTO im Kernel-Log | ✅ detektiert | Soft-Ramp wirksam |
| **EBB-Self-Shutdown** | Stromspike länger anhaltend | `static_string_id=Command request` im Klippy-Log, kein Kernel-Event | ❌ blind | Hartes Schließen testen, Servo-Versorgung trennen |

## Strategie-Optionen für 2026-04-28

- **(A) Hartes Schließen testen** — Hypothese: einzelner 52°→125° Sprung überquert 87° zu schnell als dass sich CAN-Stress aufbaut. Aber: gs_usb-Pfad könnte wieder triggern.
- **(B) Asymmetrischer Ramp** — fein im unkritischen Bereich (52°–80°, 1°/10ms), grob im kritischen (80°–125°, einzelner Sprung). Setzt voraus dass 87° nur als Durchgang nicht als Verweilpunkt gefährlich ist.
- **(C) Servo-Versorgung galvanisch trennen** — separater 5 V-BEC für Servo, gemeinsame Masse nur am EBB-GND. Adressiert Root Cause (Stromspike auf gemeinsamer 5 V-Schiene).
- **(D) Pull-Up-Width-Vorlauf** — vor Soft-Ramp explizit `SET_SERVO ANGLE=52 / G4 P200` damit der Servo aus definiertem PWM-Zustand startet (statt aus `WIDTH=0`).

## Caveat — Lock-Close-Timing

**Final-Dwell vor `WIDTH=0` muss die Lock-Mechanik-Einrastzeit umfassen.** Sonst schließt der Lock nicht vollständig:

| Final-Dwell | Lock-Close | Notiz |
|---|---|---|
| 300ms | ❌ unzureichend | Tool 1 blieb im Picker, Schlitten fuhr leer weg |
| 1000ms | 🟡 zu testen | Patch im File, FIRMWARE_RESTART-Hang verhinderte Test |
| 1500ms+ | offen | Falls 1000ms knapp |

**Hypothese:** PWM-Abschaltung VOR vollständigem Lock-Einrasten lässt Servo unter Last die letzten 5° nicht schaffen → Lock bleibt halb offen → Greifer hält Tool nicht.

## Caveat — FIRMWARE_RESTART nicht verwenden

**Zweite Crash-Quelle entdeckt:** FIRMWARE_RESTART nach Config-Änderung triggerte ENOBUFS-Hang ohne Servo-Beteiligung. Soft-Recovery (USB unbind/bind) blieb wirkungslos, erst PSU-Cycle räumte auf.

**Empfehlung:** Für Macro-Config-Änderungen `sudo systemctl restart klipper` statt FIRMWARE_RESTART verwenden. FIRMWARE_RESTART bleibt separates Diagnose-Thema (siehe [[05 Daily Notes/2026-04-27]] Spät-Abend-Update).

## Update 2026-04-30 — Servo-Test in der Luft mit D2-USBSERIAL-Topologie

**Befund:** Soft-Ramp 52°→125°→52° in vier Schritten ohne Tool-Last läuft sauber durch. Klipper bleibt `ready`, kein Crash, kein Hang, keine Watchdog-Trigger.

**Aussagekraft:**
- ✅ Servo-PWM-Pfad selbst stresst gs_usb in der USBSERIAL-Topologie nicht signifikant
- ✅ D2-Rollback hat den Pfad robuster gemacht (am 28.04. crashte derselbe Bewegungsablauf in der Hybrid-Bridge-Topologie)
- ❓ Lock-Schließen unter Federspannung mit Tool-Last — unbestätigt. Der historische Crash-Trigger bei 87° unter Last wurde nicht reproduziert, weil keine Federspannung am Lock-Mechanismus war.

**Konsequenz für Stage 09:** Risiko ist gesunken, aber nicht null. UBEC bleibt empfohlene Hardware-Mitigation, weil der Stromspike-Pfad strukturell unverändert ist (gemeinsame 5V-Schiene Servo+EBB36).

## Hardware-Lösungen (parallel, langfristig)

Soft-Ramp ist Software-Mitigation, nicht Root-Cause-Fix. Power-SPoF bleibt. Hardware-seitig:
- Servo dedizierte 5V-Versorgung (separat vom USB-Hub)
- Servo-Kabel mit Ferrit-Kern gegen EMI-Einkopplung
- USB-Hub mit besserem Netzteil
- Pi-Port direkt belastet vermeiden (USB-Hub als Puffer)

## Verknüpfungen

- [[04 Ressourcen/Klipper/ProForge5 Pinout]] — Servo am `ebb:PB5`
- [[04 Ressourcen/Klipper/EBB36 Gen2 Board-Wissen]] — Lock-Mechanik-Details
- [[05 Daily Notes/2026-04-27]] — Marathon-Saga + Verifikations-Lauf
- [[02 Projekte/ProForge5 Build/ProForge5 Build]]

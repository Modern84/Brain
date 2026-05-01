---
typ: session-ende
status: abgeschlossen
priorität: B
datum: 2026-04-27
tags: [proforge5, hardware, u2c, lessons, diagnose-detour]
abgrenzung: NICHT Reiner-WEC
ersetzt: "Session-Ende 2026-04-27 — U2C V2 hardware-tot.md"
---

# Session-Ende 2026-04-27 — U2C-Diagnose-Detour

> **Korrektur-Hinweis:** Diese Notiz ersetzt die ursprüngliche Notiz „Session-Ende 2026-04-27 — U2C V2 hardware-tot.md", die auf einer **falschen Diagnose** basierte. U2C V2 lebt — Kabel-Wackler war die Ursache. Die alte Notiz wurde mit Korrektur-Hinweis überschrieben.

## TL;DR

Pickup von Tool 1 (PH1) am ProForge5 mechanisch erfolgreich mit `zero_select_x = -99`. Direkt nach Pickup CAN-Bus-Crash. **Falsche Erst-Diagnose:** „U2C V2 hardware-tot" → 2h Recovery-Detour. **Korrekte Diagnose** (durch Mo's Push-Back ausgelöst): Kabel-Wackler + möglicher gs_usb-Software-Stuck (CVE-2025-68307). Mit neuem USB-Kabel → U2C sofort wieder lebendig.

**Recovery durchgeführt:** Tool manuell zurück in PH1-Picker, alle Sensoren konsistent, Drucker am Session-Ende sauber im Idle-State.

**Wichtigster Bonus-Befund:** Sensor-Pin-Verkabelung am EBB36 ist invers zur Klipper-Tool-Index-Konvention. Macro-Bewegungen sind korrekt, aber Pre/Post-Sensor-Checks fragen den falschen Slot.

## Was geschafft wurde

✅ **`zero_select_x = -99` als korrekt verifiziert** für PH1 (visuell + manuell durch Mo bestätigt)

✅ **Pickup SELECT_PH1 mechanisch funktioniert** — Trajektorie sauber, Servo-Lock greift Tool 1, hält formschlüssig

✅ **EBB36 GEN2 V1.0 Servo-Lock hält Tool ohne aktive PWM** — bestätigt durch Klipper-Shutdown-Phase, kein Tool-Drop

✅ **U2C V2 lebt** — drei LEDs aktiv (2× grün + 1× blau), `Bus 001 Device 016: ID 1d50:606f`, TX-Counter steigt bei `cansend`

✅ **Recovery ohne Power-Cycle** — manueller Workflow mit M84 (Steppers off) + Hand-Schieben + gezielter Servo-Open hat Tool sicher zurück in PH1 gebracht

✅ **Toolchanger-Macro-Logik defensiv programmiert verifiziert:**
- `_PRE_SELECT_VERIFY` blockiert Pickup wenn `carriage_tool_sensor` PRESSED oder `tX_dock_sensor` nicht PRESSED
- `_delayed_post_select_check` meldet `pickup_failed_*` mit konkretem Symptom-Text
- `_TOOLCHANGER_PAUSE` setzt Klipper in Pause-State (kein Hardware-E-Stop)

## Diagnose-Detour: was ich falsch gemacht habe (Claude.ai)

Drei Lücken in der Erst-Diagnose, die zu fälschlicher „Hardware-tot"-Aussage führten:

1. **USB-Kabel nie getauscht** — wir steckten den U2C an verschiedene Pi-Ports, aber immer mit demselben Kabel. **Häufigste USB-Disconnect-Ursache nicht ausgeschlossen.**

2. **Cross-Computer-Test nicht gemacht** — kein Test ob U2C an einem anderen Rechner als `1d50:606f` erkannt wird. Ohne diesen Test ist „U2C tot" nicht gerechtfertigt.

3. **CVE-2025-68307 nicht gecheckt** — bekannter gs_usb-Kernel-Bug, gepatched Ende Dezember 2025: „failed to xmit URB ... silently consume transmit URBs and eventually halt CAN transmission". **Exakt das Symptom.** Plus möglicherweise nicht im Pi-Kernel 6.12.75-1+rpt1 vom 11.03.2026 enthalten — muss verifiziert werden.

**Mo's Push-Back war die Wendung:** „Einmal gegriffen + tot? Kann nicht sein, dann passiert das ja immer wieder beim nächsten Mal." Daraufhin Web-Search + Kabel-Tausch → sofortige Auflösung.

**Lehre für Claude.ai:** Bei Hardware-Themen aktiv web-search ziehen statt Mo nach Beschriftungen/Positionen fragen. Plus: vor jedem „X ist kaputt"-Verdikt die offensichtlichen Diagnose-Schritte abhaken (Kabel, Cross-Computer, Web-Search nach Symptom-Pattern).

## Recovery-Sequenz die funktioniert hat

| Schritt | Aktion | Wer | Ergebnis |
|---|---|---|---|
| 1 | Klipper start, can0 up, TX-Test | CC | TX 0→1 ✅, Klipper ready, EBB connected |
| 2 | Steppers via M84 stromlos | CC | Schlitten frei beweglich ✅ |
| 3 | Schlitten von Hand zu PH1-Picker schieben | Mo | Tool über leerem Picker positioniert ✅ |
| 4 | Servo auf DOCK (52°), Lock öffnet | CC | Tool kann gelöst werden ✅ |
| 5 | Tool 1 manuell vom Schlitten nehmen, in PH1 setzen | Mo | „hat einwandfrei funktioniert" ✅ |
| 6 | Schlitten wegschieben, Servo zurück auf SELECT (125°) | Mo+CC | Default-Stellung ✅ |
| 7 | Sensor-Verifikation alle 5 Dock-Sensoren + carriage | CC | alle PRESSED + carriage RELEASED ✅ |

**Lehre:** EBB36 GEN2 V1.0 Servo-Lock hält Tool formschlüssig auch ohne PWM. Heißt: Recovery ohne Power-Cycle möglich. Der Workflow ist:
1. Klipper hochfahren ohne Bewegung
2. M84 → Steppers passiv
3. Mo schiebt Schlitten von Hand zum Ziel-Picker (Augenmaß)
4. Erst dann gezielt Servo öffnen (Tool ist physisch im Picker geführt, fällt nicht)
5. Tool manuell zurück in Picker
6. Servo zurück auf SELECT (Default), Sensor-Verify

**KEIN G28 mit aufgenommenem Tool** — Eddy-Z-Offset wurde gegen Schlitten kalibriert, mit Tool dran könnte Düse bei Z-Home zu nah ans Bett kommen.

## Bonus-Befund: Sensor-Mapping invers verkabelt

Während der Sensor-Verifikation (Tool noch am Schlitten in PH1-Position): `t4_dock_sensor` RELEASED, alle anderen PRESSED. Nach Recovery (Tool zurück in PH1): alle 5 PRESSED. **Heißt: t4_dock_sensor entspricht physisch PH1, nicht PH5.**

| Klipper-Sensor | Macro-Index | Mo's PH | Y-Position |
|---|---|---|---|
| t0_dock_sensor | T0 | **PH5** | y=414 (hinten) |
| t1_dock_sensor | T1 | PH4 | y=312.5 |
| t2_dock_sensor | T2 | PH3 | y=211 |
| t3_dock_sensor | T3 | PH2 | y=109.5 |
| t4_dock_sensor | T4 | **PH1** | y=8 (vorne) |

**Konsequenz:** Pickup-Macro `SELECT_PH1` fährt physisch korrekt nach Y=8 (vorne). Aber `_PRE_SELECT_VERIFY TOOL=0` checkt `t0_dock_sensor` — was tatsächlich PH5 abfragt. Heute hat das funktioniert weil PH5 belegt war (Pre-Check fand PRESSED, durfte starten). Aber `_delayed_post_select_check` wäre fälschlich fehlgeschlagen, weil sie nach PH1-Pickup `t0_dock_sensor` RELEASED erwartet — der ist aber weiterhin PRESSED weil PH5 belegt. CAN-Crash hat verhindert dass dieser False-Negative-Check uns blockiert hätte.

**Fix-Optionen:**
- **(a) Verkabelung am EBB36 PROBE-Header umstecken** (t0/t4 tauschen, t1/t3 tauschen) — Hardware-Arbeit
- **(b) `printer.cfg` umkonfigurieren** in den `[gcode_button t*_dock_sensor]` Sektionen die Pin-Zuordnung tauschen — reversibel, keine Hardware-Arbeit

Variante (b) ist sicherer. Vor Stage 07.4 Final-Test fällig.

## Drucker-Stand Session-Ende — sauber

| Komponente | Status |
|---|---|
| Klipper | `ready`, alle MCUs connected |
| can0 | UP, ERROR-ACTIVE, TX-Test grün |
| U2C V2 | lebendig auf USB-2.0-Port am Pi 5 (mit neuem Kabel) |
| Tools | alle 5 im Dock, Sensor-Mapping konsistent (alle PRESSED) |
| Schlitten | frei, Servo SELECT (125°) Default |
| Steppers | nach M84 passiv |
| Z-Achse | selbsthemmend |
| 24V-PSU | unverändert an |

**Drucker bereit für nächste Session** — kein Recovery-Schritt offen.

## Lessons Learned (zusammengefasst)

### Hardware
1. **`gs_usb -EPIPE` ≠ Adapter-Hardware-Tod.** Kann Kabel-Wackler oder Software-Bug (CVE-2025-68307) sein. Kabel-Test + Cross-Computer-Test + CVE-Check vor jedem „tot"-Verdikt.
2. **EBB36 GEN2 V1.0 Servo-Lock hält Tool formschlüssig auch ohne aktive PWM** — Recovery ohne Power-Cycle möglich.
3. **EBB36 GEN2 V1.0 RST/BOOT-Buttons sind auf der Rückseite** („relocated for convenient access" laut BTT-Wiki). Kein USB-C am Board — USB nur über externen Adapter.
4. **CAN-Bus-Topologie hat zwei Failure-Modes:** (a) Hub-USB-Disconnect unter Strom-Spitzen, (b) CAN-Layer-Stuck unter EMI-Last + gs_usb-Bug. Beide Software-fixbar bzw. mitigierbar (Watchdog, Kernel-Update, Schirmung).
5. **Sensor-Pin-Verkabelung am EBB36 ist invers** zu Klipper-Tool-Index — Fix in printer.cfg vor Stage 07.4 Final-Test.

### Workflow
6. **Drei-Layer-Workflow funktioniert auch in Recovery-Stress:** Mo Ground Truth, Claude.ai plant Stop-Punkte, CC führt aus mit Sicherheits-Vetos. CC's Veto vor blindem Servo-Open hat Tool-Drop verhindert.
7. **Bei Hardware-Themen direkt web-search ziehen** statt Mo nach Beschriftungen/Positionen fragen — fauler Reflex, der Mo's Zeit verbrennt.
8. **Vor „X ist kaputt"-Verdikt: Diagnose-Checkliste durchgehen.** Kabel, Cross-Computer, Web-Search nach Symptom. Drei einfache Tests die teure Fehl-Bestellungen verhindern.
9. **Memory-Limit (30/30) blockiert neue Lessons** — Konsolidierungslauf nötig, Lessons müssen primär in Vault leben.

## Verknüpfungen

- [[05 Daily Notes/2026-04-27]]
- [[02 Projekte/ProForge5 Build/ProForge5 Build]]
- [[04 Ressourcen/Klipper/ProForge5 Pinout]]
- [[01 Inbox/Briefing nächste Session 2026-04-27]]
- [[TASKS]]

---
tags: [ressource, klipper, proforge5, emi, mitigation]
status: aktiv
date: 2026-04-28
---

# Servo-EMI-Mitigation — Hardware-Strategien

Software-Mitigation am 2026-04-27 widerlegt: Soft-Ramp 14×50ms, Soft-Ramp 7×150ms und harter 1×125→52-Sprung scheitern alle beim Park (Lock-Engagement um ANGLE 87° herum). Pickup ist mit allen drei Varianten ✅, Park bleibt ❌ — Crash mit `MCU 'ebb' shutdown: static_string_id=Command request` während des kritischen Lock-Übergangs. Kontext: [[Servo-EMI-Mitigation]]. Dieses Dokument bewertet sechs Hardware-Pfade, recherchiert mit Quellen, Bauteilen und Preisen (Stand 2026-04-28). Klappferrit ist parallel bereits beschafft und nicht Teil dieser Bewertung.

Ausgangsbedingungen: Servo MG996R-Klasse am `ebb:PB5` (PROBE-Header), Versorgung vermutlich vom EBB-5V-Rail, EBB36 GEN2 V1.0 (STM32G0B1), CAN über U2C V2 (gs_usb), 1 Mbit Bitrate, MX3.0-Kabel.

## Option 1 — Separate 5V-Versorgung Servo (BEC, GND-Bridge am EBB)

**Wirkprinzip.** MG996R-Lastspitze nicht mehr aus dem 5V-Rail des EBB ziehen. Servo-VCC kommt aus eigenem BEC, Servo-GND wird am EBB-GND gebrückt (sonst PWM-Signal-Referenz fehlt). Spike auf der Servo-Schiene koppelt nicht mehr in CAN-Transceiver-Versorgung und MCU-VDD.

**Spec-Anforderung MG996R.** Datasheet HandsOnTec: Stall 2.5 A bei 6 V; Tower-Pro-Spec 1.4 A; reale Messungen 1.5 A bei 5 V (Arduino-Forum). Beim Lock-Engagement gegen Federspannung ist das Stall-nahe — also Auslegung auf ≥3 A Dauer, ≥5 A Peak. Ripple <50 mV unter Last wünschenswert, weil die 5V-Schiene des EBB sauber bleiben muss.

**Bauteile (Preise 2026-04-28).**
- **Hobbywing UBEC 5A Air V2** — 5/6/7.4 V umschaltbar, 5 A Dauer / 15 A Peak, geschirmtes Gehäuse, „Lowest RF Noise" laut Hersteller. Eingang 2–8S (7,4–33 V) — speist sich am sinnvollsten aus dem 24-V-PSU des Druckers über kurzen Stub. ca. 12–18 € auf Amazon.de; Hobbywing-Direct US 19,99 USD ([Hobbywing](https://www.hobbywing.com/en/products/ubec-5a93)).
- **Pololu D24V50F5** (Alternative, EU-verfügbar via Eckstein/Exp-Tech) — 5 V/5 A Step-Down, 6–38 V Eingang, ca. 22 €. Sauberer, aber teurer.
- **Reichelt-Eigenmarke Step-Down 5V/2A SO8** (Art. 256334, Taiwan-Semi) — knapp dimensioniert, nur als Notnagel ([Reichelt](https://www.reichelt.de/de/de/shop/produkt/step-down-regler_5v_2a_4_5-24vi_so8-256334)).

**Verkabelung.** BEC-Eingang von 24 V-Rail abgreifen (kein Pi-USB). BEC-Ausgang +5 V direkt an Servo-VCC am Servo-Stecker (nicht über EBB-Pin). BEC-GND und Servo-GND beide an EBB-GND-Pin am PROBE-Header. PWM-Signal `PB5` bleibt unverändert.

**Aufwand.** 30–60 Min Verkabelung, kein Löten am EBB selbst. Materialkosten 15–25 €.

**Risiko.** Niedrig. Reversibel. Einziges Risiko: GND-Schleife wenn BEC-GND zusätzlich am Druckerchassis hängt — daher Stern-Masse am EBB, sonst nichts.

**Erfolgs-Schätzung: Hoch.** Adressiert die Root-Cause-Hypothese aus [[Servo-EMI-Mitigation]] direkt: Stromspike auf gemeinsamer Versorgung. EBB-Voron-Community bestätigt, dass Toolhead-EMI über Stromschiene koppelt ([BTT EBB Issue #172 — extruder driver radiates EMI corrupting CAN](https://github.com/bigtreetech/EBB/issues/172)).

## Option 2 — Servo-Tausch MG996R → Digital-Servo mit Strombegrenzung

**Wirkprinzip.** MG996R ist Analog-Servo billiger Klasse, 50 Hz PWM, kein Soft-Start, keine interne Strombegrenzung. Digital-Servos der Mittelklasse takten intern mit 200–333 Hz und haben oft konfigurierbare Strom-Caps oder mindestens sanftere Anlauframpen.

**Modelle (≥9 kg·cm, Standard-Size 40×20×37 mm, kompatibel mit Lock-Mechanik).**
- **Savox SC-1258TG+** — Coreless Digital, 12 kg·cm @ 6 V, 0,08 s/60°, Titan-Getriebe, 64 g. Ca. 65–80 € ([Savox](https://savox-servo.com/en/product/SC-1258TGplus/savox-servo-sc-1258tg-digital-coreless-motor-titanium-gear)). Beste Verarbeitung, aber teuer und immer noch ohne dokumentierten Strom-Cap.
- **Hitec HS-485HB** — Karbonite Gear, 6 kg·cm @ 6 V, 0,18 s/60°, 45 g. Ca. 25–30 € ([Chief Aircraft 28,99 USD](https://www.chiefaircraft.com/hit-hs-485hb.html)). Drehmoment knapp; wenn 6 kg·cm reichen, sehr robuster Servo.
- **FEETECH STS3215** — Serial-Bus-Servo (TTL), 19 kg·cm @ 7,4 V, **dokumentierte Überstrom-Schutzfunktion bei 2 A für 2 s, einstellbare Strom-Schwelle**, Magnetencoder mit Positions-Feedback ([FEETECH](https://www.feetechrc.com/2020-05-13_56655.html)). Ca. 25–35 € auf Amazon.de. **Nicht plug-in-kompatibel** — TTL-Bus statt PWM, braucht UART-Anbindung am EBB. Würde aber den Crash-Pfad eliminieren, weil der Servo seinen Strom selber regelt.

**Aufwand.** Plug-in-Tausch (Savox/Hitec) 15 Min. STS3215-Umbau ~2 h plus Klipper-Macro-Umbau auf serielle Ansteuerung (kein Standard-Klipper-Modul, manueller MCU-Pin oder externer Controller).

**Risiko.** PWM-Tausch reversibel und niedrig. STS3215 mittel — weicht von Klipper-Standardpfad ab.

**Erfolgs-Schätzung: Mittel** (für PWM-Digital-Tausch) — adressiert Symptom-Schärfe (sanfterer Anlauf), aber nicht die Root-Cause auf der Stromschiene. **Hoch** für STS3215 — dort ist Stromregelung in der Spezifikation, Anlauf-Spike fundamental gedämpft. Quellenlage: keine Klipper-Forum-Berichte, dass MG996R-Tausch allein CAN-Crashes löst — Symptom verschwindet nur wenn Stromspike weg ist.

## Option 3 — TVS-Diode + RC-Snubber direkt am Servo-Stecker

**Wirkprinzip.** Zwei separate Mechanismen am Servo-Anschluss: (a) bidirektionale TVS klemmt Spannungsspitzen oberhalb 6,4 V auf max. 9,2 V Clamp, schützt EBB-5V-Rail vor Rückwirkung wenn Servo-Bürsten-Kommutierung Spikes induziert; (b) RC-Snubber (Serien-RC parallel zur Versorgung) dämpft das hochfrequente Bürstenrauschen, das sonst kapazitiv in benachbarte CAN-Leitungen koppelt.

**Bauteile (Preise 2026-04-28).**
- **Bourns SMBJ5.0CA** — bidirektionale TVS, 5 V Standoff, 9,2 V max. Clamp, 600 W Peak Pulse, SMB-Gehäuse ([DigiKey 0,52 USD](https://www.digikey.com/en/products/detail/bourns-inc/SMBJ5.0CA/2254200)). Reichelt führt SMBJ-Serie ab ca. 0,30 €. **Platzierung: Servo-VCC ↔ Servo-GND, so dicht wie möglich am Stecker (≤20 mm Lead-Länge).**
- **RC-Snubber** — 100 nF Folienkondensator (X7R Keramik akzeptabel, ≥25 V) + 10 Ω Metallfilm-Widerstand 0,5 W in Serie, parallel zur Servo-Versorgung. Wert-Empfehlung deckt sich mit der Standard-Empfehlung für induktive Lasten unter 1 kHz PWM ([Cadence — RC Snubbers](https://resources.pcb.cadence.com/blog/rc-snubbers-and-rcd-clamps-for-isolated-dc-dc-converters), [Institution of Electronics — RC snubber guide](https://institutionofelectronics.ac.uk/a-hands-on-guide-for-rc-snubbers-and-inductive-load-suppression/)). Reichelt: <1 € zusammen.

**Mini-Schaltbild (am Servo-Stecker).**
```
   EBB +5V ──┬───────────┬─────── Servo VCC
            │           │
          [TVS]      [100nF]
        SMBJ5.0CA      │
            │       [10Ω]
            │           │
   EBB GND ─┴───────────┴─────── Servo GND
```

**Aufwand.** 30 Min Lötarbeit am Servo-Kabel oder kleine Lochrasterplatine direkt am PROBE-Stecker. <2 € Material.

**Risiko.** Niedrig. Reversibel.

**Erfolgs-Schätzung: Niedrig–Mittel.** Adressiert HF-Bürstenrauschen und Induktions-Spikes, aber **nicht** den DC-Stromzug-Spike auf der 5V-Schiene, der die wahrscheinlichere Crash-Ursache ist (Lock-Engagement gegen Feder = Stall-nahe Last über mehrere hundert ms, nicht µs-Spike). Sinnvoll als **Add-on zu Option 1**, nicht als Stand-alone.

## Option 4 — CAN-Bus-Härtung (Terminierung, Schirmung, Bitrate)

**Wirkprinzip.** Reflexionen und EMI-Einkopplung auf der CAN-Leitung selbst minimieren. Drei Hebel:

**4a — Terminierung verifizieren.** ISO 11898 verlangt 120 Ω an beiden Bus-Enden, parallel ergibt 60 Ω ([Industrial Monitor Direct — CAN Termination](https://industrialmonitordirect.com/blogs/knowledgebase/can-bus-network-termination-resistor-specifications-practical-implementation-and-troubleshooting)). EBB36 GEN2 hat Jumper für 120 Ω; U2C V2 hat ebenfalls Termination-Jumper. **Pflicht-Check mit Multimeter im stromlosen Zustand zwischen CANH und CANL: 60 Ω = beide gesetzt ✅, 120 Ω = nur einer ❌, andere Werte = falsch.** Voron-Forum dokumentiert konkreten Fall: lockerer Jumper am 120R des EBB36 → 690 bytes_retransmit → nach Fix 27 h stabil ([Klipper Discourse — bytes_retransmit & shutdown](https://klipper.discourse.group/t/bytes-retransmit-increases-and-transition-to-shutdown-state-mcu/25386)).

**4b — Geschirmtes Twisted-Pair, Schirm einseitig auf U2C-Seite an GND.** Standard-CAN-Spec verlangt twisted pair mit 120 Ω Wellenwiderstand. MX3.0-Stecker-Kabel sind oft ungeschirmt. Ersatz: industrielles CAN-Kabel SF/UTP (z. B. L-Com 24AWG 120 Ω, ca. 1,50 €/m) oder Eigenkonfektion mit geschirmtem 2-adrigem Steuerleitungsabschnitt. **Schirm nur auf U2C-Seite an Pi-GND**, nicht beidseitig (Ground-Loop-Vermeidung).

**4c — Bitrate von 1 Mbit auf 500 k oder 250 k.** Niedrigere Symbolrate = größere Augen-Öffnung = robuster gegen EMI-Spikes. Klipper-Discourse-Threads bestätigen dass 1 Mbit bei kurzen Bussen Standard ist, aber 500 k/250 k bei EMI-Problemen helfen kann ([Klipper Discourse — minimum CAN speed](https://klipper.discourse.group/t/what-speed-is-minumum-for-can-bus-setup/6877)). Setzt Re-Flash von Katapult **und** Klipper-MCU-Firmware mit `CONFIG_CAN_BITRATE=500000` voraus, plus `[mcu ebb] canbus_speed: 500000` in printer.cfg. **Auf einem Bus mit nur 2 Knoten (U2C + EBB) ist der Datendurchsatz unkritisch — 500 k reicht locker.**

**Aufwand.** 4a: 5 Min, kostenlos. 4b: 30 Min + ca. 5–10 € Kabel. 4c: 1 h (Firmware-Bauen, Flashen via DFU/Katapult, Config-Anpassung).

**Risiko.** Niedrig (4a/4c reversibel). 4b mechanisch invasiv aber unkritisch.

**Erfolgs-Schätzung: Mittel.** 4a ist **Pflicht-Check** unabhängig von Strategie-Wahl. 4b lohnt nur falls Schirmung fehlt. 4c hat in Voron-Community geholfen, ist aber eher Symptom-Linderung als Root-Cause-Fix wenn der Stromspike die eigentliche Ursache ist. Quelle für EMI-Eingangskopplung am Toolhead bestätigt das Pattern: extruder driver radiates EMI ([EBB Issue #172](https://github.com/bigtreetech/EBB/issues/172)).

## Option 5 — Klipper- / EBB-Firmware-Tuning

**Wirkprinzip.** Höhere CAN-Recovery-Toleranz oder Retransmit-Tuning auf MCU-Seite. Recherche: Klipper hat keinen offiziellen Tunable für CAN-Retry-Schwellen — die Logik in `klipper/src/generic/canbus.c` und `klippy/serialhdl.py` ist hart kodiert. `static_string_id=Command request` bedeutet die EBB-MCU hat einen Befehl angefragt, dessen ID der Host nicht zuordnen konnte — typischerweise Folge von verlorenem/gestautem Frame-Pattern, nicht eigenständiger Bug ([Klipper Protocol-Doku](https://www.klipper3d.org/Protocol.html)).

**Aktueller EBB-Stand laut Memory.** EBB36: v0.13.0-623-dirty. BTT-Repo `bigtreetech/klipper` Branch `stm32g0b1-canbus` ist die Referenz für STM32G0B1-CAN-Support ([BTT EBB GitHub](https://github.com/bigtreetech/EBB)). Klipper main hat den G0B1-Support seit PR #5488 integriert ([Klipper Discourse — Updating EBB36](https://klipper.discourse.group/t/updating-klipper-on-ebb36/19670)). Kein dokumentierter „CAN-Reliability-Fix" aus 2025/2026, der die Crash-Klasse adressiert.

**Was möglich ist.** (a) `[mcu ebb]` `restart_method: command` ist Default, alternativen `restart_method: rpi_usb` ist nur für USB-direkt sinnvoll, hier irrelevant. (b) Saubere Firmware ohne `-dirty`-Suffix flashen — eliminiert Versions-Mismatch-Warnung, beseitigt aber nicht die Crash-Ursache. (c) Klipper main aktualisieren, falls > 6 Monate alt, dann Host und MCUs synchron neu bauen.

**Aufwand.** 1–2 h für sauberen Firmware-Rebuild EBB + Octopus. Kostenlos.

**Risiko.** Niedrig falls Backup vorhanden. Memory-Note: SO3-Boards **nie** mit `flash_usb.py` — Pi-Crash-Risiko.

**Erfolgs-Schätzung: Niedrig.** Sauberer Firmware-Stand ist Hygiene, kein Crash-Fix. Keine Quelle behauptet, dass main-Branch das `static_string_id=Command request`-Pattern unter Lastspike anders behandelt als v0.13.x. Lohnt nur als Begleitmaßnahme zu Option 1 oder 4, nicht als Stand-alone.

## Option 6 — Industrie-Cross-Domain-Patterns

Zwei in CNC/Robotik etablierte Muster, die das Problem fundamental anders angehen.

**6a — Galvanisch isolierter CAN-Transceiver.** TI ISO1042 oder vergleichbare iCoupler-Lösung trennt Bus-Signal-Domain galvanisch von der MCU-Domain (5 kV RMS Isolation, ±70 V Bus-Fault), Stromrückkopplung über GND wird unmöglich ([DigiKey — Isolating CAN Bus Signals & Power](https://www.digikey.com/en/articles/how-to-implement-power-and-signal-isolation-for-reliable-operation-of-can-buses), [Analog AN-770 — iCoupler in CAN](https://www.analog.com/media/en/technical-documentation/application-notes/an-770.pdf)). EBB36 verwendet **keinen** isolierten Transceiver (vermutlich TJA1051 oder vergleichbar, nicht-isoliert). Nachrüsten am EBB ist Platinen-Eingriff (CAN-Transceiver tauschen + isolierter DC-DC für Bus-Side) — **nicht praktikabel** ohne Hardware-Redesign. Industrie-Pattern bestätigt aber die Diagnose: galvanische Kopplung über GND ist die Standard-Versagenklasse, die unsere Symptomatik exakt trifft.

**6b — Dedizierter Servo-Controller mit eigener Power-Domain.** CNC- und Robotik-Welt führt Servos nie direkt am Toolhead-MCU-PWM. Etablierte Boards: **MKS Servo42C/D** (NEMA17 Closed-Loop, eigener STM32, eigene Stromversorgung, FOC, Schritt/Richtung-Eingang vom Host) ([Makerbase MKS-SERVO42C](https://github.com/makerbase-mks/MKS-SERVO42C)). Trinamic TMC4671 (Servo-FOC-Chip, industrielle Anwendung). Pattern: **Logik-Domain (MCU) und Power-Domain (Motor-Treiber) galvanisch getrennt**, Kommunikation nur über Step/Dir oder UART. Übertragung auf unseren Lock-Servo: Lock auf NEMA8/NEMA11-Stepper mit Endlagen-Sensor und MKS-Servo-Driver umbauen — **massiver mechanischer Eingriff**, weit jenseits einer Mitigation, eher Re-Design der Lock-Mechanik. Als Strategie-Pfad ehrlich nur sinnvoll wenn alles andere scheitert.

**Aufwand.** 6a nicht praktikabel (Platinen-Mod). 6b ≥1 Wochenende plus mechanische Anpassung.

**Risiko.** 6a hoch (Hardware-Eingriff), 6b mittel-hoch (Re-Design).

**Erfolgs-Schätzung: Hoch (theoretisch), aber Aufwand:Nutzen-Verhältnis schlecht.** Industrie-Patterns bestätigen die Diagnose und liefern Argumente, dass Option 1 (separate Power-Domain für Servo) die richtige Richtung ist — nur weniger drastisch umgesetzt.

## Option 7 — Drive-Shaft-Manuell-Lock (verworfen)

**Idee.** Servo-PWM-Pfad komplett umgehen: Lock-Mechanik per Hand am Drive Shaft drehen, Servo elektrisch trennen. Damit fällt der Crash-Trigger weg — kein PWM, keine EMI-Einkopplung, kein gs_usb-Down.

**Warum NEIN.**
- **Grub Screw mit Threadlocker.** Cam-Pin-Befestigung am Drive Shaft ist M3×4mm mit Loctite-Klasse-Verklebung (Dozuki Stage 03/04). Lösen = thermisch (>150 °C lokal) oder mechanisch zerstörend. Nicht alltagstauglich.
- **Drive-Shaft-Position muss zur Servo-Null-Stellung passen.** Nach jeder Demontage volle Servo-Lock-Kalibrierung wie bei Werks-Erstmontage. Pro Tool-Wechsel-Zyklus nicht praktikabel.
- **Cam Pin ist Verschleißteil** (~10 000 Wechsel Lebensdauer laut Dozuki). Wiederholte Demontage verkürzt Lebensdauer drastisch.
- **Tool-Wechsel manuell heißt Multi-Tool-Druck nicht möglich.** Fällt damit als Mitigation für den Multi-Tool-Workflow weg, nur noch für Single-Tool-Notbetrieb relevant — und dort reicht der Pfad-D-Patch (`_SERVO_DOCK` als No-Op) ohne mechanischen Eingriff.

**Erfolgs-Schätzung: nicht relevant.** Aufwand-Nutzen schlecht, mechanisch invasiv, Single-Tool-Fall bereits durch Pfad-D-Patch abgedeckt.

## Nachträge 2026-04-28 Abend

### Hypothese — Loser EBB-Mount als EMI-Verstärker

**Beobachtung.** EBB36 sitzt am 2026-04-28 mechanisch nicht satt am Toolhead — sichtbares Spiel, Knistern beim Ausschalten der 24-V-PSU.

**Pro (Verstärker plausibel).**
- Knistern beim Ausschalten = Lichtbogen-Indikator: zeigt schlechten Massekontakt zwischen EBB-GND und Toolhead-Frame
- Schlechte Schirmungs-Anbindung am Toolhead → CAN-Leitung ungeschirmter gegen Servo-PWM-Strahlung
- Schwingungs-Mikrobewegungen unter Druck können Kontakt-Übergangswiderstand modulieren

**Contra (nicht primärer Trigger).**
- `canstat_ebb` durchgehend `bus_state=active rx_error=0 tx_error=0` bis Crash → Bus-Layer sauber, kein klassisches Termination-/Reflexions-Problem
- Failure-Stelle ist gs_usb-Treiber auf Pi-Seite (USB-CAN-Bridge), nicht EBB-MCU oder Bus-Physikalik
- Selbst bei festem Mount würde Servo-PWM-Spike auf gemeinsamer 5V-Schiene weiterhin in U2C koppeln

**Bewertung.** Loser EBB-Mount ist plausibler **Verstärker**, aber **nicht primärer Trigger**. Mount fest schrauben ist Pflicht-Hygiene (Stage 09 Tool-Offset-Probe braucht ohnehin festen Sitz), eliminiert das Crash-Pattern allein aber nicht. **Reihenfolge:** EBB festziehen → BEC einbauen → Termination prüfen, in dieser Reihenfolge.

### Knistern beim Ausschalten — separates Erdungsproblem

Knistern in der PSU-Aus-Phase ist **nicht** dieselbe Klasse wie der Servo-PWM-Crash. Indikator für: schlechte Erdung Drucker-Chassis, Restenergie in Elkos die über schlechten Massepfad entlädt, möglicherweise PE-Anbindung am 24-V-Netzteil unsauber.

**To-Check getrennt:** PE-Verbindung am 24-V-PSU prüfen, Druckerchassis-Massepunkte mit Multimeter gegen Schutzleiter messen (<0,5 Ω), nach Festziehen des EBB-Mounts erneut hören. **Nicht** mit Servo-EMI-Mitigation vermischen — andere Failure-Domain.

### Community-Datenlage 2026-04-28 — dünn

**Recherche-Ergebnis.** ProForge 5 (Kickstarter Aug 2025, Auslieferung Q4 2025/Q1 2026) ist zu jung für belastbare Community-Foren-Daten. Dozuki-Doku, Makertech Discord und ein paar YouTube-Build-Logs sind die Hauptquellen. **Kein dokumentierter identischer Crash-Report** in Discord/Reddit/Klipper-Discourse zum heutigen Stand.

**Was die Community zeigt.**
- EBB36-Disconnects unter Last sind allgemeines Klipper-Pattern (Voron-Forum, BTT-Issues), Lösung dort meist Termination + Schirmung + Power-Domain-Trennung
- Servo-PWM auf EBB-PROBE-Header ist ProForge-spezifisch — vergleichbare Toolchanger (Jubilee, Stealthchanger) nutzen Stepper-basierte Lock-Mechanik, nicht Servo

**Konsequenz.** Community-Daten sind für ProForge 5 nicht load-bearing. Diagnose stützt sich auf eigene Forensik (canstat sauber, gs_usb stirbt zuerst) plus Cross-Domain-Patterns aus Voron/BTT-Welt. Discord-Anfrage bei Makertech ist sinnvoll als zusätzlicher Datenpunkt, aber nicht entscheidungsrelevant für den Hardware-Pfad.

## Empfehlung Top-3

**1 (A — hoch): Option 1 — Separate 5V-Versorgung Servo via Hobbywing UBEC 5A Air V2.** Adressiert die Root-Cause-Hypothese aus [[Servo-EMI-Mitigation]] direkt: Stromspike auf gemeinsamer 5V-Schiene koppelt nicht mehr in CAN-Transceiver-Versorgung. Niedrigster Aufwand (15–25 €, ≤1 h), reversibel, deckt sich mit Industrie-Pattern „separate Power-Domains". Wenn das den Crash nicht löst, ist die Diagnose-Hypothese falsch — und wir lernen mehr als bei jeder anderen Option.

**2 (B — mittel): Option 4a — Termination-Verifikation + ggf. 4c Bitrate auf 500 k.** Pflicht-Check unabhängig von Option 1. Loser 120R-Jumper ist dokumentierte Crash-Quelle in der Voron-Community und kostet 5 Min Multimeter. Bitrate-Reduktion ist saubere Begleitmaßnahme, falls Option 1 nicht zu 100 % stabil läuft.

**3 (C — niedrig): Option 3 — TVS + RC-Snubber als Add-on zu Option 1.** <2 € Material, 30 Min Arbeit, hilft gegen HF-Anteil des Lastspikes, der in benachbarte Leitungen koppelt. Stand-alone zu schwach, in Kombination mit Option 1 die belt-and-suspenders-Lösung.

**Warum nicht Option 2.** Servo-Tausch ist Symptom-Verschiebung. Selbst der STS3215 mit Strom-Cap löst nicht das Grundproblem, dass Servo und CAN-Transceiver auf gemeinsamer Versorgung hängen — er macht das Problem nur kleiner. Doppelter Aufwand (Hardware + Macro-Umbau bei STS3215), höheres Risiko.

**Warum nicht Option 5.** Sauberer Firmware-Stand ist Hygiene, keine Crash-Mitigation. Keine Quelle stützt die Erwartung, dass main-Branch das Pattern anders behandelt. Lohnt nur begleitend.

**Warum nicht Option 6.** Industrie-Patterns bestätigen die Diagnose, aber Aufwand:Nutzen ist schlecht. Option 1 setzt dasselbe Prinzip („Power-Domain trennen") mit 1 % des Aufwands um.

## Verknüpfungen

- [[Servo-EMI-Mitigation]] — vorausgehende Software-Mitigation und Crash-Pfad-Analyse
- [[02 Projekte/ProForge5 Build/ProForge5 Build]] — Projektkontext
- [[05 Daily Notes/2026-04-27]] — Marathon-Saga, Verifikationslauf, Diagnose-Befunde

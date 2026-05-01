---
tags: [ressource, klipper, proforge5, hardware, emi, grounding, ubec]
status: aktiv
date: 2026-04-29
---

# BEC-Erdungs-Konzept ProForge5 — UBEC-Einbau für Servo-EMI-Mitigation

**Zweck:** Pflicht-Vorbereitung vor UBEC-Bestellung. Definiert Topologie, Erdungs-Schema und Kabel-Routing für UBEC als Servo-Versorgung. Verhindert, dass der UBEC-Einbau einen zweiten EMI-Pfad statt einer Mitigation produziert.

## Problem-Setup

Aktueller Crash-Mechanismus: Servo-PWM-Spike beim Lock-Engagement (125° gegen Federspannung) koppelt EMI auf gs_usb-USB-Bridge (Pi → U2C → can0 → EBB36). Symptom: EBB-Self-Shutdown bei jedem Tool-Wechsel. Software-Mitigation widerlegt (Soft-Ramp, Hybrid-Hard-End, Pfad-D-Patch). Hardware-Pfad ist alleinige Option.

Servo zieht 5V aus EBB36-onboard-Regler → Lastspike auf EBB-5V-Schiene → EMI-Welle über GND-Loop und Strahlungspfad in CAN-Trafo am U2C.

## Lösungs-Topologie: UBEC galvanisch vor Servo-PSU, gemeinsame Masse nur am EBB

### Pfad-Skizze

```
┌──────────────┐
│  24V PSU     │──── 24V ───┬─── Octopus VIN
│              │            ├─── EBB36 VIN (über Toolhead-Kabel, CAN+24V)
│              │            └─── UBEC VIN (NEU)
│  GND         │──── GND ───┬─── Octopus GND
│              │            └─── EBB36 GND (über Toolhead-Kabel)
└──────────────┘            

UBEC ───── 5V/6V ─────────── Servo-V+
UBEC ───── GND ──────────────┐
                             │
                             ▼
                        [GND-Sammelpunkt
                         AM EBB36]
                             ▲
                             │
Servo-Signal ────── PB5 ─────┘ (PWM-Rückleiter über EBB-GND)
```

### Kernregel: Star-Ground am EBB36

- **Servo-V+ und Servo-GND kommen vom UBEC.**
- **Servo-Signal (PWM, PB5) referenziert auf EBB-GND.**
- **UBEC-GND wird AM EBB36 mit EBB-GND verbunden — nicht am 24V-PSU, nicht am Octopus, nicht am Pi.**

Begründung: Der Servo-Stromkreis muss kurzschlüssig sein (UBEC-V+ → Servo → UBEC-GND), damit Lastspikes nicht über Toolhead-Kabel und 24V-Schiene fließen. Die einzige GND-Brücke zum EBB ist für den PWM-Rückleiter — diese Brücke darf nur einen Punkt haben, sonst entsteht Ground-Loop.

Star-Topologie ist hier korrekt, weil die Module physisch entkoppelt sind und nur EIN gemeinsamer Punkt bleibt.

## Konkrete Verdrahtung

### Schritt 1 — UBEC-Eingang
- VIN/GND vom UBEC direkt an die 24V-PSU-Klemmen (nicht über Octopus durchgeschleift).
- Kabel: 18 AWG ausreichend für 5A.
- Eingangs-Sicherung 3A inline empfohlen.

### Schritt 2 — UBEC-Ausgang zum Servo

Recherche-Befund 2026-04-29: EBB36 Gen2 V1.0 hat **keine Lötbrücke und keinen Jumper, der onboard-5V vom Servo-Stecker trennt**. Der Servo läuft am PROBE-Header, dessen VCC-Pin über den **Probe-Voltage-Jumper** entweder mit 24V (VIN) oder onboard-5V verbunden wird. Eine "Aus"-Stellung gibt es nicht.

Lösung: **VCC-Pin am PROBE-Header bleibt unbelegt** — Servo-V+ wird über separate UBEC-Leitung zugeführt, nicht über den PROBE-Stecker.

Konkrete Verdrahtung:
- **Servo-Signal (PWM):** bleibt am EBB-PB5 (PROBE-Header Signal-Pin).
- **Servo-GND:** bleibt am EBB-GND (PROBE-Header GND-Pin oder direkt am EBB-GND-Anschluss).
- **Servo-V+:** kommt **NICHT** vom PROBE-VCC-Pin, sondern über separates Kabel direkt vom UBEC-Ausgang.
- **PROBE-VCC-Pin:** bleibt am Servo-Stecker offen (nicht belegen oder Pin entfernen).

Optional zur Absicherung: **Probe-Voltage-Jumper am EBB36 ziehen** — damit ist VCC am PROBE-Header tot, auch wenn ein Anwender später versehentlich den VCC-Pin belegt. Empfohlen, da Jumper-Verlust folgenlos ist (Servo wird ohnehin extern versorgt).

UBEC→Servo-Kabel: 5V und GND als verdrilltes Paar, möglichst kurz (< 30 cm). Stecker am Servo-Ende: das übliche 3-Pin-Servo-Format, V+ und GND vom UBEC, Signal vom EBB-PB5 zusammenführen (Y-Kabel oder gemeinsamer 3-Pin-Stecker).

### Schritt 3 — Star-Ground-Punkt
- UBEC-GND am EBB36-GND-Pin verbinden (gleicher Pin wie der bisherige Servo-GND).
- **NICHT** zusätzlich am 24V-PSU-Minus, **NICHT** am Octopus-GND.
- Kabel-Länge UBEC→EBB möglichst kurz halten (< 30 cm wenn machbar).

### Schritt 4 — Klappferrit am U2C-USB-Kabel
- Kabel Pi → U2C: 1× Klappferrit nahe am U2C-Stecker (≤ 5 cm).
- Optional: 2× Wicklung durch den Ferrit für höhere Dämpfung im 1–10 MHz Bereich.
- Zweck: HF-Dämpfung des EMI-Pfades, der auch nach Servo-Trennung als Restpfad existieren kann.

### Schritt 5 — Optional: Klappferrit am Servo-Kabel
- Wenn nach UBEC-Einbau Restkrise: zweiter Ferrit am Servo-Kabel nahe EBB.

## Was NICHT tun

- ❌ **UBEC-GND zusätzlich an 24V-PSU-Minus klemmen.** Erzeugt Ground-Loop über Toolhead-Kabel. Lastspike fließt durch CAN-GND.
- ❌ **UBEC mit eigenem 5V-Netzteil (separater Wandstecker).** Galvanische Trennung ohne gemeinsame Masse zerstört PWM-Pegel-Referenz. Servo zuckt oder reagiert nicht.
- ❌ **EBB-onboard-5V parallel zur UBEC-5V auf den Servo-Stecker lassen.** Zwei Quellen, eine wird die andere belasten oder zerstören. Trennen ist Pflicht.
- ❌ **USB-Shield am U2C zusätzlich erden.** USB-Spezifikation: Shield ist am Host (Pi) bereits geerdet. Zweite Erdung am U2C = Ground-Loop.

## Verifikations-Schritte vor erstem Tool-Wechsel-Test

1. **CAN-Termination:** PSU aus, U2C ziehen, CANH↔CANL: 60Ω erwartet.
2. **UBEC-Spannung unter Last:** Servo bewegen lassen, Multimeter an UBEC-Ausgang. Sollte stabil bei Sollwert bleiben (kein Einbruch >0.3V).
3. **GND-Kontinuität:** Multimeter Continuity-Mode: UBEC-GND → EBB-GND → 24V-PSU-Minus. Alle drei sollten verbunden sein. Wenn UBEC-GND isoliert ist: Verdrahtung falsch.
4. **EBB-onboard-5V getrennt:** Multimeter zwischen EBB-onboard-5V-Pin und Servo-V+-Pin: kein Durchgang. Wenn Durchgang: EBB-Brücke nicht richtig getrennt, abbrechen.

## Reihenfolge im Realeinbau

1. Drucker komplett stromlos.
2. EBB-Brücke trennen (Jumper/Lötbrücke laut Pinout).
3. Servo-Stecker am EBB neu pinnen (V+ jetzt UBEC-Quelle).
4. UBEC mechanisch befestigen (außerhalb Toolhead-Bewegungsbereich).
5. UBEC-Eingang an 24V-PSU.
6. UBEC-Ausgang zum Servo.
7. Klappferrit am U2C-USB-Kabel.
8. Verifikations-Schritte 1–4.
9. PSU an, EBB-Heartbeat prüfen, Klipper ready abwarten.
10. Manueller Servo-Test über Mainsail (`SET_SERVO ANGLE=52`, dann `ANGLE=125`). Ohne Tool, ohne Pickup-Sequenz.
11. Nur wenn 10 sauber: erster echter Tool-Pickup-Test mit T0.

## Begründungs-Quellen (kondensiert)

- **Star-Ground System-Wiring:** Cadence — gültiges Pattern wenn Module sonst nicht querverbunden sind. ProForge5 erfüllt das.
- **USB-Shield-Behandlung:** XMEGA AVR1017, TI SPRAAR7 — Shield am Pi geerdet ausreichend, zweite Erdung produziert Loop.
- **Servo-PSU-Trennung:** Standard-RC-Praxis (BEC bypass für hochlastige Servos) — separater 5V-Pfad, gemeinsame Masse am Logik-Punkt.
- **Klappferrit am USB:** TI USB 2.0 Board Design Guidelines — Ferrite an VCC und GND zur EMI-Dämpfung.

## Offene Punkte

- EBB36-Gen2-V1.0-spezifisch: **Welche Brücke trennt onboard-5V vom Servo-Stecker?** Vor Einbau Pinout-Brain-File konsultieren.
- UBEC-Output-Spannung: 5.0V oder 6.0V? Servo-Spec von Makertech offen. Default: 5.0V.
- **Hobbywing UBEC 5A Air V2 hat festen 5.0V-Ausgang** — wenn 6V gebraucht: anderes Modell (z.B. QWinOut 8A mit 5.2/6.0/7.4/8.4V Wahl). Kaufentscheidung erst nach Servo-Spec-Klärung.

## Verknüpfungen

- [[Servo-EMI-Mitigation]]
- [[Recovery-Pfade]]
- [[ProForge5 Pinout]]
- [[TASKS]]

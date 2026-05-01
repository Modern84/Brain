---
tags: [ressource, klipper, proforge5, stage-09, tool-offset, recherche]
date: 2026-04-30
status: aktiv
raum: ProForge5
---

# Stage 09 — Tool-Offset-Probe-Recherche

Read-only-Vorbereitung der „Kugelchen-Messung" (Stage 09, MakerTech-Sprech: *Tool Offsets*). **Keine Hardware-Aktion.** Datenbasis: Vault + MakerTech-GitHub-Repo (offizielle Configs).

> **Hinweis:** „Stage 09" ist Brain-/Mo-eigener Begriff. MakerTech-Dozuki dokumentiert offiziell nur Stage 00–08 + Enclosure-Upgrade. Tool-Offset-Kalibrierung ist Teil von Stage 07 (*Checks and Calibrations*) und wird über `calibrate-offsets.cfg` aus dem offiziellen Config-Set gelöst.

---

## 0. Blockier-Kette (vor allen anderen Schritten)

Die Voraussetzungen unten sind keine flache Liste, sondern eine **Kette mit harten Gates**. Ein Glied löst sich erst, wenn das vorherige durch ist.

```
[Bauphase 0] Probe-Hardware physisch da?      ✅ ERLEDIGT 2026-04-30
             M5×20-Schraube am Bett montiert
             + PG10 verdrahtet
             + gcode_button probe_pin_test
               liest State RELEASED idle
                          ↓
[Gate 1]     Servo-Spec-Antwort von MakerTech          ✅ ERLEDIGT 2026-04-30
             MG996R: 4.8V–7.2V, Nominal 6V, Stall-Strom ~2.5A
             Self-researched — Makertech-Support unzuverlässig,
             Spec aus Tower-Pro-Datenblatt + Community konsistent.
             → UBEC auf 6V einstellen, ≥3A Dauerstrom.
             Empfehlung: Hobbywing 5A UBEC (einstellbar 5V/6V)
                          ↓
[Gate 2]     UBEC bestellen + 2-3 Tage Lieferung
                          ↓
[Gate 3]     UBEC verbauen + Klappferrit + BEC-Erdung
                          ↓
[Gate 4]     Stage 07.4 PH2–PH5 Pickup-Verifikation
             (PH1 ist fertig, 27.04.)
                          ↓
[Gate 5]     Hotend-4-Nase richten/ersetzen
                          ↓
[Gate 6]     D2-USBSERIAL 24h-Stabilphase abgeschlossen
             (läuft seit 30.04. 16:37, Endmarke 2026-05-01 ~16:38)
                          ↓
[Aktivierung] tools_calibrate.py nach ~/klipper/Klippy/Extras/
             + calibrate-offsets.cfg in printer.cfg einkommentieren
             + Probe-XY auf reale Position setzen
                          ↓
[Run]        Stage 09 PH1 zuerst, dann PH2…PH5 sequentiell
```

**Bauphase 0 erledigt 2026-04-30:** Probe physisch verbaut + verkabelt, PG10 elektrisch erkannt via `gcode_button probe_pin_test` in `~/printer_data/config/stage09-prep/probe-pin-test.cfg`. Klipper liest Pin als RELEASED (idle, Stahlkugel kein Kontakt). Aktivierung der `[probe]`-Sektion + `calibrate-offsets.cfg` blockiert weiterhin auf Gates 1–6.

**Aktuell offenes erstes Glied:** Gate 2 (UBEC bestellen). Gate 1 self-researched erledigt: MG996R läuft auf 6V Nominal, Stall-Strom ~2.5A. Hobbywing 5A UBEC auf 6V = richtige Wahl. Makertech-Support nicht abwarten.

---

## 1. Hardware-Status der Tool-Offset-Probe

### Probe-Hardware

- **Probe-Pin laut MakerTech-Default `calibrate-offsets.cfg`:** `^PG10` (Octopus-Pin, Pull-Up) ✅ **2026-04-30 verifiziert via `gcode_button probe_pin_test`**
- **Probe-Location laut MakerTech-Stage-10-Doku:** **X80 / Y270** (NICHT X314/Y379 wie in früheren Versionen dieser Notiz — das war aus älterer Quelle abgeleitet)
- **Software-Voraussetzung:** `tools_calibrate.py` muss von [GitHub-Link aus Stage-09-Doku] in `~/klipper/Klippy/Extras/` kopiert + Pi-Reboot, BEVOR `calibrate-offsets.cfg` aktiviert wird
- **Probe-Hardware:** Präzisions-Aluminium-Sockel + Stahlkugel + integrierter Schalter (Werks-Modul, nicht nur Schraube). Verdrahtet zum Octopus-PROBE-Header.
- **Safe-Z:** 26 mm
- **Trigger-Logik:** Düse über Stahlkugel → Berührung schließt Schalter → PG10 auf GND → Z-Trigger
- **Beheizung beim Anfahren:** 150 °C (Nozzle warm, kein Filament-Druck)

### Verkabelungs-Status (Stand 2026-04-30) ✅

- **Probe-Hardware physisch verbaut** — Aluminium-Sockel mit Stahlkugel hinten am Bett mit M5×20 Button-Head verschraubt, Kabel zum Octopus-PROBE-Header gezogen.
- **PG10 elektrisch erkannt** — via `gcode_button probe_pin_test` in `stage09-prep/probe-pin-test.cfg`. Live-State `RELEASED` (idle, kein Kontakt). Pin liest als Pull-Up-Input.
- **`[probe]`-Sektion noch nicht aktiv** — `[include calibrate-offsets.cfg]` ist auskommentiert. So gewollt, bis Gates 1–6 durch sind.
- **Schalter-Funktionstest am Drucker noch offen** — manuell Stahlkugel drücken, State muss von RELEASED → PRESSED wechseln. Per Mainsail-Konsole: `QUERY_BUTTON BUTTON=probe_pin_test`. Dauert 5 Min am Drucker.

### [[ProForge5 Pinout]] aktualisiert

Probe-Pin-Eintrag in der Single-Source-of-Truth: `Tool-Offset-Probe → ^PG10 → PROBE-Header → NO mit Pullup, schließt bei Kugel-Kontakt → verifiziert 2026-04-30`.

### Status-Bewertung

```
✅ Probe-Hardware-Anschluss: VERIFIZIERT 2026-04-30
   → Aluminium-Sockel mit Stahlkugel am Bett verschraubt,
     Kabel zu Octopus-PROBE-Header, PG10 elektrisch erkannt.
     Schalter-Funktionstest 17:45–17:57 sauber:
     RELEASED ↔ PRESSED beide Richtungen via
     QUERY_BUTTON BUTTON=probe_pin_test verifiziert.
🟡 calibrate-offsets.cfg: VORHANDEN aber AUSKOMMENTIERT in printer.cfg
   → einkommentieren erst NACH Gates 1–6 (Servo-Spec, UBEC, etc.).
✅ tools_calibrate.py: auf Pi unter ~/klipper/klippy/extras/
   → 2026-04-30 18:26 aus viesturz/klipper-toolchanger gezogen,
     Sicherheits-Check sauber, py_compile OK, schläft bis
     FIRMWARE_RESTART bei Stage-09-Aktivierung.
```

---

## 2. MakerTech-Doku Stage 09

- **GitHub-Repo:** https://github.com/Makertech3D/ProForge-5
- **Config-Datei:** `Config Files/calibrate-offsets.cfg` (offiziell)
- **Default-Werte aus der Doku:**
  - Calibration Pin: `^PG10`
  - Probe-Position: X314 / Y379
  - Safe-Z: 26 mm
  - Travel-Speed: 20 mm/s
  - Descent-Speed: 0,50 mm/s
  - Sample-Tolerance: 0,1 mm
  - Samples: 2 (Median)
  - Heat: 150 °C
- **Macros (laut Repo-Inhalt):** je `T0..T4` ein Select+Dock-Macro, gemeinsamer `_CALIBRATE_MOVE_OVER_PROBE`-Helper, gespeichert via `save_variables`.

> Detaillierte Macro-Bodies wurden nicht aus dem Web-Fetch extrahiert. Bei Aktivierung: Datei direkt aus GitHub auf den Pi ziehen und Diff gegen aktuelle `printer.cfg` machen, bevor inkludiert wird.

---

## 3. Klipper-Macro-Skelett

> **Skelett, KEINE finalen Werte.** Probe-XY und Tool-Offsets werden beim echten Run am Drucker bestimmt.

```ini
# In printer.cfg aktivieren:
[include calibrate-offsets.cfg]

# Aus calibrate-offsets.cfg (MakerTech-Default, gekürzt/Skelett):
[probe]
pin: ^PG10
x_offset: 0
y_offset: 0
#z_offset: <SAVE_CONFIG füllt das>
speed: 0.5
samples: 2
sample_retract_dist: 2.0
samples_tolerance: 0.1
samples_tolerance_retries: 3
samples_result: median

[gcode_macro _CALIBRATE_MOVE_OVER_PROBE]
gcode:
  G90
  G0 Z{params.SAFE_Z|default(26)} F2400
  G0 X{params.PROBE_X|default(314)} Y{params.PROBE_Y|default(379)} F12000

[gcode_macro CALIBRATE_TOOL_OFFSETS]
description: 5-Tool-Sequenz, alle PHs nacheinander
gcode:
  # Voraussetzung: Bett-Mesh aktiv, Z bekannt, alle 5 Tools
  # in ihren Parkplätzen, Carriage leer.
  {% for t in [0, 1, 2, 3, 4] %}
    SELECT_PH{t+1}
    M104 S150 T{t}
    M109 S150 T{t}
    _CALIBRATE_MOVE_OVER_PROBE
    PROBE_CALIBRATE              # interaktiv, ODER:
    # alternativ: CALIBRATE_TOOL_Z TOOL={t} (MakerTech-spezifisch)
    SAVE_VARIABLE VARIABLE=tool{t}_z VALUE={printer.probe.last_z_result}
    DOCK_PH{t+1}
  {% endfor %}
  M104 S0
  SAVE_CONFIG
```

**Klipper-Standard-Mechanismen, die genutzt werden:**
- `[probe]`-Sektion mit `^PG10`
- `PROBE_CALIBRATE` (Klipper-Built-in) ODER MakerTech-eigene `CALIBRATE_TOOL_*`-Macros
- `SAVE_VARIABLE` für Persistierung in `variables.cfg` (Mo nutzt das schon für `zero_select_x` — bekanntes Muster)
- `SAVE_CONFIG` für `[probe] z_offset` schreiben

---

## 4. Reihenfolge-Empfehlung

**Empfehlung: PH1 zuerst.**

Begründung aus Vault-Daten:
- **PH1 Stage 07.4 Pickup-Mechanik verifiziert** ✅ am 27.04. — `zero_select_x = -99` mechanisch + visuell durch Mo bestätigt, Servo-Lock formschlüssig, Tool hält ohne PWM ([[05 Daily Notes/2026-04-27]]).
- PH3 hat zwar früheren Stage-07-Status, aber **PH1 hat die jüngste Realitäts-Verifikation** durch Mo-Sichtcheck. Brain-Regel: jüngste Daily-Note = Ground Truth.
- **Reihenfolge:** PH1 → PH2 → PH3 → PH4 → PH5. Sequentiell, nicht parallel — bei jedem Tool: Pickup, Probe, Z-Z-Offset speichern, Dock, Verifikation der Sensoren (Carriage/t-Sensor), erst dann nächstes Tool.
- **Abbruch-Kriterium:** Wenn ein Tool beim Pickup oder Dock crasht (gs_usb-Down, Servo-EMI), Sequenz stoppen — Servo-EMI-Mitigation greift NICHT.

---

## 5. Voraussetzungen vor dem echten Run

### Hardware (alle Pflicht)

- [ ] **Servo-EMI-Mitigation aktiv** — UBEC verbaut, Klappferrit am MX3.0-Kabel. Siehe [[Servo-EMI-Mitigation]] und [[BEC-Erdungs-Konzept]]. **Ohne UBEC kein Stage 09** — jeder Pickup/Dock kann gs_usb-Down auslösen, Sequenz crasht.
- [ ] **Hobbywing UBEC 5A Air V2 / QWinOut 8A** geliefert (ETA 2-3 Tage, Modellwahl blockiert auf Makertech-Servo-Spec-Mail).
- [ ] **Klappferrit montiert** — sekundäre Mitigation.
- [ ] **Hotend-4-Nase richten oder ersetzen** — offen seit 27.04. (Lehrgeld Servo-Open). Sonst Probe-Fehlmessung möglich.
- [ ] **M5×20 Probe-Schraube physisch installiert** + Mo-Sichtcheck Verkabelung `PG10` am Octopus.
- [ ] **Carriage-Sensor-Hardware sauber** — am 26.04. permanent PRESSED, am 27.04. durch Stecker-Reinitialisierung gefixt ([[ProForge5 Pinout]]). Vor Stage 09 erneut `QUERY_ENDSTOPS` + `gcode_button` live-watchen.

### Software / Vault

- [ ] **Stage 07.4 alle 5 Tools sauber** — laut TASKS.md offen: nur PH1 final verifiziert (27.04.), PH2-PH5 stehen aus.
- [ ] **`[include calibrate-offsets.cfg]` in printer.cfg aktivieren** — aktuell auskommentiert.
- [ ] **Backup**: `printer.cfg`, `variables.cfg`, `macros.cfg` vor Aktivierung mit Datums-Suffix sichern (Brain-Standard).
- [ ] **Probe-XY (X314/Y379) gegen Drucker-Realität prüfen** — MakerTech-Default kann je nach Bett-Position abweichen. Mo misst Probe-Schraubposition oder fährt manuell mit `G0` an und korrigiert in `calibrate-offsets.cfg`.

### Bridge / CAN

- [ ] **D2-USBSERIAL 24h-Stabilphase abgeschlossen** (seit 2026-04-30 16:37, Endmarke 2026-05-01 ~16:38) — keine ENOBUFS, alle 7 MCUs durchgehend ready, can0 ERROR-ACTIVE konstant, rx_error=0. Stage 09 fährt Servo + 5 Tools nacheinander, das ist der härteste CAN-Stress-Test bisher.
  - **Hinweis:** Hybrid-Bridge-Plan vom 29.04. wurde am 30.04. um 08:25 per D2-Rollback aufgegeben (Octopus-CAN-Header floating, nie verkabelt). Aktuelle Topologie: Octopus USBSERIAL + EBB36 über U2C/can0, single gs_usb. Bridge-Migration auf Q3 verschoben.
- [ ] **`gs-usb-Watchdog` aktiv** — falls trotz UBEC ein gs_usb-Down auftritt, Watchdog soll auto-recovern.

---

## Offen für Mo / blockiert auf

1. **Hardware-Sichtcheck:** Ist die M5×20-Probe-Schraube am Bett montiert + auf `PG10` verdrahtet? Oder muss das vor Stage 09 erst gebaut werden? — Pinout-Dokument enthält keine Probe-Pin-Zeile, das Pflegt-vermerk fehlt.
2. **Servo-Spec-Antwort von MakerTech** — bestimmt UBEC-Modellwahl (5V vs 6V). Solange offen, kein UBEC bestellt.
3. **Stage 07.4 PH2-PH5** — ohne saubere Pickup/Park-Verifikation aller 5 Tools macht Stage 09 keinen Sinn.
4. **Probe-XY für unseren konkreten Bett-Aufbau** — MakerTech-Default X314/Y379 ist unverifiziert. Beim ersten Run niedrige Speeds + manuell Probe-Position-Check.
5. **Macro-Body von `CALIBRATE_TOOL_OFFSETS`** — vollen Inhalt der offiziellen `calibrate-offsets.cfg` aus dem GitHub-Repo ziehen und in den Vault legen, sobald wir an die Stage-9-Aktivierung gehen. Skelett oben ist abgeleitet, nicht das Original.

---

## Verknüpfungen

- [[ProForge5 Pinout]]
- [[ProForge5 Dozuki Stage 06-07]]
- [[Servo-EMI-Mitigation]]
- [[BEC-Erdungs-Konzept]]
- [[05 Daily Notes/2026-04-27]] (PH1-Pickup-Verifikation)
- [[05 Daily Notes/2026-04-26]] (Carriage-Sensor permanent PRESSED)
- [[02 Projekte/ProForge5 Build/ProForge5 Build]]
- TASKS.md → „Patches die beim nächsten Klipper-Boot greifen → Stage 09 Tool-Offset-Probe"

## Quellen

1. Vault: `printer.cfg.snapshot_20260427_premacrofix`, `ProForge5 Pinout.md`, `ProForge5 Dozuki Stage 06-07.md`, Daily Notes 26.–27. April.
2. MakerTech-GitHub `calibrate-offsets.cfg` (Default-Parameter abgerufen 2026-04-30).
3. MakerTech-Dozuki ProForge_5 (Übersicht — Stage 09 nicht offiziell dokumentiert).

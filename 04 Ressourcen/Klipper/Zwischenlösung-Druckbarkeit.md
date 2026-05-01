---
tags: [ressource, klipper, proforge5, workaround, druckbarkeit]
status: aktiv
date: 2026-04-28
---

# Zwischenlösung Druckbarkeit ProForge 5 (24–48 h Wartezeit BEC/Klappferrit)

**Ziel:** heute drucken können, ohne Park-Crash zu riskieren, ohne auf Hardware zu warten. Single-Tool, Pickup einmal, Park-Pfad sauber neutralisiert. Reversibel in <60 s.

## Verifizierte Realität (live am Pi 18:49 lokal, SSH `m3d@100.90.34.108`)

- **`PRINT_END` / `START_PRINT` existieren NICHT in `macros.cfg`.** ProForge-5-Slicer-Template ruft direkt `_END_PRINT` auf. Quelle: `grep` über `macros.cfg` + `printer.cfg`, kein Match.
- **Auto-Park-Trigger ist `_END_PRINT` Zeilen 28–30:**
  ```
  {% if printer["gcode_button carriage_tool_sensor"].state == "PRESSED" %}
      DOCK
  {% endif %}
  ```
  → Wenn am Druck-Ende ein Tool am Schlitten hängt, läuft `DOCK` → `_DOCK_PHx` → `_SERVO_DOCK` (52° gegen Federspannung). Genau der heute 0× erfolgreich gefahrene Pfad.
- **`CANCEL_PRINT` ruft `_END_PRINT` auf** (Zeile 58) → identischer Park-Trigger.
- **`PAUSE` / `RESUME` parken NICHT.** Pause hebt nur Z, fährt FRONT, speichert Tool-Index. Resume setzt Temperatur und macht Wipe. Kein Servo-Move.
- **`T0`–`T4` sind reine `ACTIVATE_EXTRUDER`-Wrapper.** Kein impliziter Tool-Change-Park. Single-Tool-Slicer-Output (nur `T0`) löst keinen Park aus.
- **Carriage-Sensor jetzt RELEASED** — Schlitten leer, alle 5 Tools im Dock. Saubere Ausgangslage.

## Pfad-Bewertung mit echten Daten

### Pfad A — Manual-Park / Slicer-End-G-Code

**Gemeint:** Slicer-End-G-Code so anpassen dass `_END_PRINT` nicht aufgerufen wird, oder dass der Park-Zweig übersprungen wird.

- **Funktioniert technisch?** Ja — aber: der Slicer-End-G-Code sitzt in OrcaSlicer auf Mo's Mac (nicht auf dem Pi, nichts unter `/home/m3d/printer_data/config/*.ini`). Jeder Slice braucht das Profil. Anfällig gegen Profil-Reset / Update.
- **Reversibilität:** hoch (Profil zurücksetzen).
- **Risiko:** Filament-Out / Spaghetti / `CANCEL_PRINT` über Mainsail-Button ruft trotzdem `_END_PRINT` → Park läuft → Crash. Slicer-Patch deckt nur den happy path.
- **Aufwand:** ~5 min im Slicer.
- **Verdikt:** unvollständig. Schließt die häufigsten Crash-Auslöser (`CANCEL_PRINT`, Filament-Out via M600-Variante) nicht aus.

### Pfad B — Magnetic-Hold / Servo deaktivieren

**Gemeint:** Servo elektrisch trennen, Tool magnetisch fixieren.

- **Funktioniert technisch?** Nein, ohne Hardware-Eingriff. Servo-Lock GEN2 V1.0 hält formschlüssig — Magnete wären redundant. Servo abklemmen heißt: Pickup geht auch nicht mehr (heute aber nötig, Schlitten ist leer).
- **Verdikt:** abgelehnt. Bringt heute keinen Druckfortschritt, weil Pickup blockiert.

### Pfad C — Cam Pin manuell mechanisch verriegeln

- **Funktioniert technisch?** Ja, aber beißt sich mit Pickup. Wer den Cam-Pin fixiert, kann das Tool nicht mehr aufnehmen. Single-Tool-Druck setzt EINEN Pickup voraus.
- **Verdikt:** abgelehnt.

### Pfad D (vierte Option) — Override `_DOCK_PHx` + `_END_PRINT`-Park-Zweig

**Gemeint:** `_END_PRINT`-Park-Zweig per `SET_GCODE_VARIABLE`-Gate ausschalten, `_SERVO_DOCK` zu No-Op machen. Mo parkt Tool am Druck-Ende **per Hand** (Steppers off, Schlitten zum Picker schieben, Servo per Console öffnen, Tool reinsetzen — exakt die heute schon 1× erfolgreich gefahrene Recovery-Sequenz aus [[Recovery-Pfade]]).

- **Funktioniert technisch?** Ja — schließt ALLE Auto-Park-Pfade (`_END_PRINT`, `CANCEL_PRINT`, `DOCK`-Macro). Pickup bleibt unangetastet.
- **Reversibilität:** ein File-Restore aus Backup, ~30 s.
- **Risiko:** Mo muss am Druck-Ende anwesend sein (Single-Tool-Sessions sowieso, Adapter-Drucke sind kurz). Klipper-Crash mitten im Druck → Klipper down, kein Auto-Park möglich (das ist heute schon Realität). Filament-Out → Pause-Macro löst keinen Park aus (bereits verifiziert).
- **Aufwand:** ~3 min Patch + Backup.
- **Verdikt:** **Empfohlen.** Greift unabhängig vom Slicer, deckt alle Trigger ab, lässt Pickup unberührt.

## Konkrete Umsetzung HEUTE (Pfad D)

**Strategie:** Zwei Patches in `macros.cfg`, beide minimal-invasiv:

1. **`_END_PRINT` Park-Zweig auskommentieren** + Hinweis-Log.
2. **`_SERVO_DOCK` zu No-Op machen** (mit Hinweis-Log) — fängt versehentliche `DOCK`-Aufrufe (z. B. via Mainsail-Button oder Macros die ich übersehe) ab. Servo bleibt elektrisch verbunden, nur die Bewegung 125→52 wird unterdrückt.

`_SERVO_SELECT` bleibt unverändert (Pickup-Pfad, heute 4× verifiziert wirksam).

### Backup-Befehl (SSH direkt am Pi)

```bash
ssh m3d@100.90.34.108 'cp /home/m3d/printer_data/config/macros.cfg \
  /home/m3d/printer_data/config/macros.cfg.backup_zwischenloesung_20260428'
```

### Patch (SSH direkt am Pi, ein Block)

```bash
ssh m3d@100.90.34.108 'python3 - <<'"'"'PYEOF'"'"'
import re, pathlib
p = pathlib.Path("/home/m3d/printer_data/config/macros.cfg")
s = p.read_text()

# 1) _END_PRINT: Park-Zweig deaktivieren
old1 = """    {% if printer[\"gcode_button carriage_tool_sensor\"].state == \"PRESSED\" %}
        DOCK
    {% endif %}"""
new1 = """    # ZWISCHENLOESUNG 2026-04-28: Auto-Park deaktiviert (Servo-EMI / Park-Crash)
    # Mo parkt Tool am Druck-Ende manuell. Rueckbau: Backup macros.cfg.backup_zwischenloesung_20260428
    {% if printer[\"gcode_button carriage_tool_sensor\"].state == \"PRESSED\" %}
        M118 ZWISCHENLOESUNG: Tool am Schlitten - bitte manuell parken (Steppers off, Hand-Park).
        M117 Manuell parken!
    {% endif %}"""
assert old1 in s, "END_PRINT Block nicht gefunden - Patch abgebrochen"
s = s.replace(old1, new1)

# 2) _SERVO_DOCK: zu No-Op
old2 = """[gcode_macro _SERVO_DOCK]
gcode:
    SET_SERVO SERVO=toolchanger ANGLE=52
    G4 P1500"""
new2 = """[gcode_macro _SERVO_DOCK]
# ZWISCHENLOESUNG 2026-04-28: No-Op (Park-Crash-Vermeidung)
gcode:
    M118 ZWISCHENLOESUNG: _SERVO_DOCK uebersprungen - manuell parken.
    M117 _SERVO_DOCK skipped"""
assert old2 in s, "_SERVO_DOCK Block nicht gefunden - Patch abgebrochen"
s = s.replace(old2, new2)

p.write_text(s)
print("OK: beide Patches angewendet")
PYEOF'
```

Danach:

```bash
ssh m3d@100.90.34.108 'sudo systemctl restart klipper'
```

(Nicht `FIRMWARE_RESTART` — siehe [[Servo-EMI-Mitigation]] Caveat.)

### Verifikations-Schritte (ohne tatsächlich zu drucken)

In Mainsail-Konsole:

1. **`_SERVO_DOCK`** absetzen → erwartet: nur `M117`/`M118`-Hinweis, KEIN Servo-Move (kein Brummen, Servo bleibt wo er ist).
2. **`_SERVO_SELECT`** absetzen → erwartet: Pickup-Soft-Ramp läuft normal (52→125 in 5°-Schritten). Bestätigt dass Pickup unangetastet ist.
3. **`_END_PRINT`** absetzen bei leerem Schlitten (carriage RELEASED, jetziger Zustand) → erwartet: G28 X Y, Heizungen aus, Park-Zweig wird gar nicht erreicht (carriage nicht PRESSED), normaler Ablauf.
4. **Optional, mit Tool am Schlitten** (nach einmaligem manuellem Pickup): `_END_PRINT` → erwartet: Hinweis „Manuell parken", KEIN `DOCK`-Aufruf, KEIN Servo-Move.
5. **`DOCK`** absetzen direkt → ruft die State-Machine auf, die im happy path `_DOCK_PHx` → `_SERVO_DOCK` (No-Op) ausführt. Erwartet: Trajektorie läuft, Servo bewegt sich nicht, Tool wird mechanisch in den Picker geschoben aber Lock öffnet nicht. **Schritt 5 nur bei leerem Schlitten testen** — nicht mit Tool, sonst landet Tool ungelockt im Picker.

### Rollback-Befehl

```bash
ssh m3d@100.90.34.108 'cp /home/m3d/printer_data/config/macros.cfg.backup_zwischenloesung_20260428 \
  /home/m3d/printer_data/config/macros.cfg && sudo systemctl restart klipper'
```

## Druckteile-Inventar (24–48 h Wartezeit)

PETG, 0.2 mm Layer, Single-Tool (T0):

- **BEC-Mount** für Hobbywing UBEC 5A Air V2 — Modul-Maße laut Hersteller ca. 36 × 17 × 11 mm (vor Druck am echten Modul nachmessen, Hersteller-Maße variieren). Mount mit Lüftungsschlitzen + 2 M3-Bohrungen für Profil-Nutenstein. ~25–40 g, ~1–2 h.
- **Klappferrit-Halter** — Innendurchmesser 5–13 mm gängig, am bestellten Ferrit nachmessen. Klemmschale + Profilschuh. ~10–20 g, ~30–60 min.
- **Optional: TVS+RC-Snubber-Lochrasterhalter** — wenn ohnehin Lötarbeit ansteht. ~15 g, ~45 min.

Realistisch: **2 h Druckzeit total**, kann Mo heute nebenbei laufen lassen während er in Fusion konstruiert.

## Schluss-Empfehlung

**Pfad A abgelehnt** (Slicer-Patch deckt `CANCEL_PRINT` und Mainsail-Buttons nicht ab).
**Pfad B/C abgelehnt** (blockieren Pickup, der heute zwingend ist).
**Pfad D bestätigt** — Override `_END_PRINT`-Park-Zweig + `_SERVO_DOCK` No-Op. Reversibel, deckt alle Auto-Park-Trigger, Pickup bleibt funktional, kein Slicer-Eingriff.

**Patche `_END_PRINT` und `_SERVO_DOCK` direkt in `macros.cfg`.**

## Verknüpfungen

- [[Servo-EMI-Mitigation]]
- [[Servo-EMI-Mitigation-Strategien]]
- [[Servo-Stepper-Umbau-Bewertung]]
- [[Recovery-Pfade]]
- [[02 Projekte/ProForge5 Build/ProForge5 Build]]
- [[04 Ressourcen/Playbook/Anti-Vertagungs-Regel]]
- [[05 Daily Notes/2026-04-27]]

## Annahmen die NICHT verifiziert wurden

- **Slicer-End-G-Code-Inhalt** wurde nicht eingesehen (lebt in OrcaSlicer auf Mo's Mac, nicht auf dem Pi). Annahme: Standard-ProForge-5-Profil ruft `_END_PRINT` auf. Falls das Profil bereits etwas anderes tut, verschiebt sich Pfad A's Bewertung — Pfad D bleibt davon unberührt, weil er an der Klipper-Seite greift.
- ~~**`Servo-EMI-Mitigation-Strategien` und `Servo-Stepper-Umbau-Bewertung`** als verlinkte Notizen nicht im Vault gefunden~~ — Korrektur 2026-04-28: beide existieren, Verlinkungen oben nachgetragen.

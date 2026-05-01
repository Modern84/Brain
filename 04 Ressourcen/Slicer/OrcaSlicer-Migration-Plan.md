---
tags: [ressource, slicer, orca, proforge, drucker, migration]
date: 2026-04-28
status: geplant
priorität: B
raum: drucker
---

# OrcaSlicer-Migration-Plan ProForge 5

## Ausgangslage (Stand 2026-04-28)

- **OrcaSlicer.app** installiert auf Mac
- **Vorhandenes Maschinen-Profil:** `~/Library/Application Support/OrcaSlicer/user/default/machine/ProForge 5.json` (User-Profil, basiert auf "MyToolChanger 0.4 nozzle")
- **Vorhandenes Process-Profil:** `0.20mm Standard @ProForge`
- **PrusaSlicer** ohne ProForge-Profil
- **Kein offizielles Makertech-Profil** für OrcaSlicer öffentlich

**Kontext:** [[02 Projekte/ProForge5 Build/ProForge5 Build]] befindet sich in der Servo-EMI-Mitigations-Phase. Slicer-Migration ist **Wochenend-Projekt**, kein Eilthema.

## Kritischer Befund im existierenden Profil

`change_filament_gcode`:
```
{if previous_extruder >-1}
DOCK_T[previous_extruder]   ; Dock current tool
{endif}
SELECT_T[next_extruder]     ; Select the next tool
G1 Z[layer_z] F24000
```

`machine_end_gcode`: `_END_PRINT`

Tool-Wechsel-Macros (`DOCK_T*`, `SELECT_T*`) im Profil rufen Servo-PWM-Sequenzen → **identische Crash-Klasse** wie [[05 Daily Notes/2026-04-28]] dokumentiert. `_END_PRINT` ist Pfad-D-gepatcht und sicher.

## Migration-Schritte

1. **Aktuellen Slicer eindeutig identifizieren** (Sebastian-Frage) — welcher wurde bisher für ProForge-Drucke produktiv genutzt?
2. **Aktuelles ProForge-Profil sichern** (Export aus aktuellem Slicer als Referenz)
3. **OrcaSlicer-Profil prüfen** — woher stammt das User-Profil? Eigene Erstellung oder Import?
4. **Generic ToolChanger als Vergleichsbasis** in OrcaSlicer laden, mit User-Profil diffen
5. **Test-Profil ableiten:** Single-Tool-only Variante (kein DOCK/SELECT), für sichere Drucke bis Servo-EMI-Hardware-Mitigation eingebaut
6. **Tool-Offsets eintragen** sobald Stage 09 (Tool-Offset-Probe, [[TASKS]]) abgeschlossen
7. **Material-Profile** (PLA, PETG, ABS, ggf. Edelstahl-relevante Druckmaterialien) aufbauen
8. **Test-Drucke** in Reihenfolge: (a) Single-Tool kleines Teil, (b) Single-Tool größer, (c) Multi-Tool **erst** nach erfolgreicher Hardware-Mitigation der Servo-EMI

## Risiken und Mitigation

| Risiko | Mitigation |
|---|---|
| Multi-Tool-Slicing triggert Crash | **Bis Hardware-Mitigation steht: ausschließlich Single-Tool-Profile nutzen** |
| Tool-Offsets im Profil falsch | Erst nach Stage 09 (Kalibrierung) Multi-Tool aktivieren |
| Bed-Mesh-Generierung im Profil aktiv | gespeichertes Mesh per Macro laden statt jedes Mal neu probieren |
| `machine_end_gcode` ruft `_END_PRINT` mit Park | Pfad-D-Patch in macros.cfg fängt das ab — verifiziert 2026-04-28 |
| Ungetestetes Profil in Produktiv-Druck | **Erst nach Test-Druckserie produktiv**, nie für sicherheitskritischen Druck (z.B. EBB-Halter heute) |

## Prusa2Orca-Converter (optional, falls Konversion nötig)

- https://github.com/robertoSreis/Prusa2Orca
- https://github.com/bwees/orca_prusa

Beide sind Community-Tools. **Nur relevant**, falls aus PrusaSlicer ein vorhandenes Profil übertragen werden soll. Da PrusaSlicer **kein** ProForge-Profil hat, entfällt dieser Pfad voraussichtlich. Im Zweifel das aktuell genutzte Slicer-Profil exportieren und manuell in OrcaSlicer nachbauen — sicherer als automatische Konversion bei Toolchanger-Komplexität.

## Test-Kriterien vor Produktiv-Einsatz

Profil ist produktiv-tauglich, wenn:

- [ ] Single-Tool-Druck eines XYZ-Calibration-Cubes ohne Crash durchläuft
- [ ] Bed-Adhesion und First-Layer sauber (Eddy-Coil Z-Offset stimmt)
- [ ] Druck-Bewegungen smooth, kein Klipper-Stutter
- [ ] Klipper-Log während Druck zeigt **keine** `Network is down` / `Lost communication` / `shutdown`
- [ ] `_END_PRINT` läuft sauber durch (Pfad-D-Logik greift, Tool bleibt am Carriage)
- [ ] **Erst nach Servo-EMI-Hardware-Mitigation:** Multi-Tool Calibration mit allen 5 Tools

## Heute-Regel (2026-04-28)

**KEINE Slicer-Umstellung heute.** EBB-Halter-Druck (Sicherheitsthema, Funkenflug-Risiko) **mit dem aktuell genutzten Slicer**, Single-Tool, Pfad-D-Patch aktiv. Migration startet frühestens am Wochenende, parallel zur BEC-Hardware-Mitigation.

## Verknüpfungen

- [[02 Projekte/ProForge5 Build/ProForge5 Build]]
- [[04 Ressourcen/Klipper/Servo-EMI-Mitigation-Strategien]]
- [[04 Ressourcen/Klipper/Zwischenlösung-Druckbarkeit]]
- [[05 Daily Notes/2026-04-28]]
- [[TASKS]]

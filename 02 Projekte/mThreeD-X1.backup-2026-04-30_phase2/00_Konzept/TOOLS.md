---
projekt: mThreeD-X1
abgrenzung: NICHT Reiner-WEC
status: konzept
erstellt: 2026-04-30
---

# Tool-Konzept

## Strategische Entscheidung: Extruder-Tausch > Düsen-Tausch

Filament definiert den Extruder, nicht die Düse. Passive Multi-Düsen-Konzepte mit zentralem Drive liefern keine material-spezifische Drive-Auslegung — TPU braucht andere Kinematik als CF-Compound, PEEK andere Hotend-Thermik als PLA. Der gesamte Extruder pro Tool ist die richtige Granularität.

## Toolchanger-Mechanik

Tool-Pickup pro Kopf über **Wägezelle (Tap-Style-Prinzip)**. Bett-Mesh über separaten Eddy-Current-Sensor (Hybrid-Probe, siehe [[ARCHITECTURE#Probe-Architektur|ARCHITECTURE]]). Mechanik-Detail (Kupplungs-Geometrie, Verriegelung) wird im CAD-Mockup-Schritt festgelegt.

## Tool-Pool: 8–10 total, 4–5 pro Seite fest zugeordnet (D3 final)

Linker Kopf erreicht nur linke Docks, rechter nur rechte. Mirror-Mode wird durch identische Tools auf L1 und R1 realisiert — keine bewegliche Dock-Übergabe.

### Klasse A — Vollständige Toolheads

| Slot | Tool | Verwendung | Phase |
|------|------|-----------|-------|
| L1 | High-Flow Standard 0.4–0.8 | PLA / PETG / ABS | 1 |
| L2 | High-Temp 500 °C | PEEK / PEKK / PEI | 1–2 |
| L3 | TPU-Spezial Constrained-Path | TPU 70A–95A | 1 |
| L4 | CF-/GF-Hardened | PA-CF, PA-GF | 1 |
| L5 | Reserve / Fine-Detail 0.25 | Oberflächen | 1 |
| R1 | High-Flow Standard | Mirror-fähig zu L1 | 1 |
| R2 | Soluble-Support | PVA / BVOH / HIPS | 1 |
| R3 | Pellet-Extruder | Granulat-Direktverarbeitung | 2 |
| **R4** | **Endlosfaser-Tool** | IP-Eigenentwicklung | **2 (reserviert)** |
| R5 | Reserve / Silikon-2K | IP-Eigenentwicklung | 2 |

**D5-Konsequenz:** R4-Slot bleibt in Phase 1 leer. Endlosfaser-Tool wird als eigenständiges IP-Entwicklungsprojekt in Phase 2 nachgerüstet — Phase 1 läuft mit Standard-Tools + Pellet (R3 ebenfalls Phase 2 produktionsreif).

## Tool-Pool-Constraint (D3)

Tools sind seitenweise vor-zugeordnet — die Schlitten erreichen sich nicht ohne Kollision. Material-Planung pro Druck muss diese Zuordnung respektieren. Vorteil: identische Mechanik beidseitig vereinfacht Ersatzteil-Strategie und Service.

## IDEX-spezifische Anforderungen

- Tool-zu-Tool-Offset L↔R muss vision-basiert kalibriert werden
- Drift mit Kammertemperatur kompensieren (KI-Pipeline)
- Pro Kopf eigene Wägezelle für Z-Probing (Hybrid-Probe-Architektur, siehe [[ARCHITECTURE]])
- Bett-Mesh läuft separat über Eddy-Current-Sensor — vom Toolhead entkoppelt

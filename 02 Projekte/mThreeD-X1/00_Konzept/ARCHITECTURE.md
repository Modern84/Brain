---
projekt: mThreeD-X1
abgrenzung: NICHT Reiner-WEC
status: konzept
erstellt: 2026-04-30
---

# Architektur

## Bauraum (D1 final)

- **Druckraum:** 500 × 320 × 400 mm (X × Y × Z)
- **Maschinen-Footprint:** ~720 × 580 × 900 mm
- **Verhältnis X:Y ≈ 1.56** (nahe Goldener Schnitt) — werkstatt-tauglich, deckt 90 % der vorgesehenen Use-Cases ab

## Kinematik-Optionen — Vergleich

| Kinematik | Riemenlänge / Komplexität | Bewegte Bett-Masse | Dual-Gantry-Tauglichkeit | Eignung X1 |
|---|---|---|---|---|
| CoreXY (gemeinsame Riemen) | mittel, verkettet | gering | **nein** — Riemenführung blockiert | ungeeignet |
| CoreXY (zwei separate Systeme) | hoch, doppelte Loops über volle XY-Fläche | gering | möglich, aber bauraum-ineffizient | unattraktiv |
| Bedslinger Cartesian | kurz, einfach | **hoch** (skaliert mit Y-Bauraum) | nein — Bett-Masse explodiert | ungeeignet |
| H-Bot | mittel | gering | nein — Frame-Verzerrung schon Single-Tool | ungeeignet |
| **Cartesian Flying-Gantry, fixes Bett** | kurz, pro Achse separat | **null** (Bett fest) | **ja** — pro Brücke eigener X+Y, getrennt | **gewählt** |

## Kinematik (Auslegung)

- 2× unabhängige Y-Brücken in CNC-Massivbauweise, Carbon-Verbund 18 mm
- 2× unabhängige X-Schlitten, je einer pro Brücke
- Bett bleibt fix
- 4× Z-Spindel (16 mm) mit Closed-Loop-Servo-Antrieb

## Druckmodi

1. **Cooperative-Same-Object** — beide Köpfe parallel an einem Bauteil (Software-Voraussetzung Phase 3)
2. **Material-Parallel** — Hauptmaterial + Stützmaterial gleichzeitig
3. **Multi-Object-Parallel** — zwei Teile gleichzeitig
4. **Mirror/Duplicate** — klassische IDEX-Modi (ab Phase 1 verfügbar)

## Linearführung

- **XY:** Hiwin HG20 oder MGN12H oder größer Class P — finale Auslegung erfolgt im CAD-Mockup-Schritt
- **Y:** 2× parallele Schienen, eine pro Brücke
- **Z:** 16 mm Präzisionslager auf Spindeln

## Antrieb

- **48 V Industrie-Motion-System**
- LDO Closed-Loop NEMA17 oder Servomotoren
- Gates GT3 9 mm Stahlcord pro Achse
- Pro Brücke eigener Y-Antrieb, pro Schlitten eigener X-Antrieb — keine Verkettung

## Probe-Architektur (D2 final, Hybrid)

- **Tool-Pickup pro Kopf:** Wägezelle (Tap-Style-Prinzip) — verifiziert die Pickup-Mechanik und liefert gleichzeitig Z-Probe-Möglichkeit pro Toolhead
- **Bett-Mesh:** Eddy-Current-Sensor (Beacon RevH oder kompatibel) — Sub-Mikrometer-Auflösung, schnelle Mesh-Generierung
- **Tool-zu-Tool-Offset L↔R:** vision-basiert kalibriert, Drift mit Kammertemperatur kompensiert (KI-Pipeline)

## Bett

- MIC-6 Aluminium 20 mm
- Silikon-Heizmatte 3 kW + SSR
- 9-Zonen-Mosfet-Array für lokale Temperatur
- 16× PT100 verteilt
- 4× Wägezellen unter Platte
- ToF-Array (VL53L5CX) für lebende Höhenkarte
- **Magnet-Wechselsystem mit Federstahl-Platten** — kleine verteilte Magnete, Eddy-Current-kompatibel ausgelegt (Konsequenz aus D2). Keine Oversized-Fixed-Magnete, da diese das Eddy-Current-Bett-Mesh stören würden.

## Kammer

- Aktiv beheizt bis 120 °C
- Doppelwandig + Steinwolle-/Aerogel-Isolierung
- HEPA H14 + Aktivkohle-Umluft
- VOC-/Partikel-/CO-Sensorik mit Notabschaltung
- Schmersal AZM200 Türzuhaltung

## Thermik-Hinweis

Carbon-Verbund-Brücken bei 120 °C Kammertemperatur — Datenblätter zu thermischer Ausdehnung und Steifigkeit über Temperatur sind in der [[../03_Review/KINEMATICS-REVIEW|Kinematik-Plausibilitätsprüfung]] zu klären, bevor BOM finalisiert wird.

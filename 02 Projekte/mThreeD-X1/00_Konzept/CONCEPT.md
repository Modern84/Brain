---
projekt: mThreeD-X1
abgrenzung: NICHT Reiner-WEC
status: konzept
erstellt: 2026-04-30
---

# Konzept — Strategische Eckpfeiler

## Anspruch

Industrie-Multi-Tool-IDEX-Drucker als Eigenentwurf von mThreeD.io. Engineering-Anspruch, keine Hobby-Klasse, keine Bastel-Kompromisse.

## Kausalkette als Architektur-Anker

**Cartesian Flying-Gantry mit fixem Bett ist die mechanisch sauberste Lösung für echtes Dual-IDEX mit Toolchanger pro Seite.**

- CoreXY mit gemeinsamen Riemen blockiert Dual-IDEX direkt; zwei getrennte CoreXY-Systeme nebeneinander sind möglich, aber durch doppelte Riemen-Loops über die gesamte XY-Fläche bauraum-ineffizient
- Bedslinger-Cartesian verbietet hohe Beschleunigungen bei IDEX, weil die bewegte Bett-Masse mit den Köpfen multipliziert
- H-Bot zeigt strukturelle Frame-Verzerrung schon bei Single-Tool — Dual-Gantry verstärkt das
- Flying-Gantry mit fixem Bett entkoppelt: pro Brücke eigener Y-Antrieb, pro Schlitten eigener X-Antrieb, kurze unabhängige Riemen

Daraus folgt der Toolchanger pro Seite trivial: zwei vollständig unabhängige Köpfe können jeweils ihren eigenen Tool-Pool ansteuern. Mit 4–5 Tools je Seite stehen 8–10 Materialien gleichzeitig zur Verfügung.

Vergleichstabelle: siehe [[ARCHITECTURE#Kinematik-Optionen|ARCHITECTURE — Kinematik-Optionen]].

## Bauphilosophie

- **Frame** — CNC-Massivbauweise, 12–15 mm Aluplatten als Hauptlast, 48 V Industrie-Motion-System
- **Bauqualität** — Open-Source-FFF auf Industrie-Komponenten-Niveau (BTT-Steuerung, Hiwin-Linearführung, Mean Well-Netzteile, Schurter-Filter)
- **Steuerung** — Klipper vanilla, keine Forks
- **Mechanik** — bewährte Open-Source-Toolchanger-Architektur, eine pro Seite
- **IDEX** — echtes IDEX, beide Köpfe parallel-arbeitend, nicht nur Mirror/Duplicate
- **Bauraum** — 500 × 320 × 400 mm (X × Y × Z), Footprint ~720 × 580 × 900 mm (D1 final, Goldener-Schnitt-Verhältnis X:Y, 90 % Use-Case-Abdeckung, werkstatt-tauglich)

## Strategische Eckpfeiler

1. Engineering-Anspruch, keine Kompromisse
2. CNC-Massivframe mit fixiertem Bett
3. Open-Source-FFF-Bauqualität auf Industrie-Komponenten-Niveau
4. Toolchanger pro Seite, identische Mechanik links und rechts
5. IDEX mit zwei vollständig unabhängigen Köpfen (Dual-Flying-Gantry)
6. Echtes IDEX: parallele Druckmodi, nicht nur Mirror/Duplicate
7. Open Source bleiben (Klipper + OrcaSlicer-basiert)
8. Mehrwert durch Hardware + KI-Service, nicht durch Software-Lock-in
9. Extruder-Tausch über Toolchanger statt passive Multi-Düsen-Konzepte mit zentralem Drive
10. Komplettanbieter-Modell: Drucker + Material + Service in einer Hand
11. **Zwei-Personen-Co-Founder-Setup als bewusste Wahl** — Komplementarität statt One-Man-Show
12. **Maschine 0 als gemeinsame Lernplattform** — intern aufgebaut von Sebastian + Benjamin, Showcase und Test-Bed
13. **IP-Aufteilung wird gemeinsam definiert** — offene Diskussionsgrundlage in [[PARTNERSHIP|PARTNERSHIP]]

## Designentscheidungen D1–D7

Vollständige Begründungen siehe [[../01_Offen/OPEN-DECISIONS|OPEN-DECISIONS]]. Kurzfassung:

- **D1 — Y-Schienen:** zwei parallele Schienen, eine pro Brücke. Bauraum 500×320×400, Footprint 720×580×900. **Final.**
- **D2 — Probe-Architektur:** Hybrid. Tool-Pickup pro Kopf über Wägezelle (Tap-Style-Prinzip), Bett-Mesh über Eddy-Current-Sensor. Konsequenz: Magnet-Bett mit kleinen verteilten Magneten, Eddy-Current-kompatibel. **Final.**
- **D3 — Tool-Pool:** pro Seite eigener Pool, 4–5 Tools fest zugeordnet, identische Mechanik, Mirror-Mode durch identische Tools auf L1+R1. **Final.**
- **D4 — Pfad-Splitter:** Phase-3-Software, nach Hardware-Fertigstellung. Phase 1 läuft mit Standard-IDEX-Modi auf vorhandenem Slicer-Stack. **Final.**
- **D5 — Endlosfaser-Tool:** Phase 2, R4-Slot reserviert. Phase 1 mit Standard-Tools + Pellet. **Final.**
- **D6 — Erste Maschine:** Maschine 0 als Co-Founder-Build (Sebastian + Benjamin) intern bei mThreeD.io. **Final.**
- **D7 — Passive-Düsen-Lizenz:** verzichten. Extruder-Tausch ist die Hauptstrategie, passive Multi-Düsen passen nicht. **Final.**

## Verworfene Pfade

- Single-Tool-Toolchanger ohne IDEX (zu nahe an bestehenden Marktangeboten)
- Reine Mirror/Duplicate-IDEX ohne Toolchanger (zu wenig Material-Bandbreite)
- Eigener Slicer (Open-Source-Strategie, OrcaSlicer-Postprocessor reicht)
- Passive Multi-Düsen-Architektur als Hauptmechanik (Drive nicht material-spezifisch)

## Geschäftsmodell-Anker

X1 ist Premium-Anwendungsfall des [[../04_Service/TUNNEL-SERVICE|mThreeD.io Tunnel-Service]]. Service ist generisch, gilt auch für andere Klipper-Drucker beim Kunden. X1 ist nicht Voraussetzung für den Service.

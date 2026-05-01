---
projekt: mThreeD-X1
abgrenzung: NICHT Reiner-WEC
status: D1–D7 großteils final, einzelne Punkte für gemeinsame Diskussion mit Benjamin offen
erstellt: 2026-04-30
---

# Designentscheidungen D1–D7

Alle sieben Punkte sind in der Konzept-Session 2026-04-30 entschieden. Endgültige Validierung der mechanischen Auslegung erfolgt im CAD-Mockup-Schritt nach Kinematik-Plausibilitätsprüfung. Geschäftsmodell- und Co-Founder-relevante Aspekte (D6) sind in [[../00_Konzept/PARTNERSHIP|PARTNERSHIP]] zur gemeinsamen Diskussion mit Benjamin offen.

## D1 — Y-Schienen-Anordnung

**ENTSCHIEDEN: A — zwei parallele Y-Schienen, eine pro Brücke.**

- Bauraum: **500 × 320 × 400 mm** (X × Y × Z)
- Maschinen-Footprint: ~720 × 580 × 900 mm
- X:Y-Verhältnis ≈ 1.56 (nahe Goldener Schnitt)

**Begründung:** Werkstatt-tauglicher Footprint, deckt 90 % der vorgesehenen Use-Cases ab. Vollständig getrennte Brücken vermeiden Schlitten-Interferenz und vereinfachen Bewegungsplanung.

## D2 — Toolchanger-Mechanik / Probe-Architektur

**ENTSCHIEDEN: Hybrid-Lösung.**

- **Tool-Pickup pro Kopf:** Wägezelle (Tap-Style-Prinzip)
- **Bett-Mesh:** Eddy-Current-Sensor (Beacon RevH oder kompatibel)

**Begründung:** Wägezelle pro Toolhead verifiziert die Pickup-Mechanik und liefert Z-Probe pro Tool. Eddy-Current-Sensor liefert Sub-Mikrometer-Bett-Mesh, schnell und ohne Berührung.

**Konsequenz für Bett-Design:** Magnet-Wechselsystem mit kleinen verteilten Magneten, Eddy-Current-kompatibel. Keine oversized Fixed-Magnete, da diese das Mesh verfälschen würden.

## D3 — Tool-Pool-Logik

**ENTSCHIEDEN: A — pro Seite eigener Pool, 4–5 Tools fest zugeordnet, identische Mechanik.**

- Linker Kopf erreicht nur linke Docks, rechter nur rechte
- Mirror-Mode durch identische Tools auf L1 und R1
- Total 8–10 Tools

**Begründung:** Identische Mechanik beidseitig vereinfacht Ersatzteil-Strategie und Service. Bewegliche Dock-Übergabe wäre unnötige mechanische Komplexität bei marginalem Nutzen.

## D4 — Pfad-Splitter Software

**ENTSCHIEDEN: A — Phase 1 ohne Cooperative-Mode, Pfad-Splitter ist Phase 3.**

- Phase 1+2 läuft mit Standard-IDEX-Modi (Mirror, Duplicate, sequenziell-Multi-Material) auf vorhandenem OrcaSlicer-Stack
- Pfad-Splitter-Postprocessor wird in Phase 3 entwickelt, nach stabiler Hardware

**Begründung:** Cooperative-Same-Object ist Forschungsthema mit unklarem Aufwand. Hardware muss zuerst stabil laufen, sonst lässt sich der Splitter nicht testen.

## D5 — Endlosfaser-Tool first wave

**ENTSCHIEDEN: B — Phase 2 nachgerüstet, R4-Slot reserviert.**

- Phase 1: Standard-Tools + Pellet-Extruder (R3 ebenfalls Phase 2)
- Endlosfaser-Tool als eigenständiges IP-Entwicklungsprojekt in Phase 2

**Begründung:** Endlosfaser-Tool ist eigene IP-Entwicklung mit unklarem Zeitbedarf. Phase 1 muss ohne dieses Tool ausgeliefert werden können, sonst blockiert es die gesamte Markteinführung.

## D6 — Erste Maschine

**ENTSCHIEDEN: Co-Founder-Build — Maschine 0 wird gemeinsam von Sebastian und Benjamin intern bei mThreeD.io aufgebaut.**

- Nicht Pilotkunde, nicht Solo-Showcase
- Gemeinsame Lernplattform und Test-Bed
- Phase-1-Validierung: „funktioniert" = Maschine 0 druckt zuverlässig

**Begründung:** Benjamin ist Co-Founder-Kandidat, nicht externer Partner. Gemeinsamer Build ist gleichzeitig Probelauf der Zusammenarbeit (siehe [[../00_Konzept/PARTNERSHIP|PARTNERSHIP]]).

**Offen für gemeinsame Diskussion mit Benjamin:** Standort, Rollenteilung im Build, Zeitinvest-Erwartung.

## D7 — Passive-Düsen-Lizenz

**ENTSCHIEDEN: B — verzichten.**

- Mo's Hauptstrategie ist material-spezifischer Extruder-Tausch (kompletter Toolhead pro Material)
- Passive Multi-Düsen-Konzepte mit zentralem Drive liefern nicht die nötige material-spezifische Drive-Auslegung

**Begründung:** Strategischer Konflikt mit Toolchanger-Architektur — passive Düsen sind anderes Paradigma, das die zentrale Designentscheidung untergräbt. Lizenz-Aufwand ohne strategischen Mehrwert.

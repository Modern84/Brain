---
projekt: mThreeD-X1
abgrenzung: Außen-Dokument — keine Drucker-Hersteller-Namen
status: konzept-pitch
erstellt: 2026-04-30
adressat: Benjamin (Co-Founder-Kandidat), später Whitepaper-Basis
---

# mThreeD-X1 — Pitch

## Was ist die X1

Ein Industrie-FFF-Drucker mit zwei vollständig unabhängigen Druckköpfen, jeweils mit eigenem Toolchanger und 4–5 Tools pro Seite. Cartesian Flying-Gantry, fixiertes Bett, 500 × 320 × 400 mm Bauraum, beheizte Kammer bis 120 °C. Steuerung Klipper, Slicing OrcaSlicer-basiert, Service-Plattform über Cloudflare-Tunnel mit MCP-Anbindung. Open Source als Plattform, Mehrwert durch Hardware und Service.

## Wer hat das Problem

Werkzeug- und Anlagenbauer, additive Fertiger und Forschungsabteilungen, die heute zwischen drei unbefriedigenden Optionen wählen:

- Hochpreisige geschlossene Multi-Material-Systeme (Lock-in, kein Pellet, keine Endlosfaser)
- Toolchanger-Drucker mit einem aktiven Kopf und 4–5 Tools (kein echtes IDEX, keine parallelen Druckmodi)
- Dual-IDEX-Geräte mit fest verbauten Köpfen (zwei Materialien, kein Toolchange, kein Pellet)

Wer Multi-Material **plus** parallele Köpfe **plus** Pellet/Endlosfaser braucht, findet aktuell kein passendes System auf dem Markt. EU-Wertschöpfung und Open-Source-Steuerung verschärfen die Lücke.

## Die zentrale Kausalkette

**Cartesian Flying-Gantry mit fixiertem Bett ist die mechanisch sauberste Lösung für echtes Dual-IDEX mit Toolchanger pro Seite.**

- **CoreXY mit gemeinsamen Riemen** blockiert Dual-IDEX direkt (verkettete Riemenführung). Zwei getrennte CoreXY-Systeme nebeneinander sind theoretisch möglich, kosten aber doppelten Bauraum durch zwei Riemen-Loops über die gesamte XY-Fläche und erschweren die Brücken-Trennung erheblich.
- **Bedslinger Cartesian** verbietet hohe Beschleunigungen bei IDEX, weil die bewegte Bett-Masse mit den Köpfen multipliziert. Bei 500 mm Y-Achse industriell unbrauchbar.
- **H-Bot** hat strukturelle Frame-Verzerrung schon bei Single-Tool-Anwendungen; Dual-Gantry verstärkt das.
- **Cartesian Flying-Gantry mit fixem Bett** entkoppelt: pro Brücke eigener Y-Antrieb, pro Schlitten eigener X-Antrieb, kurze unabhängige Riemen, fixes Bett mit beliebiger Heiz- und Sensor-Infrastruktur. Zwei vollständig unabhängige Köpfe sind hier mechanisch trivial — was die Toolchanger-Mechanik pro Seite überhaupt erst sinnvoll macht.

**Folgerung:** Flying-Gantry → Dual-IDEX → Toolchanger pro Seite ist nicht beliebig kombiniert, sondern eine Kette aus aufeinander aufbauenden Designentscheidungen. Mit 4–5 Tools je Seite stehen 8–10 Materialien gleichzeitig zur Verfügung, in beliebiger Kombination parallel oder sequenziell verarbeitbar.

## Was die Maschine ermöglicht

Vier Druckmodi, alle aus derselben Hardware:

1. **Cooperative-Same-Object** — beide Köpfe arbeiten parallel an einem Bauteil mit unterschiedlichen Pfaden (Software in Phase 3)
2. **Material-Parallel** — Hauptmaterial und Stützmaterial gleichzeitig
3. **Multi-Object-Parallel** — zwei Teile gleichzeitig
4. **Mirror/Duplicate** — klassische IDEX-Modi

Material-Bandbreite über die Tool-Pool-Architektur:

- Standard-Filament (PLA/PETG/ABS) bis 500 °C-Hochtemperatur (PEEK/PEKK/PEI)
- TPU mit Constrained-Path-Extrudern
- Carbon- und Glasfaser-Compounds (gehärtete Hotends)
- Wasserlösliche Stützmaterialien (PVA/BVOH/HIPS)
- **Pellet-Direktverarbeitung** (Granulat statt Filament — Materialkosten 5–10× niedriger)
- **Endlosfaser-Tool** (Phase 2, eigene IP-Entwicklung)

## Service-Plattform

Jeder Drucker bei jedem Kunden bekommt einen Tunnel-Anschluss an die mThreeD.io-Hub-Infrastruktur:

- **Edge-KI** auf dem Drucker (Echtzeit-Vision, Anomalie-Erkennung, < 50 ms Latenz)
- **Heavy-KI im Hub** (Reasoning, Fine-Tuning auf Kunden-Historie, Vector-DB über Klipper-Doku)
- **Cloudflare-Tunnel mit mTLS** (kein offener Port beim Kunden)
- **MCP-Server** auf dem Drucker als standardisierte Schnittstelle
- **Service-Stufen Bronze/Silber/Gold** mit klarer Leistungstrennung

Der Service ist nicht X1-spezifisch — er funktioniert mit jedem Klipper-Drucker. X1 ist der Premium-Anwendungsfall, nicht die Voraussetzung.

## Phasenplan

**Phase 1 — Hardware-Fertigstellung (Maschine 0)**
- Mechanik, Elektronik, Kammer, Bett, Standard-Tools
- Software: Standard-IDEX-Modi (Mirror, Duplicate, sequenzielles Multi-Material) auf vorhandenen Slicer-Stacks
- Ziel: druckende Maschine bei mThreeD.io intern, Showcase + Lernplattform

**Phase 2 — Spezial-Tools**
- Pellet-Extruder produktionsreif
- Endlosfaser-Tool (eigene IP-Entwicklung)
- Hochtemperatur-Tools 500 °C
- Service-Plattform produktiv mit Pilotkunden

**Phase 3 — Pfad-Splitter-Software**
- OrcaSlicer-Postprocessor für Cooperative-Same-Object-Modus
- Open Source veröffentlichen
- Erst nach stabiler Hardware sinnvoll, vorher reine Theorie

## Risiken (ehrlich)

**1. Pfad-Splitter-Software ist unklar im Aufwand.** Parallel-Toolpath-Generierung im FFF-Bereich ist Forschungsthema, keine etablierte Praxis. Mann-Monate-Schätzung ist heute Hypothese. → Phase-3-Klassifizierung ist Konsequenz, nicht Vorsicht.

**2. Mechanische Wechselwirkung zwischen den Brücken.** Zwei unabhängige Y-Brücken auf demselben Frame können Resonanzen aneinander koppeln. Input-Shaping pro Brücke ist nötig, aber das gegenseitige Übersprechen muss gemessen werden, nicht angenommen.

**3. Marktzugang als Zwei-Personen-Setup.** Industriekunden kaufen ungern bei zu kleinen Anbietern. Service-Plattform als Bindeglied (langlaufender Vertrag statt Einmal-Verkauf) ist die strategische Antwort, aber nicht trivial in der Vertriebs-Praxis.

## Wer steht dahinter

**mThreeD.io** — Sebastian Hartmann, Konstrukteur und Gründer, Erfinder des „ostdeutschen Turboladers" (Firma dreiB), Schwerpunkt additive Fertigung. Vorhandene Infrastruktur: Cloudflare-Tunnel produktiv, Klipper-Erfahrung über vorhandene Toolchanger-Hardware, Vault-/Brain-System mit KI-Pipeline.

**Offen für Co-Founder-Beitritt.** Maschine 0 ist als gemeinsame Lernplattform und Showcase angelegt, nicht als Solo-Projekt. Rollenteilung, IP-Aufteilung und Geschäftsform werden gemeinsam definiert — siehe [[00_Konzept/PARTNERSHIP|PARTNERSHIP]].

## Vertiefung

- [[00_Konzept/CONCEPT|CONCEPT]] — strategische Eckpfeiler, vollständige Liste der Designentscheidungen
- [[00_Konzept/ARCHITECTURE|ARCHITECTURE]] — Kinematik-Vergleichstabelle, Bett, Kammer, Antrieb
- [[00_Konzept/TOOLS|TOOLS]] — Tool-Pool, Klassen, IDEX-Constraints
- [[00_Konzept/SOFTWARE-STACK|SOFTWARE-STACK]] — Klipper, Slicer, Edge-/Heavy-KI
- [[04_Service/TUNNEL-SERVICE|TUNNEL-SERVICE]] — Cloudflare-MCP-Architektur

> ⚠️ Eigen-Vorschlag CC, von Mo zu prüfen: Abschnitt „Wer hat das Problem" und Risiko-Top-3 sind nicht 1:1 aus dem Framing übernommen, sondern eigenständig formuliert. Inhaltlich aus dem Brain abgeleitet, vor Versand an Benjamin sichten.

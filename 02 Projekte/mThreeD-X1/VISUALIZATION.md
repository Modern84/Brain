---
projekt: mThreeD-X1
abgrenzung: Außen-Dokument — keine Drucker-Hersteller-Namen
status: konzept-pitch
erstellt: 2026-04-30
adressat: Benjamin (Co-Founder-Kandidat), später Whitepaper-Basis
---

# mThreeD-X1 — Visualisierungen

## 1. Strategische Kausalkette

Die Architektur folgt einer Kette, in der jeder Schritt den nächsten ermöglicht:

```
┌─────────────────────────────────────┐
│  Cartesian Flying-Gantry            │
│  (kurze Riemen, fixes Bett)         │
└────────────────┬────────────────────┘
                 │ ermöglicht
                 ▼
┌─────────────────────────────────────┐
│  Echtes Dual-IDEX                   │
│  (zwei vollständig unabhängige      │
│   Druckköpfe auf eigenen Brücken)   │
└────────────────┬────────────────────┘
                 │ erweitert um
                 ▼
┌─────────────────────────────────────┐
│  Toolchanger pro Seite              │
│  (4–5 Tools je Kopf, 8–10 total)    │
└────────────────┬────────────────────┘
                 │ resultiert in
                 ▼
┌─────────────────────────────────────┐
│  8–10 Materialien pro Druckjob      │
│  Material-Parallel-Druck            │
│  Mirror/Duplicate für Serienteile   │
└─────────────────────────────────────┘
```

Die Kombination dieser drei Schritte existiert in keiner kommerziellen FFF-Maschine, nicht einmal in offener Forschung.

## 2. Kinematik-Vergleich — warum Flying-Gantry

```
CoreXY (Standard FFF):
┌─────────────┐
│ ╲    ╱      │   Zwei lange Riemen verkettet,
│  ╲  ╱       │   beide Motoren wirken gemeinsam.
│   ╳         │   → Dual-IDEX blockiert oder
│  ╱  ╲       │      bauraum-ineffizient.
│ ╱    ╲      │
└─────────────┘

Bedslinger Cartesian:
┌─────────────┐
│ ═══════     │   Bett bewegt sich in Y.
│ ║[Kopf]     │   Bett-Masse wird mit Y-Bauraum
│ ║           │   und Tool-Anzahl multipliziert.
│ ▓▓▓▓▓▓▓     │   → Hohe Beschleunigung unmöglich.
│ Bett→Y      │
└─────────────┘

H-Bot:
┌─────────────┐
│ ═══╤═══════ │   Ein Riemen, asymmetrische
│    │        │   Frame-Belastung.
│  [Kopf]     │   → Frame-Verzerrung bei
│             │      Dual-Tool verstärkt.
└─────────────┘

Cartesian Flying-Gantry  ← gewählt für X1
┌─────────────────┐
│ ═══[Brücke]═══  │   Brücke bewegt sich in Y,
│       ║         │   Schlitten in X auf Brücke.
│   [Kopf]        │   Bett bleibt fix.
│                 │   Pro Achse separater Antrieb,
│ [Bett FIX]      │   kurze unabhängige Riemen.
└─────────────────┘   → Dual-Brücken trivial.
```

Für die X1 wird das Flying-Gantry-Prinzip verdoppelt: zwei unabhängige Brücken auf parallelen Y-Schienen, jede mit eigenem X-Schlitten. Mechanisch sauber, kinematisch simpel, vollständig unabhängige Bewegung beider Köpfe.

## 3. Bauraum-Proportionen (D1 final)

Druckraum: 500 × 320 × 400 mm (X × Y × Z)
Verhältnis X:Y ≈ 1.56 (nahe Goldener Schnitt)

Druckraum (Draufsicht, Maßstab schematisch):

```
◄────────── X = 500 mm ──────────►
┌──────────────────────────────────┐  ▲
│                                  │  │
│                                  │  │ Y = 320 mm
│      Druckfläche fix             │  │
│                                  │  │
│                                  │  ▼
└──────────────────────────────────┘
```

Maschinen-Footprint (inkl. Tool-Docks, Antrieb, Kammer): ~720 × 580 × 900 mm (B × T × H)

Die flache Y-Achse hat einen mechanischen Vorteil: kürzere Brücken = leichter, höhere Beschleunigung möglich, weniger Resonanz. Die breite X-Achse trägt die zwei IDEX-Köpfe ohne Y-Achse bewegen zu müssen.

Maschine passt auf eine 600er-Werkstattbank, kein Spezial-Stellplatz nötig.

## 4. Tool-Pool-Layout (D3 final)

4–5 Tools pro Seite, fest zugeordnet, identische Mechanik. Mirror-Mode durch identische Belegung von L1 und R1.

```
Linke Dock-Seite          Rechte Dock-Seite
┌─────────────┐          ┌─────────────┐
│ L1: Std     │◄─Mirror─►│ R1: Std     │  ← Standard-PLA
│ L2: HighTemp│          │ R2: Soluble │
│ L3: TPU     │          │ R3: Pellet  │  ← Phase 2
│ L4: CF/GF   │          │ R4: Faser   │  ← Phase 2 (reserv.)
│ L5: Detail  │          │ R5: Silikon │  ← Phase 2 (reserv.)
└──────┬──────┘          └──────┬──────┘
       │                        │
       ▼                        ▼
   Kopf L                    Kopf R
   erreicht nur              erreicht nur
   linke Docks               rechte Docks

              ┌────────────────────┐
              │   Druckraum        │
              │   500 × 320 mm     │
              └────────────────────┘
```

Strategie: Linker Kopf trägt Hauptmaterialien (Engineering), rechter Kopf trägt Support- und Spezialmaterialien. Mirror/Duplicate für Serienteile durch identische Standard-Tools auf L1 + R1.

Tool-Pool-Constraint ehrlich: Schlitten erreichen sich nicht ohne Kollision, deshalb keine bewegliche Übergabe. Material-Planung pro Druck respektiert die Seitenzuordnung.

## Hinweis zu den Skizzen

Diese Visualisierungen sind ASCII-Schemata zur Konzept-Vermittlung, kein CAD. Die finale Geometrie wird im CAD-Mockup-Schritt nach Plausibilitätsprüfung der Kinematik festgelegt. Maße sind Auslegungsziele, nicht Konstruktionsdaten.

Verwandte Dokumente:

- [[PITCH|PITCH]] — Whitepaper-Pitch
- [[00_Konzept/PARTNERSHIP|PARTNERSHIP]] — Co-Founder-Diskussionsgrundlage
- [[00_Konzept/ARCHITECTURE|ARCHITECTURE]] — vollständige technische Spezifikation
- [[00_Konzept/CONCEPT|CONCEPT]] — strategische Eckpfeiler

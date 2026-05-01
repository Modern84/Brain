---
projekt: mThreeD-X1
abgrenzung: NICHT Reiner-WEC
status: konzept
erstellt: 2026-04-30
---

# Referenz-Maschinen — was übernommen, was verworfen

> **Achtung: rein interne Quellenarbeit, NICHT für Pitch oder Whitepaper.** Außen-Dokumente ([[../README|README]], [[../PITCH|PITCH]], [[../00_Konzept/CONCEPT|CONCEPT]], [[../00_Konzept/PARTNERSHIP|PARTNERSHIP]]) erwähnen keine Drucker-Hersteller. Diese Datei dient ausschließlich der internen Engineering-Dokumentation.

## STōN-WoLF (Tschechien)

**Übernommen:**
- Cartesian Flying Gantry Kinematik
- 12-15mm CNC-Massiv-Frame
- 48V Motion-System
- Wägezellen-Probe-Konzept
- Klipper-pur, kein Lock-in
- Hochwertige Industrie-Komponenten (Mean Well, Schurter, Molex)

**Nicht übernommen:**
- Single-Tool (X1 ist Multi-Tool)
- 300×300 Bauraum (X1 ist 500×500)

**Quelle:** ston-3d.com, Czech-based, 1-by-1 built

## Voron 2.4 / StealthChanger

**Übernommen:**
- High-End Bauqualität-Standard
- Community-Stack (Voron-Konfigurationen, Standardkomponenten)
- Tap-Probe-Konzept (Wägezelle)
- Open-Source-Philosophie

**Nicht übernommen:**
- CoreXY (X1 ist Flying Gantry)
- Aluprofil-Rahmen als Hauptlast

## ProForge 5 (Makertech)

**Übernommen:**
- Toolchanger-Mechanik-Verständnis (Mo's bekannte Maschine)
- 5-Tool-Architektur als Basis
- Eddy-Probe-Wissen

**Nicht übernommen:**
- Single-Gantry (X1 ist Dual-Flying-Gantry)
- Servo-Lock-Mechanik (Optionsdiskussion offen, D2)

## Raise3D E2 / Bambu H2D / CR-3D C2-IDEX

**Übernommen:**
- IDEX-Prinzip (zwei unabhängige Druckköpfe)
- Mirror/Duplicate-Modi

**Nicht übernommen:**
- Geteilte Y-Brücke (X1 hat 2 unabhängige Y-Brücken = echtes IDEX)
- Single-Tool pro Seite (X1 hat Toolchanger pro Seite)

## CR-3D Cham/Bayern

**Übernommen:**
- Komplettanbieter-Vorbild (Drucker + Material + Service)
- Pellet-Extruder PX6 Architektur als Referenz
- Made-in-Germany / EU-Wertschöpfung

**Nicht übernommen:**
- Geschlossenes System (X1 ist Open Source)
- Cartesian Single-Gantry

## Bondtech INDX

**Bewertet, verworfen für Hauptarchitektur:**
- INDX = passive Düsen, aktiver Smart-Head
- Mo's Anforderung: Extruder-Tausch wichtiger als Düsen-Tausch
- Konsequenz: INDX nicht als Hauptmechanik, evtl. Phase-2-Slot
- IP geschützt, kommerzielle Nutzung lizenzpflichtig
- D7 in OPEN-DECISIONS

## Snapmaker U1

**Bewertet, irrelevant:**
- Mo: "snap mega braucht man gar nicht gucken, das meine ich nie"
- Proprietär, China, kein Klipper-Pur
- Nur zur Markt-Validierung relevant ($20M Kickstarter)

## Prusa XL + INDX

**Bewertet, verworfen:**
- Single-Gantry Toolchanger
- Geschlossenes Ökosystem
- INDX-Integration nicht offen genug

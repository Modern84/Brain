---
projekt: mThreeD-X1
abgrenzung: NICHT Reiner-WEC
status: konzept
erstellt: 2026-04-30
---

# Software-Stack

## Strategische Entscheidung

Open Source als Plattform. Mehrwert durch Hardware + Service, nicht durch Software-Lock-in.

## Steuerung

- **Klipper, vanilla, keine Forks**
- BTT Octopus Max EZ als Master + 8–10× EBB SB2240 Toolboards
- CAN-FD 1 Mbit für alle Toolheads
- Sicherheits-MCU separat (STM32-Watchdog)
- Hardwired Notaus via Pilz PNOZ s4

## Slicer-Stack — Phase 1 (Standard-IDEX, ohne Cooperative-Mode)

**D4-Final:** Phase 1 läuft mit vorhandenen Slicer-Stacks und Standard-IDEX-Modi. Keine Eigenentwicklung in Phase 1.

- **OrcaSlicer** als Hauptsystem
- **Standard-IDEX-Profile** für Mirror, Duplicate, sequenziellen Multi-Material-Druck
- Klipper-kompatible G-Code-Ausgabe
- Tool-Wechsel und Tool-Park über Klipper-Macros

Was in Phase 1 möglich ist:
- Mirror und Duplicate (zwei identische Teile parallel auf zwei Bett-Hälften)
- Sequenzieller Multi-Material-Druck (Tool-Wechsel pro Layer oder pro Bereich)
- Material-Parallel mit zwei aktiven Köpfen, solange die Pfade nicht kollidieren (manuelle Pfad-Trennung im Slicer)

Was Phase 1 noch **nicht** kann:
- Cooperative-Same-Object (zwei Köpfe arbeiten parallel an einem Bauteil mit unterschiedlichen Pfaden, automatische Kollisionsvermeidung)

## Pfad-Splitter — Phase 3 (Eigenentwicklung)

- Input: Standard-OrcaSlicer-G-Code
- Output: 2-Stream-G-Code mit Kollisions-Constraints für Cooperative-Same-Object
- Implementierung: Python-Postprocessor + Klipper-Plugin, kein Slicer-Fork
- Open Source veröffentlichen
- **Erst nach Phase-1-Hardware sinnvoll** — vorher reine Theorie ohne Test-Bett

## Klipper-Konfiguration X1

- 2× unabhängige Steppers für Y1 + Y2
- 2× unabhängige Steppers für X-L + X-R
- Custom Macros für Tool-Pickup, Park, Kollisionsvermeidung
- Sync-Macros für synchronisierte Z-Bewegung (4 Spindeln)

## Drucker-Host

- Minisforum MS-01 i9-13900H, 64 GB RAM
- 2× 10 GbE
- Klipper-Host + Moonraker + Mainsail/Fluidd
- Edge-Inferencer für Echtzeit-Vision

## Edge-KI

- NVIDIA Jetson AGX Orin 64 GB
- Triton Inference Server
- YOLO11-Vision-Modelle (fine-tuned auf Druck-Anomalien)
- < 50 ms Latenz Kamera → Reaktion

## Heavy-KI Hub (mThreeD.io zentral)

- 1× RTX PRO 6000 Blackwell oder 2× RTX 5090
- Threadripper 7975WX, 256 GB ECC
- Qwen2.5-VL 72B oder Llama 4
- Vector-DB Qdrant
- MLflow Experiment-Tracking
- Bedient mehrere Kunden-Maschinen parallel

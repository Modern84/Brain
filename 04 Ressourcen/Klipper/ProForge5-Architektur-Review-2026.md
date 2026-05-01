---
tags: [drucker, proforge5, architektur, recherche, 2026]
status: aktiv
date: 2026-04-29
constraint: 5 vollständige aktive Toolheads
---

# ProForge5 Architektur-Review 2026 — Komponenten-Optimierung

Recherche 2026-04-29 unter dem Constraint:
**5 vollständige aktive Toolheads mit material-individueller Konfiguration bleiben bestehen.**

Alle anderen Komponenten sind optimierungs-offen. Bewertungsmaßstab: Servo-PWM-EMI-Robustheit, 5×-Replizierbarkeit, CAN-Multi-MCU-Stabilität, Wartbarkeit für ein Zwei-Personen-Ingenieurbüro.

## Executive Summary

Top-3-Empfehlungen für die nächsten 6 Monate, sortiert nach Cost-Benefit:

1. **Octopus Pro CAN-Bridge-Mode aktivieren, U2C entfernen** — Aufwand ~80 EUR (UBEC bereits bestellt) und 4–6 h Reflash + Re-Wiring — Erwarteter Gewinn: ein USB-Device weniger am Pi (entlastet den ohnehin belasteten Hub-Pfad), eine SPoF-Quelle weg, identische Funktion. Servo-EMI bleibt das eigentliche Hauptproblem, aber ein bewegliches Teil weniger im Crash-Pfad.
2. **EBB36 Gen 2 sauber neu flashen (dirty-Flag entfernen) plus Servo-PWM galvanisch entkoppeln (UBEC + getrennter 5 V-Pfad)** — Aufwand ~30 min Reflash, Hardware-Pfad UBEC läuft bereits. Erwarteter Gewinn: das eigentliche Pain-Point-Cluster (gs_usb-Crashes durch Servo-EMI) wird adressiert ohne Board-Tausch. Board-Tausch nach SB2240 bringt **keinen** Servo-EMI-Vorteil — gleiches Problem, andere Form.
3. **Kalico-Migration evaluieren, aber NICHT vor Q4-2026 ausführen** — Aufwand 0 EUR, 8–12 h Test auf separatem SD-Image. Erwarteter Gewinn: bessere Multi-MCU-Diagnostik, aktivere Community für 5-Tool-Setups. Risiko: Issue #829 zeigt offenes Multi-MCU/CAN-Timing-Problem 2026-02 — abwarten bis Patch stabil.

**Was NICHT zuerst angefasst wird:** Stepper (TMC5160/2209 läuft), Bed-Probe (Eddy V1 ist seit 13.04. kalibriert), Host (Pi 5 läuft trotz USB-Schaden stabil über Tailscale).

## Komponenten-Bewertung im Detail

### B1 Toolhead-Boards

- **Aktuell:** BTT EBB36 Gen 2 V1.0 (1× am bewegten Toolhead), Servo-PWM auf PB5
- **Beste Alternative 2026:** Bestand bleibt optimal — kein Board-Tausch
- **Cost-Benefit:** Tausch auf SB2240/SHT36 V3: ~50–70 EUR, ~6 h Re-Verkabelung, **kein** Mehrwert für das Servo-EMI-Problem (alle Boards haben dieselbe PWM-Topologie). Mehrwert nur bei integriertem TMC2240 statt 2209 — Sebastian nutzt am EBB Extruder, hier irrelevant.
- **Migrations-Aufwand:** N/A (kein Tausch empfohlen)

| Kandidat | MCU | Stepper | Servo-PWM | I²C/SPI | CAN | Preis (EUR, 04/2026) | 5-Tool-Eignung |
|---|---|---|---|---|---|---|---|
| BTT EBB36 Gen 2 V1.0 (Bestand) | STM32G0B1 | TMC2209 | PB5 (frei) | I²C+SPI | ja | ~50 | ja, im Bestand |
| BTT EBB SB2240 V1.0 | STM32G0B1 | TMC2240 | ja | I²C+SPI | ja, gehärtet | ~65 | ja |
| Mellow Fly SHT36 V3 | STM32F072 | TMC2209 | ja | I²C+SPI | ja | ~45 | ja, aber CN-Doku |
| Duet 3 Toolboard 1LC | SAME5x | TMC2209 | ja | I²C | CAN-FD | ~95 | nur mit Duet-Mainboard |
| BTT EBB36 Gen 3 | — | — | — | — | — | — | UNKLAR — Quellenlage 2026-04 zeigt keinen Gen 3, nur Gen 2 |

### B2 Tool-MCU-Strategie

- **Aktuell:** 5× SO3 STM32F042 hinter aktivem 5 V-Hub am Pi (eine MCU pro Tool: Buttons, Filament-Switch, Neopixel)
- **Beste Alternative 2026:** Bestand bleibt optimal
- **Cost-Benefit:** Konsolidierung auf weniger MCUs (z. B. 1× pro Pickup-Station) würde Buttons/Sensoren über lange Kabel vom Tool zur Station führen — verschlechtert EMI-Profil und macht Tool-Wechsel mechanisch komplexer. SO3 ist seit 04/2026 mit individuellen USB-Serials und WANT_BUTTONS+WANT_TMCUART+WANT_NEOPIXEL stabil (siehe MEMORY ProForge5 Firmware-Stand). Roadmap zu SO3 V4 oder F042-Nachfolger: kein offizielles Signal LDO Motors 04/2026.
- **Migrations-Aufwand:** N/A
- **Hinweis:** Toolhead-Board (EBB36) übernimmt theoretisch SO3-Funktionen, dann aber nur bei stationärem Einzel-Tool — verstößt bei 5-Tool-Wechsler gegen Constraint.

### B3 Host + CAN-Bridge

- **Aktuell:** Pi 5 (ein USB-Port abgebrochen) + BTT U2C V2 als gs_usb-Bridge + aktiver 5 V-Hub für 5× SO3
- **Beste Alternative 2026:** **Octopus Pro im CAN-Bridge-Mode**, U2C entfällt
- **Cost-Benefit:** 0 EUR (Octopus Pro vorhanden), ~4–6 h Arbeit. Gewinn: ein USB-Device weniger am beschädigten Pi-Port-Pfad, ein gs_usb-SPoF weg. Risiko: Octopus muss neu geflasht werden, Migrations-Schritt mit Backup zwingend. Klipper-Doku & Voron-Forum bestätigen Reife des Bridge-Modes seit 2024.
- **Migrations-Aufwand:** mittel
- **Alternative für später (Q4):** Manta M8P V2 + CB1 als integrierter Host (eliminiert Pi-USB-Abhängigkeit komplett, integrierte CAN-Header). Aufwand ~120 EUR + 12–16 h Re-Verkabelung. Sinnvoll erst wenn Pi-Port-Schaden eskaliert oder ein zweiter Port stirbt.

| Kandidat | Host integriert | Native CAN | gs_usb los | SPoF-Reduktion | Aufwand |
|---|---|---|---|---|---|
| Pi 5 + U2C (Bestand) | nein | nein | nein | — | 0 |
| Pi 5 + Octopus Bridge | nein | ja (über Octopus) | teilweise | +1 | 4–6 h |
| Manta M8P V2 + CB1 | ja | ja | ja | +2 | 12–16 h, ~120 EUR |
| Duet 3 6HC | ja | CAN-FD | ja | +2 | Komplettumbau, ~400+ EUR |

### B4 Bed-Probe

- **Aktuell:** BTT Eddy Coil V1 (LDC1612), kalibriert seit 13.04.2026
- **Beste Alternative 2026:** Bestand bleibt optimal bis Q4
- **Cost-Benefit:** Tausch gegen Cartographer (CAN, leichter, ~half-price Beacon) wäre nominal eine Verbesserung — aber Eddy V1 ist gerade kalibriert und läuft. Bei 5-Toolhead-Setup ist Probe nicht am Tool, sondern am Carriage — Tool-Offset-Messung erfolgt separat (Klicky/Kugelmessung). Probe-Wechsel hilft hier nicht direkt.
- **Migrations-Aufwand:** niedrig (~3 h, neu kalibrieren), aber ohne klaren Gewinn jetzt
- **Bei Defekt/Drift:** Cartographer einsetzen (CAN, MakerTech-/Voron-Community 2026 stark). Beacon teurer, USB-only — passt schlecht zu USB-knappem Pi.

### B5 Stepper

- **Aktuell:** TMC5160 SPI (4× XY AWD), TMC2209 UART (4× Z Quad-Z), TMC am EBB36 (Extruder × 5 effektiv über SO3-Tools)
- **Beste Alternative 2026:** Bestand bleibt optimal
- **Cost-Benefit:** Closed-Loop (BTT S57V2, MKS Servo57B/D) bringt bei XY-AWD theoretisch Schritt-Verlust-Erkennung. Praxis-Berichte 2024–2026 (Klipper Discourse, S42C-Threads) zeigen mixed results — Klipper ist nicht primär für Closed-Loop optimiert, FOC-Module brauchen zusätzliche Tuning-Arbeit. Aufwand: 4× ~120 EUR plus 8–12 h Tuning. Gewinn: gering bei korrekt dimensionierten TMC5160. Nicht empfohlen.
- **Migrations-Aufwand:** N/A
- **Hinweis:** Distributed-CAN-Stepper-Module (M0 wie BTT MMB, Duet 1LC) machen erst Sinn wenn der gesamte Stack auf CAN-FD umgestellt wird — nur als Komplettumbau Q4+ sinnvoll, nicht inkrementell.

### B6 Firmware

- **Aktuell:** Klipper Master v0.13.0-623 (Octopus 30 commits hinten, EBB dirty)
- **Beste Alternative 2026:** Klipper Master bleibt jetzt, **Kalico-Evaluierung Q4-2026** auf Test-SD
- **Cost-Benefit:** Kalico (Danger-Klipper-Fork, umbenannt 12/2024) ist aktiv gepflegt, hat Multi-MCU-Sample-Configs und arbeitet an besserer Multi-MCU-Homing-Diagnose. Aber: offenes Issue #829 (autotune_tmc fails über CAN, Multi-MCU/EBB36, Stand 02/2026) zeigt, dass exakt der ProForge5-Anwendungsfall (5× MCU + EBB CAN) noch instabil sein kann. Migrations-Aufwand 8–12 h auf Test-Image, Rollback einfach. RepRapFirmware (RRF) hat nominal besseres Multi-Tool-Handling — aber kompletter Stack-Wechsel (Hardware Duet, Macro-Neuschreiben, Klicky-Konzept anpassen). Out-of-scope für 6-Monats-Horizont.
- **Migrations-Aufwand:** Kalico mittel (8–12 h Test), RRF hoch (Komplettumbau)

| Kandidat | Multi-MCU | Multi-Tool-Macros | 5-Tool-Reife 04/2026 | Migrations-Aufwand |
|---|---|---|---|---|
| Klipper Master (Bestand) | ja | Plugin (Klipper_ToolChanger) | reif | 0 |
| Kalico | ja, sample-multi-mcu.cfg | Plugin-kompatibel | offene CAN-Issues 02/2026 | 8–12 h Test |
| RepRapFirmware 3.x | ja, CAN-FD | nativ | ausgereift, aber Duet-only | Komplettumbau, 40+ h |

## Migrations-Reihenfolge (empfohlen)

**Q2-2026 (Mai–Juni):**
1. UBEC-Servo-Pfad fertig integrieren (Hardware bestellt 28.04.) — adressiert das Haupt-Pain-Point.
2. EBB36 Gen 2 sauber neu flashen (dirty-Flag weg).
3. Octopus Pro auf v0.13.0-623 mitziehen (Versionswarnung weg).
4. Verifikation: 24-h-Druck mit Servo-Bewegungen, `bytes_invalid`-Counter beobachten (Klipper-Doku-Schwellen).

**Q3-2026 (Juli–September):**
5. Octopus Pro CAN-Bridge-Mode aktivieren, U2C entfernen. Backup printer.cfg + .config zwingend.
6. Test-SD-Image mit Kalico aufsetzen, parallel testen (nicht produktiv).

**Q4-2026 (Oktober–Dezember):**
7. Wenn Kalico-Test stabil und Issue #829 gepatcht: Kalico produktiv.
8. Wenn Pi-USB-Pfad weiter degradiert: Manta M8P V2 + CB1 evaluieren.

**Abhängigkeiten:** Schritt 5 setzt 1–4 voraus (sauberes Baseline). Schritt 7 setzt 5 voraus (CAN-Topologie-Vereinfachung erleichtert Kalico-Test). Schritt 8 ist parallel-fähig wenn Hardware-Druck steigt.

## Risiko-Register

- **Schritt 1 (UBEC):** Falsche Polarität → EBB36 oder Servo-Defekt. Mitigation: vor Anschluss mit Multimeter messen, Sebastian + Claude.ai-Vier-Augen-Prinzip.
- **Schritt 5 (CAN-Bridge):** Octopus-Reflash misslingt → Drucker offline. Mitigation: Backup-SD-Image, U2C bleibt physisch montiert bis Bridge-Mode 24 h stabil läuft.
- **Schritt 7 (Kalico):** Multi-MCU-Timing-Regression auf CAN. Mitigation: separates SD, jederzeit Rollback per SD-Tausch.
- **Schritt 8 (Manta):** Komplettumbau Verkabelung → Wochen Stillstand. Mitigation: nur bei Hardware-Defekt Pi 5, sonst aufschieben.
- **Generell:** Vor jedem destruktiven Schritt printer.cfg + .config + DTB als `.backup_YYYYMMDD` (CLAUDE.md-Regel).

## Was BLEIBT (bewusste Entscheidung)

- **5× SO3 STM32F042 als Tool-MCUs** — seit 04/2026 stabil, individuelle Serials, kein Roadmap-Druck.
- **EBB36 Gen 2 V1.0** — Tausch bringt keinen Servo-EMI-Vorteil.
- **Eddy V1 Probe** — frisch kalibriert, Tool-Offsets liegen ohnehin nicht beim Probe.
- **TMC5160/2209-Stack** — Closed-Loop-ROI nicht gegeben.
- **Pi 5** — trotz USB-Schaden funktional, Tailscale-Pfad stabil. Erst tauschen bei zweitem Defekt.
- **MeanWell LRS-450/150** — keine Beanstandung.
- **Klipper Master als Produktiv-Firmware** — bis Kalico-Multi-MCU-Issues geschlossen sind.

## Was nicht in Frage kommt

- **Bondtech INDX und ähnliche passive-Tool-Systeme** — verstößt gegen Constraint (5 vollaktive Toolheads).
- **Komplettumbau auf Duet 3 6HC + RRF** — Aufwand >40 h, kompletter Stack-Wechsel, kein 6-Monats-ROI. Theoretisch beste Multi-Tool-Plattform, praktisch zu teuer als Sprung.
- **MKS/BTT Closed-Loop-Stepper im Bestand-Setup** — ROI nicht belegt, Klipper-Tuning-Aufwand hoch.
- **Beacon Probe** — USB-only, verträgt sich schlecht mit USB-knappem Pi.
- **EBB36 Gen 3** — existiert per Recherche-Stand 2026-04 nicht öffentlich, BTT-GitHub & Wiki zeigen nur Gen 2.

## Quellen

Alle abgerufen 2026-04-29.

- [BTT EBB GitHub](https://github.com/bigtreetech/EBB)
- [BTT EBB36 Gen 2 Wiki](https://global.bttwiki.com/EBB36_GEN2.html)
- [BTT EBB SB2240/2209 Wiki](https://global.bttwiki.com/EBB%202240%202209%20CAN.html)
- [Mellow Fly SHT36 V3 Docs](https://mellow.klipper.cn/en/docs/ProductDoc/ToolBoard/fly-sht36/sht36_v3/)
- [Mellow Fly SHT36 V2 Übersicht](https://mellow-3d.github.io/fly-sht36_v2_general.html)
- [Klipper CANBUS-Doku](https://www.klipper3d.org/CANBUS.html)
- [Klipper CANBUS-Troubleshooting](https://www.klipper3d.org/CANBUS_Troubleshooting.html)
- [Klipper Multi-MCU Homing](https://www.klipper3d.org/Multi_MCU_Homing.html)
- [Voron-Forum: Octopus CAN-Bridge-Mode](https://forum.vorondesign.com/threads/how-to-configure-klipper-on-octopus-using-can_bridge_mode.1429/)
- [Klipper Discourse: Octopus Pro CanBoot+Bridge](https://klipper.discourse.group/t/octopus-pro-canboot-can-bus-bridge/3734)
- [maz0r CANBUS Toolhead Install Guide](https://maz0r.github.io/klipper_canbus/)
- [BTT Manta M8P V2 Wiki](https://global.bttwiki.com/M8P-V2_0.html)
- [BTT Manta M8P V2 Review (3dprinters-guide)](https://3dprinters-guide.com/bigtreetech-manta-m8p-v2-0-review-a-deep-dive-into-this-klipper-control-board/)
- [Kalico GitHub](https://github.com/KalicoCrew/kalico)
- [Kalico Issue #829 — autotune_tmc CAN Multi-MCU](https://github.com/KalicoCrew/kalico/issues/829)
- [Kalico sample-multi-mcu.cfg](https://github.com/KalicoCrew/kalico/blob/main/config/sample-multi-mcu.cfg)
- [Hackaday: Danger-Klipper → Kalico](https://hackaday.com/2024/12/11/danger-klipper-fork-renamed-to-kalico/)
- [Klipper_ToolChanger Plugin](https://github.com/TypQxQ/Klipper_ToolChanger)
- [Klipper Discourse: Toolchangers Support](https://klipper.discourse.group/t/toolchangers-support/9549)
- [Beacon Probe Produktseite](https://beacon3d.com/product/beacon/)
- [Cartographer 3D](https://cartographer3d.com/)
- [Team FDM: Eddy Current Probe Comparison](https://www.teamfdm.com/forums/topic/3322-eddie-current-probe-comparison-a-personal-viewpoint/)
- [Klipper Discourse: Make BTT Eddy great again](https://klipper.discourse.group/t/make-btt-eddy-great-again/25139)
- [LDO Smart Orbiter V3](https://www.orbiterprojects.com/so3/)
- [LDO Orbitool O3 Toolhead PCB](https://kb-3d.com/store/ldo/1176-ldo-orbitool-o3-usb-tool-head-board-for-smart-orbiter-v3-1717942076981.html)
- [Klipper Discourse: CAN Bus Multiple Closed-Loop Stepper](https://klipper.discourse.group/t/can-bus-multiple-closed-loop-stepper-configuration/280)
- [MKS-SERVO57B GitHub](https://github.com/makerbase-mks/MKS-SERVO57B)
- [Duet 3 Mini 5+](https://www.duet3d.com/duet3mini5plus)
- [Duet 3 Toolboard 1LC Doku](https://docs.duet3d.com/Duet3D_hardware/Duet_3_family/Duet_3_Toolboard_1LC)
- [Duet3D Forum: Mini 5+ + Multiple 1LC](https://forum.duet3d.com/topic/30919/duet-3-mini-5-with-multiple-toolboards-1lc)
- [3DTechValley: Best Controller Boards 2026](https://www.3dtechvalley.com/best-3d-printer-controller-board/)

## Verknüpfungen

- [[02 Projekte/ProForge5 Build/ProForge5 Build]]
- [[04 Ressourcen/Klipper/Servo-EMI-Mitigation]]
- [[04 Ressourcen/Klipper/Servo-EMI-Mitigation-Strategien]]
- [[04 Ressourcen/Klipper/ProForge5 Pinout]]
- [[04 Ressourcen/Klipper/ProForge5 CAN-Bus Setup 2026-04-04]]
- [[04 Ressourcen/Klipper/Servo-Stepper-Umbau-Bewertung]]
- [[05 Daily Notes/2026-04-29]]

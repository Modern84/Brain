---
tags: [vault]
date: 2026-04-04
---

# TASKS

Zuletzt aktualisiert: 2026-04-04

---

## Aktiv

### ProForge5 Build — Etappe 1 (CAN-Fundament & Bed-Leveling)

- [x] **EBB36 Schlitten flashen** — aktuell im DFU-Modus, Firmware-Flash steht aus → [[02 Projekte/ProForge5 Build#EBB36 Schlitten flashen — Schritt für Schritt]]
- [ ] **EBB36 UUID auslesen** — `~/klippy-env/bin/python ~/klipper/scripts/canbus_query.py can0`
- [ ] **EBB36 UUID in printer.cfg eintragen** — unter `[mcu ebb] canbus_uuid:`
- [ ] **120R-Jumper am EBB36 Schlitten prüfen** — muss ON sein (Ende der Kette)
- [ ] **Mainsail im Browser testen** — `http://172.20.10.2` (nur `http://`, gleicher Hotspot)
- [ ] **Eddy Coil am EBB36 anschließen**

### ProForge5 Build — Konfiguration

- [ ] **Stepper-Pins an tatsächliche Verkabelung anpassen** — printer.cfg enthält noch Platzhalter
- [ ] **Input Shaping kalibrieren** — ADXL345 ist integriert im EBB36 Schlitten

---

## Geplant

### MThreeD.io — Geschäftsaufbau

- [ ] Website / Online-Präsenz aufbauen
- [ ] Angebot & Preisstruktur definieren
- [ ] Erste Referenzprojekte dokumentieren
- [ ] Druckerkapazität aufbauen (ProForge5 + Stone Wolf)

### Stone Wolf Build (startet nach ProForge5)

- [ ] Specs und Anforderungen definieren
- [ ] Komponenten beschaffen
- [ ] Bauplan erstellen

---

## Someday / Vielleicht

*(Ideen ohne konkreten Termin)*

---

## Erledigt

- [x] Octopus Pro im USB-to-CAN Bridge Modus flashen ✅
- [x] can0-Interface aktiv ✅
- [x] Octopus CAN-UUID ermittelt: `2e8e7efafd9b` ✅
- [x] EBB36 Schlitten per dfu-util geflasht ✅
- [x] Vault / Zweites Gehirn eingerichtet ✅

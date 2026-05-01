---
tags: [vault]
date: 2026-04-04
---

# TASKS

Zuletzt aktualisiert: 2026-05-01 (Pilot Fusion-Drawing-Architektur — Schritt 1 ✅, **Schritt 2 entblockt** durch Vault-Fund `WEC.dwg` als Primärquelle. Reiner-PDF-Umweg entfällt. Anleitung [[04 Ressourcen/CAD-Workflows/Fusion 360 Drawing Template L7]] steht.)

## ✅ Heute 2026-04-30 erledigt
- [x] **D2-Rollback Hybrid-Bridge → USBSERIAL** ✅ (08:25) — Klipper ready, EBB active rx_error=0. Details: [[04 Ressourcen/Klipper/Hybrid-Bridge-rx_error-Diagnose]]
- [x] **Stabilphasen-Monitor deployed** ✅ (16:37) — Variante A (systemd-User+Linger), 60s-Takt, TSV unter `~/printer_data/logs/bridge_stability.log`. 4 Bug-Fixes im livediag-Skript (CAN-State/busoff via JSON, MCU-URL-encoded, dmesg-Multiline). 39-Min-Zwischen-Check 17:20 alle Indikatoren grün.
- [x] **Brain-Struktur-Audit gegen Anker-Backup** ✅ (17:00) — Migration substanzlos sauber. 313=313 md-Files, MD5 Vortags-Dailies identisch, kein Datenverlust. „weniger weit"-Gefühl war UI-State.
- [x] **Mac-Sicherheits-Audit Stufe 1** ✅ (17:10) — alle 6 Phasen ohne rote Treffer. Datei: [[04 Ressourcen/Sicherheit/security-audit-2026-04-30]]
- [x] **Chrome-Extensions Klartext + Permissions** ✅ (17:15) — alle 9 aus offiziellem Web-Store, Datei: [[04 Ressourcen/Sicherheit/chrome-extensions-2026-04-30]]
- [x] **GoogleUpdater deaktiviert** ✅ (16:50) — Chrome-Rest, plist `.disabled_20260430_165012`
- [x] **3Dconnexion-„ifconfig"-BTM-Eintrag geklärt** ✅ (16:45) — nlserverIPalias-Daemon, legitim (SpaceMouse-Treiber-Loopback)
- [x] **SSH-Login-Forensik 90 Tage** ✅ (16:55) — 0 Accepted, 0 Failed, nur Mo selbst

## 🔴 Vor nächstem Mac-Reboot entscheiden
- [ ] **3Dconnexion-Plists**: aktuell `.disabled_20260430_165149` durch CC-Auftrag (eigentlich war (c) lassen-wie-ist gewählt). Suite-Prozesse laufen aktuell im RAM, brechen nach Reboot. **Reaktivieren** (Mo nutzt SpaceMouse für CAD), Befehl:
  ```
  sudo mv /Library/LaunchDaemons/com.3dconnexion.nlserverIPalias.plist.disabled_20260430_165149 \
          /Library/LaunchDaemons/com.3dconnexion.nlserverIPalias.plist
  sudo mv /Library/LaunchAgents/com.3dconnexion.helper.plist.disabled_20260430_165149 \
          /Library/LaunchAgents/com.3dconnexion.helper.plist
  sudo launchctl bootstrap system /Library/LaunchDaemons/com.3dconnexion.nlserverIPalias.plist
  launchctl bootstrap gui/$UID /Library/LaunchAgents/com.3dconnexion.helper.plist
  ```

## 🟡 Stabilphasen-Bewertung (Regel angepasst 2026-04-30)
- [x] **Servo-PWM-Test in der Luft** ✅ (2026-04-30 ~18:50) — Soft-Ramp 52°→125°→52° ohne Tool-Last, Klipper sauber durch. D2-USBSERIAL-Topologie verarbeitet Servo-PWM robust, kein gs_usb-Stress. Details: [[04 Ressourcen/Klipper/Servo-EMI-Mitigation#Update 2026-04-30]]
- [x] **FIRMWARE_RESTART-Test** ✅ (2026-04-30 18:46) — Klipper sauber durch, state=ready, 7/7 MCUs, can0 ERROR-ACTIVE rxerr=0, keine Errors nach Restart. Nebenbefund: `tools_calibrate.py` beim Restart von Klipper zum ersten Mal beim Boot gesehen und schadlos durchgegangen — Modul ist mit aktueller Klipper-Version kompatibel.
- [x] **Pi-Reboot-Test** ✅ (2026-04-30 18:52) — `sudo reboot`, Pi pingbar nach 30s, klipper.service auto-start 18:52:51, state=ready, 7/7 MCUs, can0 ERROR-ACTIVE. Stabilphasen-Monitor mit systemd-User-Linger kommt automatisch hoch (erster Snapshot 18:53:12). Komplette Recovery in 47s ohne manuellen Eingriff. tools_calibrate.py + probe_pin_test reboot-fest.
- [ ] **Lock-Schließen unter Federspannung + Tool-Last** — finaler Crash-Trigger-Test. Erst nach UBEC-Einbau sinnvoll, sonst hohes Crash-Risiko mit Tool im Greifer.

*Hinweis: Ehemalige 24h-Idle-Regel (Endmarke 2026-05-01 ~16:38) entfällt — historische Crashes waren immer servo-PWM-getriggert, nicht zeit-getriggert. Idle-Phase liefert kaum Aussagekraft, Aktiv-Tests sind aussagefähiger. Monitor läuft trotzdem weiter als Hintergrund-Beobachtung.*

## 🟡 Bauphase 0 — Probe-Hardware (vor Stage 09)

Neu strukturiert 2026-04-30 nach Review der Stage-09-Recherche. Stage 09 hat eine Blockier-Kette mit harten Gates, die volle Kette steht in [[04 Ressourcen/Klipper/Stage-09-Tool-Offset-Probe-Recherche#0 Blockier-Kette]]. Diese Tasks sind das **erste Glied**.

- [x] **Probe-Hardware physisch verbaut** ✅ (2026-04-30) — Aluminium-Sockel mit Stahlkugel hinten am Bett mit M5×20 Button-Head verschraubt, Kabel zum Octopus-PROBE-Header.
- [x] **PG10 elektrisch erkannt** ✅ (2026-04-30) — via `gcode_button probe_pin_test` in `~/printer_data/config/stage09-prep/probe-pin-test.cfg` (CC am Vormittag im Zuge des D2-Rollback proaktiv angelegt). Klipper liest Pin als Pull-Up-Input. Stabilphase ungestört.
- [x] **Pinout-Doku aktualisiert** ✅ (2026-04-30) — Probe-Pin-Eintrag in [[04 Ressourcen/Klipper/ProForge5 Pinout|ProForge5 Pinout]] ergänzt.
- [x] **Schalter-Funktionstest am Drucker** ✅ (2026-04-30 17:45–17:57) — Mainsail-Konsole `QUERY_BUTTON BUTTON=probe_pin_test` zeigt sauberen Wechsel: idle = `FREIGEGEBEN/RELEASED`, Stahlkugel gedrückt = `PRESSED (Pin auf GND gezogen)`. Beide Richtungen verifiziert. Bauphase 0 final abgeschlossen, Probe-Hardware komplett betriebsbereit.
- [ ] **Stage 07.4 PH2–PH5 Pickup-Verifikation** — PH1 ist fertig (27.04. `zero_select_x = -99` mechanisch + visuell durch Mo). PH2/3/4/5 brauchen jeweils dieselbe Verifikation: Pickup, Servo-Lock, Carriage-Sensor, Tool hält ohne PWM. Kann erst NACH UBEC-Einbau (sonst Servo-EMI-Crash-Risiko).
- [ ] **Hotend-4-Nase richten oder ersetzen** — offen seit 27.04. (Lehrgeld Servo-Open). Vor Stage 09 Pflicht, sonst Probe-Fehlmessung möglich.
- [x] **`tools_calibrate.py` aus viesturz/klipper-toolchanger** ✅ (2026-04-30 18:26) — auf Pi unter `~/klipper/klippy/extras/tools_calibrate.py` (18.805 B, SHA256 `1d057d0225...01bf07`). Quelle: https://raw.githubusercontent.com/viesturz/klipper-toolchanger/main/klipper/extras/tools_calibrate.py (Makertech-Stage-09-Doku verlinkt darauf). Sicherheits-Check sauber (nur `logging`-Import, keine eval/exec/curl, py_compile OK). Modul schläft bis FIRMWARE_RESTART bei Stage-09-Aktivierung. Klipper-State unverändert, Stabilphase ungestört.
- [ ] **Probe-XY auf reale Position kalibrieren** — MakerTech-Default ist X80/Y270 (NICHT X314/Y379 wie in früheren Brain-Notizen). Bei erstem Run manuell mit `G0` anfahren und gegen Realität prüfen, dann in `calibrate-offsets.cfg` eintragen.

## 🟡 Vorbereitung für Q3-Bridge-Wiederversuch (kein Notfall)
- [ ] **Octopus-CAN-Header-Bauform klären** (Mo am Drucker, gelegentlich): welcher Header, Pinout, ist 120-Ω-Termination-Jumper vorhanden?
- [ ] **Verkabelungs-Plan** falls Bridge-Mode Q3 wieder versucht wird: physisches CAN-Kabel Octopus ↔ EBB36 (dann EBB auf can0 via Octopus-Bridge, U2C raus)
- [ ] **Bridge-Stability-Monitor deployen** (Variante A) auf aktuellen USBSERIAL-Stand — als Baseline-Referenz, nicht mehr Bridge-spezifisch

## Termine

- **🔴 Mo 2026-05-04 — reMarkable Paper Pro bestellen** für Reiners 70er am 16. Mai. Bundle: Paper Pro 11,8" + Marker Plus, **649 €**, reMarkable.com direkt. Connect-Abo bei Checkout ablehnen. Lieferung 3–7 Werktage, Setup-Puffer eine Woche. Plan: [[02 Projekte/reMarkable Paper Pro - Geschenk Reiner]]
- **Sa 2026-05-16 — Reiner 70. Geburtstag** — Übergabe Paper Pro mit erster live-Bens-Korrektur (30 Min). Vorbereitung am Mi 2026-05-13: echte Bens-Zeichnung als PDF auf Pro vorladen.
- ~~U2C V2 Ersatz bestellen~~ ✅ **AUFGELÖST 2026-04-27 Nachmittag** — war Kabel-Wackler, kein Hardware-Defekt. Mit neuem USB-Kabel stabil. 1× U2C als Lager-Backup bleibt sinnvoll, kein Eilthema. Drucker-Stand: alle 5 Tools im Dock, Klipper ready, beide Watchdogs aktiv.
- **HEUTE 2026-04-21 — Volker Bens Lagerschalenhalter mit Reiner:** Überarbeitung auf EHEDG/Lebensmittelindustrie abschließen. Zeichnungs-/BOM-/3D-Abgleich gegen Reiners Korrektur-Scans. Reiner bringt Muster aus früheren erfolgreichen Volker-Projekten (Input für [[04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl|Bens-Lieferstandard]], v.a. STEP-Schema). **White-Label-Prinzip strikt einhalten** (alles unter Bens-Label, kein WEC/Sachsenmilch sichtbar — siehe [[03 Bereiche/WEC/CLAUDE#Volker Bens / Bens Edelstahl|WEC-Regeln]]). Briefing: [[03 Bereiche/WEC/wiki/Kunden/Volker Bens - Lagerschalenhalter Lebensmittelindustrie|Lagerschalenhalter-Wiki]] + [[04 Ressourcen/Playbook/WEC Kundenordner - Muster und Ableitungen|Kundenordner-Playbook]]. Raw: `03 Bereiche/WEC/raw/Kunden/Volker Bens/aktuelle Projekte/Lagerschalenhalter Lebensmittelindustrie/`.
  - [ ] **Zeichnungsnummern final bestätigen:** BE-LS-202603 ist richtig (8 Reiner-Scans belegen). BE-IS-202631 aus CSV war Fehler → global ersetzen
  - [ ] **Schriftfeld-Felder L7/M7 klären:** Konstrukteur/Ingenieur-Name (blank / VB / Bens-Konvention?). **Forensik 2026-05-01:** Fusion 360 schreibt eingeloggten User („Sebastian Hartmann", V2 zusätzlich „Woldrich") in alle Liefer-PDFs. Mit Strategie „Bens in Solid Edge" (Mo 2026-05-01) entfällt das Problem — L7/M7 direkt im Solid-Edge-Template setzen.
  - [x] **Fusion-Template-Quelle lokalisieren** ✅ (2026-05-01) — `07 Anhänge/Allgemein/Profil/SEST4/Templates/WEC/`: `BENS Edelstahl.dwg` (BG, 72 KB) + `BENS Edelstahl - ET.dwg` (ET, 54 KB) + zugehörige Solid-Edge-`.dft`-Drafts. **Es ist ein Solid-Edge-Template, aktuelle Liefer-PDFs kommen aber aus Fusion 360.** Strategie-Entscheidung Mo 2026-05-01: **Fusion 360 + Solid Edge parallel** — Fusion 360 für eigene Konstruktion, Solid Edge für Bens-Lieferungen.
  - [ ] **Pharma vs. Lebensmittel:** Echte GMP-Anforderung oder nur Branding-Slogan? Normen-Stack daraus ableiten. **Forensik 2026-05-01:** „Quality for Pharmacy" weder im Bens-Logo noch in 4 Bens-Templates auffindbar (strings-Scan negativ). Slogan ist vermutlich Brain-Phantom — Reiner bestätigen lassen, dann alle Verweise streichen. Sachsenmilch-Projekt = Lebensmittel, nicht Pharma.
  - [x] **Zeichnungsnummern in BOM konsistent** ✅ (2026-04-20) — BE-IS-202631 war bereits seit 18.04. weg. 4 fehlende `-0`-Suffixe nachgezogen (B8/B19/B26/B29 in `BOM_bereinigt.xlsx`). Offen für Reiner: B16 Welle_V2 / B12 Scheibe_t=1 Konflikt um `203`.
  - [ ] **Vektor-Text „Sebastian Hartmann" aus Liefer-PDFs entfernen.** **Befund 2026-05-01:** Bestätigt in 5 PDFs (`Grundplatte-SM` 2026-02-10, `Zwichenplatte-SM` 2026-02-12, `Lagerhalter` 2026-03-24, `Lagerschale` 2026-03-24, `Zusammenbau V2` 2026-04-16 — letztere zusätzlich „Woldrich"), Erzeuger Fusion 360 (PDF-Metadaten). Strukturelle Lösung: kommende Bens-Lieferungen direkt aus Solid Edge (Bens-Template). Übergangsweise für laufende Lieferung: einmalige PDF-Vektor-Bereinigung der 5 Files.
  - [ ] **Nach Termin:** Erkenntnisse in [[04 Ressourcen/Playbook/WEC Kundenordner - Muster und Ableitungen]] einarbeiten, Bens-Profil aus Stub zu voller Seite ausbauen
  - [ ] **Fehlende Standard-Artefakte anlegen:** `wiki/Kunden/Volker Bens - Zeichnungsindex.md`, `wiki/Kunden/Volker Bens - Profil.md` mit Template aus Playbook
  - [ ] **Schritt 2 (entblockt 2026-05-01): Fusion-Drawing-Template aus WEC.dwg bauen** — Quelle gefunden: `03 Bereiche/WEC/raw/Standards WEC/Templates/WEC.dwg`. Reiner-PDF nicht mehr nötig. Anleitung: [[04 Ressourcen/CAD-Workflows/Fusion 360 Drawing Template L7]]. Pflichtfelder: L7=`Hartmann`, M7=`Woldrich` (Nachname-only), `Date of issue` auto, `Rev.` manuell Startwert `00`. **Diese Anleitung baut das WEC-eigene Template (für eigene/MThreeD-Aufträge); Bens-Klon-Variante mit `Bens_Vordruck.dwg` folgt analog.**
  - [ ] **Reiner: Solid Edge Viewer installieren** (entkoppelt vom Pilot, weiter sinnvoll als Generalwerkzeug) — Anleitung [[02 Projekte/WEC/Onboarding Reiner/Solid Edge Viewer Setup]]
  - [ ] **Sheet Metal DXF Creator in Fusion installieren** (free, nicht-blockierend) — beschleunigt Bens-Liefer-Pipeline. Quelle: [[04 Ressourcen/CAD-Workflows/Fusion 360 Add-Ins]]

### WEC Korpus-Pipeline (Strategie 2026-05-01)

Konzept: [[02 Projekte/WEC Neustart mit Reiner/Strategie - Korpus-Auslesen und KI-Pipeline]]. Stress-Test 2026-05-01 abgeschlossen, Schweregrad-Sortierung in Konzept-Notiz. Klärungs-Tasks:
- [ ] **🔴 Vault-Sweep „SolidWorks" → „Solid Edge" — Restarbeiten** (Update 2026-05-01): 12 Auto-Replaces gemacht (Profil-/Setup-/Doku-Stellen), 8 historische Stellen bewusst gelassen (Daily Notes, Korrektur-Hinweise, Sweep-Meta). Offen — semantischer Eingriff nötig:
  - [ ] `03 Bereiche/WEC/Idee - Claude SolidWorks Integration.md` — komplette Prämisse falsch (Solid-Edge-API ≠ SolidWorks-API). Notiz neu denken oder umbenennen
  - [ ] `02 Projekte/WEC Neustart mit Reiner/Idee - Apple-Strategie für WEC und MThreeD.io.md` — Sektion „Die große offene Frage — SolidWorks" + Tool-Migrations-Argumente überarbeiten
  - [ ] `02 Projekte/MThreeD.io/_MThreeD.io.md:52` + `02 Projekte/WEC/Idee - Zeichnungs-Generator aus Konstruktion.md:7` — Wikilinks nach Umbenennung anpassen
  - [ ] `03 Bereiche/WEC/raw/README.md:15` — Datei-Endungen `.sldprt/.sldasm/.slddrw` → `.par/.asm/.dft`. **raw/-Schutz: nur mit explizitem Auftrag editieren**
  - [ ] `01 Inbox/2026-04-29 Anthropic Anfrage Entwurf.md` — Entwurf vor Versand prüfen
- [ ] **🔴 Daten-Inventar Sebnitz (Phase-2-Vorzieher)** — WinDirStat-Lauf pro Rechner + NAS, IN/OUT-Filter (STEP/DXF/DWG/DFT/PDF/XLSX), Frage-Schema, Aggregations-Datei. Details: Konzept-Notiz Sektion „Phase 2 Vorzieher". Voraussetzung: Sebnitz-/Pirna-Besuch + Reiner-Slot ~3 h
- [ ] **🔴 Sabine-Wissens-Transfer-Pfad** — 4 Monate bis Rente August 2026, in Pipeline-Roadmap fehlend. Norm-/Zeichnungs-Wissen extrahieren bevor sie geht
- [ ] **🔴 Volker-Zustimmung schriftlich** — Bens-Daten-Cloud-Verarbeitung (nicht nur Anthropic-DPA, auch Volker-Verkäufer-Risiko: mündlich begeistert, schriftlich vergessen)
- [ ] **🔴 Reiner-Patent-Klasse als TOP SECRET** — Fahrrad-Federung NIE in Cloud, auch nicht Brückenzeit. Hybrid-Stub von Tag 1 nötig
- [ ] **🟡 Sample-Korpus aus abgeschlossenem Projekt extrahieren** — STEP+DXF+PDF+Stückliste eines Volker-Bens-Abschlusses als Test-Set
- [ ] **🟡 RAG-Test mit Cloud-Claude + messbare Akzeptanzkriterien** — z.B. „Top-3-Treffer richtige Referenz-Zeichnung", nicht subjektiv
- [ ] **🟡 Mac-Studio-Beschaffungs-Drop-Dead-Date** — WWDC Juni 2026; Plan-B definieren falls Verschiebung
- [ ] **🟡 Anthropic-DPA + Solid-Edge-EULA juristisch** — White-Label-Pflicht (Bens) und Training-Erlaubnis-Frage
- **HEUTE 2026-04-21 — SSD-Übergabe an Reiner:** Welcome-Kit zurück + externe SSD als Projektspiegel. Anleitung → [[02 Projekte/WEC Neustart mit Reiner/Anleitung Reiner - Externe SSD Projektspiegel]]

---

## Aktiv

### Hardware-Strategie — Mo + Reiner (neu 24.04.2026)

**Session:** [[02 Projekte/WEC Neustart mit Reiner/Sessions/2026-04-24 Hardware-Strategie Update]]

**Entscheidung nötig:**
- [ ] **Hardware-Szenario wählen:** A (Ultra + Mini Basis), B (Ultra + Mini Pro), oder C (2× Max)
- [ ] **Budget klären:** Privat oder MThreeD.io? Steuerliche Abschreibung?
- [ ] **Use-Cases konkretisieren:** Braucht Mo wirklich 256GB RAM? Konkrete Workloads?
- [ ] **Reiner's Rolle:** Wird er selbst konstruieren oder bleibt er bei Delegation an Mo?

**Obsidian Sync (KRITISCH für Übergangszeit):**
- [ ] **Obsidian Sync für Mo aktivieren** (4€/Monat, jährlich = 48€/Jahr)
- [ ] **Obsidian Sync für Reiner aktivieren** (4€/Monat, jährlich = 48€/Jahr)
- [ ] **Reiner's Obsidian mit Sync verbinden** (nach Windows-Setup oder Mac-Kauf)

**Timing:**
- [ ] **WWDC Juni 2026 abwarten** für finale M5-Specs + Preise
- [ ] **Nach WWDC: Hardware bestellen** (Juli), einrichten (Juli), operativ (August)

### ProForge5 Build — Etappe 1 (CAN-Fundament & Bed-Leveling)

- [x] EBB36 Schlitten flashen ✅
- [x] EBB36 UUID auslesen & in printer.cfg eintragen ✅ (`71c47e0b85cf`)
- [x] 120R-Jumper am EBB36 prüfen ✅
- [x] Endstops X / Y / Dock verifiziert ✅
- [x] Servo-Config eingetragen (`ebb:PB5`) ✅
- [x] Servo testen ✅ (`SET_SERVO SERVO=toolchanger ANGLE=90`)
- [x] TMC Config fixen ✅
- [x] printer.cfg auf offizielle MakerTech-Basis ✅
- [x] X-Endstop verifiziert ✅
- [x] Y-Endstop gefixt ✅
- [x] Homing X testen ✅
- [x] Homing Y testen ✅
- [x] CAN-Bus Auto-Start gefixt ✅
- [x] Tailscale auf Pi neu eingerichtet ✅ — IP `100.90.34.108`
- [x] **Octopus Pro flashen** ✅ — v0.13.0-623-gaea1bcf56 via Software-DFU, Persistenz nach Pi-Reboot bestätigt (16.04.2026)
- [x] **Pi Stromversorgung intern gelöst + verifiziert** ✅ (17.04.2026) — Pi 5 intern aus ProForge5 versorgt via USB-C (2-Draht). `vcgencmd get_throttled=0x0` → kein Throttling, Versorgung stabil.
- [x] **SO3 Boards (PH1–PH5) flashen** ✅ (2026-04-26) — alle 5 mit v4-Firmware (v0.13.0-623, BUTTONS+TMCUART+NEOPIXEL, FLASH_START_0000, je individuelle USB-Serial PH1..PH5). Drei Marathon-Runden nötig wegen schrittweise entdeckter WANT_*-Flag-Lücken. Flash-Adresse korrigiert: **`0x08000000:force:mass-erase:leave`** (NICHT `0x8002000` — Klipper läuft bare-metal ohne Bootloader auf STM32F042). Workaround reduziert von 20 → 3 Zeilen pro cfg (nur tachometer disabled, weil WANT_PULSE_COUNTER nicht gebaut — Hotend-Lüfter-RPM nicht überwacht, nicht sicherheitskritisch). Pi-Reboot-Test bestanden. Details: [[05 Daily Notes/2026-04-26]].
- [x] **Stage 07.4 Pickup-Mechanik verifiziert** ✅ (2026-04-27) — `zero_select_x = -99` für PH1 mechanisch korrekt (visuell + manuell durch Mo bestätigt). SELECT_PH1-Trajektorie sauber durchgelaufen, Tool 1 erfolgreich gegriffen, Servo-Lock formschlüssig zu. Tool hält auch ohne aktive Servo-PWM. Details: [[05 Daily Notes/2026-04-27]].
- [x] ~~U2C V2 Ersatz~~ ✅ aufgelöst (2026-04-27 Nachmittag) — war Kabel-Wackler, kein Hardware-Defekt. Mit neuem USB-Kabel stabil. 1× U2C als Lager-Backup trotzdem sinnvoll, kein Eilthema.
- [x] Tool-1-Recovery ✅ (2026-04-27 Spät-Abend) — manuell via Brain-Sequenz zurück in PH1, alle Sensoren konsistent.
- [x] **Watchdog für can0 + gs_usb** ✅ (2026-04-27) — `/usr/local/bin/gs-usb-watchdog.sh` + systemd-Timer (10s-Intervall). Detection-Pattern `EPIPE|EPROTO|echo id|ENOBUFS` im Kernel-Log. Recovery: stop klipper → unbind/bind USB → can0-cycle → restart klipper bei UUID. Manuell-Trigger 16:29:05 verifiziert, designgemäßes Verhalten.
- [x] **Pi-Kernel-Update CVE-2025-68307** ✅ (2026-04-27) — Patch-Commit `4a82072e451e` (2025-11-08) im laufenden Kernel 6.12.75-1+rpt1 verifiziert. **Konsequenz: gs_usb-Bug nicht mehr Verdächtiger** für Crashes — Power-SPoF/EMI bleibt Hauptverdacht.
- [x] **Pin-Swap t0↔t4, t1↔t3 final verifiziert** ✅ (2026-04-27) — Pickup + Park beide Richtungen sauber. Mapping in [[04 Ressourcen/Klipper/ProForge5 Pinout]] dokumentiert.
- [x] **Lock-Close-Timing gelöst** ✅ (2026-04-27 Spät-Abend) — Hybrid-Macro mit Hard-End-Pulse zu 125° (statt Soft-Ramp+WIDTH=0) griff Tool 1 beim Hybrid-Test 18:40 sauber. Pickup formschlüssig, kein WIDTH=0 mehr. Final-Dwell 1000 ms ausreichend.
- [x] **Strategie-Wechsel: Hartes Schließen vs. asymmetrischer Ramp** ✅ widerlegt (2026-04-27 Nacht) — drei Software-Varianten getestet: Soft 14×50ms, Soft 7×150ms, Hart 1×125→52. Alle drei Pickup ✅ / Park ❌ Crash. **Servo-Bewegungsprofil ist NICHT der Park-Trigger** — EMI-Spike entsteht beim Lock-Engagement gegen Federspannung, nicht durch Bewegungs-Timing. Software-Mitigation-Pfad sauber ausgeschlossen. Details: [[04 Ressourcen/Klipper/Servo-EMI-Mitigation]].

### 2026-04-29 — Hardware-Pfad (BEC zuerst)

**Hoch priorisiert (vor UBEC-Einbau, Lieferung ETA 2–3 Tage):**
- [x] **BEC-Erdungs-Konzept recherchieren** ✅ (2026-04-29) — Single-Point-Ground bei galvanisch getrennten 5V-Versorgungen, Shield-Behandlung CAN-Bus, Ground-Loop-Vermeidung Servo+EBB36+UBEC. Output: [[BEC-Erdungs-Konzept]]. Pflicht-Voraussetzung vor UBEC-Einbau erfüllt.
- [x] **EBB36-Gen2-V1.0: onboard-5V-Brücke zum Servo-Stecker identifizieren** ✅ (2026-04-29) — Befund: existiert nicht. EBB36 Gen2 V1.0 hat keine Lötbrücke/Jumper zur Trennung. Servo läuft am PROBE-Header, VCC kommt über Probe-Voltage-Jumper (24V oder 5V wählbar, kein Aus). Lösung: VCC-Pin am Servo-Stecker offen lassen, Servo-V+ vom UBEC separat zuführen. Optional Probe-Voltage-Jumper komplett ziehen. Details in [[BEC-Erdungs-Konzept]] Schritt 2.
- [x] **Servo-Spec geklärt** ✅ (2026-04-30, self-researched) — MG996R: 4.8V–7.2V, Nominal **6V**, Stall-Strom ~2.5A (Spitze). Makertech-Support unzuverlässig — Spec aus Tower-Pro-Datenblatt + Community eindeutig. UBEC auf **6V**, **≥3A** Dauerstrom einstellen.
- [x] **UBEC bestellt + versendet** ✅ (2026-04-30) — Hobbywing BEC 5A V2-Air UBEC, ~19,87 €, Amazon Prime. Versendet, ETA **6.–8. Mai**. Bestellnr. 303-6541703-0101939. Jumper auf **6.0V** setzen bei Einbau.
- [x] **EBB36 festziehen** ✅ (2026-04-29 ~04:50) — Sebastian-Bestätigung: „fest, kann zu 95% nicht wackeln". Phase-1-Verifikation: Klipper ready, CAN UP, 7/7 MCUs, bus-errors 0/0/0.
- [ ] **Knistern-Test EBB** (niedrig, „wenn am Drucker, kostet 2 Min") — PSU-Aus-Verhalten gegen Vortag vergleichen, ob Mount-Verbesserung das Knistern reduziert.

**Niedrig priorisiert:**
- [ ] **Roadmap-HTML-Korrekturen via claude.ai** — Hub-SPoF-Argument entschärfen (gilt nur für SO3-Pfad), Z-Antennen-Hypothese als „unbelegt" markieren (0 Z-Stepper-Errors), BEC-Erdungs-Konzept als Pflicht-Punkt vor UBEC einfügen.
- [x] **ProForge5 Build.md Zeile 216 korrigiert** ✅ (2026-04-29) — Sebastian-Freigabe ~05:00. Topologie-Eintrag auf 2026-04-29-Wahrheit umgeschrieben. Backup: `ProForge5 Build.md.backup_20260429_topology`.
- [x] **ProForge5 Build.md Zeilen 199 + 254–257 + ASCII-Tree (165–197) + Lessons-Bullet (401) korrigiert** ✅ (2026-04-29 ~05:08, pauschale Sebastian-Freigabe). Datei jetzt vollständig topologie-konsistent. Vault-weite Final-Verifikation sauber.
- [x] **TTS-Briefing-Template als Workflow-Asset** ✅ (2026-04-29) — angelegt unter `04 Ressourcen/Workflow/TTS-Briefing-Template.md`. Standard-Prompt-Skelett für Audio-Briefings, basiert auf bewährtem Format vom Morgen.
- [x] **ProForge5 Architektur-Review 2026 erstellt** ✅ (2026-04-29 ~05:35) — CC-Recherche-Agent unter 5-Toolhead-Constraint, 30 Quellen, Top-3: (1) Octopus CAN-Bridge-Mode, U2C raus (Q3); (2) EBB36 clean reflash + UBEC-Entkopplung (Q2); (3) Kalico evaluieren NICHT vor Q4. SO3/Eddy/Stepper/Pi 5 bewusst nicht angefasst. Datei: [[04 Ressourcen/Klipper/ProForge5-Architektur-Review-2026]].
- [x] **USB-Disconnect-Tiefendifferenzierung** ✅ (2026-04-29) — 5994 Roh-Events seit 26.04. klassifiziert als **HARMLOS**: Bursts korrelieren mit U2C-Kabel-Wackler 27.04. 19:28–21:00, seither ruhig. Klipper sieht 0 echte Disconnects, Watchdog-Timer-Logs erklären Volumen. Punkt geschlossen. Details: [[05 Daily Notes/2026-04-29]] Phase 4.
- [x] **Octopus-Bridge-Flash-Versuch v1 + Rollback** ✅ (2026-04-29 ~06:08–06:25) — v1-Bin hatte falsche Pins (PB8/PB9 statt PD0/PD1) wegen Kconfig-Choice MMENU↔CMENU verwechselt. Drucker via Rollback sauber zurück. Details: [[05 Daily Notes/2026-04-29]] Phase 13.
- [x] **Bridge-FW v2 sauber gebaut** ✅ (2026-04-29 ~06:50) — Pin-Konflikt-Hypothese bestätigt, `CMENU_CANBUS_PD0_PD1=y` korrekt gesetzt, klipper.dict zeigt `RESERVE_PINS_CAN: PD0,PD1`. Flash-Skript v2 mit `--path 1-2`, neues `verify_bridge_persistent.sh`. SD-Card-Auto-Flash-Hypothese widerlegt (keine SD eingelegt) — Auto-Revert-Mechanismus offen. Details: [[05 Daily Notes/2026-04-29]] Phase 14.
- [x] **Octopus-Bridge-Flash-Versuch v2 + zweiter Revert** ❌ (2026-04-29 ~18:55–19:10) — v2-Bin (PD0/PD1 verifiziert) erfolgreich geflasht, Bridge-FW lief im RAM (Octopus-UUID `2e8e7efafd9b` auf can1, gs_usb sichtbar), nach Cold-Boot erneut Revert auf USBSERIAL v0.13.0-593. **Pin-Konflikt-Hypothese widerlegt.** Backup-MD5 vor v1-Flash und vor v2-Flash identisch (`b3f8e28...`) — App-Slot wird gespiegelt oder bei Reset überschrieben. Nebenbefund: USB-Hub + U2C kurz stromlos durch Cold-Boot-Sequenz, Pi-USB-Stack OK, alle Devices nach Wiederherstellung automatisch zurück. Klipper jetzt wieder `ready`, 7/7 MCUs. Details: [[05 Daily Notes/2026-04-29]] Phase 15.
- [x] **Bridge-FW Auto-Revert-Mechanismus geklärt + eliminiert** ✅ (2026-04-29 ~22:00) — Ursache: BTT-Bootloader-Recovery-Master überschrieb App-Slot beim Cold-Boot. Lösung: Katapult-Bootloader via DFU+`mass-erase` an `0x08000000` ersetzt BTT komplett. Cold-Boot-Persistenz-Beweis erbracht (Bridge-FW v2 als `1d50:606f` nach Power-Cycle stabil). Details: [[05 Daily Notes/2026-04-29]] Phase 16.
- [x] **Octopus auf USBSERIAL zurückgerollt (Katapult bleibt)** ✅ (2026-04-29 ~23:25) — Bridge-Mode-Klipper-Connect schlug fehl (`Timeout on identify_response` auf can0/can1, UUID `2e8e7efafd9b` via fasthash64 berechnet). Sebastian-Entscheidung Option A: App-Slot mit `octopus.bin` USBSERIAL via Katapult-DFU geflasht, printer.cfg auf `serial:`-Zeile zurück, Klipper ready, 7/7 MCUs. Details: Phase 17.
- [x] **Bridge-Mode-Connect-Debug** ✅ (2026-04-30 ~01:15) — H1 (`txqueuelen 128` + can1 UP) wirksam. Erste Connect-Fehler waren so3_0-Shutdown-State aus voriger Session, kein Bridge-Problem. `FIRMWARE_RESTART` + can1-Wiederhochbringen löste es. **Hybrid-Bridge live:** `[mcu] canbus_uuid: 2e8e7efafd9b, canbus_interface: can1`, EBB36 weiter via U2C/can0. Klipper ready, 7/7 MCUs. Details: [[05 Daily Notes/2026-04-29]] Phase 18.
- [ ] **24 h Stabil-Phase Hybrid-Bridge** (bis ~01:15 2026-05-01) — keine ENOBUFS/EPROTO/Lost-Comm beobachten, alle 7 MCUs durchgehend `ready`.
- [ ] **`can1`-Konfig FIRMWARE_RESTART-fest** — aktuell durch H1 manuell gesetzt (txqueuelen 128). Sauber via systemd-networkd-Drop-in dokumentieren, damit `FIRMWARE_RESTART` und Reboot can1 korrekt hochbringen.
- [ ] **Octopus CAN-Header (PD0/PD1) Bauform-Verifikation** (Priorität B, blockiert Bridge-Migration Schritt 6): Steckerbauform am physischen CAN-Header des Octopus Pro V1.1 H723 visuell klären — Stiftleiste? JST-XH? Schraubklemme? Molex Picoblade? Brain dokumentiert nur die Pin-Belegung (PD0/PD1), nicht die Bauform. Ohne diese Information ist OPTION A der U2C-Komplettentfernung ([[Octopus-CAN-Bridge-Migration]] §Pfad-Optionen) nicht sauber planbar (Adapter/Crimp-Bedarf abhängig von Bauform). Umsetzung: ein Foto vom Octopus-CAN-Header bei nächster Drucker-Session, zusätzlich BTT-Schaltplan-Snippet im Brain ablegen.
- [x] **Zusammenarbeits-Regeln im Brain verankert** ✅ (2026-04-29 ~05:40) — vier Regeln (Constraint-First, Keine Lob-Sätze, CC-Faktencheck Pflicht, Zeitrechnungs-Sorgfalt) in [[CLAUDE]] eingefügt + [[Prinzipien]] neu angelegt. Backup `CLAUDE.md.backup_20260429_collaboration_rules`. Synchron mit claude.ai-Memory 13–16. Daily Note Phase 10.



- [x] **Pfad-D-Patch macros.cfg** ✅ (2026-04-28) — Auto-Park in `_END_PRINT` deaktiviert + `_SERVO_DOCK` zu No-Op. Backup `macros.cfg.backup-2026-04-28-PfadD`. Greift sofort. Pickup-Pfad bleibt davon unberührt.
- [x] **Pickup-Test mit Hybrid-Macro** ❌ (2026-04-28) — Crash bei `_SERVO_SELECT` (eventtime 7038.9: `Got error -1 in can read: (100)Network is down`), `canstat_ebb` durchgehend sauber. **Beide Crashes (Park + Pickup) sind dieselbe Klasse: Servo-PWM-EMI auf gs_usb-Bridge.** Hybrid-Macro als Software-Mitigation **widerlegt**. Details: [[05 Daily Notes/2026-04-28]].
- [ ] **Hobbywing UBEC 5A Air V2 bestellen** (15-25 €, 2-3 Tage Lieferung) — primäre Hardware-Mitigation, separate 5V-Quelle für Servo, gemeinsame Masse nur am EBB-GND
- [ ] **Klappferrit besorgen** (Reichelt/Conrad/Amazon, ~5 €) — sekundäre Mitigation am U2C-USB-Kabel + ggf. Servo-Kabel
- [ ] **Multimeter besorgen** (falls nicht vorhanden) — für CAN-Termination-Check
- [ ] **CAN-Termination-Check VOR BEC-Einbau** — Drucker-PSU AUS, USB U2C ziehen, 200 Ω-Range, CANH gegen CANL: Erwartung 60 Ω (= beide 120 Ω parallel)
- [ ] **Mail Makertech** wegen Servo-Spec / STEP-Files (für ggf. späteren Stepper-Umbau)
- [ ] **Nach BEC-Einbau: Pickup+Park Stress-Test** alle 5 Tools, gs_usb-Watchdog-Counts überwachen
- [ ] **Auto-Recovery-Macro entwerfen** — Trigger: Klipper-Boot mit `Carriage=PRESSED` + ein `t_X=RELEASED`. Sequenz: Boot → Macro erkennt Tool am Schlitten → fährt zu PHx → **HARTE PAUSE mit Mo-Bestätigung „Tool in Hand"** → ERST DANN `SET_SERVO ANGLE=52` → Tool-Drop in PH → `SET_SERVO ANGLE=125` → Sensor-Verify. Kritisch: Servo-Open NIE ohne Mo-Bestätigung (Lehrgeld 2026-04-27: Hotend-4-Nase verbogen)
- [ ] **Hotend-4-Nase richten oder ersetzen** — Schadensbewertung visuell + ggf. Funktionstest
- [ ] **Stage 09 Tool-Offset-Probe** — Voraussetzung: Stage 07.4 alle 5 Tools sauber

### 2026-04-30 — Slicer-Setup & Folge-Tasks

- [x] **Stabilphasen-Monitor deployed** ✅ (2026-04-30 16:37) — Variante A (systemd-User+Linger) aktiv, 60s-Takt, TSV-Log unter `~/printer_data/logs/bridge_stability.log`. Skript-Bugs aus Pre-D2-Zeit gefixt (can_state/busoff via JSON, MCU-Namen URL-encoded, dmesg-Multiline-Bug entschärft). Drei Snapshots verifiziert: 18 Felder, can0=ERROR-ACTIVE, 7/7 MCUs, throttled=0x0. Endmarke 24-h-Phase: 2026-05-01 ~16:38. Details: [[05 Daily Notes/2026-04-30]].
- [ ] **Stabilphasen-Auswertung 2026-05-01 ~09:00** — `~/bridge_stability_summary.sh` laufen lassen. Vorher Spalten-Indizes im summary-Script gegen das gepatchte livediag prüfen (TSV-Schema unverändert, sollte passen).
- [ ] **Stage-09-Recherche reviewen:** [[04 Ressourcen/Klipper/Stage-09-Tool-Offset-Probe-Recherche]] — 5 offene Punkte (Hardware-Sichtcheck Probe-Schraube/PG10, Servo-Spec-Mail, PH2-PH5-Verifikation, Probe-XY, Macro-Body aus GitHub).
- [ ] Single-Tool-Druck Z-OffsetTest (Test-Datei aus `02 Projekte/ProForge5 Build/assets/`) — erster Real-Test des gepatchten Slicer-Profils
- [ ] Servo-EMI Hardware-Mitigation: BEC-Mount drucken (Hobbywing UBEC 5A Air V2)
- [ ] Servo-EMI Hardware-Mitigation: Klappferrit-Halter drucken
- [ ] Klappferrit am MX3.0-Kabel montieren, Park-Test wiederholen
- [ ] Bei weiterhin Crash: separate 5V-PSU für Servo (BEC) verbauen
- [ ] Tool-Offset-Probe Stage 09 (nach erfolgreicher Servo-EMI-Mitigation)
- [ ] Multi-Tool-Sperre M112 in Slicer-Profil entfernen (nach Stage 09 abgeschlossen)
- [ ] Slicer-Profil-Snapshot in `02 Projekte/ProForge5 Build/slicer-profile/` ablegen (Versions-Kontrolle Mo-spezifischer Anpassungen)

### Patches die beim nächsten Klipper-Boot greifen

- [x] **Filament-Sensor Auto-Heating-Patch** ✅ (2026-04-27 Nacht) — alle 5 so3_X.cfg `release_gcode` neutralisiert. Backup unter `/home/m3d/printer_data/config/backup_filament_safety_<TS>/`. Greift beim nächsten Klipper-Boot. Details: [[04 Ressourcen/Klipper/SAFETY-Filament-Sensor-AutoHeating]]
- [ ] **Live-Diag-Tracker-Pattern dokumentieren** (2026-04-28) — `/home/m3d/livediag_tool1.sh` als Vorlage festhalten. Tracker (200 ms) korreliert `bytes_retransmit` ↔ `servo.value` ↔ `toolhead.position`. Hat heute den Crash-Pfad sauber lokalisiert. Pattern als Standard-Werkzeug für Hardware-Stress-Tests.
- [ ] **FIRMWARE_RESTART → ENOBUFS-Hang separates Diagnose-Thema** (2026-04-28) — neues Crash-Pattern, unabhängig von Servo-Last. Soft-Recovery (unbind/bind) wirkungslos, nur PSU-Cycle räumt auf. Workaround: `sudo systemctl restart klipper` statt FIRMWARE_RESTART.
- [ ] **gs_usb-Watchdog Detection-Pattern um ENOBUFS + Network is down erweitern** (2026-04-29) — heutiger 4. Hang loggte ENOBUFS nur ins Klipper-Log, nicht ins Kernel-Log → Watchdog triggerte nicht. Pattern auf Klipper-Log mit `Got error -1 in can read.*Network is down` erweitern, oder zusätzlichen Detector auf `bus_state != active` über JSON-RPC.
- [ ] **Recovery-Pfade.md erweitern** (2026-04-29) — Trigger-Liste für gs_usb-Down-Klasse: `_SERVO_DOCK`, `_SERVO_SELECT`, jeder Servo-PWM-Macro. Keine neue Sub-Klasse "Post-Pickup-Crash" — gleiche Klasse, andere Trigger.
- [ ] **Servo-EMI-Mitigation-Strategien.md aktualisieren** (2026-04-29) — Hybrid-Macro-Sektion ergänzen: "in Praxis nicht ausreichend, am 2026-04-28 widerlegt durch Pickup-Crash trotz 14×Soft+Hard-End".
- [ ] **Stage 07.4 Final-Test alle 5 Tools** (2026-04-28) — mit Soft-Ramp + korrektem Lock-Timing. Voraussetzung: Lock-Timing oben.
- [ ] **Stage 09 Tool-Offset-Probe** (2026-04-28) — Kalibrierung „Kugelchen-Messung". Voraussetzung: Stage 07.4 alle 5 Tools sauber.
- [ ] **Brain-MCP-Connector für Claude.ai** (2026-04-28) — Anbindung Brain-Vault über MCP, Claude.ai kann lesend zugreifen ohne Filesystem-Connector-Latenz.
- [ ] **Servo-EMI Hardware-Mitigation langfristig** — dedizierte 5V-Versorgung für Servo, Ferrit am Servo-Kabel. Soft-Ramp ist Software-Patch, kein Root-Cause-Fix. Details: [[04 Ressourcen/Klipper/Servo-EMI-Mitigation]].
- [ ] **EBB36 clean flashen** — v0.13.0-623 ohne "-dirty" (DFU-Verfahren)
- [x] 4.7kΩ Pull-Up Widerstände — nicht mehr nötig ✅
- [x] Eddy Coil kalibrieren ✅
- [ ] **Input Shaping kalibrieren** — ADXL345 am EBB36 (blockiert bis CAN wieder läuft)
- [ ] **USB-Webcam anschließen & Crowsnest einrichten**

### ProForge5 Remote-Zugriff — Feinarbeit

- [ ] Nach WLAN-Umstellung Pi → echtes Netz: cloudflared-Protokoll von `http2` zurück auf `quic` (config.yml auf Pi, siehe [[02 Projekte/Cloudflare Tunnel Setup — ProForge 5]]).

### WEC Neustart mit Reiner

- [ ] **Fernzugriff einrichten** — AnyDesk auf Reiners PC, dann vom Mac verbinden
- [ ] **Reiners Gehirn einrichten** — ZIP auf seinen PC, Obsidian + Claude Desktop verbinden
- [ ] **Pfändung Mail absenden** — Reiner schickt fertige Mail an Vollstreckung@pirna.de
- [ ] **🔥 Pilot: Lagerschalenhalter Volker Bens** — Zeichnungsnummern passen nicht (Reiner scannt, kommen per Mail/Stick). Fix gegen bestehende Excel-BOM und 3D-Daten abgleichen — konkretes Pilotprojekt für Fix-Prozess bei Zeichnungs-/BOM-Inkonsistenzen
- [x] **BOM White-Label-Bereinigung** ✅ (2026-04-18) — Lagerschalenhalter-BOM bereinigt (6 Befunde: hartmann@w-ec.de × 3, SM_Lagerschale → AM_Lagerschale, Hartmann/Woldrich leer). Bereinigte Version: `03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/2026-04-21 Montag-Session/BOM_bereinigt.xlsx`. Offen für Montag: L7/M7-Konvention (leer/VB/Bens-Name) + STEP-Schema AP203 vs. AP214.
- [ ] **Lieferung Volker Bens** — 2D-PDF, 3D-PDF, STEP (AP203), Stückliste CSV fertig machen
- [ ] **Windows Terminal auf Reiners PC** — installieren damit Claude Code funktioniert
- [ ] **OneNote Autostart deaktivieren** auf Reiners PC
- [ ] **WEC Mail einrichten** — Passwort von Reiner holen, dann `hartmann@w-ec.de` in Apple Mail
- [ ] **Apple Mail aktivieren** — iCloud-Account (`modern3b@icloud.com`) über Systemeinstellungen → Internetaccounts
- [ ] **Externe SSD Projektspiegel** — Reiner prüft alternativen Hersteller (Kosten), Richtwert ≥ 1.000 MB/s, 2 TB, USB-C

### Mac-Inventur (Pilot für WEC-Rollout)

- [x] **Etappe 1 Phase 1+2 komplett** ✅ (2026-04-18) — 708 Dateien vorsortiert, 211 gesichtet + verarbeitet (Müll, Installer, iPhone-Fotos, Duplikate, Kollisionen), ≈ 14 GB freigegeben. Skripte `mac-inventur.sh` + `duplikate-check.sh` erprobt, Skill „Duplikat-Prüfung per md5" als beherrscht dokumentiert.
- [ ] **Etappe 1 Phase 3** — 175 von 188 verbleiben. Vorsortierung: [[02 Projekte/Mac Inventur - Phase 3 Vorsortierung]]
  - [x] **Session 1 Bens** ✅ (2026-04-18) — 13 Dateien nach `03 Bereiche/WEC/raw/Kunden/Volker Bens/` (9 Projekt + 4 Standards & Vorlagen), Inbox-Notiz → `wiki/Kunden/`, Ingest.md aktualisiert
  - [x] **Session 2 ProForge5** ✅ (2026-04-18) — 22 Dateien bearbeitet: 19 verschoben in neuen `02 Projekte/ProForge5 Build/` (Ordner-Umwandlung, Unterordner assets/backups/snapshots/firmware/slicer-profile), 4 in Papierkorb (~1,8 GB), 3 Transkripte + CAN-Bus-Doku nach `04 Ressourcen/Klipper/`. firmware.bin via md5-Match als Octopus-Pro-Stock-Firmware identifiziert.
  - [x] **Session 3 Finanzen** ✅ (2026-04-18) — 12 Dateien (statt 10) nach `03 Bereiche/Finanzen/` mit Unterordnern Bescheide/, Bescheide/Scans 2026-02/, Persönlich/, Rechnungen/. Alle md5-verschieden, alle behalten. Hartmann-PDFs passwortgeschützt → Persönlich. Meshy-Rechnung an Ildi → Rechnungen.
  - [x] **Session 4 1Password-Migration** ✅ (2026-04-18) — 15 Dateien (statt 14, +`1Password for Safari`-Executable). 4 in Papierkorb (3 Installer/Diagnostics + 1 generisches FIDO-Info-PDF), 11 bleiben physisch in `~/Mac-Inventur/` für Sebastian-Aktion (4 Recovery-Codes → Schlüsselbund, 4 Emergency Kits → physisch/verschlüsselt, 3 Safari-Reste). Checkliste: `03 Bereiche/Finanzen/Persönlich/1Password Migration - Offene Punkte.md`. **Keine Code-Inhalte im Vault** (CLAUDE.md-Regel).
- [ ] **1Password-Migration manuell abschließen** — 11 offene Punkte aus Session 4. Checkliste: [[03 Bereiche/Finanzen/Persönlich/1Password Migration - Offene Punkte]]
  - [x] **Session 5a Konstruktion (Verschieben + Papierkorb + Parkplatz)** ✅ (2026-04-18) — 43 Dateien (statt geschätzt 32). 9 verschoben (Topf, CLAM Vase, Stone Wolf — `Stone Wolf Build` von Datei zu Ordner umgestellt, neue Projekt-Hubs für Topf + CLAM Vase angelegt). 4 in Papierkorb (Fremd-Refs: BOTE Barock, iPhone17Pro, 3DBenchy, Meshy-AI). 30 in Parkplatz: [[02 Projekte/Mac Inventur - Konstruktion Parkplatz]] — 6 Blöcke (bene GmbH, Raise3D-Flotte, Korb, SM-Teile, Pixelmator-UUID, Spielereien).
  - [x] **Session 5b Konstruktions-Parkplatz (4 von 6 Blöcken)** ✅ (2026-04-18) — Sebastian-Freigabe für Default-Empfehlungen. 22 in Papierkorb (Block 1 bene GmbH, Block 2 Raise3D-Flotte, Block 4 SM-Teile, Block 6 Spielereien) + 1 verschoben (Zuschnittservice-Preisliste → neuer Ordner `04 Ressourcen/Lieferanten/`, `.pdf0`-Endung korrigiert). Erwartung „80 %+ Spielereien weg" hat sich auf 100 % bestätigt.
  - [ ] **Session 5b Rest — Korb + Pixelmator** (7 Dateien, ~710 MB) — Block 3 Korb (3 Dateien): Bens-Kontext oder eigenes Projekt? Block 5 Pixelmator UUID 1F9384A9 (4 Dateien): Sebastian öffnet einmal in Pixelmator. Details: [[02 Projekte/Mac Inventur - Konstruktion Parkplatz]]
  - [ ] **Session 6 ItsLitho** (19 Dateien) → danach Rest (67)
- [ ] Etappe 1 Abschluss — `~/Mac-Inventur/` leeren und löschen
- [ ] Etappen 2–7 — `~/Documents/`, iCloud Drive, `~/Pictures/`, Apps, `sort-brain`-Dauerbetrieb, Playbook extrahieren (Ziel: vor WEC-Start in Pirna, August 2026)

### System & Werkzeug

- [x] `brain`-Alias in ~/.zshrc auf iCloud-Pfad korrigiert ✅ (16.04.)
- [x] `resize-for-claude.sh` + `rfc`-Alias eingerichtet ✅ (16.04.)
- [x] Desktop aufräumen ✅ (16.04.)
- [x] **Screenshot-Speicherort umgestellt** ✅ (16.04.)
- [x] **Claude Code Auto-Update strukturell gefixt** ✅ (16.04.)
- [x] **Claude Code auf Opus 4.7 aktualisiert** ✅ (16.04.)
- [x] **Cloudflare-Account verbunden** ✅ (16.04.)
- [ ] `.md`-Standardapp von Ulysses auf Obsidian umstellen
- [x] **Claude Code geupdated** ✅ — `npm i -g @anthropic-ai/claude-code` (v2.1.112, 17.04.)
- [x] **autoUpdates aktiviert** ✅ — `~/.claude/settings.json` gesetzt (17.04.)
- [ ] **`claude doctor`** — manuelle Verifikation im Terminal (nicht kritisch)
- [ ] **Memory-Konsolidierung Claude.ai** (2026-04-27 neu) — Limit von 30 Memory-Einträgen erreicht. Lessons müssen vorrangig in Vault leben. Konsolidierungslauf: redundante/veraltete Memory-Einträge identifizieren, in Vault überführen wo nicht schon dokumentiert, Memory bereinigen für neue Einträge.

### Git-Backup

- [x] **Remote-Push auf `origin/main` repariert** ✅ (2026-04-21) — `git filter-repo --strip-blobs-bigger-than 10M` entfernte alle Großdateien aus History (Firmware-Zip 2,7 GB, Proforge4-STEP 202 MB, CLAM-Vase-OBJ/STL/3MF, Topf-OBJ/STEP, Sicat-PDF/PAR/DOCX). `.git` 3,6 GB → 273 MB, Force-Push durch (Initial-Commit-Divergenz überschrieben). Backup `.git.backup_20260420_174612` parallel zum Vault. Leak-Pfade (Fusion360, Reiners_Gehirn, Topologie-Screenshot, .claudian) waren bereits per `.gitignore` nicht im Tracked-Set — kein Filter-Eintrag nötig. Tag `vor-bens-termin-2026-04-21` muss neu gesetzt werden (SHAs geändert) — offen wenn gebraucht.

### Vault-Struktur (offen aus 19.04. Schema-Durchlauf)

- [ ] **🟡 Entscheidung Datensatz_SK** — `07 Anhänge/Allgemein/Datensatz_SK` (4,1 GB, 4273 Dateien): Sabines USB-Stick-Dump. Empfehlung: raus aus Vault → externe SSD/T9 oder `06 Archiv/Alte Auftraege/SK-Bestand/`. iCloud-Sync-Entlastung.
- [ ] **🟡 Entscheidung Solid-Edge-Profil** — `07 Anhänge/Allgemein/Profil` (144 MB): komplett zu WEC migrieren (`03 Bereiche/WEC/raw/Standards WEC/Solid Edge Profil/`) oder nur ausgewählte Templates? Laut [[03 Bereiche/WEC/Operationen/Ingest|Ingest.md]] offen.
- [x] **Kaputtes Tag fixen** ✅ (2026-04-20) — war kein echter Tag im Einsatz, nur irreführender Pipe-Platzhalter im Wiki-README-Template (`[wiki, wec, kunde|norm|standard|bwl]`). Auf `<kategorie>`-Platzhalter mit Kommentar umgestellt.
- [x] **Daily-Notes-Lücke** ✅ (2026-04-20) — 07.–12. April als bewusst leer markiert via Sammel-Notiz [[05 Daily Notes/2026-04-07_bis_12_keine-eintraege]]. Keine Commits in dem Fenster, Vault-Setup-Phase.
- [x] **`brain-lint.sh` Baseline** ✅ (2026-04-20) — ausgeführt. Befunde: 20 Dateien ohne Kopfdaten (hauptsächlich `03 Bereiche/Ildi/` = ungarisch, Ildikó-Bereich), 1 Tag-Fehler (Template `daily-note` → `tagesbuch` gefixt), 20 broken Wikilinks (Stichprobe) — davon die meisten absichtliche Skills-Roadmap-Stubs, 2 echte im Playbook „Montag-Vorbereitung — Bens Zeichnungsabgleich" (`Zeichnungsnummern-Abgleich`, `White-Label Bereinigung`) die durch das finale `Aenderungsprotokoll.md` ersetzt wurden.
- [ ] **Playbook „Montag-Vorbereitung — Bens Zeichnungsabgleich" nachziehen** — tote Links auf nie-erstellte Geschwister-Dateien durch Verweise auf das tatsächlich erzeugte [[03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/2026-04-21 Montag-Session/Aenderungsprotokoll|Aenderungsprotokoll]] ersetzen. Nach Reiner-Session, wenn das Playbook retrospektiv aktualisiert wird.
- [ ] **Aliase in ~/.zshrc** — `blint`, `bstats`, `bdaily` für die neuen Scripts (optional, siehe [[04 Ressourcen/Scripts/README]]).

### Sicherheit (AMOS-Vorfall 17.04.)

- [x] **AMOS-Akut abgeschlossen** ✅ (2026-04-26) — Pi-Forensik + SSH-Härtung, Mac-Forensik, Recovery-Codes-Hygiene, AnyDesk-Inventur, Anleitung_Mac.pdf einsortiert. Runbook: [[04 Ressourcen/Sicherheit/AMOS Runbook 2026-04-26]] · Tagesbuch: [[05 Daily Notes/2026-04-26]].

**Verbleibend für eigene Sessions** (keine Zeitkritik):

- [ ] **🔥 claudian-Plugin prüfen oder ersetzen** — möglicher AMOS-Vektor, läuft solange aktiv (höchste Priorität der Restpunkte)
- [ ] **Chrome-Passwörter-Inventar** (`chrome://password-manager/passwords`)
- [ ] **Pi `pi`/`m3d`-Passwörter rotieren** — optional, mit SSH-Härtung weniger dringlich
- [ ] **Pi Tunnel-Credentials** ggf. rotieren (abhängig von Generierungsort)

### Sicherheit Mac (neu 2026-04-30)

- [ ] **DXF Viewer Chrome-Extension deaktivieren** (Hygiene-Punkt aus Stufe-1-Audit) — einzige Drittanbieter-Extension mit `<all_urls>` für einen Viewer ungewöhnlich. Bei Bedarf reaktivieren. Fusion + native Apps öffnen DXF eh selbst. Reduziert Angriffsfläche. Erledigt-Pfad: chrome://extensions → DXF Viewer → Toggle aus.
- [ ] **SSH-Härtung Mac am physischen Gerät** — Mo nutzt SSH-zum-Mac vom iPhone via Tailscale. 90-Tage-Forensik sauber (0 fremde Logins/Versuche). Nicht akut, aber empfohlen:
  - PasswordAuthentication no in /etc/ssh/sshd_config (nur Keys)
  - SSH-Key vom iPhone (Termius/Blink/Working Copy) auf Mac-`~/.ssh/authorized_keys` einrichten
  - Optional: Tailscale SSH statt OpenSSH (granular per ACL, MagicDNS)
  - **Pflicht: am physischen Mac sitzend ausführen, nicht über iPhone-Session.** Konfig-Fehler kappt sonst Zugriff.
- [x] **GoogleUpdater deaktiviert** ✅ (16:50) — Chrome-Rest, plist umbenannt nach com.google.GoogleUpdater.wake.plist.disabled_20260430_165012
- [x] **3Dconnexion-Suite Sicherheits-Check** ✅ (16:50) — „ifconfig"-Hintergrund-Eintrag entpuppte sich als legitimer 3Dconnexion-Treiber (nlserverIPalias, Loopback-Alias). SpaceMouse aktiv genutzt, Suite bleibt aktiv.
- [x] **SSH-Login-Forensik** ✅ (16:55) — 90-Tage-Logs sauber: 0 Accepted, 0 Failed. Nur Mo selbst eingeloggt.

---

## Geplant

### MThreeD.io — Geschäftsaufbau

- [ ] **🔥 Steuerberater mit DE-HU-Expertise konsultieren** — Ildi hat Gewerbe in Ungarn angemeldet, wohnt aber in Deutschland. Zu klären: (1) Ort der Geschäftsleitung (§ 10 AO) → Risiko Betriebsstätte in DE, (2) KATA-Pauschalsteuer seit 2022 nur noch für Privatkunden nutzbar, (3) Fremdvergleichsgrundsatz bei Rechnungen zwischen Sebastian/MThreeD.io und Ildis ungarischem Gewerbe, (4) sauberer Weg für Weiterberechnung von Tools wie Meshy (EU-Reverse-Charge). Anlass: Meshy-Rechnung Jan. 2026 (€114) ausgestellt auf Ildi — nicht als MThreeD.io-Betriebsausgabe absetzbar ohne geklärte Konstruktion. Vor weiteren Rechnungen auf Ildis Gewerbe klären.
- [ ] Website / Online-Präsenz aufbauen
- [ ] Angebot & Preisstruktur definieren
- [ ] Erste Referenzprojekte dokumentieren
- [ ] Druckerkapazität aufbauen (ProForge5 + Stone Wolf)

### Stone Wolf Build (startet nach ProForge5)

- [ ] Specs und Anforderungen definieren
- [ ] Komponenten beschaffen
- [ ] Bauplan erstellen

### Jarvis — Sprachassistent (Phase 1 ready zum Bauen)

- [ ] **Phase 1 Solo Mac, Read-Only** (1–2 Abende mit CC) — Wake-Word + Whisper.cpp + Claude Agent SDK + ElevenLabs, nur Briefing/Status sprechen, keine Aktionen. Akzeptanz: „Jarvis, briefing" → Antwort in 3 s. Plan: [[02 Projekte/Jarvis - Sprachassistent]]
- [ ] Phase 2 Aktionen + iPhone (1 Abend) — Mail/Kalender via AppleScript, Siri-Shortcut → Tailscale → Mac
- [ ] Phase 3 Proaktiv (offen) — Drucker-Milestone, Mail-Watcher Bens/Knauf
- [ ] Wake-Word entscheiden („Jarvis" vs. eigenes — openWakeWord-Lizenz prüfen)
- [ ] ElevenLabs-Stimme aussuchen (deutsch, männlich, ruhig)

### Jarvis Phase 1 — Härten

- [x] **Phase 1.1 — Streaming-Path** (2026-05-01). Satz-für-Satz-Streaming: Claude `messages.stream` → ElevenLabs `convert` pro Satz → afplay-Queue im Player-Thread. Gemessen: 3.4 s erreicht (vorher 71 s, 95 % Reduktion). 446 ms über 3-s-Ziel — akzeptiert weil weitere Optimierung schlechter Trade (Komma-Trigger=Prosodie-Risiko, Kontext kürzen=schlechtere Briefings, Whisper tiny=mehr STT-Fehler).
- [x] **Phase 1.2 — VAD statt 4s-Festfenster** (2026-05-01). webrtcvad-wheels, Aggressiveness 2, 30-ms-Frames, Stop bei 800 ms Stille (min 500 ms, max 15 s). Aufnahme-Dauer dynamisch (1.6 s kurz / 4 s lang gemessen). Bonus: bei kurzer Aufnahme first_audio = 2823 ms (Phase-1.1-Ziel erreicht).
- [ ] **Phase 1.3 — Tool-fähige Claude-Klasse — Code fertig, Live-Test ausstehend** (2026-05-01). `claude_client.py` `JarvisClient`-Klasse mit `register_tool` + Streaming-Loop für Tool-Use bis `max_tool_iters`. In `jarvis.py` integriert (haupt + tool-client). Live-Test ausstehend. Commit: 1d0d42c.
- [x] **Phase 1.4 — Wake-Word-Debounce** (2026-05-01). 500 ms Stream-Drain nach Detection in `listen_for_wake`. Defensive Maßnahme — der ursprüngliche Doppel-Wake-Bug war vermutlich Multi-Prozess-Log-Artefakt (mehrere Jarvis-Instanzen schrieben parallel ins selbe JSONL), nicht echter Doppel-Trigger.
- [x] **Phase 1.5 — Single-Instance-Lock** (2026-05-01). `~/jarvis/jarvis.pid`: tote PID wird überschrieben, lebendige PID → exit 1 mit Hinweis-Meldung. atexit + SIGTERM/SIGINT räumen auf. Unit-Tests + Live-Test ✅.
- [x] **Phase 2.1 — Schreibrechte Brain** (2026-05-01). Tools `write_inbox`, `append_daily`, `add_task` mit Pfad-Validator (`_safe_join`) gegen Path-Traversal. Live-Test ✅.

---

## Someday / Vielleicht

- [[02 Projekte/Ildikó Brain Setup]] — paralleles Vault + Claude-Integration für Ildikó. Kontext, Vision, Setup-Plan bereits dokumentiert, Umsetzung wenn Zeit passt.
- Obsidian-MCP einrichten → hochgestuft auf [[02 Projekte/Obsidian-MCP Einrichtung]], priorität: A, due 2026-05-17
- Kanban-Erweiterung in Obsidian
- QuickAdd-Erweiterung

---

## Erledigt

- [x] Octopus Pro im USB-to-qCAN Bridge Modus flashen ✅
- [x] can0-Interface aktiv ✅
- [x] EBB36 Schlitten per dfu-util geflasht ✅
- [x] Vault / Zweites Gehirn eingerichtet ✅
- [x] Pi SSH + Tailscale + Ollama eingerichtet ✅
- [x] KlipperScreen am TFT50 Display ✅
- [x] TMC5160 SPI Config korrigiert (13.04.) ✅
- [x] Y-Endstop Pin gefixt (13.04.) ✅
- [x] X/Y Homing verifiziert (13.04.) ✅
- [x] CAN-Bus Auto-Start via systemd (13.04.) ✅
- [x] Tailscale auf modern3b@ Account (13.04.) ✅
- [x] Eddy Coil kalibriert + Bed Mesh (15.04.) ✅
- [x] Moonraker Auth per Tailscale gefixt (15.04.) ✅
- [x] SO3 Config-Audit + Reality-Check (15.04.) ✅
- [x] Diktierfunktion eingerichtet (15.04.) ✅
- [x] Obsidian Darstellung optimiert (15.04.) ✅
- [x] CLAUDE.md auf deutsche Begriffe + 20MB-Regeln (16.04.) ✅
- [x] `brain`-Alias auf iCloud-Pfad korrigiert (16.04.) ✅
- [x] `rfc`-Alias eingerichtet (16.04.) ✅
- [x] Eli-Bestellung (Ildiko) erfasst (16.04.) ✅
- [x] **Pi Stromversorgung intern + verifiziert** (17.04.) ✅
- [x] **Cloudflare Tunnel live** (17.04.) ✅ — `https://drucker.mthreed.io` öffentlich, Tunnel-ID `378a4792-1636-4a40-b97f-b17ae4184755`, Protokoll `http2` (Hotspot blockt QUIC), cloudflared v2026.3.0 via `.deb`, systemd-Service persistent, nginx/Moonraker-Header bereinigt. Details: [[02 Projekte/Cloudflare Tunnel Setup — ProForge 5]]
- [x] **Cloudflare Access produktionsreif** (17.04.) ✅ — Zero-Trust-Team `mthreed`, App `ProForge 5 Mainsail` + Policy `WEC-Zugang` (Sebastian, Reiner, Ildiko), E-Mail-OTP, Session 24 h. Browser-Test bestanden. App-ID `f4ff7e08-d44b-4a28-a4c3-cc30d8c04ec7`, Policy-ID `35da1cb2-1105-470b-87ee-81c6761d9478`.
- [x] **Read-Only-Proxy für externe Mainsail-Gäste** (17.04.) ✅ — `moonraker-readonly-proxy.service` auf `127.0.0.1:2096`, Python-aiohttp. nginx splittet via `Cf-Connecting-Ip`: extern → Proxy, Tailscale → direkt. Schreibende JSON-RPC + POST/DELETE geblockt, Notaus erlaubt. Bugfix: map liefert direkte `IP:Port`-Strings statt Upstream-Namen (sonst hängt WS-Upgrade). UX: `notify_gcode_response` bei Block → rote Fehlerzeile in Mainsail-Konsole. Extern verifiziert.
- [x] **WEC Knowledge System nach Karpathy-Pattern** (18.04.) ✅ — `03 Bereiche/WEC/` als Operationszentrale: raw/wiki/Operationen/Sessions + eigene CLAUDE.md + README. BWL-Filter strukturell verankert (Kundenbonität, Vertragsprüfung, Warnsignale). Root-CLAUDE.md um "Räume & Auto-Erkennung" erweitert — 8 Räume mit Stichworten, Single-Word-Trigger. Visuelle Karte als Canvas: [[03 Bereiche/WEC/WEC System - Visuelle Karte.canvas|WEC System Karte]]. Details: [[03 Bereiche/WEC/Sessions/2026-04-17 WEC Workspace Aufbau]]
- [x] **Vault-Schema-Durchlauf + Werkzeugkasten** (19.04.) ✅ — Tag-Konsistenz (5 Daily Notes auf `tagesbuch`), 2 Projekte archiviert (Cloudflare Tunnel, Google Drive), 6 Handover-Templates nach `04 Ressourcen/Templates/Claude-Handover/` (**02 Projekte: 20 → 12**), SICAT-Altlast (1,4 GB) nach `06 Archiv/Alte Auftraege/`, Lernkurve-Datei nach MThreeD.io, READMEs für Konstruktion/KI-Anwendungen/Finanzen, Ildi-Raum im Raumsystem. Neuer Werkzeugkasten: [[04 Ressourcen/Scripts/]] (4 Scripts) + [[04 Ressourcen/Prompts/]] (4 Prompts).
- [x] **Cyber-Overlay CSS + Graph-View neuronal** (19.04.) ✅ — Additives Snippet `cyber-overlay.css` mit Neon-Palette (Cyan/Magenta/Grün), in `appearance.json` aktiviert. Graph-View auf neuronale Physik (`repel 10`, `center 0.08`, `linkDistance 160`, `linkStrength 1.0`) + 44 Farb-Queries inkl. Anhänge-Unterordner-Differenzierung (gelber Ring → strukturierte Inseln) + Lila-Kontrast (Archiv dunkel ↔ Clippings hell) + Hub-Hervorhebung (CLAUDE/README/TASKS/MEMORY).
- [x] **Shared Brain Architektur dokumentiert** (24.04.) ✅ — Ein Vault (Mo's Brain), beide über Obsidian Sync verbunden. Claude filtert Kontext für Reiner (nur WEC-Bereiche sichtbar). Details: [[03 Bereiche/WEC/Shared Brain Architektur]], Filter-Regeln in [[03 Bereiche/WEC/CLAUDE]].

---

### mThreeD-X1 (Mo-Produktspur, NICHT Reiner-WEC)

Konzept-Vault unter [[02 Projekte/mThreeD-X1/README|02 Projekte/mThreeD-X1/]].

- [x] **Vault-Struktur angelegt** ✅ (2026-04-30)
- [x] **D1–D7 entschieden** ✅ (2026-04-30) — Bauraum 500×320×400, Hybrid-Probe (Wägezelle + Eddy-Current), Tool-Pool seitenweise, Pfad-Splitter Phase 3, Endlosfaser Phase 2, Maschine 0 als Co-Founder-Build, passive-Düsen verworfen
- [x] **PITCH-Korrekturen final** ✅ (2026-04-30) — Risiko Top-4 (Cooperative-Mode-Forschungsrisiko), neuer „Wer steht dahinter"
- [x] **PARTNERSHIP-Korrekturen final** ✅ (2026-04-30) — Vorgehen-Schritte raus, offener Schluss-Absatz
- [x] **ARCHITECTURE-Korrektur final** ✅ (2026-04-30) — MGN12H-Kommentar
- [x] **VISUALIZATION.md angelegt** ✅ (2026-04-30) — 4 ASCII-Skizzen in Code-Blöcken
- [x] **ZIP-Bundle erstellt** ✅ (2026-04-30) — `~/Downloads/mThreeD.iO_ProjektX_DerEndgegner.zip` + Vault-Archiv `02 Projekte/mThreeD-X1/_Versand/`
- [ ] **CAD-Mockup-Schritt: Linearführungs-Auslegung finalisieren** (MGN12H vs HG15 vs HG20 für 500-mm-X-Achse mit IDEX-Last)
- [ ] **E-Mail an Benjamin verfassen + ZIP anhängen**
- [ ] **PARTNERSHIP-Diskussion mit Benjamin terminieren**
- [ ] **Kinematics-Review-Recherche** — Auftrag an claude.ai mit Web-Recherche zu Stub [[02 Projekte/mThreeD-X1/03_Review/KINEMATICS-REVIEW|KINEMATICS-REVIEW]] (Steifigkeit, Resonanz, Klipper-Multi-Gantry, Carbon@120 °C, Pfad-Splitter-Aufwand, Dock-Bauraum, BOM-Klassen, Top-3-Risiken)
- [ ] **Whitepaper-Veröffentlichungs-Plan erstellen** — mThreeD.io-Website? Externe Plattform? Timing relativ zum Co-Founder-Gespräch klären
- [ ] **Bei Review grün/gelb:** nächste Phase planen (CAD-Mockup-Konzept)
- [ ] **Bei Review rot:** Architektur überdenken
- [ ] **Phase-2-Backup nach Co-Founder-Gespräch löschen** (`02 Projekte/mThreeD-X1.backup-2026-04-30_phase2/`)

## Inbox

- [ ] Will Task (jarvis 04:02)
- [ ] Eilman Sound vor Jarvis-Sprechen einbauen (jarvis 03:43)

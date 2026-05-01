---
tags: [ressource, klipper, octopus, canbus, migration]
status: pausiert-bis-q3
date: 2026-04-30
risiko: niedrig
---

# Octopus CAN-Bridge-Mode — Migrations-Anleitung

Migration vom Octopus-USB-Mode (mit U2C V2 als CAN-Bridge) auf Octopus-eigenen CAN-Bridge-Mode. Eliminiert U2C, reduziert Pi-USB-Devices, entfernt gs_usb-via-U2C als SPoF.

**Status (2026-04-30 ~08:25):** **PAUSIERT BIS Q3.** D2-Rollback durchgeführt — Bridge-Mode aufgegeben wegen rx_error 104k/s im Bridge-FW (Wurzel: Octopus-CAN-Header physisch nicht verkabelt, Brain Daily 2026-04-04). Octopus läuft jetzt USBSERIAL, EBB36 weiter via U2C/can0. Klipper ready, 7/7 MCUs, EBB rx=0/active. Voraussetzung für Q3-Wiederversuch: Header-Bauform geklärt + physische Verkabelung Octopus↔EBB + Termination-Messung. Diagnose: [[Hybrid-Bridge-rx_error-Diagnose]].

## ⚠️ BLOCKER

### Blocker 1 — Bridge-FW-Connect ✅ AUFGELÖST 2026-04-30
H1 (`txqueuelen 128` + `can1 UP`) wirksam. Erste Connect-Fehler waren so3_0-Shutdown-State aus vorheriger Session — `FIRMWARE_RESTART` + can1-Wiederhochbringen löste es. Bridge-FW v2 als `1d50:606f` stabil. Siehe [[05 Daily Notes/2026-04-29]] Phase 18.

### Blocker 2 — U2C ist nicht nur CAN-Bridge, sondern auch 24V-Verteiler
Klarstellung 2026-04-30: U2C V2 nimmt 24V vom LRS-450 über V+/V- Schraubklemmen entgegen und gibt sie zusammen mit CAN_H/CAN_L über seinen seitlichen 4-pol Molex Microfit 3.0 an die EBB36 weiter. Ein einziges 4-adriges Kabel (VIN+GND+CAN_H+CAN_L) verbindet U2C und EBB. **Heißt:** "U2C entfernen" ist nicht nur ein USB-Kabel ziehen — es muss eine alternative 24V-Versorgung der EBB sichergestellt werden. Mit Bordmitteln lösbar (siehe Optionen unten), aber nicht trivial.

### Blocker 3 — Bauform des Octopus-CAN-Headers (PD0/PD1) unbekannt
Brain dokumentiert PD0/PD1 als CAN-Pin-Pair (verifiziert gegen offiziellen BTT Octopus Pro PIN.pdf), aber **NICHT** die physische Steckerbauform: Stiftleiste? Schraubklemme? JST-XH? Molex Picoblade? Ohne diese Information ist nicht entscheidbar, wie das Kabel mit offenen Litzen am Octopus angeschlossen wird (Dupont? Crimp? Adapter?). 

**Quellen geprüft (2026-04-30):**
- [[ProForge5 Pinout]] — listet PD0/PD1 nicht (kein CAN-Eintrag für Octopus)
- [[Octopus-Recovery-Pfade]] — keine Header-Bauform-Aussage
- [[ProForge5 Build]] — keine Header-Bauform-Aussage
- Daily Notes 2026-04-04 / 2026-04-29 — nur Pin-Belegung, keine Bauform
- `02 Projekte/ProForge5 Build/firmware/` — nur .bin-Files
- BTT Octopus Pro PIN.pdf liegt nicht im Brain-Vault als Asset

**Lösung:** Visuelle Klärung am Drucker (Foto vom CAN-Header). Siehe TASK in [[TASKS.md]].

## Pfad-Optionen für Schritt 6 (U2C-Komplettentfernung)

**OPTION A — U2C komplett raus, zweites Kabel als Direkt-Ersatz:**
- LRS-450 → 2 Litzen (VIN/GND) am offenen Kabel-Ende → 4-pol-Kabel → MX3.0 → EBB36
- Octopus CAN-Header (PD0/PD1) → 2 Litzen (CAN_H/CAN_L) am gleichen Kabel-Ende
- Beide laufen über das eine 4-pol-Kabel zur EBB
- **Voraussetzung:** Octopus-CAN-Header-Bauform geklärt (Blocker 3)
- **Vorteil:** U2C ganz raus, ein USB-Device weniger, ein Kabel weniger im Setup, kein gs_usb-Treiber nötig
- **Nachteil:** je nach Header-Bauform Adapter/Crimp nötig; LRS-450-Schraubklemmen müssen zusätzliche Litzen aufnehmen (ggf. Aderendhülsen)

**OPTION B — U2C als 24V-Verteiler bleibt, CAN-Bridge wandert zu Octopus:**
- U2C bleibt verkabelt mit V+/V- am LRS-450, liefert weiterhin 24V über seinen Molex zur EBB
- Octopus-Bridge-Mode aktiv, CAN-Adern vom U2C-Molex werden TOT (nicht mehr genutzt)
- Octopus-CAN müsste über zweites Kabel (offene Litzen) am Octopus-Header anlanden, parallel zu den toten U2C-CAN-Pins am EBB36-Stecker → Stern-Topologie, zwei CAN-Quellen am gleichen Bus, Termination-Konflikt
- **Verworfen** — nicht sauber.

**OPTION C — Migration verschieben:**
- Plan auf "wartet auf Hardware-Klärung" setzen
- Heute keine Aktion. Disconnect-Stabilität läuft seit 2026-04-29 sauber (laut Daily Note 2026-04-29 Phase 17 Rollback), kein akuter Druck.
- **Aktiv gewählt** bis Blocker 1+3 gelöst.

## Lessons aus v1-Versuch (2026-04-29)

1. **Kconfig-Choice MMENU vs. CMENU:** Klipper hat zwei separate CAN-Pin-Choices — `MMENU_CANBUS_*` (regulär) und `CMENU_CANBUS_*` (unter `if USBCANBUS`, Bridge-Mode). v1 setzte fälschlich MMENU → `make olddefconfig` wählte CMENU-Default `PB8/PB9`. v2 setzt korrekt **`CONFIG_STM32_CMENU_CANBUS_PD0_PD1=y`**.
2. **klipper.dict-Verifikation als Pflicht-Schritt:** Vor jedem Flash `RESERVE_PINS_CAN` aus `out/klipper.dict` lesen. Bei v1 hätte das gezeigt: `RESERVE_PINS_CAN: PB8,PB9` ≠ Erwartung PD0/PD1. v2 verifiziert: `RESERVE_PINS_CAN: PD0,PD1` ✅.
3. **DFU-Mehrfach-Disambiguierung:** U2C V2 wirft sich beim DFU-Reboot ggf. mit auf den Bus (runtime-DFU via budgetcan-FW). `dfu-util` ohne `--path` schlägt fehl mit „More than one DFU capable USB device found". Fix: `--path 1-2` für Octopus. v2-Skript hat das.
4. **Auto-Revert nach Cold-Boot:** v1-Bridge-FW war nach Power-Cycle weg, Octopus zurück auf v0.13.0-593 USBSERIAL. **Ursache nicht abschließend geklärt.** SD-Karten-Auto-Flash-Hypothese widerlegt (keine SD eingelegt). Mögliche Ursachen: STM32H7-Boot-Logik bei FW-Hardfault während CAN-Init mit Falschpins, oder BTT-Bootloader-Recovery. Wird im v2-Versuch beobachtet — wenn mit korrekten Pins kein Revert: Pin-Konflikt war alleinige Ursache.

## Stufe-2-Bereitstand (2026-04-29 ~06:00)

- **Pin-Verifikation:** PD0/PD1 als CAN-Pin-Pair gegen offiziellen BTT Octopus Pro PIN.pdf bestätigt durch claude.ai (PD0=CAN_RX1, PD1=CAN_TX1). Risiko-Punkt 1 abgehakt.
- **printer.cfg-Backup:** `~/printer_data/config/printer.cfg.backup_pre_bridge_20260429`
- **printer.cfg-Diff-Template:** [[04 Ressourcen/Klipper/printer-cfg-bridge-diff]]
- **Flash-Skript:** `~/scripts/flash_octopus_bridge.sh` (DFU-Check → Backup-Bin → Flash → canbus_query)
- **Rollback-Skript:** `~/scripts/rollback_octopus_usb.sh` (DFU-Check → letzten Pre-Bridge-Backup-Bin restoren → printer.cfg-Restore-Hinweis)

## Constraint-Check (vor Start)

- [x] 5-Toolhead-Constraint: Bridge-Mode lässt SO3 unberührt (5 SO3 + EBB hängen weiter am Bus)
- [x] EBB36 nutzt bereits `canbus_uuid` (`71c47e0b85cf`) — kein Eingriff am EBB nötig
- [x] CAN-Bus-Frequenz 1 MHz: Octopus-Build-Config matcht U2C/EBB/SO3 (alle 1000000)

## Bereitstand (heute fertig)

- **Test-Bin v2:** `m3d@mThreeD-IO:~/klipper-builds/octopus_bridge_20260429_v2.bin` (45676 Bytes) — **aktiv**
- **Quell-Config v2:** `~/klipper/.config.octopus_bridge_v2` (mit `CONFIG_STM32_CMENU_CANBUS_PD0_PD1=y`)
- **Build-Stand:** v0.13.0-623-gaea1bcf56 (matcht aktive SO3, keine Versions-Drift)
- **klipper.dict-Verifikation v2:** `RESERVE_PINS_CAN: PD0,PD1`, `CANBUS_BRIDGE: 1` ✅
- **Build-Verzeichnis-State:** `.config` zurück auf SO3-aktiv, `out/klipper.bin` = SO3-Bin (17908 B). Kein Drift.
- **v1-Bin obsolet:** `octopus_bridge_20260429.bin` hatte falsche Pins (PB8/PB9), nicht verwenden.

## Build-Config-Diff (gegenüber `.config.octopus_h723_v623`)

```diff
- CONFIG_USBSERIAL=y
+ # CONFIG_USBSERIAL is not set
- CONFIG_STM32_USB_PA11_PA12=y
+ # CONFIG_STM32_USB_PA11_PA12 is not set
- # CONFIG_STM32_USBCANBUS_PA11_PA12 is not set
+ CONFIG_STM32_USBCANBUS_PA11_PA12=y
- # CONFIG_STM32_CMENU_CANBUS_PD0_PD1 is not set
+ CONFIG_STM32_CMENU_CANBUS_PD0_PD1=y
```

**Begründung der Pin-Wahl PD0/PD1:** Octopus Pro H723 CAN-Header CANbus = PD0/PD1 (BTT-Standard, schon historisch in `.config.backup_can_pb12pb13`-Reihe getestet auf anderen Pin-Kombinationen → PD0/PD1 ist der CAN-Header der von BTT für Octopus Pro dokumentiert ist). **Vor Flash physisch verifizieren** durch BTT-Schaltplan-Lookup.

## Vorbereitung (vor Migrations-Session)

1. **Druck-Frei:** Klipper darf nicht drucken, alle Tools im Dock.
2. **Backups (am Pi):**
   ```bash
   cp ~/printer_data/config/printer.cfg ~/printer_data/config/printer.cfg.backup_pre_bridge
   sudo systemctl stop klipper
   ```
3. **Octopus-USB-Kabel-Identifikation:** notieren welches USB-Kabel zum Octopus geht (für DFU-Modus später). Aktuell: `/dev/serial/by-id/usb-Klipper_stm32h723xx_1D0015001251313531383332-if00` (Chip-ID-Suffix dient zur Wiedererkennung).
4. **U2C-Backup-Plan:** U2C V2 bleibt zunächst physisch verbunden — falls Bridge nicht funktioniert, Rückbau auf USB-Mode möglich. **NICHT vorher abstecken.**

## Migrations-Schritte

### Schritt 1 — Octopus in DFU-Mode versetzen (5 Min)

**SSH direkt:**
```bash
# Klipper stoppen
sudo systemctl stop klipper

# Octopus aktuell als USB-Serial → über klipper-FW DFU-Reboot triggern
~/klippy-env/bin/python ~/klipper/scripts/flash_can.py -d /dev/serial/by-id/usb-Klipper_stm32h723xx_1D0015001251313531383332-if00 --bootloader 2>&1 | head -5
```

**Falls flash_can.py nicht reicht — physisch:**
- Octopus stromlos
- BOOT0-Jumper setzen
- Octopus stromlos+USB an Pi
- `lsusb | grep -i "STM Device in DFU Mode"` muss erscheinen

### Schritt 2 — Bridge-Bin flashen (5 Min)

**SSH direkt — über das gefixte Skript v2:**
```bash
~/scripts/flash_octopus_bridge.sh
```
Skript nutzt `--path 1-2` für DFU-Disambiguierung (U2C wirft sich beim DFU-Reboot mit auf den Bus) und v2-Bin mit korrekten Pins.

### Schritt 2b — Persistenz-Check (Pflicht vor printer.cfg-Edit!)

Aus Lesson v1: Bridge-FW kann nach Cold-Boot weg sein. Daher:

**Mo physisch:** Drucker komplett stromlos (PSU + USB ziehen), 30 s warten, wieder an.

**SSH direkt:**
```bash
~/scripts/verify_bridge_persistent.sh
```
Erwartung: kein `1d50:614e` mehr in lsusb (= USBSERIAL-FW), Octopus-UUID auf can0 oder can1. Bei Revert: STOP, Ursache untersuchen, kein printer.cfg-Edit.

**Verifikation:**
```bash
# Octopus sollte rebooten und NICHT mehr als usb-serial auftauchen
ls /dev/serial/by-id/ 2>&1 | grep stm32h723
# → erwartet: leer (Octopus ist jetzt CAN-Bridge, kein Serial-Device mehr)

# can0 sollte kommen
dmesg | tail -20 | grep -i "gs_usb\|can"
ip -d link show can0
```

### Schritt 3 — canbus_uuid des Octopus ermitteln (2 Min)

**Voraussetzung:** can0 ist UP. U2C kann jetzt physisch entfernt werden ODER vorerst dranbleiben (gs_usb-Treiber bedient beide Devices).

```bash
~/klippy-env/bin/python ~/klipper/scripts/canbus_query.py can0
# → erwartet: 2 uuids (Octopus + EBB36, da SO3 USB-direkt ist NICHT auf CAN)
# → EBB-uuid bekannt: 71c47e0b85cf
# → Octopus-uuid: NEU, notieren
```

### Schritt 4 — printer.cfg umstellen (5 Min)

**printer.cfg-Diff:**
```diff
  [mcu]
- serial: /dev/serial/by-id/usb-Klipper_stm32h723xx_1D0015001251313531383332-if00
+ canbus_uuid: <NEUE_OCTOPUS_UUID>
```

**Andere `[mcu ...]`-Sektionen unverändert:**
- `[mcu ebb]` canbus_uuid bleibt `71c47e0b85cf`
- `[mcu so3_0]` … `[mcu so3_4]` bleiben USB-Serial (nicht auf CAN)

### Schritt 5 — Klipper starten + Smoke-Test (5 Min)

```bash
sudo systemctl start klipper
sudo systemctl status klipper
sudo journalctl -u klipper -n 50 --no-pager
```

**Mainsail-Konsole:**
- `STATUS` → printer ready erwartet
- `QUERY_ENDSTOPS` → erwartet alle Endstops antworten
- `M115` → Firmware-Versionen prüfen (Octopus + EBB36 + SO3×5 müssen sichtbar sein)

### Schritt 6 — U2C entfernen (Option A, nach 24h Stabil-Phase)

**Voraussetzung:** Blocker 3 gelöst (Octopus-CAN-Header-Bauform geklärt), Bridge-Mode mindestens 24h sauber, Probe-Druck erfolgreich.

**Hardware-Aktionen:**
1. Klipper stoppen, Drucker stromlos.
2. Vorhandenes 4-pol-Kabel zwischen U2C-Molex und EBB36 abziehen.
3. Zweites Kabel (MX3.0 EBB-seitig + offene Litzen U2C-seitig) am EBB36 einstecken.
4. Offene Litzen am anderen Ende belegen:
   - **VIN-Litze** → in V+ Schraubklemme am LRS-450 (zusätzlich zur bestehenden V+-Belegung des Octopus, ggf. Aderendhülse)
   - **GND-Litze** → in V- Schraubklemme am LRS-450
   - **CAN_H-Litze** → an Octopus-CAN-Header PD0-Seite (Verbindungsmethode abhängig von Header-Bauform → Blocker 3)
   - **CAN_L-Litze** → an Octopus-CAN-Header PD1-Seite
5. U2C V2 USB-Kabel und V+/V- Schraubklemmen abklemmen → U2C komplett ausbauen.
6. Drucker einschalten, can0 muss stehen (jetzt direkt vom Octopus, nicht mehr U2C).
7. Klipper starten, Smoke-Test wiederholen ([[#Verifikations-Tests nach Migration]]).
8. EBB36-LED + grüne Spannungsanzeige verifizieren bevor Klipper startet.

**Termination-Check:** Mit Multimeter zwischen CAN_H und CAN_L (stromlos) → 60 Ω erwartet (zwei 120-Ω-Terminierungen parallel: U2C-Software-Termination ist weg, dafür Octopus-internal-Terminierung muss aktiv sein, plus EBB36-Jumper). Falls 120 Ω: nur eine Terminierung aktiv → CAN-Header-Termination am Octopus per Jumper aktivieren (Header-Position laut BTT-Schaltplan).

## Verifikations-Tests nach Migration

| Test | Befehl | Erwartung |
|------|--------|-----------|
| can0 UP | `ip -d link show can0` | state UP, parentdev = Octopus statt U2C |
| canbus_query | `canbus_query.py can0` | Octopus + EBB36 (2 uuids) |
| Klipper ready | Mainsail STATUS | "Printer is ready" |
| MCU-Verbindungen | M115 | 7 MCUs (Octopus, EBB, 5× SO3) |
| Endstops | QUERY_ENDSTOPS | alle 6 antworten |
| Druck-Probe | kleiner Bench (~30 Min) | sauber, keine Lost-Communication-Events |
| Kernel-Log | `dmesg \| grep -iE "enobufs\|epipe\|eproto"` | 0 Events seit Migration |

## Rollback-Plan

**Trigger für Rollback:** Klipper kommt nicht in `ready`-State, MCU-Verbindungen brechen, oder neue Kernel-CAN-Errors innerhalb 1h nach Bridge-Aktivierung.

**Rollback-Schritte:**
```bash
# 1. printer.cfg zurück
cp ~/printer_data/config/printer.cfg.backup_pre_bridge ~/printer_data/config/printer.cfg

# 2. Octopus zurück auf USB-Serial-Build flashen
sudo systemctl stop klipper
# DFU-Mode → wie Schritt 1
sudo dfu-util -a 0 -s 0x08020000:leave -D ~/klipper-builds/octopus.bin

# 3. U2C V2 ist noch dran (nicht entfernt vor 24h-Stabil) → can0 läuft wieder über U2C
sudo systemctl start klipper
```

**Backup-bin im Klipper-Builds-Ordner:** `~/klipper-builds/octopus.bin` (43300 Bytes, USB-Mode-Stand).

## Zeitschätzung

| Schritt | Dauer | Risiko |
|---------|-------|--------|
| 1 — DFU-Mode | 5 Min | niedrig (USB-Reboot Standard) |
| 2 — Flash | 5 Min | niedrig (dfu-util etabliert) |
| 3 — canbus_uuid | 2 Min | niedrig |
| 4 — printer.cfg | 5 Min | niedrig (1-Zeilen-Diff) |
| 5 — Smoke-Test | 5 Min | mittel (MCU-Verbindungen müssen kommen) |
| Druck-Probe | 30 Min | mittel |
| **Gesamt aktiv** | **~50 Min** | |
| 6 — U2C entfernen | 5 Min (nach 24h) | niedrig |

**Gesamtaufwand inkl. 24h-Stabilphase:** ~2 Stunden aktive Arbeit, davon 50 Min Migration + Probedruck.

## Bekannte Risiken

1. **CAN-Pin-Verifikation PD0/PD1:** Vor Flash BTT Octopus Pro H723 Schaltplan gegenchecken. Falls falsche Pins → Octopus erscheint zwar als gs_usb auf USB, aber CAN-Bus zu EBB36 funktioniert nicht. Symptom: can0 UP, aber EBB nicht erreichbar via canbus_query.
2. **DFU-Adresse 0x08020000:** Octopus H723 nutzt Bootloader-Offset, NICHT 0x08000000. Bei falscher Adresse: brick-ähnlicher Zustand, Recovery via SD-Card-Bootloader oder Pi-DFU-Wieder-Trigger.
3. **EBB-Disconnect während Migration:** Solange Octopus in DFU ist, ist CAN-Bus down → EBB sieht keine Traffic. Beim Hochfahren des Bridge-Mode kommt EBB von selbst wieder.

## Empfehlung (Stand 2026-04-30 ~01:15)

**Hybrid-Bridge live, 24-h-Stabilphase läuft bis ~01:15 2026-05-01.**

**Reihenfolge:**
1. 24 h Hybrid-Bridge beobachten — keine ENOBUFS/EPROTO/Lost-Comm, alle 7 MCUs durchgehend `ready`.
2. `can1`-Konfig via systemd-networkd FIRMWARE_RESTART-fest dokumentieren (aktuell durch H1 manuell gesetzt).
3. Visuelle Klärung Octopus-CAN-Header-Bauform (Blocker 3) — Foto am Drucker.
4. Erst wenn 1–3 erledigt: Schritt 6 (Option A, U2C-Komplettentfernung) planen.

**Reversibilität bleibt voll erhalten:** U2C noch dran, EBB36 weiter über `can0`. Falls Hybrid-Bridge instabil → printer.cfg auf pre-bridge-Backup zurück, USBSERIAL-Klipper via Katapult ins App-Slot, ~5 Min Recovery.

## Verknüpfungen

- [[04 Ressourcen/Klipper/ProForge5-Architektur-Review-2026]] — Empfehlung Top-1 (Q3-Slot)
- [[02 Projekte/ProForge5 Build/ProForge5 Build]] — Hardware-Doku
- [[04 Ressourcen/Klipper/ProForge5 Pinout]] — aktuelle Pin-Wahrheit
- Klipper-Doku: https://www.klipper3d.org/CANBUS.html
- Klipper-Doku: https://www.klipper3d.org/CANBUS_Troubleshooting.html

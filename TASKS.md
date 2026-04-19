---
tags: [vault]
date: 2026-04-04
---

# TASKS

Zuletzt aktualisiert: 2026-04-18 (nach Session 5b Parkplatz-Abbau)

## Termine

- **Montag 2026-04-21 — Volker Bens Lagerschalenhalter mit Reiner:** Überarbeitung auf EHEDG/Lebensmittelindustrie abschließen. Zeichnungs-/BOM-/3D-Abgleich gegen Reiners Korrektur-Scans. Reiner bringt Muster aus früheren erfolgreichen Volker-Projekten (Input für [[04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl|Bens-Lieferstandard]], v.a. STEP-Schema). **White-Label-Prinzip strikt einhalten** (alles unter Bens-Label, kein WEC/Sachsenmilch sichtbar — siehe [[03 Bereiche/WEC/CLAUDE#Volker Bens / Bens Edelstahl|WEC-Regeln]]). Briefing: [[03 Bereiche/WEC/wiki/Kunden/Volker Bens - Lagerschalenhalter Lebensmittelindustrie|Lagerschalenhalter-Wiki]]. Raw: `03 Bereiche/WEC/raw/Kunden/Volker Bens/aktuelle Projekte/Lagerschalenhalter Lebensmittelindustrie/`
- **Montag 2026-04-21 — SSD-Übergabe an Reiner:** Welcome-Kit zurück + externe SSD als Projektspiegel. Anleitung → [[02 Projekte/WEC Neustart mit Reiner/Anleitung Reiner - Externe SSD Projektspiegel]]

---

## Aktiv

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
- [ ] **SO3 Boards (PH1–PH5) flashen** ❌ — **physischer BOOT0-Zugang nötig** (Hardware-Only Entry). Flash-Adresse: `0x8002000:leave`. Je Board eigene Binary mit `USB_SERIAL_NUMBER_STR="PHx"`. Workaround läuft, Klipper `ready`.
- [ ] **Toolhead-Kalibrierung** — blockiert bis SO3 geflasht
- [ ] **EBB36 clean flashen** — v0.13.0-623 ohne "-dirty" (DFU-Verfahren)
- [x] 4.7kΩ Pull-Up Widerstände — nicht mehr nötig ✅
- [x] Eddy Coil kalibrieren ✅
- [ ] **Input Shaping kalibrieren** — ADXL345 am EBB36
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

### Sicherheit (Folgemaßnahmen AMOS-Vorfall 17.04.)

- [ ] `Anleitung_Mac.pdf` prüfen und löschen
- [ ] AnyDesk-Kennwort rotieren
- [ ] Pi Tunnel-Credentials ggf. rotieren (abhängig von Generierungsort)
- [ ] Chrome-Passwörter-Inventar durchgehen
- [ ] Eintragspunkt AMOS klären
- [ ] **gcodehistory-Fund prüfen** — `backup-mainsail_2026-04-06_mobile.json` enthält Befehl `sudo passwd pi` (kein Passwort, nur Verlauf). Wann, durch wen? Pi-Passwort rotieren wenn Kontext unklar. Bei AMOS-Audit berücksichtigen.

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

---

## Someday / Vielleicht

- [[02 Projekte/Ildikó Brain Setup]] — paralleles Vault + Claude-Integration für Ildikó. Kontext, Vision, Setup-Plan bereits dokumentiert, Umsetzung wenn Zeit passt.
- Obsidian-MCP einrichten
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

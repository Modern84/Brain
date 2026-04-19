---
tags: [projekt, wec]
date: 2026-04-15
status: aktiv
---

# Reiners Gehirn — Setup Plan (Windows)

## ⚠️ Status 16.04.2026 — Setup nicht abgeschlossen

**Heute bei Reiner versucht:** AnyDesk-Verbindung, um Setup aus der Ferne zu machen.

**Ergebnis:** 
- Vor Ort bei Reiner hat AnyDesk funktioniert, Setup konnte teilweise begonnen werden.
- Nach Rückfahrt nach Pirna und MacBook-Neustart: AnyDesk verlangt Bestätigung durch Reiner am PC — das geht nicht wenn Reiner nicht am Platz sitzt.
- **Kernproblem:** AnyDesk ist aktuell im "Attended Mode" — jede Verbindung braucht manuelle Bestätigung von Reiner.

**Was Sebastian eigentlich braucht** (nicht nur "Installation aus der Ferne", sondern **volle Remote-Arbeitsfähigkeit** auf Reiners PC):

1. **AnyDesk Unattended Access** — Reiner setzt einmalig ein festes Passwort im AnyDesk-Client (Einstellungen → Sicherheit → "Unbeaufsichtigten Zugriff aktivieren"). Sebastian kann dann jederzeit ohne Reiner rein.
2. **Administrator-Rechte für Sebastian** — entweder als separater Admin-Account auf Reiners Windows, oder Reiners Account mit Admin-Rechten versehen. Ohne Admin kein vernünftiges System-Setup möglich.
3. **Windows Terminal + PowerShell oder WSL** — damit Sebastian Terminal-Kommandos absetzen kann wie lokal auf dem Mac. WSL (Windows Subsystem for Linux) ist die bessere Wahl: gibt eine echte Linux-Shell auf Windows, Node/npm/Git funktionieren wie erwartet.
4. **Claude Code auf Windows** — Installation via npm (wie auf Mac). Dafür Node.js LTS + npm installieren. Idealerweise via `nvm-windows` (saubere Version-Verwaltung wie nvm auf Mac).
5. **Alternativen zu AnyDesk prüfen:**
   - **Parsec** — niedrige Latenz, für interaktive Arbeit besser
   - **TeamViewer** — etabliert, auch Unattended-Access
   - **Tailscale SSH** + Windows OpenSSH Server — Terminal-only, für Automatisierung/Skript-Arbeit extrem schnell und zuverlässig

**Nächster Versuch — Checkliste für Reiner-Termin vor Ort:**

---

- [ ] AnyDesk auf Reiners (Alt-)PC → Einstellungen → Sicherheit → "Unbeaufsichtigten Zugriff aktivieren" + Passwort setzen (nur für Übergangsphase bis Mac steht)
- [ ] Admin-Rechte-Status auf Reiners Alt-PC klären (Steffen-Problem)
- [ ] Mac-Strategie finalisieren (siehe Abschnitt unten)

---

## Hardware-Strategie — Apple Silicon statt Windows (16.04.2026)

**Kern-Entscheidung:** Statt Windows zu fixen, raus aus dem Windows-Ökosystem. Apple Silicon hat die bessere KI-Architektur (Unified Memory, Neural Accelerators), bessere Terminal-Integration (Unix-basiert), und befreit uns von der IT-Politik bei WEC (Steffen, Admin-Rechte, Domäne).

### Timing — auf M5-Generation warten

- **Aktuell (April 2026):** Mac Studio M4 Max + M3 Ultra (seit März 2025)
- **MacBook Pro M5 Pro/Max** released März 2026 — 4× AI-Performance vs M4 dank Neural Accelerators in jedem GPU-Core
- **Mac Studio M5 Max + M5 Ultra** erwartet zu WWDC Juni 2026 — ~2 Monate warten
- **Mac Mini M5 + M5 Pro** ebenfalls Juni 2026 erwartet

**Konsequenz:** August-Deadline erlaubt zu warten. Juni bestellen, Juli einrichten, August operativ.

### Warum Apple Silicon für KI-Arbeit

- **Unified Memory:** CPU/GPU/Neural Engine teilen einen RAM-Pool. Keine VRAM-Jonglage wie bei NVIDIA.
- **Lokale LLMs möglich:** Mit 128GB unified memory laufen 70B-Modelle (LLaMA 3.3, Qwen 72B) flüssig lokal — eigene KI-Infrastruktur, unabhängig von Anthropic/OpenAI.
- **Wichtig für sensitive Kundenprojekte** (Rüstung, Medizintechnik, IP-kritisch): lokale Modelle, keine Cloud-Übertragung.

### Hardware-Optionen (erwartete Preise Juni 2026)

**Mac Mini M5 Pro** (~1.400–2.000€ je nach Config)
- Für: Arbeitsplatz-PC, Obsidian, Fusion 360 leicht, Cloud-Claude-Integration
- Nicht stark genug für große lokale LLMs
- Ideal als **Reiners Arbeitsplatz** (ersetzt Windows-PC)

**Mac Studio M5 Max** (ab ~2.200€, mit 64–128GB RAM ~3.000–4.500€)
- **Sweet-Spot.** Fusion 360 rennt. Lokale LLMs bis 70B laufen flüssig.
- Ideal als **Sebastians Workstation / MThreeD.io-Hub**

**Mac Studio M5 Ultra** (ab ~4.500€, mit 192–256GB RAM ~7.000–9.000€)
- Overkill für jetzigen Use-Case
- Sinn nur bei großen Modellen (400B+) oder mehreren parallel

### Kritische Hebel bei der Konfiguration

**RAM — maximieren beim Kauf!**
- Unified Memory ist auf dem Chip gelötet — NICHT nachrüstbar
- Für lokale LLMs: 64GB Minimum, 128GB ideal
- Unter 32GB keinen Sinn wenn KI ein Ziel ist

**SSD — moderat intern, extern skalieren**
- Interner Storage ist bei Apple überteuert (1→4TB Upgrade: ~1.200€)
- Empfehlung: **1TB intern** als System-Disk
- **Externe Thunderbolt-5-SSDs** für Archiv/Projekte: Samsung T9 Pro oder OWC Envoy Pro, 4TB ~400€, schneller als interne SSD früherer Generationen

### Empfohlene Konfiguration (wenn "alles rausholen" die Maxime ist)

**Zwei Geräte, zwei Rollen:**

1. **Mac Mini M5 Pro für Reiner** (~2.000€)
   - Sein Arbeitsplatz. macOS statt Windows. Keine Ablenkung, keine IT-Politik.
   - 48–64GB RAM, 1TB SSD
   - Externe SSD für Projekt-Archive

2. **Mac Studio M5 Max 128GB für Sebastian / MThreeD.io** (~4.000€)
   - Workstation in Pirna. Fährt Fusion 360, lokale LLMs, ist der Hub.
   - 128GB RAM, 1TB SSD + externe 4TB TB5-SSD
   - Via Tailscale mit Reiners Mini verbunden

**Gesamt ~6.000€.** MThreeD.io-Investition, bleibt unabhängig von WEC, trägt sich ins eigene Unternehmen.

**Alternative wenn Budget knapp:** Mac Studio M5 Max 64GB für Sebastian (~3.000€) + Übergangs-Mini-PC mit Linux/Windows für Reiner (~500€). Upgrade auf Reiner-Mac später.

### Offene Fragen

- [ ] Soll Reiner Fusion 360 selber bedienen können (→ mehr GPU) oder nur Claude + Office + Skizzen-Review? (→ Mini reicht)
- [ ] Zentraler Dateiserver — bei Sebastian in Pirna oder bei Reiner vor Ort? (Entscheidet Standort des Mac Studio)
- [ ] Bei welcher Firma laufen die Geräte — privat oder MThreeD.io? (Steuerliche Abschreibung, IP-Trennung)

---

## Politisches Problem — Steffen (16.04.2026)

**Situation:**
- Reiner hat auf seinem PC **keine Admin-Rechte**
- Admin-Rechte + Netzwerk-Administration + NAS-Verwaltung liegen bei **Steffen** (aktuell aus privaten Gründen nicht da)
- **Kritisch:** Die Umstellung/Setup darf von Steffen und anderen Mitarbeitern (Sabine, Petra, Andreas) nicht bemerkt werden. Jeder Versuch, Admin-Rechte zu ändern oder neue User anzulegen, würde in Logs auftauchen und Konflikte provozieren.

**Strategie — maximale Entkopplung (empfohlen):**

Statt in die bestehende WEC-IT einzugreifen, **paralleles System** aufbauen:

1. **Eigener Mini-PC** für Reiner — steht neben seinem WEC-PC, ist voll von Sebastian administrierbar
   - Budget: ~500€ (Intel NUC, Beelink oder vergleichbar, 16GB RAM, 500GB SSD, Windows 11 Pro)
   - Keine Domänen-Integration — rein lokaler Account
2. **Eigener mobiler LTE-Router / Hotspot** — unabhängig vom WEC-WLAN
   - Vermeidet Logs auf Steffens Netzwerk-Infrastruktur
3. **NAS-Daten über Reiner ziehen** — nicht direkt zugreifen
   - Reiner kopiert relevante Zeichnungen/Vorlagen/Kundenordner auf externe SSD
   - Sebastian übernimmt die Daten auf den Mini-PC
   - Keine Zugriffe von neuen Accounts auf den NAS, keine verdächtigen Logs
4. **Remote-Zugriff** über AnyDesk (Unattended) ODER Tailscale auf dem Mini-PC
   - Unabhängig von Steffens Netzwerk-Richtlinien

**Finanzielle Logik:**
- 500€ Mini-PC + ~30€/Monat LTE-Router = MThreeD.io-Investition, keine WEC-Betriebsmittel
- Wenn nach August ohnehin eine eigene Struktur aufgebaut wird, startet diese nicht bei Null
- Das Mini-PC-Setup ist **das Fundament für die Post-WEC-Zeit**

**Langfristig — nach August (wenn Steffen + andere weg sind):**
- Admin-Rechte auf WEC-Hardware übernehmen
- NAS-Zugriff direkt einrichten  
- Paralleles System wird zum WEC-System (oder bleibt separat als MThreeD.io-Infrastruktur)

**Offene Fragen für Klarheit:**
- [ ] Hat Reiner als normaler Mitarbeiter-Account Zugriff aufs NAS? (Wahrscheinlich ja)
- [ ] Welches NAS-Fabrikat / Modell? (Synology, QNAP, TrueNAS, anderes)
- [ ] Kennt Reiner sein eigenes lokales Admin-Passwort? (Für Option "stiller Weg" — lokaler Sebastian-Account)
- [ ] Ist Reiner Inhaber/GF oder Gesellschafter von WEC? (Relevant für rechtliche Legitimation des parallelen Setups)

---

## Datentransfer — Samsung T9 als Brücke (17.04.2026)

**Entscheidung:** Statt auf NAS-Netzwerkzugriff zu warten oder Remote-Desktop-Probleme zu lösen, nutzen wir eine externe SSD als Brücke NAS → Mac.

**Hardware (Kandidat, offen):** Samsung Portable SSD T9, 2 TB, USB-C (Modell MU-PG2T0B/EU, ~188–250 € bei Geizhals DE Stand April 2026).

> **Status 17.04.2026 Nachmittag:** Reiner prüft wegen der Kosten einen alternativen Hersteller. Pflicht-Anforderungen bleiben: 2 TB Kapazität, USB-C, ≥ 1.000 MB/s Lese-/Schreibrate. Modell/Hersteller/Preis wird aktualisiert sobald entschieden.

**Warum 2 TB, nicht 1 TB oder 4 TB:**
- SolidWorks-Einzelteile: 1–50 MB
- Baugruppen: 50–500 MB  
- Zeichnungen: 5–20 MB
- 30 Jahre Projektbestand realistisch: 500 GB–1,5 TB
- 2 TB = genügend Luft für PDFs, Stücklisten, Dokumentation, ohne dass wir nochmal aufrüsten müssen
- 4 TB kostet rund doppelt so viel ohne dass wir den Platz absehbar brauchen

**Warum genau die T9:**
- USB-C nativ mit beiden Kabeln im Lieferumfang (C-zu-C und C-zu-A) — passt an Reiners Windows-PC und Mos Mac ohne Adapter
- 2.000 MB/s — 2 TB kopiert in unter 20 Minuten
- Sturzsicher bis 3 m, 5 Jahre Samsung-Garantie, AES-256 Hardware-Verschlüsselung
- 122 g, portabel

**Ablauf:**
1. Reiner kauft die SSD (Bezugsquelle steht in [[01 Inbox/Notiz Reiner - Externe SSD statt Remote Desktop]])
2. Reiner kopiert die relevanten NAS-Ordner auf die SSD — nur kopieren, nicht verschieben! Originale bleiben auf dem NAS.
3. Reiner übergibt Sebastian die SSD.
4. Sebastian übernimmt Reiners Daten auf seinen Mac (01_WEC-Projekte).
5. **Sebastian befüllt dieselbe SSD mit Reiners fertigem Gehirn** (02_Reiner-Gehirn): Obsidian-Vault mit CLAUDE.md, Ordnerstruktur auf deutsch, Vorlagen, Start-Dateien, Installer für Obsidian und Claude Desktop (Windows + Mac je nach Zielgerät), kurze PDF-Anleitung.
6. SSD geht zurück an Reiner — mit seinen Original-Daten plus seinem startklaren neuen Arbeitssystem.
7. Kein Zugriff von neuen Accounts aufs NAS — Steffen merkt nichts.
8. Kein Remote-Desktop-Stress, keine Netzwerk-Abhängigkeit.

**Welcome-Kit-Prinzip:** Die SSD macht eine Runde und erledigt zwei Aufgaben in einem Durchgang. Reiner bekommt nicht nur seine alten Daten zurück, sondern ein **vorbereitetes System**. Psychologisch wichtig: hier ist was Neues, und es ist bereit für dich, nicht "bau es dir selbst auf".

**Anleitung für Reiner:** [[01 Inbox/Anleitung Reiner - Externe SSD Projektspiegel]] (Schritt-für-Schritt inkl. Ordnerstruktur WEC-Projekte)

**Strategische Einordnung:** Die T9 ist die **physische Umsetzung** der Entkopplungsstrategie. Sie löst drei Probleme gleichzeitig:
1. Datentransfer ohne Netzwerk-Anpassungen bei WEC-IT
2. Redundante Sicherung der 30 Jahre Konstruktionsdaten
3. Unabhängigkeit von Reiners PC-Verfügbarkeit (Mo kann offline arbeiten)

**Für später:** Die T9 bleibt sinnvoll auch nach dem Mac-Studio-Kauf — als Transportmedium für Kunden, als Backup-Quelle, als Notfall-Datenträger wenn die Cloud ausfällt. Nicht weggeworfenes Geld.

**Was Sebastian auf dem Mac vorbereiten muss** (bevor SSD zurück zu Reiner geht) — Checkliste siehe [[02 Projekte/WEC Neustart mit Reiner/Checkliste - Reiner-Gehirn auf T9 vorbereiten]]

---

## Ziel

Reiner bekommt ein eigenes Zweites Gehirn (Obsidian + Claude), komplett auf Deutsch, auf seinem Windows-PC. Damit wir auf der gleichen Wellenlänge kommunizieren.

## Downloads — vorher runterladen

- [ ] **Obsidian**: [obsidian.md/download](https://obsidian.md/download) → Windows-Installer (.exe)
- [ ] **Claude Desktop**: [claude.ai/download](https://claude.ai/download) → Windows-Installer (.exe)

## Schritt 1 — Obsidian installieren (5 Min)

1. `Obsidian.x.x.x.exe` ausführen → installieren
2. Obsidian starten
3. "Neuen Tresor erstellen" wählen
4. Name: **Gehirn**
5. Speicherort: `C:\Users\Reiner\Documents\Gehirn` (oder Desktop)
6. "Erstellen" klicken

## Schritt 2 — Ordnerstruktur anlegen (5 Min)

In Obsidian links in der Sidebar: Rechtsklick → "Neuer Ordner" für jeden:

```
Gehirn/
├── 00 Kontext/
├── 01 Eingang/
├── 02 Projekte/
├── 03 Bereiche/
│   ├── WEC/
│   └── Kunden/
├── 04 Wissen/
├── 05 Tagesbuch/
├── 06 Archiv/
└── 07 Anhänge/
```

## Schritt 3 — Grunddateien anlegen (5 Min)

Drei Dateien direkt in Obsidian erstellen (Strg+N → Titel eingeben):

### CLAUDE.md (im Root)

```markdown
# Gehirn — Kontext

Dieses Gehirn gehört Reiner Woldrich, Inhaber von WEC — WOLDRICH ENGINEERING + CONSULTING.

## Über Reiner

(Wird gleich zusammen ausgefüllt)

## Wichtig

- Reiner ist Praktiker, kein IT-Mensch
- Klare, einfache Sprache — kein Fachjargon
- Deutsche Begriffe verwenden, kein Englisch
- Diktierfunktion ist sein Haupteingabeweg (Win+H → sprechen)
- Sebastians Texte immer still auf Rechtschreibung korrigieren — keine Kommentare

## Verbindung zu Sebastian

Reiner arbeitet eng mit Sebastian (Basti) zusammen bei WEC.
Sebastians Gehirn: separates System, aber gleiche Struktur und gleiche Begriffe.
Gemeinsame Projekte: WEC Pirna, Konstruktionsaufträge, Lebensmittelindustrie.

## Begriffe — Deutsch

| Statt (Englisch) | Sagen wir | Bedeutung |
|---|---|---|
| Vault | Gehirn | Der gesamte Notiz-Raum |
| Daily Note | Tagesbuch | Täglicher Eintrag |
| Inbox | Eingang | Neue Gedanken, unsortiert |
| Tag | Schlagwort | Kategorisierung |

## Ordner

- **00 Kontext/**: Wer ist Reiner, was macht WEC
- **01 Eingang/**: Schnelle Gedanken, unsortiert
- **02 Projekte/**: Aktive Projekte mit Ziel und Enddatum
- **03 Bereiche/**: Laufende Verantwortung (WEC, Kunden)
- **04 Wissen/**: Referenzmaterial, Gelerntes
- **05 Tagesbuch/**: Tägliche Einträge
- **06 Archiv/**: Erledigtes
- **07 Anhänge/**: Bilder, Dokumente
- **AUFGABEN.md**: Offene To-Dos

## Regeln

- Neue Notizen ohne klaren Platz → 01 Eingang/
- Tagesbuch im Format: JJJJ-MM-TT.md
- Verknüpfungen mit [[Ziel]] zwischen Notizen
- Erledigte Projekte → 06 Archiv/

## Bei Session-Start

1. AUFGABEN.md lesen
2. Letztes Tagesbuch lesen
3. Kurzes Briefing geben: Was ist offen, wo war ich
```

### AUFGABEN.md (im Root)

```markdown
---
tags: [aufgaben]
date: 2026-04-15
---

# AUFGABEN

Zuletzt aktualisiert: 2026-04-15

---

## Aktiv

### WEC — Umzug Pirna
- [ ] Planungsstand klären
- [ ] Eigene Rolle beim Umzug definieren
- [ ] Synergien mit Bens Edelstahl verstehen

### WEC — Laufend
- [ ] Lagerschalenhalter Lebensmittelindustrie — Stückliste überarbeitet (Sebastian)

---

## Erledigt

- [x] Gehirn eingerichtet (15.04.2026) ✅
```

### 00 Kontext/Über mich.md

```markdown
---
tags: [kontext]
date: 2026-04-15
---

# Über mich — Reiner Woldrich

## Wer bin ich

(Zusammen mit Reiner ausfüllen — per Diktierfunktion)

## WEC — WOLDRICH ENGINEERING + CONSULTING

- Website: w-ec.de
- Standort: Walther-Wolff-Str. 11, 01855 Sebnitz
- Umzug nach Pirna geplant (Ende August 2026)

## Fachgebiete

(Zusammen ergänzen)

## Ziele

(Zusammen ergänzen)
```

## Schritt 4 — Obsidian Einstellungen (3 Min)

In Obsidian: Einstellungen (Zahnrad unten links):

1. **Dateien & Links** → Standardordner für Anhänge: `07 Anhänge`
2. **Dateien & Links** → Standardspeicherort für neue Notizen: `01 Eingang`
3. **Dateien & Links** → Links automatisch aktualisieren: **An**
4. **Editor** → Rechtschreibprüfung: **An**
5. **Tägliche Notizen** (Core-Plugin aktivieren):
   - Ordner: `05 Tagesbuch`
   - Datumsformat: `YYYY-MM-DD`

## Schritt 5 — Claude Desktop installieren (10 Min)

1. `Claude-Setup.exe` ausführen → installieren
2. Claude Desktop starten
3. **Einloggen** mit Reiners Email
4. **Claude Pro Abo** abschließen (20$/Monat reicht für den Anfang)
5. **Filesystem-Connector** einrichten:
   - Einstellungen → Integrationen → Filesystem
   - Pfad: `C:\Users\Reiner\Documents\Gehirn` (oder wo der Ordner liegt)
   - Speichern
6. **Testen**: Neuen Chat starten → "Kannst du mein Gehirn lesen? Zeig mir die Ordnerstruktur."

## Schritt 6 — Diktierfunktion (Windows) (3 Min)

1. **Win+H** drücken → Windows Spracherkennung startet
2. Ins Textfeld klicken (Obsidian oder Claude Chat)
3. Sprechen → Text erscheint
4. Fertig — kein Setup nötig, Windows hat das eingebaut

**Alternativ:** In den Windows-Einstellungen → Barrierefreiheit → Spracherkennung → "Windows Spracherkennung" aktivieren

## Schritt 7 — Erste Notizen zusammen (20 Min)

1. **"Über mich"** zusammen per Diktierfunktion ausfüllen
   - Wer ist Reiner, was macht er, was ist WEC
2. **Erstes Projekt** anlegen: `02 Projekte/WEC Pirna.md`
3. **Erste Tagesbuch-Notiz**: Strg+N → `2026-04-15.md` in `05 Tagesbuch/`

## Schritt 8 — Erklären (10 Min)

- **Verknüpfungen**: `[[` tippen → Notiz auswählen → verbindet Notizen
- **Suche**: `Strg+O` → schnell jede Notiz finden
- **Tagesbuch**: Einfach reinschreiben, Claude sortiert
- **Diktierfunktion**: `Win+H` → sprechen statt tippen

## Checkliste

- [ ] Obsidian installiert
- [ ] Ordnerstruktur angelegt
- [ ] CLAUDE.md erstellt
- [ ] AUFGABEN.md erstellt
- [ ] Über mich.md erstellt
- [ ] Obsidian Einstellungen angepasst
- [ ] Claude Desktop installiert
- [ ] Claude Pro/Max Abo aktiv
- [ ] Filesystem-Connector verbunden
- [ ] Diktierfunktion getestet (Win+H)
- [ ] Erste Notizen zusammen geschrieben
- [ ] Reiner kann selbstständig Notiz erstellen
- [ ] Reiner kann Verknüpfung setzen
- [ ] Reiner kann Tagesbuch öffnen

## Verknüpfungen

- [[02 Projekte/WEC Neustart mit Reiner/WEC Neustart mit Reiner]]
- [[02 Projekte/WEC Neustart mit Reiner/Reiner Onboarding - Email Version]]

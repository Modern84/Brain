---
tags: [projekt, inventur, mac, pilot]
status: aktiv
priorität: A
date: 2026-04-18
owner: Sebastian
raum: MThreeD
due: 2026-08-01
---

# Mac Inventur

## Pilot-Charakter — warum das mehr ist als ein Mac-Aufräumen

**Das hier ist der Pilot für die spätere WEC-Gerätesicht-Integration.** Wenn in Zukunft Mitarbeiter-PCs ins System kommen, müssen deren Daten und Dokumente genauso sauber in Reiners bzw. Sebastians Gehirn einfließen. Was wir hier auf Sebastians Mac entwickeln — Kategorien, Stapel-Logik, Skript-Muster, Dokumentation — wird zum **Playbook für jeden weiteren Rechner**.

Konkreter Scope der späteren Skalierung: **6 PCs bei WEC** mit fünf verschiedenen Nutzerprofilen (Sekretariat, zwei Zeichnungs-Profile, Präzisions-Konstruktion mit Berechnung, Autodesk-Stahlbau, Geschäftsführung mit Solid Edge). Details: [[02 Projekte/WEC-Geraete Pilotscope]]

Konsequenz für diese Arbeit:

- **Methode vor Bequemlichkeit.** Lieber einen sauberen, übertragbaren Ablauf als einen schnellen Hack nur für Sebastian.
- **Kategorien müssen universell sein.** Was für Sebastian gilt (Müll / Installer / Fotos / Duplikate / Projekt-Material), muss auch für Reiner und einen zukünftigen Mitarbeiter gelten. Nutzer-spezifische Stapel kommen *zusätzlich*, nicht statt der universellen.
- **Skripte müssen portierbar sein.** macOS heute → Windows später (Reiner, Mitarbeiter-PCs). Gleiche Logik, andere Sprache.
- **Dokumentation läuft parallel mit.** Jede Entscheidung die wir treffen, halten wir so fest dass ein anderer Mensch (oder Claude in einer neuen Session) sie nachvollziehen und anwenden kann.
- **Am Ende der Etappe 1 entsteht das Playbook.** Extrahiert aus den hier gemachten Erfahrungen: [[04 Ressourcen/Playbook - Gerät ins Gehirn integrieren]] *(wird nach Abschluss Etappe 1 erstellt)*.

## Der größere Rahmen — warum das jetzt passiert

Der Mac ist historisch gewachsen. **Der Finder als Ganzes ist für Sebastian nicht mehr einsehbar** — nicht nur Desktop und Downloads, sondern die komplette Benutzer-Struktur. Dateien liegen an Orten die er selbst nicht mehr findet, Duplikate sammeln sich, wichtige Projektdaten sind mit Müll vermischt.

**Deadline: vor dem WEC-Start in Pirna (August 2026).** Je früher desto besser. Ein Ingenieurbüro kann nicht auf einem unsortierten Laptop laufen — weder für Sebastian noch für Reiner wenn sie irgendwann gemeinsam an einer Datei arbeiten. Saubere Finder-Struktur ist genauso wichtig wie saubere Konstruktionsdaten.

**Endziel:**
- Finder ist in unter 2 Minuten komplett scannbar
- Jede Datei hat einen erwartbaren Ort
- Gehirn enthält alle entscheidenden Projektinformationen
- Desktop und Downloads bleiben dauerhaft leer (via `sort-brain`)
- Kundendaten liegen im jeweiligen Kunden-Kontext (WEC/raw/Bens, WEC/raw/Knauf, etc.)
- **Methode ist auf Reiner und Mitarbeiter-PCs übertragbar**

## Erste Eindrücke aus Sebastians `~/Documents/`

*Screenshot-Analyse vom 2026-04-18, bevor Etappe 2 startet.*

- **Zig „Archive 2025-0...XXX?"-Ordner** mit abgeschnittenen, kryptischen Namen. In Kombination mit den sichtbaren `OpenBoM_Logs_hartman...X.zip`-Dateien sehr wahrscheinlich **automatisch generierte OpenBoM-Backups**. Wenn bestätigt: als **eigene Sonderkategorie** behandeln (z.B. `06_OpenBoM_Archive/`) und als Block sichten — die sind nicht einzeln entscheidbar, sondern als Gesamtheit behalten oder löschen.
- **Chrome-Passwörter.csv** im Documents-Ordner — Sensibel. Muss weg (in Schlüsselbund migriert, CSV sicher löschen).
- **GitHub-Ordner** — vermutlich aktive Entwicklungs-Repos, nicht anfassen bis geprüft.
- **Pi-5-m3d.terminal** — Terminalprofil für SSH zum Pi. Ins Gehirn als Konfigurations-Asset oder in `04 Ressourcen/Automatisierung/`.
- **Visual Studio** (Code?) — wahrscheinlich Arbeits-Workspace.
- **Apple_Intelligence_Report / DDPM-Dateien / Monitors.mif** — unklar, muss bei Etappe 2 einzeln geprüft werden.

Diese Erkenntnisse fließen ins Skript für Etappe 2 ein (OpenBoM-Erkennung als zusätzliche Kategorie-Regel).

## Pilot-Erkenntnisse (laufend gesammelt)

*Diese Liste wächst mit jeder Etappe und wird am Ende zur Grundlage für [[04 Ressourcen/Playbook - Gerät ins Gehirn integrieren]].*

### 2026-04-18 — Etappe 1, Phase 1 gelaufen

- **Verhältnis Müll zu Projekt-Material bei Sebastian: 15 zu 189 (≈ 1 zu 13).** Auf einem gepflegten Gerät ist Müll die klare Minderheit — das Gros ist echtes Projekt-Material. **Relevanz für WEC-Rollout:** Erwartungshaltung für Reiners Team setzen. Die Inventur ist kein „Großputz", sondern ein **Sortiervorgang** — 90 % der Arbeit ist Einsortieren ins Gehirn, nicht Löschen. Wer mit „ich schmeiß das meiste weg" rangeht, unterschätzt den Aufwand.
- **Screenshots dominieren mengenmäßig (307 Stück)** — direkt ins Gehirn, nicht in einen Sichtungs-Stapel. Automatisierung hier ist Pflicht, manuell nicht machbar.
- **iPhone-Fotos (115) sind der zweitgrößte Block** — bei Büro-PCs ohne iPhone-Sync entfällt diese Kategorie; dort ist sie durch `Handy_Fotos_Videos/` oder ganz leer zu ersetzen.
- **Namenskollisionen treten auf (3 Stück bei Sebastian)** — gleiche Dateinamen in Desktop *und* Downloads. Skript löst das mit `Downloads_`-Präfix sauber, muss im Playbook als bekannte Situation dokumentiert werden.
- **1Password-Diagnostics-Exports sind ein klassisches Muster** — sammeln sich bei jedem Nutzer der Support-Tickets gestellt hat. Auf WEC-PCs wahrscheinlich relevant. Support-Logs allgemein sind ein wiederkehrender Müll-Cluster: 1Password, Klipper/Moonraker, Browser-Diagnose. Gehören alle in `01_Muell`.
- **Installer-Stapel ist der Stapel mit der schnellsten Entscheidungsrate** — 95 % sind nach Installation redundant. Bei WEC-PCs gilt die gleiche Regel: Was installiert ist, ist installiert. Ausnahmen nur für Offline-Installer seltener Tools oder Firmware für aktive Hardware.
- **Autodesk-Ökosystem ist extrem installer-lastig** — allein Desktop Connector, Access, ODIS, Identity Manager, Inventor Pro Setup, DSKCON, AltiumDesigner summieren sich bei Sebastian auf ≈ 6 GB. Bei Steffens Autodesk-PC (Stahlbau/Inventor) erwartbar noch mehr. Der `02_Installer`-Stapel auf Autodesk-PCs wird speicher-kritisch.
- **Fremd-OS-Installer tauchen auf jedem Rechner auf** — Mac-User mit Windows-`.exe`, Windows-User mit Mac-`.pkg`. Entstehen durch Support-Downloads für Kollegen oder durch Windows-Installer-Erzeugung. **Regel fürs Playbook: Installer für das falsche OS sind immer Müll, ohne Ausnahme.**
- **Fotos/Bilder-Stapel braucht immer einen Host-Mechanismus außerhalb des Gehirns.** Bei Mac = Apple Fotos (erkennt Duplikate automatisch). Bei Windows = OneDrive Pictures oder vergleichbare Foto-Verwaltung. Das Gehirn ist nicht der richtige Ort für die Masse privater Fotos — nur für projekt-relevante Bilder, die bewusst ausgewählt und verlinkt werden.
- **AppleScript-Import in Apple Fotos hat Standard-Timeout von 2 Minuten** — bei mehr als 50 Dateien oder HEIC/Video explizit `with timeout of N seconds` setzen (empirisch: 115 Dateien ≈ 10 Minuten). Windows-Pendant (Fotos-App) hat andere Mechanik — vermutlich PowerShell + COM, für Reiners Team noch zu evaluieren.
- **Beim Import in Apple Fotos sind ≈ 25 % Duplikate durch iCloud-Sync erwartbar** (bei Sebastian: 30 von 115 = 26 %). Gutes Verhältnis — die Automatik spart echte Arbeit. Im Playbook als Erwartungswert für alle Geräte mit iCloud- oder OneDrive-Sync dokumentieren.
- **Duplikat-Kategorie ist nicht binär.** Drei Sub-Typen: md5-identisch (sicher weg), versioniert (beide behalten mit sprechenden Namen), verwaist (Original schon migriert, Kopie kann weg). Das Skript [[04 Ressourcen/Automatisierung/duplikate-check.sh]] trennt sie automatisch — ohne md5-Vergleich hätten wir Firmware-Versionen gelöscht.
- **Firmware-Archive und Repo-Snapshots als versionierte Duplikate sind ein klassisches Muster bei Hardware-Projekten.** Regel fürs Playbook: ZIP-Dateien mit Software- oder Firmware-Bezug NIE blind als Duplikat behandeln — immer md5 + Geburts-Zeitstempel (`stat -f "%SB"`) prüfen. Bei identischer mtime entscheidet die Geburtszeit.
- **md5-Match allein reicht bei Bildern nicht.** Wenn der md5 verschieden ist, müssen Dimensionen und Dateigröße verglichen werden: gleiche Seitenverhältnisse deuten auf Versionen desselben Motivs, verschiedene Seitenverhältnisse auf verschiedene Motive. Werkzeug: `sips -g pixelWidth -g pixelHeight`.
- **Online-verfügbare Assets gehören nicht lokal gespeichert.** ISOs, Sprachdokumentationen, Thingiverse/Cults-Downloads, ItsLitho-Service-Outputs — was online jederzeit neu generierbar oder ladbar ist, ist kein Projektmaterial. Regel fürs Playbook: Bei allen Archiven und Downloads zuerst prüfen, ob die Quelle online verfügbar und stabil ist; wenn ja → weg.

### 2026-04-18 — Phase 3 Session 1 (Bens)

- **Phase 3 Zwischenstand:** 13 von 188 Dateien aus `05_Projekt_Material/` nach `03 Bereiche/WEC/raw/Kunden/Volker Bens/` migriert — 9 Projekt-Dateien in `aktuelle Projekte/Lagerschalenhalter Lebensmittelindustrie/`, 4 wiederverwendbare Datenblätter in `Standards & Vorlagen/`. Inbox-Notiz zur Überarbeitung nach `wiki/Kunden/Volker Bens - Lagerschalenhalter Lebensmittelindustrie.md` kompiliert. Ingest.md um den Eintrag ergänzt.
- **Schema gewinnt gegen pauschale Inventur-Heuristik.** Bei strukturierten Zielbereichen (wie WEC mit `raw/wiki/schema`-Layer) ist das Vorsortier-Schema dem Ziel anzupassen, nicht umgekehrt. Konkret: Material-Datenblätter eines Kunden gehören in eine wohlstrukturierte Kundendatenschicht `Standards & Vorlagen` (wiederverwendbar), nicht in die Projekt-Unterordner. Claude-generierte Analysen und READMEs gehören in den `wiki/`-Layer, nicht in `raw/`. **Regel fürs Playbook:** Vor einer Phase-3-Session prüfen, ob der Zielbereich ein eigenes Schema hat (z.B. `WEC/CLAUDE.md`, `raw/README.md`) — Schema gewinnt immer.
- **md5-Abgleich isolierter Firmware-Binary gegen enthaltene Firmware in Repo-Snapshots identifiziert die Herkunft zuverlässig** — `firmware.bin` (42 KB, unklare Board-Zuordnung) wurde so als Octopus-Pro-Stock-Firmware aus dem ProForge-5-Snapshot 2026-03-28 erkannt (`unzip -p ZIP datei | md5 -q` gegen Datei-md5 vergleichen). **Regel fürs Playbook:** Bei unklaren `.bin`-Dateien immer md5 gegen bekannte Repo-/Release-Archive prüfen, bevor nach Hardware-Signatur (Reset-Vector, Stack-Pointer) geraten wird. Spart Zeit und ist eindeutig.
- **Vorsortierungs-Heuristiken müssen bei der Ausführung mit echten Metadaten gegengeprüft werden** — Beispiel: `backup-mainsail-2.json` war als „ältere Mini-Version → weg" eingestuft, ist tatsächlich aber NEUER (06.04. vs. 20.03.) und enthält Mobile-Layout-Settings. Geburts-/Modify-Datum ergibt sich aus Vorsortierung nicht zwingend richtig — `stat -f %SB` und Inhalts-Stichprobe bei jedem „weg"-Kandidaten in der Ausführungs-Session sind Pflicht. **Regel fürs Playbook:** Vorsortierung ist Vorschlag, nicht Verdikt. Ausführungs-Session validiert.
- **Doppelte Extensions wie `.pdf.pdf` sind ein wiederkehrendes OS-Artefakt** (entstehen beim „Speichern unter" wenn die Extension schon im Namen ist). Automatische Fix-Regel im Playbook vormerken: Beim Verschieben in ein Zielverzeichnis doppelte Extensions am Ende erkennen und auf eine reduzieren. Kunden-Tippfehler im Dateinamen (`Gundplatte`, `Zwichenplatte`) dagegen bleiben **unangetastet** — Original-Bezugnahme ist wichtiger als Sauberkeit.

## Scope in Etappen

Der Mac wird nicht in einer Nacht aufgeräumt. Etappe für Etappe, ohne Überlastung:

### Etappe 1 — Desktop und Downloads *(aktuell — Pilot)*

Der heißeste Ort — 500+ Dateien, mischt Arbeit und Müll. Skript `mac-inventur` sortiert vor, dann Stapel-Review. **Hier entwickeln wir die Methode.**

### Etappe 2 — `~/Documents/`

Noch schlimmer gewachsen als Desktop/Downloads. Viele automatisch generierte OpenBoM-Archive, Chrome-Passwörter als CSV (sicherheitsrelevant), aktive Projektordner vermischt mit Alt-Kram. Skript wird um OpenBoM-Kategorie erweitert.

### Etappe 3 — iCloud Drive außerhalb vom Gehirn

Was liegt in der iCloud auf Root-Ebene? Apps legen oft eigene Ordner an (Pages, Numbers, Keynote, Fusion 360, etc.). Prüfen was noch relevant ist.

### Etappe 4 — `~/Pictures/` und Fotos-App

Apple Fotos ist der richtige Ort für persönliche Fotos. Alle Projekt-relevanten Bilder ins Gehirn übernehmen.

### Etappe 5 — Applications

Ungenutzte Apps deinstallieren. Baut Platz frei und reduziert Hintergrundprozesse.

### Etappe 6 — Dauerbetrieb aktivieren

`sort-brain` läuft ab jetzt regelmäßig (manuell oder über macOS-Shortcut). Keine neuen Altlasten mehr.

### Etappe 7 — Playbook extrahieren

Aus den Erfahrungen der Etappen 1–6 entsteht die Ressource [[04 Ressourcen/Playbook - Gerät ins Gehirn integrieren]]. Anleitung wie jedes weitere Gerät (Reiners Windows-PC, die fünf Mitarbeiter-PCs) nach demselben Muster integriert wird — inklusive PowerShell-Variante der Skripte und profil-spezifischer Zusatz-Stapel.

---

## Etappe 1 — Desktop und Downloads (aktueller Arbeitsschritt)

### Methode — drei Phasen, keine Überlastung

#### Phase 1: Automatische Vorsortierung

Skript `mac-inventur` sortiert alles nach `~/Mac-Inventur/` in 5 Stapel. Nichts wird gelöscht, nur verschoben. Screenshots sind die einzige Ausnahme — die gehen direkt ins Gehirn.

```
~/Mac-Inventur/
├── 01_Muell/                  ← .crdownload, Logs, Diagnostics, Checksums
├── 02_Installer/              ← .exe .dmg .pkg .msi .iso .apk .tar.gz
├── 03_iPhone_Fotos_Videos/    ← IMG_XXXX.HEIC/JPG/MOV, „Neueste Fotos"
├── 04_Moegliche_Duplikate/    ← Dateien mit „ 2", „ 3", „ (1)" im Namen
├── 05_Projekt_Material/       ← alles andere = echte Kandidaten fürs Gehirn
└── _Kollisionen/              ← wenn gleicher Name in Desktop UND Downloads
```

Diese fünf Kategorien sind **bewusst universell**. Sie müssen auf jedem Gerät funktionieren — Mac, Windows, Reiners NAS.

#### Phase 2: Stapelweise sichten (ohne Gehirn)

Ein Stapel pro Session. Nicht alles auf einmal.

| Stapel | Aktion | Zeitschätzung |
|---|---|---|
| 01 Müll | Kurz drüberschauen → Papierkorb | 5 Minuten |
| 02 Installer | Brauche ich noch? Rest weg | 15 Minuten |
| 03 iPhone Fotos/Videos | In Apple Fotos importieren, dann weg | 20 Minuten |
| 04 Duplikate | Gegen Original vergleichen, weg wenn identisch | 20 Minuten |
| 05 Projekt-Material | → Phase 3 | separat |

#### Phase 3: Projekt-Material ins Gehirn — in Themen-Batches

Nicht Datei für Datei. Pro Session ein Thema:

- **Bens-Dateien** → `03 Bereiche/WEC/raw/Bens/` (STEP, DXF, DWG, Zeichnungen, Logo)
- **ProForge5-Dateien** → Projektordner (Firmware, Configs, Logs sinnvoll, STL-Tests)
- **Bescheide und Finanz-PDFs** → `03 Bereiche/Finanzen/`
- **Fusion/CAD-Eigenentwicklungen** → `03 Bereiche/Konstruktion/` oder Projekt
- **1Password-Kram** → wahrscheinlich komplett weg, wird im Schlüsselbund neu
- **Rest** → Einzelentscheidung mit Claude

**Wichtig für den Pilot:** Während wir das hier für Sebastians Dateien tun, notieren wir uns **wiederkehrende Muster** — welche Kundenordner sich herauskristallisieren, welche Dateitypen für welche Projekte typisch sind, welche Entscheidungen oft vorkommen. Diese Muster werden zur Grundlage des Playbooks für Reiner und Mitarbeiter-PCs.

## Fortschritt — Etappe 1

- [x] Inventur-Skript gebaut
- [x] Phase 1 gelaufen (`mac-inventur` ausgeführt) — 2026-04-18, 708 Dateien sortiert, Manifest unter `~/Mac-Inventur/Manifest_2026-04-18_0526.md`
- [x] Phase 2a: 01 Müll gesichtet — 2026-04-18, 15 Dateien in Papierkorb
- [x] Phase 2b: 02 Installer gesichtet — 2026-04-18, 32 Dateien in Papierkorb (≈ 9,1 GB freigegeben)
- [x] Phase 2c: 03 iPhone Fotos gesichtet — 2026-04-18, 115 Dateien: 85 neu in Apple Fotos, 30 als Duplikate erkannt (≈ 26 %), alle in Papierkorb (≈ 408 MB)
- [x] Phase 2d: 04 Duplikate gesichtet — 2026-04-18, 50 Dateien: 7 identisch (Papierkorb), 5 Unterschied (2 versionierte Firmware/Repo behalten mit Datumstempel, 3 Bilder einzeln entschieden), 38 ohne Original (16 → Apple Fotos, 6 Logs → Papierkorb, 2 Screenshots, 12 Einzelstücke → Einzelentscheidung). Report: `~/Mac-Inventur/Duplikate_Report_2026-04-18.md`
- [x] Phase 2e: `_Kollisionen/` gesichtet — 2026-04-18, 3 Dateien: 2× md5-Match → Papierkorb, 1× unterschiedlich → als `…_Downloads_kopie.jpg` zurück nach `05_Projekt_Material/`
- [ ] Phase 3: Projekt-Material themenweise einsortiert
- [ ] Mac-Inventur-Ordner leer → gelöscht
- [x] Pilot-Erkenntnisse während der Arbeit dokumentiert — laufend in Abschnitt „Pilot-Erkenntnisse" oben

## Fortschritt — Etappen 2–7

- [ ] Etappe 2: `~/Documents/` inventarisiert
- [ ] Etappe 3: iCloud Drive außerhalb Gehirn inventarisiert
- [ ] Etappe 4: `~/Pictures/` und Fotos-App sortiert
- [ ] Etappe 5: Applications aufgeräumt
- [ ] Etappe 6: `sort-brain` im Dauerbetrieb
- [ ] Etappe 7: Playbook extrahiert → bereit für Reiner und Mitarbeiter-PCs

## Regeln für alle Etappen

- **Kontext entscheidet, nicht Dateityp.** Eine STEP-Datei von Bens gehört zu Bens, nicht in einen generischen CAD-Ordner.
- **Pro Session ein Thema.** Nicht zwischen Kunden oder Bereichen springen.
- **Wenn unklar:** ab in `01 Inbox/_Eingang Dateien/` und später entscheiden.
- **Originale bleiben intakt.** Bei Zweifel kopieren statt verschieben.
- **Skripte werden wiederverwendet.** `mac-inventur.sh` kann für andere Ordner angepasst werden — gleiches Muster.
- **Alles pilot-tauglich dokumentieren.** Jede Entscheidung ist ein Muster für die spätere Skalierung.
- **Sensible Daten (Passwörter, Backup-Codes, Diagnose-Logs) sicher behandeln** — nie als Klartext im Gehirn, nie einfach im Papierkorb liegen lassen.

## Verknüpfungen

- [[02 Projekte/WEC-Geraete Pilotscope]] — die 6 WEC-PCs mit Nutzerprofilen
- [[04 Ressourcen/Automatisierung/mac-inventur.sh]] — Skript Etappe 1
- [[04 Ressourcen/Automatisierung/sort-brain.sh]] — laufender Betrieb
- [[04 Ressourcen/Automatisierung/Automatisierung]] — Übersicht
- [[01 Inbox/_Eingang Dateien/README]] — Eingang-Ordner
- [[02 Projekte/WEC Neustart mit Reiner/WEC Neustart mit Reiner]] — übergeordnetes WEC-Projekt
- [[03 Bereiche/WEC/README]] — WEC-Bereich (Ziel für Kundendaten)

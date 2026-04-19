---
tags: [skill, geraete-integration, inventur]
status: in-entwicklung
date: 2026-04-18
---

# Skill — Mac-Inventur Methode

## Was das ist

Eine systematische Methode um einen historisch gewachsenen Rechner (aktuell Mac, später Windows) **nicht durch Löschen sondern durch Sortieren** aufzuräumen. Alle Dateien aus Desktop und Downloads werden automatisch in fünf universelle Stapel vorsortiert, dann stapelweise gesichtet und entweder ins Gehirn übernommen oder verworfen. Screenshots laufen direkt ins Gehirn, alles andere durchläuft einen kontrollierten Entscheidungspfad.

## Wann anwenden

- Neuer Rechner soll ins System integriert werden (Reiners PC, Mitarbeiter-PCs bei WEC)
- Bestehender Rechner ist unübersichtlich geworden und braucht eine Inventur
- Deadline vor wichtiger Zusammenarbeit (wie WEC-Start in Pirna August 2026)
- Auslöser beim Sprechen: „Finder unübersichtlich", „Mac aufräumen", „PC integrieren", „Daten ins Gehirn"

## Wie (Kurzanleitung)

**Voraussetzung:** Das Gehirn selbst ist aufgebaut und strukturiert ([[CLAUDE]]-Regeln gelten).

**Schritt 1 — Vorsortier-Skript bereitstellen**

Für macOS: [[04 Ressourcen/Automatisierung/mac-inventur.sh]]
Für Windows: PowerShell-Variante (noch zu erstellen)

**Schritt 2 — Preview ausführen**

```bash
mac-inventur --preview
```

Zeigt die Zahlen pro Kategorie ohne etwas zu bewegen. Plausibilitätscheck bevor es ernst wird.

**Schritt 3 — Scharf laufen lassen**

```bash
mac-inventur
```

Legt `~/Mac-Inventur/` an mit fünf universellen Stapeln:

1. `01_Muell` — .crdownload, Logs, Diagnose-Files
2. `02_Installer` — .exe .dmg .pkg .msi .iso .apk
3. `03_iPhone_Fotos_Videos` (oder `03_Handy_Fotos_Videos` auf Büro-PCs)
4. `04_Moegliche_Duplikate` — Dateien mit „ 2", „ 3", „ (1)" im Namen
5. `05_Projekt_Material` — alles andere

Plus `_Kollisionen/` wenn gleiche Dateinamen in Desktop UND Downloads lagen. Screenshots gehen direkt ins Gehirn nach `07 Anhänge/Screenshots/`.

**Schritt 4 — Stapelweise sichten (ein Stapel pro Session)**

- `01_Muell` → Papierkorb (typisch: 5 Minuten)
- `02_Installer` → 95 % in Papierkorb, Ausnahmen nur für Offline-Installer seltener Tools
- `03_iPhone_Fotos` → Apple Fotos importieren, dann Papierkorb (Apple Fotos erkennt Duplikate)
- `04_Moegliche_Duplikate` → gegen Original vergleichen, identische weg
- `05_Projekt_Material` → Themen-Batches ins Gehirn (siehe Schritt 5)

**Schritt 5 — Projekt-Material ins Gehirn einsortieren**

Pro Session ein Thema, nicht Datei für Datei:

- Kunde A (z.B. Bens) → `03 Bereiche/WEC/raw/Bens/`
- Projekt X (z.B. ProForge5) → passender Projektordner
- Bereich (z.B. Finanzen) → `03 Bereiche/Finanzen/`

Kontext entscheidet, nicht Dateityp. Eine STEP-Datei von Bens gehört zu Bens, nicht in einen generischen CAD-Ordner.

**Schritt 6 — Dauerbetrieb aktivieren**

Nach der Einmal-Inventur übernimmt [[04 Ressourcen/Automatisierung/sort-brain.sh]] — verschiebt alles Neue pauschal in `01 Inbox/_Eingang Dateien/`.

## Stand der Beherrschung

**in-entwicklung** — wird gerade zum ersten Mal in Etappe 1 des [[02 Projekte/Mac Inventur]] Pilot-Projekts angewendet. Methode wird parallel dokumentiert und verfeinert. Nach Abschluss der sieben Etappen wird daraus das [[04 Ressourcen/Playbook - Gerät ins Gehirn integrieren]].

**Bereits bestätigte Muster:**
- Auf gepflegten Geräten ist Müll die Minderheit (≈ 1 zu 13 bei Sebastian)
- Screenshots dominieren mengenmäßig (307 Stück) — Automatisierung ist Pflicht
- Installer-Stapel ist der mit der schnellsten Entscheidungsrate (95 % weg)
- Fremd-OS-Installer sind immer Müll, ohne Ausnahme

## Abhängigkeiten

- [[Skill - Obsidian Brain pflegen]] — das Ziel-System muss stehen
- Claude Code für Terminal-Arbeit (ideal) oder manuelles Ausführen
- Bei Windows: [[Skill - Claude Code CLI Setup]] auf dem Ziel-PC

## Referenzen

- [[02 Projekte/Mac Inventur]] — der laufende Pilot
- [[02 Projekte/WEC-Geraete Pilotscope]] — die 6 Ziel-PCs
- [[04 Ressourcen/Automatisierung/mac-inventur.sh]] — das Skript
- [[04 Ressourcen/Automatisierung/sort-brain.sh]] — Dauerbetrieb-Skript
- [[01 Inbox/_Eingang Dateien/README]] — Eingang im Gehirn

## Lessons Learned

*Aktuelle Liste — wächst mit jeder Phase:*

- Skripte immer auf der Default-Shell-Version der Zielplattform testen, nicht auf der modernsten (macOS hat Bash 3.2, keine assoziativen Arrays).
- Filesystem-Connector-Writes entfernen das Execute-Bit — nach jedem Skript-Update `chmod +x` neu setzen.
- Inventur ist Sortiervorgang, kein Großputz — wer mit „ich schmeiß das meiste weg" rangeht, unterschätzt den Aufwand.
- Support-Logs (1Password, Klipper, Browser) sind wiederkehrender Müll-Cluster auf jedem Rechner.
- Autodesk-Installer-Stapel ist speicher-kritisch (≈ 6 GB bei Sebastian, erwartbar mehr bei Steffens PC).
- **AppleScript-Import in Apple Fotos hat Standard-Timeout von 2 Minuten.** Bei mehr als 50 Dateien oder HEIC/Video explizit `with timeout of N seconds` setzen. Empirisch: 115 Dateien ≈ 10 Minuten. Windows-Pendant (Fotos-App) hat andere Mechanik — vermutlich PowerShell + COM, muss für Reiners Team noch evaluiert werden.
- **Beim Import in Apple Fotos sind ≈ 25 % Duplikate durch iCloud-Sync erwartbar** (Sebastian: 30 von 115 = 26 %). Gutes Verhältnis — die Automatik spart echte Arbeit. Im Playbook als Erwartungswert für alle Geräte mit iCloud- oder OneDrive-Sync dokumentieren.
- **Vor dem Löschen großer Foto-/Videobestände immer einen Index im Gehirn anlegen** (chronologisch, mit Dateiname + Größe + Aufnahmedatum). Sicherheitsnetz, falls später ein bestimmtes Bild gesucht wird und nicht in der Foto-App landet.
- **Duplikate sind kein binärer Fall.** Drei Sub-Typen: md5-identisch (sicher weg), versioniert (beide behalten mit sprechenden Namen), verwaist (Original schon migriert, Kopie kann weg). Werkzeug: [[04 Ressourcen/Automatisierung/duplikate-check.sh]] + eigener Skill [[Skill - Duplikat-Pruefung per md5]].
- **Firmware-Archive und Repo-Snapshots als versionierte Duplikate sind ein klassisches Muster bei Hardware-Projekten.** ZIP-Dateien mit Software- oder Firmware-Bezug NIE blind als Duplikat behandeln — immer md5 + Geburts-Zeitstempel prüfen. Bei identischer mtime entscheidet `stat -f "%SB"`.
- **md5-Match allein reicht bei Bildern nicht.** Wenn der md5 verschieden ist, Dimensionen und Dateigröße vergleichen (`sips -g pixelWidth -g pixelHeight`) — gleiche Seitenverhältnisse deuten auf Versionen, verschiedene auf unterschiedliche Motive.
- **Online-verfügbare Assets gehören nicht lokal.** ISOs, Sprachdokumentationen, Thingiverse/Cults-Downloads, Service-Outputs (ItsLitho etc.) — was online stabil verfügbar ist, ist kein Projektmaterial.

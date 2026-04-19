---
tags: [skill, daten-handling, inventur]
status: beherrscht
date: 2026-04-18
---

# Skill — Duplikat-Prüfung per md5

## Was das ist

Eine systematische Methode um vermeintliche Duplikate **nicht blind zu löschen**, sondern per md5-Hash-Vergleich in drei Sub-Kategorien zu sortieren: wirklich identisch, versioniert (unterschiedlicher Inhalt trotz ähnlichem Namen) oder verwaist (Original nicht mehr auffindbar). Werkzeug dafür: [[04 Ressourcen/Automatisierung/duplikate-check.sh]].

## Wann anwenden

- Nach einer Mac-/PC-Inventur, wenn der Stapel „Mögliche Duplikate" gesichtet wird
- Wenn zwei Dateien gleichen/ähnlichen Namens auftauchen und unklar ist, ob wirklich identisch
- Vor dem Löschen von ZIP-Archiven mit Software- oder Firmware-Bezug (versionierte Snapshots sind oft wertvoll)
- Auslöser beim Sprechen: „ist das ein Duplikat?", „kann ich das Doppelte weg?", „welche Version ist aktuell?"

## Wie (Kurzanleitung)

```bash
# Signatur:
# duplikate-check.sh [--output <pfad>] [--verbose] \
#   <duplikat-ordner> <original-ordner> [<weitere-ordner> ...]

# Mac-Inventur (Ursprungsfall):
~/Brain/04\ Ressourcen/Automatisierung/duplikate-check.sh \
  ~/Mac-Inventur/04_Moegliche_Duplikate \
  ~/Mac-Inventur/05_Projekt_Material \
  ~/Brain/07\ Anhänge/Screenshots

# Report-Ziel explizit setzen, mit Fortschrittsausgabe:
~/Brain/04\ Ressourcen/Automatisierung/duplikate-check.sh \
  --output ~/Desktop --verbose \
  ~/Downloads/dubletten ~/Archiv/2024 ~/Archiv/2025
```

**Optionen:**
- `--output <pfad>` — Zielpfad für den Markdown-Report (Default: aktuelles Arbeitsverzeichnis). Früher lag der Report fest bei `<duplikat-ordner>/../Duplikate_Report_*.md` — das ist jetzt über `--output` steuerbar, damit das Skript auch außerhalb der Mac-Inventur-Ordnerstruktur sauber läuft.
- `--verbose`, `-v` — gibt pro Datei aus, welcher Original-Kandidat gesucht und gefunden wurde und mit welchem md5-Ergebnis einsortiert wird. Nützlich bei Debug oder wenn man live mitlesen will.
- `--help`, `-h` — zeigt den Header-Kommentar als Hilfe an.

Das Skript:

1. Leitet aus jedem Duplikat-Namen den vermutlichen Original-Namen ab (entfernt Muster `" N"` und `" (N)"` mit N = 1–3 Stellen vor der Extension)
2. Sucht das Original rekursiv (case-insensitive) in den angegebenen Original-Ordnern
3. Vergleicht md5 von Duplikat und Original
4. Verschiebt in Unter-Ordner:
   - `_identisch/` — md5-Match, sicher löschbar
   - `_unterschied/` — md5 anders, beide Versionen prüfen
   - `_kein_original/` — Original nicht gefunden, Einzelentscheidung
5. Schreibt Markdown-Report `Duplikate_Report_YYYY-MM-DD.md` in den `--output`-Pfad (oder ins aktuelle Arbeitsverzeichnis) mit Tabelle: Dateiname | Original-Pfad | md5-Match | Entscheidung + Zusammenfassung

## Entscheidungsregeln pro Sub-Kategorie

### `_identisch/` → Papierkorb
Kein Zweifel, md5 ist Byte-genau. Einziger Sonderfall: zwei identische Versionen könnten absichtlich an zwei Orten liegen (Backup-Strategie) — dann nur die Kopie im Duplikat-Ordner löschen, das Original am Zielort lassen.

### `_unterschied/` → Einzelprüfung
Hier liegt der Wert des Skripts: **ohne md5-Check hätte man wertvolle Versionen gelöscht**.

Typische Fälle:
- **Firmware-Archive** (P5FW.zip vs P5FW (1).zip): beide behalten, mit Datumstempel umbenennen (z.B. `P5FW_alt_YYYY-MM-DD.zip` / `P5FW_aktuell_YYYY-MM-DD.zip`). Bei identischer mtime Geburtszeit prüfen: `stat -f "birth=%SB" -t "%Y-%m-%d_%H:%M"`
- **Repo-Snapshots** (ProForge-5-main.zip vs ProForge-5-main (2).zip): gleich benennen mit Datum: `ProForge-5-main_snapshot_YYYY-MM-DD.zip`
- **Bilder mit unterschiedlichem md5**: Dimensionen prüfen (`sips -g pixelWidth -g pixelHeight <datei>`). Gleiche Seitenverhältnisse = wahrscheinlich Versionen desselben Motivs (größere behalten). Verschiedene Seitenverhältnisse = verschiedene Motive (beide behalten).
- **Sehr kleine Bilder** (< 20 KB, 400×267 etc.) bei md5-Unterschied: oft Thumbnail-Artefakte, meist beide weg.

### `_kein_original/` → Einzelentscheidung
Original wurde schon migriert, gelöscht oder war nie an der erwarteten Stelle. Typische Kategorien:

- **Verwaiste iPhone-Kopien** (`IMG_xxxx 2.HEIC`): nach `03_iPhone_Fotos_Videos/` zurück → Batch-Import in Apple Fotos → dann weg. Apple Fotos erkennt echte Duplikate automatisch.
- **Verwaiste Screenshots** (`Bildschirmfoto … 1.png`): md5 gegen Vault-Screenshots prüfen. Match → weg. Kein Match → ins Vault übernehmen (vergessenes Bild).
- **Online-verfügbare Assets** (ISOs, Sprachdokumentationen, Thingiverse/Cults-Downloads, Service-Outputs): Papierkorb.
- **Versionierte Einzelstücke** (z.B. `Proforge 4.STEP` als Referenz zu ProForge5): mit sprechendem Namen ins passende Projektmaterial.

## Stand der Beherrschung

**beherrscht** — in Etappe 1 Phase 2d des [[02 Projekte/Mac Inventur]]-Piloten am 2026-04-18 erstmals vollständig angewendet. 50 Duplikat-Kandidaten verarbeitet, 46 in Papierkorb, 4 wertvolle Versionen gerettet (2 Firmware-Builds + 2 Repo-Snapshots).

## Werkzeuge

- **macOS:** `md5 -q`, `stat -f`, `find -iname`, `sips` — alle in Bordmitteln vorhanden
- **Windows-Pendant:** `Get-FileHash -Algorithm MD5`, `Get-ChildItem`. PowerShell-Portierung von `duplikate-check.sh` steht aus — muss für Reiners Team erstellt werden.

## Abhängigkeiten

- [[Skill - Mac-Inventur Methode]] — dieser Skill ist ein Sub-Werkzeug davon

## Referenzen

- [[04 Ressourcen/Automatisierung/duplikate-check.sh]] — das Skript
- [[02 Projekte/Mac Inventur]] — erste Anwendung
- [[02 Projekte/WEC-Geraete Pilotscope]] — zukünftige Skalierung

## Lessons Learned

- **Firmware NIE blind löschen.** Sebastian hätte durch blindes Löschen eines scheinbaren Duplikats eine 2,7-GB-Firmware-Version verloren. md5-Check ist die Versicherung.
- **Bei Bildern reicht md5 nicht** — Dimensionen und Seitenverhältnis prüfen, bevor eine Version verworfen wird.
- **Bei identischer Modification Time** (mtime gleich, aber md5 anders): `stat -f "%SB"` liefert die Geburtszeit und entscheidet zuverlässig.
- **Verwaiste Dubletten sind oft harmlos** — wenn das Original längst in Apple Fotos, im Vault oder online liegt, ist die Kopie wirklich Müll.

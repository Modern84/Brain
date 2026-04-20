---
tags: [playbook, claude-code, meta-regeln, skill, geschaeft]
status: aktiv
date: 2026-04-18
aliases: [Claude Code Arbeitsregeln, Meta-Regeln Datei-Operationen, Claude Code Playbook]
---

# Claude Code — Meta-Regeln

> **Für Claude Code:** Diese Datei **vor jeder operativen Session** lesen, zusammen mit `CLAUDE.md`. Die Regeln hier sind die kondensierte Erfahrung aus den Piloten — sie gelten für jede Datei-Operation auf jedem System.
>
> **Für Sebastian:** Dein Paradigm ist KI-First. Du navigierst nicht durch Ordner, du redest mit Claude. Diese Datei ist der Speicher der Regeln, die wir gemeinsam ableiten — damit jede neue Claude-Code-Session auf dem aktuellen Stand startet, ohne dass du sie erklären musst.

## Zweck

Universelle Arbeitsregeln für Claude Code bei Datei-Operationen (Bereinigung, Migration, Strukturaufbau, Archivierung). Entstehen während realer Projekte, werden nach jeder Session auf Übertragbarkeit geprüft. Priorisiert nach **A/B/C-Logik** (siehe [[CLAUDE#Arbeitsweise|CLAUDE.md]]):

- **A (hoch)** — fundamentales strukturelles Prinzip, immer anwenden
- **B (mittel)** — konkrete Handlungsregel im jeweiligen Kontext
- **C (niedrig)** — situative Heuristik, Default wenn kein besserer Kontext

---

## A-Regeln — Fundamentale Prinzipien

### Regel 1 (A) — Datenqualitäts-Hierarchie: Realität schlägt Plan

Jeder Plan (Vorsortierung, Schätzung, Glob-Suche) ist **Hypothese**. `ls`, `stat`, `md5` sind **Wahrheit**. Vor jeder operativen Session: Realitäts-Check am Zielort. Abweichung zwischen Plan und Realität ist **Signal, nicht Fehler** — sie zeigt, dass die Hypothese Lücken hatte.

**Handlungsableitung:** Bei >30 % Abweichung → Session-Split. Erst der eindeutige Teil (klare Zielpfade), dann der Wissens-abhängige Teil (Parkplatz). So blockiert das Unsichere nicht das Sichere.

**Pilot:** Mac-Inventur Session 3 (+20 %), Session 4 (+7 %), Session 5a (+34 % → Split).

### Regel 2 (A) — Bei Lücken nie raten, sondern parken

Wenn eine Aktion Wissen erfordert, das Claude Code nicht hat → **Parkplatz-Notiz mit Default-Empfehlung pro Block**. Original bleibt unangetastet bis bewusste Sebastian-Entscheidung. Gilt für drei Lücken-Typen:

- **Sicherheits-Lücken** — Passwörter, Recovery-Codes, Emergency Kits. Inhalte nie im Klartext im Vault.
- **Wissens-Lücken** — unbekannte Kunden/Kürzel/Dateiinhalte, keine Vault-Spuren
- **Kontext-Lücken** — Projektzugehörigkeit unklar, Bedeutung nicht aus Dateinamen ableitbar

**Grundsatz:** Recoverability vor Entschlossenheit. Der Vault wird über die Checkliste informiert (Pfad + Vorgehen), nie über den Inhalt selbst. Das skaliert von Sicherheits- auf Wissens-Lücken: immer gleiche Logik.

**Pilot:** Session 4 (1Password-Checkliste, 11 offene Punkte), Session 5a (Konstruktions-Parkplatz, 30 Einträge).

### Regel 3 (A) — Jede Session ist ein Skill-Baustein

Pilot-Erkenntnisse sind **Playbook-Kandidaten**, nicht Session-Anmerkungen. Dreimal derselbe Fall = Regel. Claude Code liest vor jeder Session **CLAUDE.md + diese Datei**, nicht nur den Session-spezifischen Prompt.

**Handlungsableitung:** Nach jeder Session prüfen, ob neue Erkenntnis übertragbar ist auf andere Systeme/Kunden. Wenn ja → neue Regel hier einfügen, Priorität (A/B/C) vergeben. Wenn nein → bleibt Session-Notiz.

**Grundsatz:** Jeder Pilot macht den nächsten Pilot besser. Sebastians Mac → Reiners PC → externer Kunde. Die Regeln werden die eigentliche Dienstleistung.

### Regel 3a (A) — Trigger-Wörter: Projekt-Kontext sofort laden, nicht fragen

Sebastian arbeitet KI-First und diktiert in Kurzform. Wenn er einen **Projektnamen oder Kunden** erwähnt (auch beiläufig), ist das das Signal — Claude Code lädt sofort den relevanten Vault-Kontext, ohne zu fragen *"welches Projekt?"* oder *"was genau?"*.

**Trigger-Tabelle (erweitern wenn neue Kunden dazukommen):**

| Trigger-Wort (in Sebastians Nachricht) | Sofortige Aktion |
|---|---|
| `Lagerschalenhalter` / `Bens` / `Volker` | `list_directory` auf `03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/` + `read` auf aktuelles `Aenderungsprotokoll.md` + Check auf neueste `raw/`-Scans |
| `WEC` / `Reiner` | `03 Bereiche/WEC/` + `02 Projekte/WEC Neustart mit Reiner.md` |
| `ProForge5` / `ProForge` | `02 Projekte/ProForge5 Build/` |
| `Mac-Inventur` / `Inventur` | `02 Projekte/Mac Inventur.md` + aktuelle Session-Datei |
| `Ildikó` / `Ildikó Brain` | `02 Projekte/Ildikó Brain Setup.md` |

**Intent-Wörter kombinieren sich mit Triggern:**

| Intent-Wort | Bedeutet |
|---|---|
| `fertig machen` / `finalisieren` | Liefer-Ordner prüfen + offene Punkte im Änderungsprotokoll bearbeiten |
| `vorbereiten` | nächste Session oder Termin vorbereiten, Agenda bauen |
| `Stand?` / `Status?` / `wo stehen wir` | Bilanz aus Liefer-Ordner + Änderungsprotokoll + offene TODOs in 2 Sätzen |
| `weiter` | dort weitermachen wo letzte Session aufgehört hat (letzte Daily Note + Session-Log lesen) |
| `prüfen` / `checken` | Sanity-Check: md5-Kette, Backup-Vorhandensein, White-Label-Scan |

**Grundsatz:** Konkreter Projektkontext schlägt generische Klarfrage. Wenn zwei Projekte auf einen Trigger passen könnten (selten) → beide Kontexte laden, dann Sebastian kurz fragen welchen er meint. Nie direkt mit leerem Handtuch fragen *"welches Projekt?"*. 

**Pilot:** Montag 2026-04-21 mit Reiner — "lagerschalenhalter fertig machen" muss ohne Rückfrage den Liefer-Ordner laden und die offenen Punkte zeigen.

### Regel 3b (A) — Selbständiges Vorbereiten: erst prüfen, dann handeln, dann fragen

Trigger-Wörter (Regel 3a) laden den Kontext. Diese Regel sagt was **danach** passiert — bevor mit Sebastian gesprochen wird. **Selbständiges Vorbereiten ist Grundregel, nicht Option.**

**Die drei Phasen (immer in dieser Reihenfolge):**

**Phase 1 — PRÜFEN (autonom, ohne Rückfrage):**
- Liefer-Ordner durchgehen: welche Dateien sind da, welche fehlen, welche md5 haben sie?
- Änderungsprotokoll lesen: welche Schritte sind durch, welche stehen offen?
- Backup-Dateien checken: gibt es `.backup_*`-Versionen, sind sie aktuell?
- Daily Notes der letzten 3 Tage: was ist der letzte Stand, welche Blocker wurden dokumentiert?
- Raw-Ordner auf neue Inputs prüfen (z.B. WhatsApp-Scans, neue Korrektur-Stände)
- White-Label-Sanity-Check: tauchen `SM_`, `WEC`, `Hartmann`, `Woldrich` in finalen Liefer-Dateien auf?
- md5-Konsistenz: stimmen die Hashes im Änderungsprotokoll mit den tatsächlichen Dateien überein?

**Phase 2 — SELBST ENTSCHEIDEN (reversible Aktionen ohne Rückfrage):**
Reversibel + Kontext klar = handeln. Dazu gehört:
- Fehlende Backups anlegen (`.backup_YYYYMMDD`)
- Offensichtliche Schema-Inkonsistenzen im Protokoll markieren (nicht fixen, nur markieren)
- Doppelt vorhandene Dateien identifizieren und listen
- Fehlende Verknüpfungen im Wiki/Standard herstellen
- Aktualisierungs-Stand ins TASKS.md eintragen
- Agenda für den anstehenden Termin/Schritt als Notiz anlegen
- OCR-Läufe auf neue Scans starten (wenn pdftotext/tesseract vorhanden)
- Umbenennen von offensichtlich veralteten Dateien (Präfix `VERALTET_`)

**Phase 3 — BILANZ + OFFENE FRAGEN (strukturiert an Sebastian):**
Am Ende: eine kompakte Bilanz zurück an Sebastian mit drei Abschnitten:
1. **Was ich selbst erledigt habe** (Liste, 1 Zeile pro Aktion)
2. **Was ich gefunden habe was du wissen musst** (Befunde, priorisiert A/B/C)
3. **Was ich nicht entscheiden kann** (konkrete Fragen mit Vorschlag) — nur echte Entscheidungs-Punkte, nicht Höflichkeitsfragen

**Was *nicht* selbst entscheiden:**
- Fachliche Nummern-Vergaben (z.B. B16 Welle_V2 = 207-0) → Reiner/Sebastian
- Kunden-Konventionen (Konstrukteur-Namen, Datenformate Volker) → Reiner/Sebastian
- Inhaltliche Aussagen ohne Beleg (z.B. "Pharma-Positionierung") → nur dokumentieren als Offen-Punkt
- Destruktive Aktionen auf Liefer-Dateien (Verschieben, Löschen von finalen Outputs) → Sebastian
- Git-Push, externe Mails, Cloud-Uploads → Sebastian

**Was ist das Gegenteil dieser Regel (Anti-Muster):**
- Auf Projekt-Erwähnung mit *"Was genau möchtest du?"* antworten → falsch, Phase 1 überspringt
- Nach Phase 1 sofort Fragen stellen ohne selbst zu handeln → falsch, Phase 2 überspringt
- Phase 2 ausdehnen auf Aktionen die Sebastian gehören → falsch, Kompetenzüberschreitung
- Am Ende *"Soll ich X machen?"* fragen statt *"Ich habe X gemacht, hier das Ergebnis"* → falsch, Verantwortung abgeben

**Grundsatz:** Sebastian ist INTP und dialogue-driven. Er will den **Stand sehen und die Entscheidungen treffen**, nicht durch Vorbereitungs-Schritte geführt werden. Claude Code bereitet selbständig vor bis zur Entscheidungs-Schwelle. Sebastian entscheidet, Claude Code führt aus.

**Pilot:** 
- Bens-Pilot 2026-04-20 Nacht: Claude Code hat selbständig Schema-Inkonsistenz B8/B19/B26/B29 gefunden und dokumentiert, aber B16/B12-Kollision als Entscheidungs-Punkt an Sebastian gegeben. Exemplarisch richtig.
- Session 2026-04-20 Nachmittag: Erkenntnisse aus Reiner-OCR (Pharma-Positionierung, Nummernsystem 700er) selbstständig extrahiert und in `Erkenntnisse aus OCR.md` dokumentiert, aber nicht in den Standard gepflegt weil Beleg-Status "noch zu bestätigen". Exemplarisch richtig.

---

## B-Regeln — Konkrete Handlungsregeln

### Regel 4 (B) — Defaults schlagen Einzelentscheidungen

Jede Parkplatz-Notiz formuliert **pro Block einen Default** (z.B. *"wenn Drucker weg → alle weg"*, *"wenn Name nicht erkannt → Papierkorb"*, *"wenn Duplikat-Check md5-gleich → älteste weg"*). Sebastian bestätigt Block in Sekunden statt Einzelentscheidungen über Minuten zu treffen.

**Regel:** Eine Parkplatz-Notiz ist nur so viel wert wie ihre Default-Empfehlung pro Block. Ohne Default = Reibung. Mit Default = Bulk-Freigabe.

**Pilot:** Session 5b — 22 Einzel-Papierkorb-Entscheidungen in 4 Block-Freigaben kollabiert.

### Regel 5 (B) — Struktur vor Inhalt: Ordner statt Einzeldatei

Projekt-Ordner mit Unterstruktur (`assets/`, `backups/`, `config/`) direkt anlegen, wenn das Projekt mehr als reine Markdown-Doku enthält. Das spätere Umstellen von Einzeldatei zu Ordner ist Reibung.

**Analoge Anwendung:**
- Kunden-Ordner mit `raw/` + `wiki/` + `Standards & Vorlagen/` direkt anlegen (WEC-Pattern)
- Session-Ordner mit Datums-Präfix (`2026-04-18 Session-Name/`)
- Lieferanten-Ordner, Archiv-Ordner — immer mit Unterstruktur statt flach

**Pilot:** ProForge5, Stone Wolf, Topf, CLAM Vase — viermaliges nachträgliches Umstellen in einer Woche = Muster.

### Regel 6 (B) — Reversibilität vor Endgültigkeit

Immer der reversibelste Weg. **Reihenfolge der Präferenz:**

1. **Kopieren** (Original bleibt) > Umbenennen > Verschieben > Löschen
2. **Papierkorb statt `rm`** — bei allem was gelöscht werden soll
3. **Alias/Symlink** wenn Datei an zwei Orten gebraucht wird

**Technische Umsetzung:**
```bash
# Papierkorb (richtig):
osascript -e 'tell application "Finder" to delete (POSIX file "…")'

# Endgültig löschen (falsch, außer explizit so gewollt):
rm "…"
```

**Grundsatz:** Der macOS-Papierkorb ist 30 Tage stille Versicherung. Jede Aktion, die rückholbar ist, ist psychologisch zehnmal leichter zu treffen als eine endgültige. Sebastian freigabebereit zu halten kostet wenig, Druck wegzunehmen zahlt sich aus.

---

## C-Regeln — Situative Heuristiken

### Regel 7 (C) — Generische Namen = Bulk-Default Papierkorb

Bei generischen Dateinamen ist die Trefferquote für "brauchbar" so niedrig, dass Einzelprüfung teurer ist als Einzelfall-Recovery aus Trash.

**Muster für Bulk-Papierkorb:**
- `TEST*`, `Unbenannt*`, `Untitled*`, `Komponente*` (generische Placeholder)
- `Zusammengeführt*`, `neue_version_*`, `Bild N.jpg` (verlorener Kontext)
- UUID-Dateinamen ohne Projekt-Kontext (`E2E57112-BB64-...`)
- Hash-Dateinamen (`502ca4b7e5f9...`)
- Leer- oder Quasi-leer-Dateien (< 1 KB mit Platzhalter-Content)

**Ausnahme:** Wenn generischer Name in klarem Projekt-Kontext auftaucht (z.B. `Unbenannt.step` im Topf-Assets-Ordner), dann Regel 2 (parken) statt Regel 7 (weg).

**Pilot:** Session 5a (Spielereien-Block: Erwartung 80 %+ → reale Trefferquote 100 % Papierkorb).

### Regel 8 (C) — md5-Match statt Hardware-/Kontext-Raten

Bei unklaren Binaries (Firmware, Backup-Blobs, unbenannte Archive, Foto-Duplikate) vor Rätselraten immer **md5 gegen bekannte Referenzen** prüfen. Löst Versions-, Herkunfts- und Duplikat-Fragen deterministisch.

**Arbeitsschritt:**
```bash
md5 "unbekannte_datei.bin"
# dann gegen alle bekannten Referenzen
find ~/Archiv -name "*.bin" -exec md5 {} \;
```

**Pilot:** Session 2 — `firmware.bin` als Octopus-Pro-Stock-Firmware durch md5-Match identifiziert statt nach Hardware-Signatur zu raten. Phase 2d — 50 Duplikat-Kandidaten per md5 sauber getrennt in identisch/unterschiedlich/kein-Original.

---

## Arbeitsweise

### Für Claude Code — Session-Einstieg (jede Session)

1. `CLAUDE.md` im Vault-Root lesen
2. **Diese Datei lesen**
3. Session-spezifischen Prompt lesen
4. Bei Datei-Operationen: `ls`/Realitäts-Check am Zielort (Regel 1)
5. Session-Plan bauen, Abweichungen dokumentieren

### Für Claude Code — nach jeder Session

- Pilot-Erkenntnisse in der Session-Dokumentation nummeriert festhalten (A/B/C-Priorität explizit)
- Bei fundamentalen Erkenntnissen (A-Kandidat): Hinweis an Sebastian, dass neue Meta-Regel zu prüfen ist

### Für Sebastian — Regel-Pflege

Wenn neue Pilot-Erkenntnis entsteht:
1. Kriterium: Ist sie übertragbar auf andere Systeme/Kunden?
2. Wenn ja → hier einfügen, Priorität (A/B/C) vergeben
3. Wenn Regel sich schärft (weil Erfahrung dazukommt) → aktualisieren, nicht löschen. Alte Formulierung als HTML-Kommentar unten erhalten, damit die Lernkurve nachvollziehbar bleibt.

**Grundsatz:** Diese Datei ist die Fortschrittskurve von Sebastian + Claude. Sie wächst, sie schrumpft nicht.

---

## Skill-Architektur (Geschäftsmodell-Bezug)

Diese Meta-Regeln sind das Fundament einer Dreier-Skill-Architektur:

**Skill 1 (A) — Inventur.** Durchführung der eigentlichen Bereinigungsarbeit. Die hier formulierten Regeln sind der Kern. Aktuell im Sebastian-Pilot entstehend.

**Skill 2 (A) — Handoff.** Wie wird der Kunde nach der Inventur selbst handlungsfähig? Training, Grenzen, Übergabe-Dokumentation. Unterschied zwischen *"wir haben aufgeräumt"* und *"Sie können jetzt weiterarbeiten"*. → noch zu schreiben

**Skill 3 (B) — Assessment.** Was braucht der Kunden-PC/Mac/Server? Ausgangslage, Zeitabschätzung, Sonderfälle (Kundendaten, Passwörter, Lizenzen, regulatorische Anforderungen). Werkzeug für das Angebots-Gespräch. → noch zu schreiben

### Warum das ein Geschäft wird

**0 %-Fehlertoleranz nach außen** ist kein Stil, es ist das Verkaufsargument. Mittelständler, die Claude Code nicht vertrauen, kaufen die Dienstleistung nicht. Mittelständler, die sehen:

- Papierkorb statt `rm` (Reversibilität — Regel 6)
- Parkplatz statt Raten (Sicherheit bei Lücken — Regel 2)
- Checkliste statt Exponierung (Passwort-Disziplin — Regel 2)
- A/B/C-Priorisierung (strukturiertes Denken — CLAUDE.md)
- md5-basierte Deterministik statt Rätselraten (Regel 8)

— die unterschreiben. Die Regeln sind Sicherheitstechnik, nicht Bürokratie. Sie tragen das Versprechen: *Dieser Prozess zerstört nichts, dokumentiert alles und lässt den Kunden handlungsfähig zurück.*

### Pilot-Kette

1. **Pilot 1 (laufend):** Sebastians Mac — Proof-of-Concept, Regel-Entwicklung. Aktueller Stand: 128/188 Dateien bearbeitet, 8 Meta-Regeln extrahiert.
2. **Pilot 2 (Aug 2026):** Reiners PC in Pirna — gleiche Regeln, anderer Kontext (Windows, Konstruktions-Arbeitsrechner, WEC-Produktion)
3. **Pilot 3 (später):** Steffen oder externer Kunde — erster zahlender Auftrag, Stahlbau/Inventor-Spezialfall
4. **Produkt-Status:** Wenn Pilot 3 sauber läuft, kann MThreeD.io/WEC das als Dienstleistung anbieten

---

## Verknüpfungen

- [[CLAUDE]] — Root-Regeln, dort verankerte A/B/C-Priorisierung
- [[02 Projekte/Mac Inventur]] — laufender Pilot 1
- [[02 Projekte/Mac Inventur - Phase 3 Vorsortierung]] — operative Referenz
- [[02 Projekte/Mac Inventur - Konstruktion Parkplatz]] — Referenz-Implementation von Regel 2 + 4
- [[04 Ressourcen/Skills/Skill - Duplikat-Pruefung per md5]] — technische Sub-Skill zu Regel 8
- [[03 Bereiche/Business MThreeD.io/Business MThreeD.io]] — Geschäftsbezug, Skill 2+3 anzusiedeln
- [[02 Projekte/WEC Neustart mit Reiner]] — Pilot 2 Kontext
- [[02 Projekte/Ildikó Brain Setup]] — paralleles Brain-Projekt, auch von diesen Regeln profitierend

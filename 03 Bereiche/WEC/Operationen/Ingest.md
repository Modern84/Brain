---
tags: [bereich, wec, operation, ingest]
date: 2026-04-17
---

# Operation: Ingest — Neue Daten ins System einspielen

> **Zweck:** Wenn neue Rohdaten in `raw/` landen, sicherstellen dass Claude sie kompiliert und ins `wiki/` einarbeitet.

---

## Wann Ingest läuft

- Reiner liefert T9-SSD mit neuen NAS-Daten
- Sebastian fügt Kunden-Korrespondenz hinzu (PDF, Mails)
- Volker liefert neue Spezifikationen / Standards
- Reiner zeichnet ein neues Konstruktionsmuster auf
- Neuer Kunde wird aufgenommen

---

## Ablauf

### 1. Daten ablegen
- Sebastian/Reiner kopiert in `raw/Kunden/[Kunde]/[Unterordner]/`
- Original-Verzeichnisstruktur möglichst beibehalten
- Keine Bearbeitung der Dateien

### 2. Ingest-Eintrag schreiben
Hier in dieser Datei am Ende ein Eintrag:

```markdown
## YYYY-MM-DD — [Kurzer Titel]
- **Quelle:** woher (NAS-Pfad, Mail, etc.)
- **Wo abgelegt:** raw/Kunden/.../...
- **Inhalt:** kurz was es ist
- **Zu kompilieren:** welche Wiki-Artikel sollen betroffen werden
- **Status:** offen | in arbeit | kompiliert
```

### 3. Claude beauftragen
- "Lies die neuen Daten in raw/Kunden/Volker Bens/[Ordner], aktualisiere wiki/Kunden/Volker Bens - Profil.md"
- Claude bestätigt was geändert wurde
- Sebastian/Reiner verifiziert

### 4. Status aktualisieren
- Ingest-Eintrag auf `kompiliert` setzen
- Bei Problemen: TODO-Marker im Wiki-Artikel

---

## Spezialfall: Neuer Kunde

1. Neuen Ordner anlegen: `raw/Kunden/[Neuer Kunde]/`
2. Ersten Datensatz reinlegen (z.B. erste Kundenanfrage, erste Spezifikation)
3. Claude beauftragen: "Lege Wiki-Profil für [Neuer Kunde] an, kompiliere aus raw/Kunden/[Neuer Kunde]"
4. Profil entsteht in `wiki/Kunden/[Neuer Kunde] - Profil.md`
5. CLAUDE.md im WEC-Bereich erweitern: kunden-spezifische Regeln

---

## Spezialfall: Reiner-Wissen festhalten

Reiner erzählt im Gespräch eine Lessons-Learned (z.B. "Bei Edelstahl 1.4404 muss man die Verzahnung anders machen weil...").

Das ist Wissen das **nicht in raw/** liegt, sondern direkt ins **wiki/Standards WEC/** gehört.

Workflow:
1. Sebastian schreibt Reiners Aussage als Notiz mit auf
2. Sebastian sagt zu Claude: "Reiner sagte [Zitat]. Pack das in Standards WEC."
3. Claude legt Eintrag an oder erweitert bestehenden
4. Verifikation beim nächsten Treffen mit Reiner

---

## Ingest-Log

> Hier neue Einträge nach Datum sortiert (neueste oben):

### 2026-04-19 — WEC/Bens Templates + Solid Edge Profil (aus 07 Anhänge/)
- **Quelle:** `07 Anhänge/` (lokal aus früheren Obsidian-Clips) + `07 Anhänge/Allgemein/Profil/` (Sabines historisches Solid-Edge-Setup)
- **Wo abgelegt:**
  - `raw/Kunden/Volker Bens/Standards & Vorlagen/` — 4 Bens-Vordrucke (Bens_Vordruck.dwg, Vordruck_A4.dwg, Vordruck.dwg, Vordruck.dft)
  - `raw/Standards WEC/Templates/` — 4 WEC-Templates (WEC.dwg, WEC.bak, Zeichnungsvordrucke.dft [5.2 MB], Zeichnungsblöcke_neu Ausführung.dft [4.7 MB])
- **Umfang:** 8 Dateien verschoben (alle >1 KB, keine iCloud-Platzhalter); md5 pro Datei protokolliert in [[03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/2026-04-21 Montag-Session/Zeichnungsnummern-Abgleich]]
- **Solid Edge Profil:** Komplettes `DesignData/` + `SEST4/Templates/` noch in `07 Anhänge/Allgemein/Profil/` — inventarisiert, Migration ins raw/ erst nach Sebastian-Entscheidung (gehört ganz zu WEC oder nur ausgewählte Templates?)
- **Status:** ingested; Kompilation ins Wiki offen (Standards WEC - Templates-Katalog)

### 2026-04-18 — Bens Lagerschalenhalter Lebensmittelindustrie (via Mac-Inventur)
- **Quelle:** Sebastians Mac-Inventur — Phase 3 Session 1 (Dateien aus Desktop/Downloads, nicht vom NAS)
- **Kunde:** Volker Bens / Bens Edelstahl GmbH
- **Wo abgelegt:**
  - `raw/Kunden/Volker Bens/aktuelle Projekte/Lagerschalenhalter Lebensmittelindustrie/` — 9 Projekt-Dateien (Zeichnungen, STEP, Stücklisten, Grund- und Zwischenplatte-PDFs)
  - `raw/Kunden/Volker Bens/Standards & Vorlagen/` — 4 wiederverwendbare Datenblätter (Bens-Logo, Copper3D antibakteriell, Elastollan, Herstellerbescheinigung MAXITHEN)
- **Umfang:** 13 Dateien gesamt
- **Wiki-Kompilation:** [[03 Bereiche/WEC/wiki/Kunden/Volker Bens - Lagerschalenhalter Lebensmittelindustrie]] (aus `01 Inbox/` migriert und mit raw-Quellenverweisen ergänzt)
- **Status:** ingested, wiki-kompiliert, bereit für Montag-Session 2026-04-21 mit Reiner

### YYYY-MM-DD — Erster Volker-Bens-Datensatz via T9
- **Quelle:** Reiners NAS, Ordner [...]
- **Wo abgelegt:** `raw/Kunden/Volker Bens/aktuelle Projekte/`
- **Inhalt:** [zu füllen wenn T9 da ist]
- **Zu kompilieren:** `wiki/Kunden/Volker Bens - Profil.md`
- **Status:** offen

*(Weitere Einträge nach Bedarf)*

---

## Verknüpfungen

- [[03 Bereiche/WEC/raw/README]]
- [[03 Bereiche/WEC/wiki/README]]
- [[03 Bereiche/WEC/Operationen/Query]]
- [[03 Bereiche/WEC/Operationen/Lint]]

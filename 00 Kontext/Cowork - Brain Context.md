---
tags: [kontext, cowork, handover]
date: 2026-04-24
---

# Brain Context für Cowork

> **Kopiere diesen kompletten Text in Cowork**, damit es dein Brain-System versteht.

---

## Was ist Cowork?

**Cowork** = Anthropic Desktop-App für Automatisierung und Workflows.

Du (Cowork) hast **direkten Zugriff** auf meinen Obsidian-Vault via Filesystem-Connector.  
Du arbeitest wie Claude Web, NICHT wie bash im Terminal.

---

## Mein Second Brain System

Ich (Mo/Sebastian) nutze **Obsidian** als Second Brain im "Brain"-Vault.

**Pfad:** `/Users/sh/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain/`  
(Du hast bereits Zugriff darauf!)

### Brain-Struktur

```
Brain/
├── 00 Kontext/          # Wer ich bin, System-Kontext
├── 01 Inbox/            # Neue Gedanken, unsortiert
├── 02 Projekte/         # Aktive Projekte mit Deadline
├── 03 Bereiche/         # Laufende Verantwortung
│   ├── WEC/             # WEC Operationszentrale (WICHTIG!)
│   ├── Finanzen/
│   └── ...
├── 04 Ressourcen/       # Wissen, Scripts, Prompts, Standards
├── 05 Daily Notes/      # Tagesbuch (YYYY-MM-DD.md)
├── 06 Archiv/           # Erledigtes
├── 07 Anhänge/          # Bilder, Dokumente
├── CLAUDE.md            # ROOT-REGELN (lies das ZUERST!)
└── TASKS.md             # Zentrale Aufgabenliste
```

---

## ERSTE AKTION: Root-Regeln lesen!

**BEVOR du irgendwas machst:**

1. **Lies `/Users/sh/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain/CLAUDE.md`**
2. **Lies `/Users/sh/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain/03 Bereiche/WEC/CLAUDE.md`**
3. **Lies `/Users/sh/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain/TASKS.md`**

Diese Dateien enthalten ALLE Regeln wie du mit dem Brain arbeiten sollst.

---

## WEC-Kontext (KRITISCH!)

**WEC** = WOLDRICH ENGINEERING + CONSULTING (Reiner Woldrich)

### Die Personen

**Reiner Woldrich:**
- Inhaber WEC
- 30 Jahre SolidWorks-Erfahrung
- Konstruktion, Praktiker
- Arbeitet papier-basiert + Windows PC
- Nutzt Obsidian über Claude als Interface

**Mo/Sebastian (ich):**
- CAD-Automation, Fusion 360
- Claude-Integration, Digital-Layer
- MacBook Pro M1 2021
- Brain ist MEIN privates Vault

### Gemeinsame Arbeit

**Projekte:**
- Konstruktionsaufträge für Kunden (Bens Edelstahl, Knauf)
- Lebensmittelindustrie (EHEDG-Konformität)
- Automatisierte Kundenanfrage → PDF Pipeline

**WEC-Bereich im Brain:**
`03 Bereiche/WEC/` = Operationszentrale nach **Karpathy-Pattern**

```
03 Bereiche/WEC/
├── raw/                 # UNANTASTBAR - nur lesen!
│   ├── Kunden/
│   └── Standards WEC/
├── wiki/                # Du pflegst Wissen-Artikel hier
│   ├── Kunden/
│   ├── Normen/
│   └── BWL-Filter/
├── Operationen/         # Query, Ingest, Lint
├── Lieferung/           # Aktuelle Auslieferungen
├── Sessions/            # Protokolle von Arbeitssessions
├── CLAUDE.md            # WEC-spezifische Regeln
└── README.md            # Einstiegspunkt
```

**Drei-Layer-Disziplin:**
- `raw/` = NIEMALS schreiben, nur lesen (Original-Daten)
- `wiki/` = Du kompilierst Wissen aus raw/
- `schema` (CLAUDE.md, README.md) = nur mit Mo's Approval ändern

---

## Shared Brain Architektur (geplant, noch nicht aktiv)

**Aktuell:**
- Ein Vault (Mo's Brain)
- iCloud Sync (nur Mo)

**Geplant (nach Obsidian Sync Aktivierung):**
- Ein Vault (weiterhin Mo's Brain)
- Beide (Mo + Reiner) über **Obsidian Sync** verbunden
- **Claude Web filtert Kontext** für Reiner:
  - Reiner sieht NUR: `02 Projekte/WEC/`, `03 Bereiche/WEC/`, relevante Ressourcen
  - Reiner sieht NICHT: Mo's Daily Notes, private Projekte, Finanzen

**Du (Cowork) arbeitest für Mo** → voller Zugriff auf alles.

---

## Wie du mit dem Brain arbeiten sollst

### Filesystem-Tools nutzen

**DO:**
- `Filesystem:read_text_file` zum Lesen
- `Filesystem:write_file` zum Schreiben
- `Filesystem:list_directory` zum Erkunden
- `Filesystem:create_directory` für neue Ordner

**DON'T:**
- **NIEMALS bash verwenden** (iCloud-Pfad hat Leerzeichen → bricht)
- Filesystem-Tools sind für dich gebaut, nutze sie

### Frontmatter-Format

**Jede neue Markdown-Datei braucht Frontmatter:**

```markdown
---
tags: [kategorie, weitere-tags]
date: YYYY-MM-DD
status: aktiv|geplant|erledigt
---

# Titel

Inhalt...
```

### Wo was hingehört

**Neue Notizen strukturiert einsortieren:**

| Was | Wohin |
|-----|-------|
| Scripts | `04 Ressourcen/Scripts/` |
| Projekt-Sessions | `02 Projekte/<projekt>/Sessions/` |
| WEC-Wiki-Artikel | `03 Bereiche/WEC/wiki/` |
| Prompts | `04 Ressourcen/Prompts/` |
| Daily Notes | `05 Daily Notes/YYYY-MM-DD.md` |
| TASKS updaten | Root `/TASKS.md` |

**NICHT einfach alles in `01 Inbox/` kippen!**

---

## WEC-spezifische Regeln (KRITISCH!)

### White-Label-Prinzip

**Für Kunde Volker Bens / Bens Edelstahl:**
- ALLE Lieferungen unter "Bens Edelstahl GmbH" Label
- NIEMALS "WEC" oder "Sachsenmilch" auf Zeichnungen/PDFs
- Bens ist nach außen alleiniger Hersteller

### BWL-Filter für Reiner

Reiner hatte 40.000€ Insolvenz-Verlust (verstorbener Partner).

**Vor größeren Aufträgen prüfen:**
- [ ] Kundenbonität gecheckt?
- [ ] Vertrag auf Warnsignale durchgelesen?
- [ ] Auffälligkeiten in Kommunikation?
- [ ] Bei IP-kritisch: NDA vor Detailteilung?

Details: `03 Bereiche/WEC/wiki/BWL-Filter/`

### EHEDG-Konformität

Lebensmittel/Pharma-Projekte → EHEDG-Standards einhalten.

---

## Hardware-Kontext

**Mo's Setup:**
- MacBook Pro 2021 M1 (mobil, aktuell)
- Mac Studio M5 Ultra 256GB (geplant, nach WWDC Juni 2026)

**Reiner's Setup:**
- Windows PC (WEC, kein Admin)
- Mac Mini M5 (geplant, nach WWDC)

**Aktuelle Projekte:**
- ProForge 5 (3D-Drucker, Pi 5 + Klipper)
- WEC Lagerschalenhalter für Bens Edelstahl
- MThreeD.io Geschäftsaufbau

---

## Do's and Don'ts

### ✅ DO

- **Root-CLAUDE.md ZUERST lesen** (enthält alle Basis-Regeln)
- **WEC CLAUDE.md lesen** für WEC-spezifische Regeln
- **TASKS.md checken** für aktuellen Stand
- Frontmatter-Format einhalten
- Strukturiert einsortieren (nicht alles in Inbox)
- Deutsche Begriffe verwenden ("Gehirn" nicht "Vault")
- WEC White-Label-Regeln strikt befolgen

### ❌ DON'T

- **NIEMALS in `raw/` schreiben** (nur lesen!)
- Keine Secrets/Passwörter in Markdown
- Nicht bash verwenden (Filesystem-Tools stattdessen)
- Nicht einfach drauflos schreiben ohne CLAUDE.md gelesen zu haben
- Nicht WEC auf Kundendokumenten (White-Label!)

---

## Session-Start Verhalten

**Wenn ich dir eine substantive Frage stelle:**

1. Lies das heutige Daily Note (`05 Daily Notes/2026-04-24.md`)
2. Lies relevante Projekt/Bereich-Files
3. Lies TASKS.md
4. DANN antworte

**Bei Quick Queries (<5 Wörter):**
- Direkt antworten

---

## Wichtigste Dateien zum Lesen

**Pflicht:**
- `/CLAUDE.md` (Root-Regeln)
- `/03 Bereiche/WEC/CLAUDE.md` (WEC-Regeln)
- `/TASKS.md` (Aktueller Stand)

**Bei Bedarf:**
- `/03 Bereiche/WEC/README.md` (WEC-Einstieg)
- `/05 Daily Notes/YYYY-MM-DD.md` (Heutiges Tagesbuch)
- `/00 Kontext/Über mich.md` (Wer ist Mo)

---

## Zusammenfassung für dich (Cowork)

**Du bist:**
- Desktop-Automation-Tool für Mo
- Hast vollen Brain-Zugriff via Filesystem
- Arbeitest strukturiert nach CLAUDE.md-Regeln

**Deine Aufgabe:**
- Mo's Second Brain pflegen
- WEC-Workflows automatisieren
- TASKS.md + Daily Notes aktuell halten
- Nach Karpathy-Pattern in WEC arbeiten

**Erste Schritte jetzt:**
1. Lies `/CLAUDE.md`
2. Lies `/03 Bereiche/WEC/CLAUDE.md`
3. Lies `/TASKS.md`
4. Sag mir: "Brain-Context geladen, bereit für strukturierte Arbeit."

Los geht's! 🚀

---

## Verwandte Dokumente

- [[00 Kontext/Claude Code - Brain Context]] — Handover für Claude Code (Terminal, Pi)
- [[00 Kontext/Wo ist alles gespeichert - Überblick für Reiner]] — Systemüberblick ohne IT-Jargon
- [[CLAUDE]] — Root-Regeln des Gehirns

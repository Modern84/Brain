---
typ: anleitung
für: reiner
datum: 2026-04-22
---

# Obsidian Layout & Graph-View — Handover für Reiner

## Dein Gehirn auf dem Stick

**Ort:** `/Volumes/INTENSO/02_Reiner-Gehirn/Gehirn/`

**Größe:** 156 MB, 232 Markdown-Notizen, 923 Links zwischen Notizen (Dichte 3,98 Links pro Notiz — sehr gut vernetzt)

**Was drauf ist:**
- Komplette WEC-Struktur (Lieferungen, Standards, Workflows, Kunden-Docs)
- Volker Bens Lagerschalenhalter komplett
- Playbooks & Musterbeispiele
- Fusion-Workflows & CAD-Standards
- MThreeD.io-Business-Kontext
- CLAUDE.md (Regeln wie Claude mit dir arbeitet)

**Was NICHT drauf ist:**
- Sebastians Privates (Finanzen, Daily Notes, Inbox)
- Sicherheits-Logs
- Archiv-Altlasten

---

## Obsidian Layout (PARA-System)

Das Gehirn ist nach dem **PARA-System** strukturiert (Projects, Areas, Resources, Archives). Deutsche Begriffe:

### Ordner-Struktur

```
Gehirn/
├── 02 Projekte/              ← Aktive Arbeit mit Deadline
│   ├── WEC/                  ← Laufende WEC-Projekte
│   ├── WEC Neustart mit Reiner/
│   └── MThreeD.io/
│
├── 03 Bereiche/              ← Dauerhafte Verantwortung ohne Deadline
│   ├── WEC/                  ← WEC-Operationszentrale (wichtigster Ordner)
│   │   ├── Lieferung/        ← Fertige & laufende Lieferungen
│   │   ├── raw/              ← Rohdaten (Kunden, Standards, Alt-Projekte)
│   │   ├── wiki/             ← Strukturierte Doku (Kunden, Normen, BWL)
│   │   ├── Operationen/      ← Workflows (Ingest, Sessions)
│   │   ├── Sessions/         ← Arbeitsprotokolle
│   │   ├── CLAUDE.md         ← Regeln für WEC-Raum
│   │   └── README.md         ← Einstieg ins WEC-System
│   ├── Business MThreeD.io/  ← Geschäftsaufbau 3D-Druck-Service
│   └── Konstruktion/         ← CAD-Projekte, Fusion-Wissen
│
├── 04 Ressourcen/            ← Nachschlagewerke & Werkzeuge
│   ├── Playbook/             ← Best Practices (Fusion, Lieferung, Kunden)
│   ├── Musterbeispiele-Reiner/ ← Deine erfolgreichen Alt-Projekte als Referenz
│   ├── CAD-Standards/        ← Zeichenvorlagen, Material-Datenbanken
│   ├── Templates/            ← Vorlagen für neue Notizen
│   ├── Scripts/              ← Automatisierungs-Scripts
│   └── Workflow/             ← Prozessdoku
│
└── 07 Anhänge/               ← Bilder, PDFs, STEP-Dateien
    ├── Fusion360/
    ├── Volker_v4/
    ├── Reiners_Gehirn/       ← Deine Patent-Skizzen etc.
    └── Zeichenvorlage/
```

### Wichtigste Dateien für dich

- **`03 Bereiche/WEC/README.md`** — Einstieg ins WEC-System, lies das zuerst
- **`03 Bereiche/WEC/CLAUDE.md`** — Regeln wie Claude mit WEC-Daten arbeitet (BWL-Filter, Kundenbonität, White-Label)
- **`04 Ressourcen/Playbook/Fusion-zu-Liefer-Pipeline.md`** — Workflow von Konstruktion bis PDF-Lieferung
- **`04 Ressourcen/Musterbeispiele-Reiner/`** — Deine Alt-Projekte als Vorlagen

---

## Graph-View Erklärung

Der **Graph-View** zeigt alle Notizen als Netzwerk. Jede Notiz ist ein Punkt, jeder Link zwischen Notizen ist eine Linie.

### Farbcode (GitHub-Dark-Palette)

**Zwei Hauptakzente:**
- **Grün** = WEC (dein Brot-und-Butter-Geschäft)
- **Tiefes Violett** = MThreeD.io (Sebastians 3D-Druck-Service)

**Weitere Signalfarben:**
- **Rot** = CLAUDE.md (Herz des Systems, Regelwerk)
- **Orange** = Playbook (Best Practices, nimm-mich-als-Vorlage)
- **Cyan/Teal** = Musterbeispiele-Reiner (deine Referenzprojekte)
- **Goldgelb** = TASKS (offene Arbeit)

**Graustufen** = alles andere (Projekte, Konstruktion, Finanzen, Daily Notes, Archiv)

### Vorher/Nachher — Graph-Optimierung

Der Graph wurde gestern Abend (21.04.) von "Donut-Chaos" auf "Struktur lesbar" umgestellt. Vergleich:

**VORHER (17:54 Uhr) — Donut + Regenbogen:**

![[Graph-Vorher-Donut.png]]

- Großer Ring aus 1900 Attachments (PDFs, Bilder) überlagert die eigentlichen Notizen
- Viele konkurrierende Farben (Orange, Grün, Rot, Lila, Cyan) ohne klare Hierarchie
- Struktur schwer lesbar

**NACHHER (18:22 Uhr) — Kompakt + Gedämpft:**

![[Graph-Nachher-Kompakt.png]]

- Attachments ausgeblendet → nur noch Notizen sichtbar (232 statt 2132 Punkte)
- Zwei klare Akzente: WEC Grün + MThreeD Violett
- Rest in Graustufen → ruhiger Hintergrund
- Struktur sofort erkennbar

**Das System ist nicht zufällig so — es wurde bewusst umgestellt damit du beim ersten Blick die Logik siehst.**

### Was du im Graph siehst

- **Kompakter Cluster in der Mitte** = gut vernetzte Notizen (aktive Arbeit)
- **WEC-Grün dominiert** = ca. 40% der Notizen hängen am WEC-Kosmos
- **Kleine isolierte Inseln** = Notizen ohne Links zum Hauptnetz (Waisen, nicht schlimm)
- **Zwei rote Punkte oben + Cluster unten rechts** = abgeschnittene Subgraphen (noch nicht ins System integriert)

### Wie du den Graph nutzt

1. **Obsidian öffnen** → linke Sidebar → **Graph-Icon** (Netzwerk-Symbol)
2. **Einzoomen:** Scrollrad
3. **Notiz öffnen:** Punkt anklicken
4. **Filter:** Rechts im Panel kannst du Ordner ein-/ausblenden

**Praktischer Nutzen:**
- Schnell sehen welche Kunden/Projekte wie vernetzt sind
- Waisen finden (Notizen ohne Links → isolierte Infos)
- Themenbereiche visuell erfassen (WEC-Grün = große zusammenhängende Insel)

---

## Wie du mit dem System arbeitest

### Täglicher Workflow

1. **Neues Projekt von Kunde X kommt rein:**
   - Ordner anlegen: `03 Bereiche/WEC/raw/Kunden/[Kunde]/[Projekt]/`
   - Notiz anlegen: `03 Bereiche/WEC/wiki/Kunden/[Kunde] - [Projekt].md`
   - Link zur Kunden-Profil-Notiz setzen

2. **Zeichnung erstellt, soll dokumentiert werden:**
   - PDF/STEP in `07 Anhänge/[Kunde]/` ablegen
   - Wiki-Eintrag aktualisieren
   - Zeichnungsindex pflegen

3. **Best Practice gefunden, soll wiederverwendet werden:**
   - Neue Notiz in `04 Ressourcen/Playbook/`
   - Mit konkretem Projekt verlinken (damit du später siehst "das kommt aus Projekt X")

### Claude-Integration

Wenn du **Claude Desktop** auf deinem PC hast:
- Claude liest direkt aus deinem Obsidian-Vault
- Du fragst "Was haben wir für Kunde X gemacht?" → Claude durchsucht `03 Bereiche/WEC/`
- Claude schreibt neue Notizen direkt in dein Gehirn (kein Copy-Paste)

**Wichtig:** Claude kennt die WEC-Regeln aus `03 Bereiche/WEC/CLAUDE.md` — BWL-Filter, White-Label-Prinzip, Kundenbonität-Check.

---

## Claude Desktop Installation (Windows)

**Was ist Claude Desktop?** Eine Desktop-App die direkt mit deinem Obsidian-Vault arbeitet. Du fragst "Was haben wir für Volker Bens gemacht?" und Claude durchsucht automatisch `03 Bereiche/WEC/` und fasst zusammen.

### Installation (5 Minuten)

1. **Download:** https://claude.ai/download (Windows-Version)
2. **Installieren:** Installer ausführen, Standard-Pfad OK
3. **Anmelden:** Mit deiner Anthropic-Account-E-Mail (oder neu erstellen)
4. **Obsidian-Vault verbinden:**
   - Claude Desktop öffnen
   - Settings (Zahnrad unten links) → Integrations
   - "Add Folder" → Dein Vault-Ordner auswählen (`H:\02_Reiner-Gehirn\Gehirn\` oder wo dein Stick gemountet ist)
   - "Allow Access" bestätigen

### Erste Schritte mit Claude

Probier diese Fragen:

- **"Zeig mir alle WEC-Kunden"** → Claude listet Ordner in `03 Bereiche/WEC/raw/Kunden/`
- **"Was haben wir für Volker Bens gemacht?"** → Claude durchsucht `wiki/Kunden/Volker Bens*` und fasst zusammen
- **"Schreib eine neue Notiz für Projekt X"** → Claude erstellt die Datei direkt im Vault

**Wichtig:** Claude schreibt direkt in deinen Vault — kein Copy-Paste, keine Doppelarbeit. Alles was Claude schreibt landet sofort in Obsidian.

### Tipps für Claude-Nutzung

- **Sei spezifisch:** "Zeig mir die Lagerschalenhalter-Lieferung" statt nur "Zeig mir was"
- **Claude kennt die Struktur:** Du kannst sagen "Leg das in Playbook ab" und Claude weiß wo das ist
- **Claude kennt die WEC-Regeln:** Aus `03 Bereiche/WEC/CLAUDE.md` — White-Label, BWL-Filter, Kundenbonität

---

## Nächste Schritte für dich

1. **Stick einstecken, Obsidian installieren** (Windows: https://obsidian.md/download)
2. **Vault öffnen:** "Vault aus Ordner öffnen" → `H:\02_Reiner-Gehirn\Gehirn\` (oder wo der Stick gemountet ist)
3. **Graph-View anschauen:** Linke Sidebar → Graph-Icon
4. **Erste Notiz öffnen:** `03 Bereiche/WEC/README.md`
5. **Claude Desktop installieren** (optional, aber empfohlen) — dann kann Claude direkt mit deinem Gehirn reden

---

## Fragen?

Frag Sebastian. Das System wächst mit der Nutzung — nicht alles muss perfekt sein, Hauptsache es funktioniert für dich.

**Wichtigster Punkt:** WEC-Struktur ist komplett drauf, Volker-Bens-Lieferung ist dokumentiert, Playbooks liegen bereit. Du kannst sofort loslegen.

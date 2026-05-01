---
tags: [bereich, wec, vision, strategie]
date: 2026-04-15
---

# Vision — Automatisierte Konstruktions-Pipeline

## Architektur — Die Gehirne als Fundament

**Kern-Erkenntnis (16.04.2026):** Die Gehirne sind nicht eine Komponente der Pipeline, sie sind das Substrat auf dem sie läuft. Alle drei Schichten (Capture, Translation, Production) arbeiten *durch* die Gehirne, nicht neben ihnen.

### Drei-Schichten-Modell

**1. Capture** — wo Reiner denkt und Sebastian baut
- Reiner: Remarkable 2 beim Kunden. Skizzen, Aufmaße, Notizen landen automatisch als PDF in Reiners Gehirn-Inbox
- Reiner: Sprachmemos für Kontext/Gedanken — automatisch transkribiert in Tagesbuch
- Sebastian: Fusion-360-Sessions, Chat-Dialoge mit Claude, alles im eigenen Gehirn
- **Nichts geht verloren. Nichts muss nachträglich „in den Vault getragen“ werden.**

**2. Translation** — wo KI Denken in Arbeit übersetzt
- Claude liest Reiners Capture (Skizze + Memo) und nutzt archivierte Muster (Sabines/Petras Altbestand) als Referenz
- Output: strukturierter Projekt-Brief im geteilten Projektordner (Parameter, Material, Toleranzen, vermutete Fusion-Herangehensweise, BOM-Schätzung)
- Sebastian reviewt den Brief, entscheidet, konstruiert

**3. Production** — wo Arbeit zu Kunden-Deliverables wird
- Fusion-Output durch Pipeline mit WEC-Konventionen (Schriftfeld, Nummernschema, Oberflächenzeichen) — auf Basis des archivierten Altbestands aufgebaut
- Raus: STEP, 2D-Zeichnung, 3D-PDF, Stückliste, Kunden-PDF
- **Jedes Deliverable wird zurück ins Gehirn gespiegelt** — Projekt 12 lernt von Projekt 11

### Was die Gehirne systemisch leisten

- **Gemeinsamer Speicher.** Reiners Skizzen, Sebastians Konstruktionen, Kundenhistorie, Pipeline-Outputs, Lessons Learned. Eine Quelle der Wahrheit.
- **Kontext-Lieferant für jede KI-Interaktion.** Der fünfte Kunde wird besser bedient als der erste, weil das Gehirn mitgewachsen ist.
- **Portabilität.** Reiners Gehirn gehört Reiner, nicht WEC. Sebastians Gehirn gehört Sebastian, nicht MThreeD.io. Kein Vendor-Lock-in. Wenn sich Strukturen ändern, tragen die Menschen ihr Wissen mit.
- **Schnittstelle zwischen Reiner und Sebastian.** Phase 2 aus [[02 Projekte/WEC Neustart mit Reiner/Konzept Zwei Gehirne]] (geteilte Projektordner, private Bereiche bleiben getrennt) ist das Governance-Modell.

### Strategischer Punkt

Das System ist nicht "Workflow mit KI drin." Es ist "ein wachsendes gemeinsames Gedächtnis mit automatisierten Arbeitshänden drumherum." Der Unterschied ist fundamental — ersteres skaliert nicht, letzteres wird mit jedem Monat wertvoller. Das ist gleichzeitig die MThreeD.io-Blaupause: ein Template das später auf andere Konstruktions-Partner ausgerollt werden kann.

---

## Die Idee (ursprünglich)

Von der Kundenanfrage bis zur Rechnung — alles in einem Fluss:

```
Kundenanfrage
    ↓
Konzept & Konstruktion (Fusion 360 / SolidWorks)
    ↓
Zeichnungsableitung (automatisch: Maße, Material, Toleranzen)
    ↓
Stückliste (automatisch: Normteile, Kaufteile, Links)
    ↓
3D-PDF + 2D-PDF (automatisch abgeleitet)
    ↓
Materialbibliothek (standardisiert, immer aktuell)
    ↓
Ordner → Klick → Versenden → Rechnung
```

Kein manuelles Zusammensuchen, kein Copy-Paste, kein "wo war nochmal die Zeichnung".

## Warum das geht

Was wir heute schon gemacht haben beweist das Prinzip:
- Stückliste aus Fusion exportiert → Claude hat sie überarbeitet, Fehler gefunden, Links recherchiert, CSV erstellt
- Das war in einer Session, vom Handy, mit Diktierfunktion
- Mit SolidWorks-API und Fusion-API geht das automatisiert

## Was dafür nötig ist

### Sebastians Blocker in Fusion (jetzt)
- Textfelder, Schriftfeld und Stückliste müssen **händisch** eingetragen werden (fehlt im Standard-Abo)
- Zeichnungsableitung: Einzelteile, Schweißzeichnungen, Baugruppen — Prinzip verstanden, aber nicht 100% sicher
- Keine automatischen Zeichnungsnummern
- Braucht: Fusion Vollversion oder Extensions für automatische BOM/Schriftfelder
- Bens hat spezifische Zeichnungsvorlagen → müssen in Fusion nachgebaut werden

### Kurzfristig (jetzt — kostenlos)
- [x] Stücklisten manuell exportieren → Claude überarbeitet (heute bewiesen ✅)
- [ ] Bens Zeichnungsvorlage in Fusion nachbauen
- [ ] Materialbibliothek anlegen (Edelstahl 1.4404, Baustahl, Alu, etc.)
- [ ] Fusion Vollversion/Extensions evaluieren (automatische BOM, Schriftfelder)

### Mittelfristig (Monate)
- [ ] Fusion 360 API oder SolidWorks API anbinden
- [ ] Automatische Zeichnungsableitung (2D aus 3D)
- [ ] Automatische Stücklisten-Erstellung mit Normteil-Erkennung
- [ ] PDF-Export (3D-PDF + 2D-Zeichnung)
- [ ] Kundenordner automatisch anlegen

### Langfristig (Vision)
- [ ] Kundenanfrage per Mail → Claude erstellt Projektordner
- [ ] Konstruktion fertig → Klick → alle Unterlagen abgeleitet
- [ ] Versand per Mail mit einem Befehl
- [ ] Rechnung automatisch erstellt
- [ ] Alles im Gehirn dokumentiert und nachvollziehbar

## Was das kostet vs. was es bringt

### Kosten
- Claude Max: ~100$/Monat (hast du schon)
- Fusion 360 Vollversion: ~70€/Monat (für Zeichnungsableitungen, Extensions)
- SolidWorks: Reiner hat Lizenz
- Obsidian: kostenlos

### Was es spart
- Keine Stunden mehr für Zeichnungsableitungen von Hand
- Keine vergessenen Materialangaben oder falschen Normteile
- Kein "wo ist die Datei" — alles strukturiert
- Wirkt nach außen wie ein Büro mit 20 Leuten
- Mehr Projekte in weniger Zeit = mehr Umsatz

## Reiners Rolle

Reiner ist das **Head Brain** — 30 Jahre Konstruktionserfahrung, Branchenwissen, Kundenbeziehungen. Sein Wissen + Claude = Maschine. Sebastian konstruiert, Reiner berät und prüft, Claude automatisiert den ganzen Rest.

## Zusammenhang

- [[02 Projekte/WEC Neustart mit Reiner/Konzept Zwei Gehirne]]
- [[03 Bereiche/WEC/Idee - Claude SolidWorks Integration]]
- [[Business MThreeD.io|MThreeD.io]]
- [[03 Bereiche/Konstruktion/Konstruktion]]

---
tags: [kontext, meta, wachstum, struktur, ai-playbook]
date: 2026-04-19
status: aktiv
---

# Gehirn — Organisches Wachstum

Operatives Playbook für Claude. PARA ist das Skelett — diese Datei beschreibt die **ausführbare Dynamik**: erkennbare Signale, deterministische Aktionen, messbare Zustände.

## Kernprinzipien (für Claude bindend)

1. **Signal > Plan.** Keine Struktur ohne konkreten Auslöser.
2. **Keine leeren Hüllen.** Hub nur mit Inhalt, Ordner nur mit Knoten.
3. **Auslöser sind maschinell erkennbar** (grep, Backlinks, Datei-Timestamps) — kein subjektives Urteil.
4. **Reversible Phasenwechsel ohne Rückfrage.** Archivierung und Löschung mit Vorschlag an Sebastian.

---

## Lebenszyklus — Phase → Trigger → Aktion

### Phase 1 — Genese

```yaml
trigger: neuer Gedanke ohne festen Ort
detection:
  - user dictates / writes kurze Notiz
  - keine existierende Datei passt
action:
  default: append to "05 Daily Notes/$(date +%Y-%m-%d).md"
  alternativ: create "01 Inbox/$KurzTitel.md"
frontmatter:
  required: [tags, date]
  tags_default: [inbox]
guard: Sebastian
```

### Phase 2 — Reifung

```yaml
trigger: EINE der folgenden Bedingungen
detection:
  - rg -l "$thema" "05 Daily Notes/" | wc -l  >= 2    # zwei Daily Notes berühren das Thema
  - in TASKS.md steht konkrete Aufgabe dazu
  - Inbox-Datei älter als 14 Tage + nicht verlinkt
action:
  if "konkretes Ziel mit Enddatum":
    move to "02 Projekte/$Titel.md"
    frontmatter: {status: geplant|aktiv, date: YYYY-MM-DD, tags: [projekt, ...]}
  elif "zeitlos / Referenz":
    move to "04 Ressourcen/$Kategorie/$Titel.md"
    frontmatter: {status: aktiv, tags: [ressource, ...]}
guard: Claude proaktiv, ohne Rückfrage
backlinks: mindestens 1 eingehender Link setzen
```

### Phase 3 — Verzweigung

```yaml
trigger: Einzeldatei zeigt drei getrennte Stränge
detection:
  - datei enthält >= 3 H2-Abschnitte mit je eigenen Backlinks
  - ODER grep-count der Teilthemen in anderen Dateien je >= 2
action:
  1. mkdir "$Pfad/$Titel/"
  2. move Hauptdatei nach "$Pfad/$Titel/$Titel.md" (Hub)
  3. extract Abschnitte in "$Pfad/$Titel/$Teilthema.md"
  4. update Backlinks (grep+sed)
  5. log in Daily Note: "verzweigt: $Titel"
guard: Claude + Sebastian (einmal bestätigen, dann ausführen)
```

### Phase 4 — Verknotung

```yaml
trigger: gleiche Kernaussage in 3+ Dateien dupliziert
detection:
  - rg "$kernaussage" | anzahl eindeutiger Dateien >= 3
  - ODER Sebastian äußert: "steht eh überall"
action:
  1. identify SoT-Kandidat: älteste / vollständigste / thematisch passendste Datei
  2. konsolidiere Inhalt dort
  3. ersetze Duplikate durch [[Link]]
  4. optional: alten Abschnitt mit Blockquote der Kernzeile behalten
guard: Claude, reversibel → ohne Rückfrage
```

### Phase 5 — Abschluss

```yaml
trigger: EINE der folgenden
detection:
  - frontmatter status == "abgeschlossen"
  - ODER file.mtime älter als 90 Tage UND keine offene Aufgabe in TASKS.md UND keine Erwähnung in letzten 3 Daily Notes
action:
  propose: "Archiv-Kandidat: $Pfad — Grund: $Grund. Verschieben?"
  if Sebastian bestätigt: move to "06 Archiv/$ursprungsPfad"
  never: automatisches Löschen oder Verschieben
guard: Claude schlägt vor, Sebastian entscheidet
```

### Querphase — Pflege (Session-Ende-Routine)

```yaml
trigger: Session-Ende-Signal ("ok", "schliese ab", "fertig")
actions:
  - check_orphans: Dateien ohne eingehende Backlinks listen
  - check_duplicates: gleiche Überschriften in verschiedenen Dateien
  - check_drift: fehlende tags / date / status in Kopfdaten
  - check_dead_links: [[Link]] ohne Zieldatei
  - report: 1-Zeilen-Zusammenfassung pro Kategorie in Daily Note
guard: Claude, reversible Fixes direkt, destruktive Vorschläge an Sebastian
```

---

## Cluster-Erkennung

```yaml
cluster_definition:
  min_nodes: 10
  min_internal_backlink_ratio: 0.6    # mehr interne als externe Backlinks
  shared_tag: mindestens 1 Haupt-Schlagwort
  entry: Hub-Datei ODER README.md vorhanden

promote_to_bereich:
  conditions_all:
    - cluster_definition erfüllt
    - trägt Verantwortung ohne Enddatum
    - Sebastian hat in >= 3 Sessions dort gearbeitet
  action: move to "03 Bereiche/$Titel/", add to CLAUDE.md Raum-Tabelle
```

---

## Raum-Splitting (CLAUDE.md-Erweiterung)

```yaml
new_room_criteria:
  all_required:
    - cluster_definition erfüllt
    - stichwort_overlap_mit_bestehenden_räumen < 30 %
    - >= 3 Sessions aktive Arbeit dort
action:
  1. Einstiegsdatei anlegen (README.md oder Hub.md)
  2. Raum-Tabelle in CLAUDE.md um Zeile ergänzen (Emoji, Pfad, Stichwörter)
  3. Sebastian in 1 Zeile informieren
```

---

## Lebende Kennzahlen

Werden von [[Gehirn - Selbstanalyse.base]] live berechnet und hier gedeutet:

```yaml
orphan_quote:
  formula: (anzahl_dateien_ohne_backlinks / gesamt_dateien) * 100
  target: "< 30 %"
  ist: 51 %                # 2026-04-19
  aktion_wenn_über_60: "Pflege-Session überfällig — Sebastian benachrichtigen"
  aktion_wenn_unter_25: "Platz für neue Keime frei"

inbox_alter:
  formula: max((now - file.ctime).days) for file in "01 Inbox/"
  target: "< 14 Tage"
  aktion_wenn_überschritten: "ältesten Kandidaten in Reifung (Phase 2) heben"

cluster_dichte:
  formula: internal_backlinks / external_backlinks per Ordner
  target: "> 1.5 bei reifen Clustern"
  aktion_wenn_unter_1: "Cluster lose — Verdichtung oder Auflösung prüfen"
```

---

## Entscheidungs-Flow (Claude liest dies beim Einsortieren)

```
neue Information angekommen
    │
    ├── konkreter Auftrag mit Enddatum? ──► 02 Projekte/
    │
    ├── zeitlose Referenz? ─────────────────► 04 Ressourcen/$Kategorie/
    │
    ├── Teil eines bestehenden Raums?
    │   (Stichwort-Match mit CLAUDE.md-Tabelle) ──► in den Raum
    │
    ├── flüchtiger Gedanke / Status-Update? ─► 05 Daily Notes/heute
    │
    └── sonst ─────────────────────────────► 01 Inbox/
```

---

## Selbstbezug

Dieses Dokument ist selbst ein Produkt seiner Regeln: Signal war „lass uns die struktur definieren" → Phase 2 (Reifung) eines Konzepts, das bis dahin nur implizit in CLAUDE.md lebte. Nach „ai optimirt" wurde es von narrativer Prosa in operatives YAML/Pseudo-Code umgebaut — Claude soll daraus handeln können, nicht nur lesen.

## Verknüpfungen

- [[Claude - Selbstkarte]] — Wer das Geflecht liest und pflegt
- [[Claude - Fehler und Lernen]] — Wie aus Fehlern Regeln werden
- [[Gehirn - Neuronale Karte.canvas]] — Standbild der Cluster
- [[Gehirn - Selbstanalyse.base]] — Live-Puls
- [[CLAUDE.md]] — Tragende Regeln

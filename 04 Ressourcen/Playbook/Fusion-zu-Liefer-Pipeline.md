---
typ: playbook
titel: Fusion-zu-Liefer-Pipeline (Bens/Reiner-Workflow)
stand: 2026-04-21 abends
gilt-für: alle zukünftigen Liefer-Projekte mit Fusion-Konstruktion + externer Fertigung
basis: Lernings aus Lagerschalenhalter-Session 21.04.2026
---

# Fusion-zu-Liefer-Pipeline — Playbook

Dieses Playbook entsteht aus den Lernings der Volker-Bens-Lagerschalenhalter-Session am 21.04.2026. Zwölf Stunden Arbeit, fünf Patcher-Iterationen, am Ende Reiner's pragmatischer Papier-Stift-Scan-Weg parallel dazu. Was hängen geblieben ist, steht hier — damit das nächste Projekt direkt sauber läuft statt die Schleife neu zu drehen.

## Die zentrale Einsicht

**Patcher-Arbeit kaschiert Fusion-Master-Inkonsistenzen. Das ist Sisyphus.** Jedes Mal wenn Fusion neu exportiert, kommen die Fehler wieder. Der Hebel liegt im Master, nicht im Export.

Gleichzeitig: **Reiner arbeitet papierbasiert.** Ausdrucken, Mengen in Rot markieren, scannen, rausschicken an Fertiger (Tomasz KM Metalworks PL) + Kunden CC. Fertigung läuft über STEP-Dateien — die PDF-Nummern sind dort nachrangig. Mos saubere Dokumentation an Kunden ist ein paralleler Pfad, nicht konkurrierend.

Daraus folgt: Bei Zeitdruck nicht automatisch in Patcher-Kaskade gehen. Erst klären ob Reiners Papier-Weg für die Fertigungslogistik reicht — wenn ja, kann die saubere Dokumentation in Ruhe folgen.

## Phase 1 — Projekt-Setup (erster Kontakt mit dem Projekt)

Bevor irgendwas exportiert wird:

1. **Klären wer Empfänger ist** — getrennt nach Fertigungslogistik (Reiner → Fertiger) und Kunden-Dokumentation (Volker bzw. Endkunde). Beide bekommen potentiell unterschiedliche Ausbaustufen.

2. **STEP-Datenhoheit klären** — wer exportiert STEP, wer hat die 3D-Master. Bei Lagerschalenhalter: Reiner aus Fusion, direkt an Tomasz. Das ist der eigentliche Fertigungs-Input.

3. **Nummernschema festlegen** und ins Register eintragen (`03 Bereiche/WEC/Lieferung/<Kunde>/_Register/<Kunde>-Nummernregister.md`). Reiners Standard: `BE-<3-Buchst>-<MMYY>-<NNN>-<R>` mit NNN-Blöcken (000=Hauptzusammenbau, 001-099=SBG, 200-299=Dreh-/Rohrteile, 400-499=Blech, 700-799=Kaufteile, 900-999=Normteile). Abweichungen bewusst dokumentieren.

4. **Keine-Recycling-Regel**: Jede Nummer die einmal vergeben wurde wird nie wiederverwendet. Auch nicht wenn das Teil obsolet wird.

## Phase 2 — Fusion-Master prüfen VOR Export

Zehn-Minuten-Check im Fusion-Master bevor irgendwas raus geht. Das spart Stunden in der Pipeline.

### Checkliste Fusion-Master

- [ ] **Werkstoff-Strings** in der Materialdatenbank: `1.4404` statt `1.44.04`, `1.4301`, `AISI 316L` etc. — einmal pro Material prüfen, weil sich jeder Tippfehler auf alle Teile vererbt
- [ ] **Bauteil-Namen konsistent** mit dem tatsächlichen Teil: wenn V2-Welle aus V1 dupliziert wurde, Name explizit auf "Welle_V2" ändern. Fusion kopiert den Namen nicht automatisch um
- [ ] **Dateinamen pro Teil global eindeutig**: wenn sowohl im Einzelteile-Ordner als auch im Baugruppen-Ordner "Welle_V1 Zeichnung" existiert, kollidieren sie beim Batch-Export. Lösung: "Welle_V1 Einzelteil Zeichnung" vs "Welle_V1 Baugruppe Zeichnung" oder getrennte Export-Zielordner
- [ ] **-0-Suffix-Konsistenz** in allen Zeichnungsnummern: entweder alle mit `-0` als Revision oder alle ohne. Nicht mischen
- [ ] **Keine Nummern-Kollision** wie `-203` und `-203-0` für verschiedene Teile — das ist ein Unfall im Wartestand
- [ ] **Schweißbaugruppen-Nummern** sind eigenständige Nummern, nicht gleich der zugrunde liegenden Einzelteil-Nummer
- [ ] **Zusammenbau-Inhalte** pro Variante sauber getrennt: V1-Zusammenbau enthält nur V1-Teile, nicht V2 "zum Vergleich"

## Phase 3 — Export aus Fusion

Immer beides exportieren:

1. **PDF pro Zeichnung** — das ist der Liefer-Output für Kunden und Fertiger. Menschenlesbar.
2. **CSV pro Zeichnung** — das ist der Pipeline-Input für die Analyse. Strukturierte Stückliste mit Bauteilnummer, Name, Menge, Material, Masse. Maschinenlesbar.

Nur-PDF zwingt in PDF-Text-Extraktion, die unzuverlässig ist. CSV gibt harte Daten.

Fusion-Export-Menü hat vier Optionen: PDF, DWG, Plan als DXF, CSV. PDF+CSV als Minimum, DXF wenn der Fertiger Blechteile per Laser/Plasma schneidet, DWG auf Anfrage.

**STEP-Dateien separat** aus dem 3D-Master — nicht aus dem Zeichnungsexport. Die gehen direkt an den Fertiger.

## Phase 4 — Analyse der CSV-Exports

Wenn CSVs da sind, lässt sich pro Teil sauber klassifizieren:

| Stücklisten-Inhalt der CSV | Klassifizierung |
|---|---|
| Nur 1 Eintrag (sich selbst) | **Einzelteil** (Y=1) |
| Mehrere Einträge + "nach Schweißen" im PDF | **Schweißbaugruppe** SBG (Y=5) |
| Mehrere Einträge + Normteile (Schrauben, Lager) | **Zusammenbau** (Y=9) |
| Mehrere Einträge ohne Schweißhinweis und ohne Normteile | **Baugruppe** (Y=5, nur montiert) |

Die Klassifizierung ergibt direkt die Zielnummer im Register und den Ziel-Dateinamen (mit `_SBG`-Suffix für Schweißbaugruppen, wie in Reiners Mustern).

## Phase 5 — Patcher-Kaskade (nur wenn Fusion-Master nicht fixbar)

Wenn der Master nicht zeitnah sauber gemacht werden kann (z.B. weil die Fertigung schon läuft, oder weil der Fusion-Zugriff beim Konstrukteur liegt), fängt der Patcher die Fehler ab. Tools:

- `02 Projekte/WEC/scripts/v5_patcher.py` — patcht Nummern, White-Label-Texte, Werkstoff-Tippfehler in PDFs
- `02 Projekte/WEC/scripts/v4_patcher_v2.py` — fügt Info-Block (Allgemeintoleranzen, EHEDG-Hinweise) hinzu
- Mapping pro Projekt: `mapping_<projekt>_v<N>.yaml` neben dem Liefer-Ordner

Reihenfolge im Lauf: v5 (Nummern) → v4v2 (Info-Block) → Paket bauen.

## Phase 6 — Paket-Build (Produktions-Regel)

**Vor jedem Rausgang: Staging + Audit + Mo-Freigabe.** Bewährt am 21.04.2026 — zwei Unfälle (Whitelist-Fehler und AM_Lagerschale-Platzhalter) nur so abgefangen.

- Paket-Build nur mit **expliziten Dateinamen**, niemals Globs wie `find -iname "*reiner*"`. Am 21.04. hätte so ein Filter interne Dokumente (Pfändungsbrief, Kundenprofil, Tonalitätsnotizen) in Reiners Paket gezogen. Explizit schreiben was rein soll.
- **Audit-Report** nach jedem v5-Lauf lesen (`_staging/v5_run_*/02_audit/`). `not_found`-Meldungen sind nicht zwingend Fehler (globale Regel trifft in nicht allen PDFs), aber auffällige Häufungen prüfen.
- **Visueller Spot-Check** auf 2-3 PDFs vor Versand: Schriftfeld, Stückliste, Info-Block-Position.

## Phase 7 — Zusammenspiel mit Reiners Workflow

Reiner's Weg: ausdrucken → Mengen in Rot markieren → scannen → E-Mail an Fertiger + Kunden CC. Das ist eine eigene Produktivlinie.

Mos Pipeline ist komplementär: saubere Kunden-Dokumentation, Register-Pflege, Nummern-Konsistenz für zukünftige Revisions-Tracking.

**Nicht in Konkurrenz denken.** Wenn Reiners Paket schon raus ist und die Fertigung läuft, ist die Patcher-Kaskade kein Not-Job mehr. Sie kann in Ruhe fertig gemacht werden für die Akten oder als Ersatz-Lieferung falls Volker Rückfragen hat.

## Phase 8 — Register und Lessons pflegen

Nach Projekt-Abschluss:

- Alle vergebenen Nummern im Register bestätigen, inkl. Mengen (falls Reiner Stückzahlen auf dem Scan markiert hat — die sind wertvolle BOM-Info)
- Lessons aus dem Projekt in dieses Playbook einfließen lassen, falls was Neues gelernt wurde
- STEP-Dateien und alle Lieferpakete im Projekt-Ordner archivieren (nicht löschen, auch nicht obsolete Versionen)

## Anti-Patterns — nicht nochmal machen

**Dinge die heute Zeit gekostet haben:**

1. **Nicht** Patcher-Iteration als Ersatz für Master-Cleanup. Wenn dieselbe Klasse Fehler 3× auftaucht → Master fixen.
2. **Nicht** Dateien während laufender Session wahllos verschieben/umbenennen. Erst Archiv-Ordner anlegen, dann kontrolliert arbeiten. Heute zweimal Archivierung unnötig rückgängig gemacht.
3. **Nicht** theoretisch-spekulativ vorgehen wenn reale Daten verfügbar sind. CSVs früher einfordern statt PDF-Text-Extraktion zu raten.
4. **Nicht** eigenmächtig Zeichnungen aus der Lieferung entfernen (z.B. "Kombi-Zeichnung" als "Konstruktionsfehler" verwerfen) — das ist Reiners Konstruktions-Entscheidung, nicht meine.
5. **Nicht** Options-Listen A/B/C anbieten wenn Mo Fortschritt will. Entweder direkt handeln oder genau EINE gezielte Frage stellen.

## Referenzen

- **Konkrete Fehlerliste Lagerschalenhalter**: `03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/Fusion-Master-Cleanup-mit-Reiner.md`
- **Reiners Standard-Template**: `04 Ressourcen/Musterbeispiele-Reiner/Muster-Analyse_Reiner-Standard.md`
- **Nummernregister Volker Bens** als Beispiel-Schema: `03 Bereiche/WEC/Lieferung/Volker Bens/_Register/Volker-Bens-Nummernregister.md`
- **Patcher-Scripts**: `02 Projekte/WEC/scripts/`

---
tags: [wiki, wec, kunde, bens, konstruktion, flanschlager, lebensmittel, ehedg]
date: 2026-04-18
status: in-arbeit
---

# Flanschlager — Käsekarussell Sachsenmilch

> **Kunde:** Bens Edelstahl GmbH → Sachsenmilch (Endkunde)
> **Einsatz:** Käsekarussell für Harzer Käse — **Spannhebel für Riemenvorschub**
> **Abgrenzung:** Dies ist *nicht* der [[Volker Bens - Lagerschalenhalter Lebensmittelindustrie|Lagerschalenhalter]] (der dient der Riemenspannung am selben Karussell). Beide Bauteile, gleiche Anwendung, unterschiedliche Funktion.
> **Status:** Stub. Wartet auf Daten-Abgleich mit Reiner, Termin **Montag 2026-04-21**.

## Anlass

Zweiter aktiver Bens-Auftrag am Käsekarussell, nach dem Lagerschalenhalter. Reiner bringt Montag Scans seiner Korrekturen zu den Zeichnungsnummern — diese sind in der aktuellen Arbeitsversion inkonsistent mit der BOM und/oder den 3D-Daten. Aufgabe der Session: auslesen, gegenchecken, korrigieren, konsistent liefern.

## Kontext aus dem Lagerschalenhalter-Projekt übernehmbar

Folgende Regeln gelten für den Flanschlager **1:1 analog**, weil gleicher Endkunde, gleiche Anwendung, gleiche Norm-Landschaft:

- **EHEDG-Konformes Hygienic Design** — siehe [[Volker Bens - Lagerschalenhalter Lebensmittelindustrie#Oberflächenanforderungen (EHEDG)|EHEDG-Anforderungen]]
- **Werkstoff:** 1.4404 (316L) für alle medienberührten und reinigungszugänglichen Teile
- **Schrauben:** A4-80, bevorzugt Hygienic Design (glatter Kopf, nicht Innensechskant)
- **Schmierstoff bei bewegten Teilen:** NSF H1 zugelassen (bei Flanschlager = Lagerschmierung!)
- **Ra ≤ 0,8 µm** auf medienberührten Flächen, Radien min. R6 an Übergängen, keine Toträume
- **Lebensmittelkontakt-Kontext:** Maschinenumfeld, trocken, manuelle Reinigung (Reiner hat beim Lagerschalenhalter bestätigt)

## Aufgaben für Montag 2026-04-21 (mit Reiner)

### 1. Daten-Ingest
- [ ] **Reiner-Scans sichten** — was wurde korrigiert? (Zeichnungsnummern, Stücklisten-Positionen, Materialangaben?)
- [ ] **Aktuelle Arbeitsdateien lokalisieren** — Sebastian: liegen die Flanschlager-Daten schon im Vault (`raw/Kunden/Volker Bens/aktuelle Projekte/Flanschlager Käsekarussell/`) oder noch auf Desktop/Downloads? → Falls Desktop: vor Session in raw/ ablegen.
- [ ] **Formate-Inventar:** Welche Dateien sind vorhanden? (PDF-Zeichnungen, DWG/DXF, STEP, Excel-BOM, ggf. Fusion360 `.f3d`)

### 2. Abgleich Zeichnung ↔ BOM ↔ 3D
Kernaufgabe. Analog Lagerschalenhalter-Pattern:

- [ ] **Alle Zeichnungsnummern extrahieren** — aus 2D-Zeichnungen (PDF), aus BOM-Stückliste, aus 3D-Datei-Namen
- [ ] **Diskrepanz-Tabelle erzeugen** — pro Teil: Zeichnungsnummer 2D vs. Zeichnungsnummer BOM vs. Dateiname 3D
- [ ] **Reiners Korrektur-Scans** als Quelle der Wahrheit nehmen, Rest angleichen
- [ ] **Artikelnummern prüfen** — Normteile (Lager, Schrauben, Dichtungen) gegen Katalog (Mädler, SKF, Würth) gegenchecken, Dummy-Nummern ersetzen
- [ ] **Lager-Bezeichnung** — typische Stolperstelle beim Lagerschalenhalter war `2203` vs. `2202`. Beim Flanschlager analog prüfen: welche Lagergröße, welche Ausführung, Food-Grade?

### 3. Lieferformat Bens-tauglich machen
- [ ] **STEP-Export-Schema klären** — Volker hat altes CAD-System, kann vermutlich nur **STEP AP203** lesen (nicht AP214 oder AP242). → *Am Montag mit Reiner klären, welches Schema er in den letzten Lieferungen benutzt hat.* Das fließt in [[CAD-Datenuebergabe Standard - Bens Edelstahl]] zurück.
- [ ] **Schriftfeld:** Volker-Logo, ausgefülltes Schriftfeld (Konstrukteur/Prüfer, Werkstoff, Maßstab, Blattnummer)
- [ ] **Bemaßung konsistent** auf allen Einzelteil- und Baugruppen-Blättern
- [ ] **Blatt-Definierung** sauber (welches Blatt zeigt was, Nummerierung 1/N, 2/N, …)
- [ ] **Ra-Angaben** auf allen Einzelteilzeichnungen, Radien R6 an Übergängen vermerkt

### 4. Bens-Standard verfeinern
- [ ] Reiner bringt **Muster aus früheren erfolgreichen Volker-Projekten** — das sind Gold für den [[CAD-Datenuebergabe Standard - Bens Edelstahl]]. Beim Durchgehen der Muster: jedes erkannte Muster (Schriftfeld-Aufbau, Dateinamen-Schema, BOM-Spalten-Reihenfolge) direkt im Standard ergänzen. **Beobachten statt fragen.**

## Offene Fragen für Reiner (Montag-Agenda)

- STEP-Schema (AP203 / AP214 / AP242)? — *am Besten aus `FILE_SCHEMA`-Zeile einer alten erfolgreichen Lieferung ablesen*
- Welche Zeichnungen sind aus Sicht von Reiner *richtig*, welche brauchen Korrektur?
- Wie ist die Baugröße des Flanschlagers? Aufnahmedurchmesser der Welle, Befestigungs-Lochbild, max. Belastung?
- Ausführung: Zweiloch? Vierloch? Mit/ohne Lagerbock?
- Lager-Ausführung im Flanschlager: Standardlager + Nachfetten NSF H1, oder Food-Line-Lager ab Werk?

## Raw-Daten

Rohdaten zum Projekt liegen in:
```
03 Bereiche/WEC/raw/Kunden/Volker Bens/aktuelle Projekte/Flanschlager Käsekarussell/
```

*(Inhalt füllt sich mit Montag-Ingest. Falls Sebastian vorher schon Daten auf Desktop hat: bitte vor Montag in diesen Ordner legen, damit Claude Code sie findet.)*

## Fehler-Tabelle *(nach Analyse zu füllen)*

Analog zu [[Volker Bens - Lagerschalenhalter Lebensmittelindustrie#Fehler im Original|Lagerschalenhalter-Fehlertabelle]]. Montag nach Abgleich ausfüllen:

| Problem | Details | Handlung |
|---|---|---|
| … | … | … |

## Überarbeitete Stückliste *(nach Analyse zu füllen)*

Analog zu [[Volker Bens - Lagerschalenhalter Lebensmittelindustrie#Überarbeitete Stückliste|Lagerschalenhalter-BOM]].

| Pos | Bauteil | Beschreibung | Menge | Material | Änderung |
|---|---|---|---|---|---|
| … | … | … | … | … | … |

## Checkliste vor Freigabe *(Arbeitsversion — an Reiner-Korrekturen anzupassen)*

- [ ] Alle Zeichnungsnummern konsistent in 2D, BOM, 3D, Dateinamen
- [ ] STEP-Export im Volker-kompatiblen Schema (vermutlich AP203)
- [ ] Schriftfeld komplett ausgefüllt (Volker-Logo, Konstrukteur, Prüfer, Werkstoff, Maßstab, Blattnummer)
- [ ] Bemaßung auf allen Blättern konsistent
- [ ] Ra ≤ 0,8 µm auf medienberührten Flächen in Zeichnung eingetragen
- [ ] Radien R6 an Übergängen geprüft
- [ ] Lager-Spezifikation: Bezeichnung, Größe, Food-Grade-Variante / Nachfettung
- [ ] Schrauben: A4-80, Hygienic Design wo möglich
- [ ] Dichtungen/Abdichtung: NSF H1, FDA 21 CFR
- [ ] Material- und Konformitätserklärung (EC 1935/2004) verfügbar
- [ ] Lieferpaket nach Bens-Standard strukturiert (→ [[CAD-Datenuebergabe Standard - Bens Edelstahl]])

## Verknüpfungen

- [[03 Bereiche/WEC/wiki/Kunden/Volker Bens - Profil|Volker Bens — Kundenprofil]]
- [[03 Bereiche/WEC/wiki/Kunden/Volker Bens - Lagerschalenhalter Lebensmittelindustrie|Schwester-Projekt Lagerschalenhalter]] — selbe Karussell-Anwendung, andere Funktion
- [[03 Bereiche/WEC/CLAUDE|WEC-Regeln]] — EHEDG und Bens-Spezifika
- [[04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl|Bens-Lieferstandard]]
- [[02 Projekte/WEC Neustart mit Reiner/WEC Neustart mit Reiner]]
- [[TASKS#Termine|Termin Montag 2026-04-21]]

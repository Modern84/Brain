---
tags: [ressource, wec, kunde, standard, cad, volker-bens]
status: in-aufbau
date: 2026-04-17
---

# CAD-Datenübergabe Standard — Bens Edelstahl GmbH

**Zweck:** Verbindliches Lieferformat für alle CAD-Datenübergaben an Volker Bens.

**Methode:** Das Profil wird **nicht** durch Nachfragen bei Volker erstellt, sondern durch **Analyse der historischen Liefer-Datensätze** (30 Jahre Zusammenarbeit Reiner ↔ Volker). Was über Jahrzehnte funktioniert hat, ist der Standard.

**Status:** ⏳ Template angelegt, wartet auf historische Datensätze zur Analyse.

---

## Analyse-Quellen (einzukippen)

Sobald Reiner die historischen Lieferungen bereitstellt (per SSD, USB-Stick oder E-Mail), werden diese hier verlinkt:

- [ ] Beispiel-Lieferung 1: _(Projekt, Jahr)_ → `07 Anhänge/Volker-Historie/…`
- [ ] Beispiel-Lieferung 2: _(Projekt, Jahr)_ → …
- [ ] Beispiel-Lieferung 3: _(Projekt, Jahr)_ → …

**Priorität für aussagekräftige Analyse:** mindestens 3 Lieferungen aus unterschiedlichen Jahren, idealerweise aus verschiedenen Komplexitätsstufen (Einzelteil, Baugruppe, komplette Anlage).

---

## Kundenprofil Volker Bens — abzuleitende Parameter

### 1. 3D-Daten
- **3D-Format:** **IGES** (nicht STEP!) — aus Fusion360-Projektpaket 07 Anhänge/Fusion360/ bestätigt (2026-04-18). Alle 3D-Exports sind `.iges`-Dateien. Volkers altes CAD-System liest IGES zuverlässig. STEP AP214 (`Lagerhalter.stp` in raw/) ist eine parallele Exploration, kein finales Liefer-Format.
- **Dateistruktur (aus Fusion360-Paket abgeleitet):**
  - Zusammenbau: `Zusammenbau_[Bauteilname].iges`
  - Einzelteile: eigener Unterordner, je eine `.iges` pro Bauteil
  - Varianten: Suffix `_V1`, `_V2` (z.B. `Welle_V1.iges`, `Welle_V2.iges`)
- **Alternativformate:** PDF-Zeichnungen separat (A3 Querformat, Fusion Drawings 25.1)
- **Versionierung im Dateinamen:** `_V1`, `_V2` für Varianten/Überarbeitungen (Montag bestätigen)
- **Einzelteile separat vs. Zusammenbau:** Beides — Zusammenbau + alle Einzelteile separat
- **Ordnerstruktur (aus Fusion360-Paket):**
  ```
  Baugruppen_Einzelteile_[Projektname]/
  ├── PDF/
  │   ├── [Zusammenbau].pdf
  │   ├── [Baugruppe].pdf (z.B. Schweißgruppe_Halter)
  │   └── Einzelteile/
  │       ├── [Einzelteil] Zeichnung.pdf
  │       └── ...
  └── Step/  (irreführend benannt — enthält tatsächlich .iges!)
      ├── [Zusammenbau].iges
      ├── [Baugruppe].iges
      └── Einzelteile/
          └── [Einzelteil].iges
  ```

### 2. 2D-Zeichnungen
- **Format:** IGES (Liefer-Format) + PDF (für Volker-Ansicht und Prüfung)
- **Papiergröße:** A3 Querformat (aus Zusammenbau-Zeichnung 2026-04-18 bestätigt: 1684×1191pt)
- **Export-Software:** Autodesk Fusion 360 (Fusion Drawings 25.1, Stand April 2026)
- **Schriftfeld-Layout (aus Zusammenbau-Zeichnung extrahiert 2026-04-18):**

| Feld | Position | Aktueller Inhalt (IST) | Soll (White-Label) |
|---|---|---|---|
| Maßstab | unten rechts | `1:1` | `1:1` |
| Technical reference | unten rechts | (leer) | (leer) |
| Bearbeitet: Name | unten rechts | `Sebastian Hartmann` | *Bens-Konstrukteur (Montag klären)* |
| Bearbeitet: Datum | unten rechts | `2026-04-16` | aktuelles Datum |
| Geprüft: Name | unten rechts | `Woldrich` | *Bens-Prüfer (Montag klären)* |
| Geprüft: Datum | unten rechts | `2026-04-16` | aktuelles Datum |
| Document type | unten rechts | (leer) | (leer) |
| Anmerkung | unten rechts | (leer) | (leer) |
| Title | unten rechts | `Zusammenbau_Lagerschalehalter` | Bauteilname |
| Zeichnungsnummer | unten rechts | `BE-LS-202603-000-0` | korrekte BE-Nummer (nach Montag) |
| Projektgruppe | unten rechts | `SM_Lagerschale` | *Bens-interne Bezeichnung (kein `SM_`!)* |
| Rev. / Date of issue | unten rechts | | |
| Sheet | unten rechts | `1/1` | `1/N` |

**White-Label-Hinweis:** Felder Bearbeitet/Geprüft/Projektgruppe müssen im Fusion-360-Template angepasst werden — PDF-Patch nicht möglich ohne Geometrie-Schäden (Vektortext im TITLEBLOCK-Layer). Fusion-360-Template-Fix ist separate Skill-Aufgabe (nach Montag).
- **Bemaßungsstil:** _(ISO? ANSI? metrisch?)_
- **Toleranzangaben:** _(ISO 2768-m? ISO 2768-f? explizit bemaßt?)_
- **Oberflächensymbole:** _(DIN EN ISO 1302? Eigene Konvention?)_

### 3. Stückliste (BOM)
- **Format:** _(Excel .xlsx? CSV? PDF?)_
- **Spalten-Reihenfolge:** _(Pos. / Menge / Benennung / Werkstoff / Halbzeug / Masse / Bemerkung?)_
- **Numerierungssystematik:** _(fortlaufend? hierarchisch 1.1, 1.2?)_
- **Werkstoffangabe:** _(DIN-Bezeichnung `1.4404` oder Kurzname `V4A`? Beides?)_
- **Normteile:** _(DIN-Nummer? ISO? Hersteller + Artikelnummer?)_
- **Oberflächenangabe:** _(Ra-Wert? Beizen/Passivieren? Poliert?)_

### 4. Oberflächenbeschaffenheit
- **Standardangabe:** _(z.B. `Ra ≤ 0,8 µm` für Lebensmittelbereich — EHEDG)_
- **Dokumentationsort:** _(auf Zeichnung? in BOM-Spalte? separat?)_
- **Sondervermerke:** _(beizen, passivieren, elektropoliert?)_
- **Oberflächensymbolik:** _(DIN EN ISO 1302? Alte DIN-Symbolik? Eigenes Schema?)_

### 5. Symbole & Zeichensprache
- **Schweißzeichen:** _(DIN EN ISO 2553? DIN EN 22553? ANSI? Eigene Vereinfachung?)_
- **Form- und Lagetoleranzen:** _(DIN EN ISO 1101? Klassische DIN 7184?)_
- **Gewindesymbolik:** _(genormte Darstellung? Vereinfacht?)_
- **Schnittdarstellungen, Maßlinien, Pfeile:** _(aus Zeichnungen ablesbar)_
- **Ansichten-Anordnung:** _(Erste Projektion / Dritte Projektion / gemischt?)_

### 6. Normen-Referenzen auf Zeichnungen und in BOM
Aus historischen Lieferungen ableiten welche Normen Volker in seinem Dokumentationsstandard erwartet. Typische Kandidaten im Lebensmittel-/Edelstahl-Bereich:
- **Werkstoff:** DIN EN 10088 (Edelstähle), EN 10028 (Bleche), EN 10204 (Prüfbescheinigung 3.1?)
- **Hygienic Design:** EHEDG Doc. 8, DIN EN 1672-2, EC 1935/2004, FDA 21 CFR
- **Schmierstoffe:** NSF H1 (bei bewegten Teilen)
- **Allgemeintoleranzen:** ISO 2768-m / ISO 2768-f
- **Gewinde/Schrauben:** DIN EN ISO 4762 (Innensechskant), DIN 985 (Hutmutter), A2-70 / A4-80
- **Zeichnungsnormung:** DIN 6771 (Schriftfeld), DIN 824 (Faltung)
- _(weitere aus Analyse ergänzen)_

### 7. Zeichnungsnummern-Systematik

**Format (aus Zusammenbau-Zeichnung extrahiert 2026-04-18):**
`BE-XX-XXXXXX-XXX-X`

| Teil | Bedeutung | Beispiel |
|---|---|---|
| `BE` | Bens Edelstahl | immer gleich |
| `XX` | Typ-Kürzel | `LS` (Lagerschale?) oder `IS` (in Klärung) |
| `XXXXXX` | Projektnummer | `202603` oder `202631` (in Klärung) |
| `XXX` | Positions-Nr. | `000`, `100`, `201`, `302` … |
| `X` | Revision/Variante | `0` = erste Ausführung |

**⚠️ Bekannte Inkonsistenz (Montag 2026-04-21 klären):**
- CSV-Stückliste (`Lagerschalenhalter_Stueckliste_Lebensmittel.csv`) hat: `BE-IS-202631-XXX-X`
- Zusammenbau-Zeichnung PDF hat: `BE-LS-202603-XXX-X`
- Zwei Unterschiede: Typ-Kürzel (`IS` vs `LS`) + Projektnummer (`202631` vs `202603`)
- Reiner bringt Montag Korrektur-Scans mit den richtigen Nummern — das ist die Kern-Aufgabe des Termins.

**700er-Block = Kaufteile/Normteil-Referenz** (Beleg: `BOM_bereinigt.xlsx` 2026-04-20, Liefer-Ordner Montag-Session):

| Nummer | Bauteil | Hersteller / Norm |
|---|---|---|
| `BE-LS-202603-700-0` | Pendelkugellager (Lager) | SKF 2202 E-2RS1TN9 / Mädler Art. 64773026 |
| `BE-LS-202603-704-0` | Klemmring | Edelstahl 1.4305, Mädler Art. 62399115 |

**Ableitung:** Nummernbereich 700–799 ist reserviert für **Kaufteile mit Hersteller-Referenz** (nicht selbst gefertigt). Einzelteile eigene Fertigung = 100–299 (belegt durch 200/201/202/203/204/205/206). Zusammenbauten = 000/001 (belegt durch 000-0 Hauptbaugruppe, 1-0 Schweißgruppe). Normteile (DIN-Schrauben, -Muttern) haben **keine** BE-Nummer, nur DIN-Referenz.

**Hierarchie-Beispiel (CSV, Stand 15.04.2026):**
```
BE-IS-202631-000-0   Lagerschale_Baugruppe (Hauptbaugruppe)
BE-IS-202631-100     Lagerhülse
BE-IS-202631-201-0   Lagerseite
BE-IS-202631-302-0   Steg_Lagerschalenhalter
BE-IS-202631-700-0   Pendelkugellager (Kaufteil)
BE-IS-202631-203-0   Scheibe t=1
BE-IS-202631-704-0   Klemmring (Kaufteil)
BE-IS-202631-205-0   Scheibe t=3
BE-IS-202631-204     Welle
```
Normteile (Schrauben, Muttern) ohne BE-Nummer — referenziert über DIN/ISO + Hersteller-Artikelnr.

### 8. Dateinamen-Konvention
- **Muster:** _(aus Analyse ableiten)_
- **Sonderzeichen, die Volkers System nicht mag:** _(Umlaute? Slashes?)_
- **Maximale Länge:** _(wegen Windows-Pfadlimit?)_

### 9. Lieferpaket-Struktur
- **Ordner-Aufbau:** _(aus Analyse ableiten)_
- **ZIP oder einzelne Dateien:** _(per E-Mail? Download-Link?)_
- **Begleitdokument:** _(Lieferschein? Mail-Text mit Übersicht?)_

### 10. Kommunikations-Standard
- **Benachrichtigung über Fertigstellung:** _(E-Mail? Anruf?)_
- **Fragen-Kanal:** _(wenn Rückfragen auftreten — E-Mail oder Telefon?)_
- **Review-Prozess:** _(schickt Volker kommentierte Rückmeldung? Abnahme schriftlich?)_

---

## Pilot-Projekt zum Validieren des Profils

**Projekt:** Lagerschalenhalter für Sachsenmilch (Käsekarussell, Harzer Käse)

Das aktuelle Pilot-Projekt läuft parallel zum Profil-Aufbau:
- IST-Zustand liegt vor: `07 Anhänge/Fusion360/Baugruppen_Einzelteile_Lagerschalenhalter/`
- Bekannte Probleme: IGES statt STEP, Zeichnungsnummern-Inkonsistenzen, fehlende 3D-/2D-Paarungen
- Reiner schickt kommentierte SOLL-Scans nach

Sobald das Profil steht, wird der Pilot **am Profil ausgerichtet** — und nicht nach Bauchgefühl geliefert. Erfolgreiche Abnahme durch Volker = Profil bestätigt.

---

## Verwendung

Nach erfolgreicher Ableitung wird dieses Dokument:
1. **Verbindlicher Standard** für alle Volker-Lieferungen — Reiner und Mo prüfen jede Auslieferung dagegen
2. **Automatisierungs-Grundlage** für die MThreeD.io-Pipeline — Export-Einstellungen und Prüfregeln lassen sich aus den Feldern direkt ableiten
3. **Muster für weitere Kundenprofile** — Knauf, Sachsenmilch direkt etc. bekommen je ein eigenes Dokument nach gleicher Struktur

---

## Arbeitsregeln für die Profil-Ableitung

Diese Regeln sind verbindlich für den Prozess, wie das Profil aus den historischen Datensätzen gebaut wird:

1. **Beobachten statt fragen.** Der Kunde wird nicht mit Format-Fragen belastet. Was über Jahre als Lieferung akzeptiert wurde, ist der Standard.
2. **PDF-Zeichnungen sind die Hauptquelle.** Sie zeigen Schriftfeld, Bemessungsstil, Symbole, Normen-Referenzen und Oberflächenangaben auf einen Blick. 3D-Dateien liefern technische Metadaten (Schema, Einheiten), BOMs liefern Spaltenlogik und Werkstoffbezeichnung.
3. **Nur dokumentieren was belegbar ist.** Wenn eine Angabe in mehreren historischen Lieferungen auftaucht → Standard. Wenn nur einmal → als „mutmaßlich“ markieren, nicht als Regel.
4. **Bei Widersprüchen zwischen alten Lieferungen:** die **jüngste** Lieferung gewinnt — außer sie ist erkennbar ein Ausreißer. In dem Fall Regel dokumentieren + Hinweis, dass hier Unsicherheit besteht.
5. **Jede abgeleitete Regel bekommt einen Beleg.** Format: `(Quelle: Projekt XY, Jahr 2019, Datei `Zeichnung_001.pdf`)`. Kein Feld ohne Rückverweis.
6. **Änderungen des Profils werden versioniert.** Unten in der Datei ein Changelog führen, damit Reiner und Mo nachvollziehen können warum sich was wann geändert hat.
7. **Das Profil wird mit dem Pilot-Projekt validiert.** Erst wenn der Lagerschalenhalter erfolgreich abgenommen ist, ist das Profil bestätigt. Bis dahin Status: `in-aufbau`.

---

## Changelog

| Datum | Änderung | Quelle |
|---|---|---|
| 2026-04-17 | Template angelegt, 10 Profil-Sektionen mit Platzhaltern, Arbeitsregeln formuliert | Session mit Mo |
| 2026-04-17 | Pre-Delivery Kontext-Check ergänzt (Toleranzen, Passungen, Kantenbearbeitung, Nachbearbeitung, Prüfdokumente). Vision der halbautomatischen Lieferung dokumentiert (3D-Modell → Kontext-Check → Ableitung → Erzeugung → Freigabe → direkte Lieferung) | Session mit Mo |
| 2026-04-20 | Feldname „STEP-Schema" → „3D-Format" korrigiert (Widerspruch mit IGES-Inhalt). 700er-Kaufteile-Systematik ergänzt, belegt aus `BOM_bereinigt.xlsx`. | Claude Code |

---

## Verknüpfungen

- [[04 Ressourcen/Methodik - Kundenprofile aus Historie]] — allgemeine Methodik, gilt für alle Kundenprofile
- [[00 Kontext/WEC Kontakte/Volker Bens]]
- [[02 Projekte/WEC Neustart mit Reiner/Sachsenmilch Käsekarussell]]
- [[02 Projekte/WEC Neustart mit Reiner/Mail Reiner - Lagerschalenhalter Überarbeitung]]
- [[Volker Bens - Lagerschalenhalter Lebensmittelindustrie]]
- [[01 Inbox/Vision - Automatisierte Konstruktions-Pipeline]]

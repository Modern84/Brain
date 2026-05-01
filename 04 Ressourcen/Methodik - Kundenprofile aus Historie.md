---
tags: [ressource, methodik, wec, mthreed, kunden]
status: aktiv
date: 2026-04-17
---

# Methodik — Kundenprofile aus Historie ableiten

Verbindliche Vorgehensweise, wie bei WEC / MThreeD.io **Kundenprofile** aufgebaut werden.

## Grundprinzip — Beobachten statt fragen

Kunden werden **nicht** mit Format-, Layout- oder Systemfragen belastet. Stattdessen wird das Kundenprofil **aus der dokumentierten Historie** abgeleitet: Was über Jahre als Lieferung akzeptiert wurde, ist der gültige Standard für diesen Kunden.

**Warum so:**

- **Professionalität.** Ein etabliertes Ingenieurbüro fragt nicht bei jedem neuen Auftrag „welches STEP-Schema hätten Sie denn gerne?" — es kennt den Kunden und liefert im vertrauten Format. Wer fragt, signalisiert Unerfahrenheit.
- **Unbelasteter Kunde.** Volker, Knauf und andere wollen ihr Ergebnis, nicht Prozessarbeit. Jede Frage die wir intern klären können, ist eine Frage die sie nicht beantworten müssen.
- **Wiederholbarkeit.** Ein einmal abgeleitetes Profil gilt für alle künftigen Lieferungen an denselben Kunden und schafft Planbarkeit auf beiden Seiten.
- **Automatisierungs-Grundlage.** Die MThreeD.io-Pipeline (CAD → Zeichnung → BOM → PDF → Lieferung) kann pro Kunde exakt parametriert werden, sobald das Profil steht. Ohne Profil keine saubere Automatisierung.

## Profil-Aufbau — verbindliche Regeln

1. **Historische Lieferungen sind die Datenbasis.** Mindestens 3 repräsentative Beispiele aus unterschiedlichen Jahren und Komplexitätsstufen (Einzelteil, Baugruppe, Komplett-Anlage), soweit vorhanden.

2. **PDF-Zeichnungen sind die Hauptquelle.** Sie zeigen Schriftfeld, Bemessungsstil, Symbole, Normen-Referenzen und Oberflächenangaben auf einen Blick. 3D-Dateien liefern technische Metadaten (Schema, Einheiten), BOMs liefern Spaltenlogik und Werkstoffbezeichnung.

3. **Nur dokumentieren was belegbar ist.** Wenn eine Angabe in mehreren Lieferungen auftaucht → Standard. Wenn nur einmal → als „mutmaßlich" markieren, nicht als Regel.

4. **Bei Widersprüchen:** die **jüngste** Lieferung gewinnt — außer sie ist erkennbar ein Ausreißer. In dem Fall Regel dokumentieren + Hinweis auf Unsicherheit.

5. **Jede Regel bekommt einen Beleg.** Format: `(Quelle: Projekt XY, Jahr 2019, Datei Zeichnung_001.pdf)`. Kein Feld ohne Rückverweis.

6. **Änderungen werden versioniert.** Jedes Profil führt ein eigenes Changelog.

7. **Validierung durch Pilot-Projekt.** Erst wenn eine nach dem Profil gefertigte Lieferung vom Kunden angenommen wurde, ist das Profil bestätigt. Bis dahin Status: `in-aufbau`.

## Profil-Struktur — Mindest-Sektionen

Jedes Kundenprofil deckt diese zehn Bereiche ab:

1. 3D-Daten (Format, Schema, Versionierung, Ordnerstruktur)
2. 2D-Zeichnungen (Format, Papiergröße, Schriftfeld, Bemaßung, Toleranzen)
3. Stückliste (Format, Spalten, Nummerierung, Werkstoffangabe, Normteil-Benennung)
4. Oberflächenbeschaffenheit (Standard, Dokumentationsort, Symbole)
5. Symbole & Zeichensprache (Schweißen, Toleranzen, Projektion, Schnitte)
6. Normen-Referenzen (Werkstoff, Branche, Allgemeintoleranzen, Zeichnungsnormung)
7. Zeichnungsnummern-Systematik (Aufbau, Präfixe, Konsistenz)
8. Dateinamen-Konvention (Muster, erlaubte Sonderzeichen, Längenlimit)
9. Lieferpaket-Struktur (Ordner, Archivformat, Begleitdokument)
10. Kommunikations-Standard (Kanal, Ansprechpartner, Review-Prozess)

---

## Pre-Delivery Kontext-Check — projektspezifische Ergänzungen

Das Kundenprofil gibt den **Rahmen** vor. Aber bei jedem einzelnen Projekt gibt es Feinheiten, die das Profil nicht auf Dauer festlegen kann, weil sie von Bauteil zu Bauteil variieren. Diese Punkte werden **vor** der Zeichnungserzeugung kurz zwischen Sebastian (oder Reiner) und Claude abgestimmt und stichpunktartig als Projekt-Kontext festgehalten.

Typische Kandidaten für den Kontext-Check:

- **Allgemeintoleranzen** für dieses Projekt (z.B. ISO 2768-m vs. -f; in Einzelfällen strenger bei kritischen Passflächen)
- **Konkrete Passungen** (z.B. H7/g6 für Lagersitze, H8/f7 für Gleitführungen) — Bauteil-abhängig
- **Kantenbearbeitung** (Entgraten, gebrochen 0,5×45°, kanten gerundet, scharfkantig verboten bei Lebensmittelkontakt)
- **Oberflächen-Abweichungen vom Standard** (wenn Profil Ra ≤ 0,8 µm sagt, aber Bauteil lokal Ra ≤ 0,4 µm oder poliert braucht)
- **Sonder-Schweißnahtvorgaben** (WIG durchgeschweißt, bei Lebensmittel bündig verschliffen)
- **Wärmebehandlung, Beschichtung, Nachbearbeitung** (Beizen, Passivieren, Elektropolieren)
- **Hinweise zur Montage** (Drehmomentvorgaben, Klebstoffe, Dichtmittel)
- **Prüfdokumente** (3.1-Abnahme, Röntgen, FPI?)

**Wie der Check abläuft:**

1. Sebastian/Reiner bringen das 3D-Modell mit (plus Absicht und Funktion des Bauteils).
2. Claude fragt **gezielt** die Kontext-Check-Punkte ab — nicht als Fragebogen, sondern als strukturiertes Kurzgespräch.
3. Das Ergebnis wird stichpunktartig notiert: entweder im jeweiligen Projekt-Dokument oder als `Kontext-<Projektname>.md`.
4. Dieser Kontext + das Kundenprofil sind gemeinsam die Grundlage für die Zeichnungserzeugung.

**Fundamentale Regel:** Kein 2D-Dokument verlässt das System ohne vorher geklärten Projekt-Kontext. Alles was nicht geklärt ist, wird vor der Ausgabe sichtbar gemacht („offen geblieben: Passung Lagersitz → Rückfrage an Reiner").

---

## Vision — Halbautomatische Lieferung

Die Methodik ist auf folgende Arbeitsweise ausgelegt, die sich mit wachsender Profil-Abdeckung und trainiertem Kontext-Check immer weiter automatisiert:

### Schritt 1 — Eingang: 3D-Modell + Absicht
Sebastian oder Reiner liefern das 3D-Modell (Fusion, SolidWorks, STEP) und geben dazu die **Absicht** an: Was macht das Bauteil, wo sitzt es, welcher Kunde, welcher Anwendungsbereich.

### Schritt 2 — Kontext-Check
Claude führt den Pre-Delivery-Kontext-Check durch (siehe oben). Kurze Abstimmung — strukturierte Stichpunkte.

### Schritt 3 — Ableitung aus Profil + Kontext
Claude zieht das Kundenprofil heran (Schriftfeld, Bemaßungsstil, Normen, Stücklistenlogik) und kombiniert es mit den projektspezifischen Kontext-Stichpunkten.

### Schritt 4 — Erzeugung der Liefer-Artefakte
Claude bzw. die MThreeD.io-Pipeline erzeugt:
- 2D-Zeichnungen (pro Einzelteil + Zusammenbau) mit korrektem Schriftfeld, Bemaßung, Toleranzangaben, Oberflächenangaben, Kantenhinweisen
- Stückliste nach Kunden-Format
- 3D-Export im richtigen Schema für diesen Kunden
- Lieferpaket-Struktur nach Kunden-Konvention
- Begleitdokument (Mail, Lieferschein)

### Schritt 5 — Prüfung
Sebastian oder Reiner sichten die erzeugten Artefakte. Profil-Regelverstöße werden sichtbar gemacht („dieses Feld fehlt", „dieser Wert weicht ab"). Nach Freigabe geht es raus.

### Schritt 6 — Direkte Lieferung
Idealerweise wird das fertige Paket **direkt an den Kunden geschickt** — per Mail im Kunden-Tonfall oder als Cloud-Link.

### Reifegrad
- **Heute:** Alles manuell, Claude unterstützt bei Recherche und Dokumentation.
- **Mittelfristig (mit erstem fertigen Profil):** Claude erzeugt Entwürfe der Artefakte, Sebastian/Reiner prüfen und geben frei.
- **Langfristig (mehrere Profile + Pipeline-Integration):** Kompletter Durchlauf halbautomatisch, Mensch nur noch bei Kontext-Check und Freigabe beteiligt.

---

## Speicherort

- Alle Kundenprofile liegen in `04 Ressourcen/` mit der Benennung: `CAD-Datenuebergabe Standard - <Kundenname>.md`
- Kontextbezogene Kundendaten (Personen, Firma, Historie) bleiben in `00 Kontext/WEC Kontakte/<Kundenname>.md`
- Beide Dateien verknüpfen sich gegenseitig

## Aktuelle Kundenprofile

- [[04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl]] — in-aufbau (Pilot: Lagerschalenhalter)
- Knauf — geplant, sobald Erstauftrag
- Sachsenmilch direkt — geplant, falls Direktbeziehung entsteht

## Verknüpfungen

- [[CLAUDE]] — Vault-Grundregeln (Abschnitt „Auftreten nach außen")
- [[Business MThreeD.io|MThreeD.io]]
- [[03 Bereiche/WEC/WEC Vision - Automatisierte Pipeline]]

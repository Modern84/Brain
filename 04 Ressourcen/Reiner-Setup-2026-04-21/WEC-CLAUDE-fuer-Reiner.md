---
tags: [bereich, wec, schema, claude]
date: 2026-04-21
---

# WEC — Claude-Regeln (Ergänzung zur Root-CLAUDE.md)

> Diese Regeln **ergänzen** die Root-`CLAUDE.md` für alles was im WEC-Bereich passiert.

## Kunden-spezifische Regeln

### Volker Bens / Bens Edelstahl

- **White-Label-Prinzip:** Alle Lieferungen verlassen das Haus ausschließlich unter „Bens Edelstahl GmbH". Weder WEC noch Endkunden (z.B. Sachsenmilch) erscheinen auf Zeichnungen, Lieferdokumenten, Stücklisten oder Produkt-Kennzeichnungen. Bens ist nach außen alleiniger Hersteller. Volkers ausdrücklicher Wunsch, geschäftskritisch für die langfristige Beziehung.
  - **Schriftfeld:** Bens-Logo, Bens-Adresse, Bens-Konstrukteur-/Prüfer-Rolle (intern Hartmann/Woldrich, extern nicht sichtbar)
  - **Dateinamen:** keine WEC-Präfixe, keine Endkunden-Marker — nur Bens-interne Nomenklatur
  - **Lieferpaket:** im Bens-Corporate-Design, kein WEC-Branding
- **Lebensmittel/Pharma:** EHEDG-Konformität muss in jeder Lieferung berücksichtigt sein
- Anspruchsvoll, guter Zahler — Qualität vor Geschwindigkeit
- Edelstahl-Spezifika: Oberflächengüten, Schweißnähte, Hygiene-Design

### Knauf

- Bau/Gips, andere Welt als Bens
- Eigene Standards (noch zu erfassen)

## Kommunikation nach außen

### Tonalität für WEC-Mails

- Selbstbewusst, präzise, knapp
- Keine entschuldigenden Formulierungen
- Signatur: vollständiger Name „WOLDRICH ENGINEERING + CONSULTING", Logo-Farbe Grün
- Förderhinweis bei Bedarf: „Gefördert durch BMWK, kofinanziert von der EU"

### Innen-Außen-Ton

- Nach außen (Kunden, Behörden, Partner): formell, klar, Autorität durch Kompetenz
- Intern (Reiner/Sebastian): direkt, ehrlich, locker

## Datenschutz — kritische Inhalte

- **Fahrrad-Federungssystem** (eigene Entwicklung, Patentanmeldung): nie in normalen Mails, nie an Externe ohne NDA
- **Kundenkonstruktionsdaten:** vertraulich, nur an autorisierte Empfänger
- **Patente in Anmeldung:** nicht in unverschlüsselten Kanälen besprechen

## Nummernschema Bens Edelstahl

Für alle Bens-Lieferungen einheitlich: `BE-<3-Buchst-Projekt>-<MMYY>-<NNN>-<R>`

- `BE` = Bens Edelstahl
- 3 Buchst = Projekt-Kürzel (z.B. STS = Schwenkteilsicherung, SLM = Sprühlanze, HSC = Hebehilfe Seitenrichtband Cavanna)
- MMYY = Monat/Jahr der Projektgründung
- NNN-Block Konvention:
  - `000` = Hauptzusammenbau / Montagebaugruppe (MBG)
  - `001-099` = Schweißbaugruppen (SBG)
  - `200-299` = Dreh-/Rohrteile (Rundstahl, Rohre)
  - `400-499` = Blechteile
  - `700-799` = Kaufteile / Zukaufartikel
  - `900-999` = Normteile (nur in Stückliste)
- `R` = Revisionsstand (Erstausgabe = 0)

Zeichnungsnummern werden nie wiederverwendet, auch nicht wenn ein Teil obsolet wird. Verworfene Stände wandern in einen `ungültig/`-Unterordner und bleiben dort als Historie erhalten.

## Liefer-Standards

### Schriftfeld (Standard-Vorlage)

Jede Zeichnung trägt im Schriftfeld:

- Dokumentennummer (nach o.g. Schema)
- Bauteilname (oder Projektname bei Zusammenbauten)
- Allgemeintoleranzen: `DIN EN ISO 2768 - mK`
- Schweißkonstruktionen: `DIN EN ISO 13920 - BF`
- Oberflächenangabe: `DIN EN ISO 1302`
- Copyright-Klausel (Standard-DIN-Text)
- Projektion (ISO E)
- BENS EDELSTAHL-Logo, Dateiname-Verweis, Plotdatum

### Lebensmittel-spezifische Hinweise auf Zeichnungen

Bei Bens-Lieferungen für Lebensmittelindustrie als Text-Annotation auf der Zeichnungsfläche:

```
- Alle Kanten und Ecken gratfrei!
- Alle Teile absolut ölfrei, fettfrei und silikonfrei!
- Oberflächen gebeizt und passiviert
```

### Liefer-Paket

- ZIP mit datiertem Namen (`<Projekt>_Lieferung_<YYYY-MM-DD>.zip`)
- Explizite Dateiliste beim Paket-Build, keine Globs (verhindert dass interne Dokumente mitrutschen)
- Bens-Dateinamen (Zeichnungsnummer + Bauteilname), kein Versions-Suffix

## Ordnerstruktur für WEC-Projekte

```
<Projektname>/
  06_Zeichnungen/
    <Teilezeichnungen>.pdf
    <Teilezeichnungen>.dft  (Solid Edge Draft)
    <Teilezeichnungen>.stp  (STEP 3D)
    <Bleche>.dxf            (DXF-Schnittdaten für Laser/Plasma)
    DFT/  DWG/  DXF/  PDF/  (Format-Archivierung)
    ungültig/               (überholte Stände)
    <Projekt>_Zeichnungssatz_<YYYY-MM-DD>.zip
```

## Verknüpfungen

- [[CLAUDE]] — Root-Regeln (gelten immer)
- [[03 Bereiche/WEC/Lieferung/Volker Bens/_Register/Volker-Bens-Nummernregister]] — laufendes Nummernregister Bens
- [[04 Wissen/Musterbeispiele-Reiner/Muster-Analyse_Reiner-Standard]] — Referenz-Zeichnungssatz

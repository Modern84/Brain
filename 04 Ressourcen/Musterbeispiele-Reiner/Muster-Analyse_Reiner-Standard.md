---
typ: muster-analyse
quelle: USB-Stick Reiner (INTENSO), 21.04.2026
projekte: Hebehilfe Cavanna, Schwenkteilsicherung, Sprühlanze
zweck: Vorlage für v5/v4-Weiterentwicklung und Projekt-Setup-Standard
---

# Muster-Analyse — Reiners Standard-Zeichnungssatz

Stand: 2026-04-21. Quelle: `04 Ressourcen/Musterbeispiele-Reiner/`. Drei eingescannte Projekte (Hebehilfe Cavanna / April 2025, Sprühlanze / Januar 2025, Schwenkteilsicherung / Januar–Februar 2026).

## Zentraler Befund

**Reiners eigenes Schriftfeld-Template enthält bereits alles, was unser v4-Patcher nachträglich aufklebt** — und deutlich mehr. Info-Block, Allgemeintoleranzen, Oberflächenangabe, Copyright-Klausel, Projektion, Logo, Dokumentennummer, Dateiname-Referenz — alles in einem konsistenten Schriftfeld, kein Overlay, keine Notbehelfe. v4 ist ein Workaround für Fusion-Exports, die diese Infrastruktur nicht haben.

Die beiden Patcher treffen also auf zwei verschiedene Welten:
- **Fusion 360 (Sebastian):** rudimentäres Schriftfeld, v4+v5 gleichen das nach
- **Solid Edge (Reiner):** vollständiges Schriftfeld, keine Nachbearbeitung nötig

Langfristig gibt's zwei Wege — beide tragfähig, nur bewusst wählen (siehe „Richtungsfrage" am Ende).

## Nummernschema bei Reiner

Format: `BE-<3-Buchst-Projektkürzel>-<MMYY>-<NNN>-<R>_<Teilname>.<ext>`

Beispiele:
- `BE-HSC-0425-000-0_Hebevorrichtung-Seitenrichtband_kpl.pdf` — Hebehilfe (HSC), April 2025
- `BE-STS-0126-200-0_Welle Kupplung.pdf` — Schwenkteilsicherung (STS), Januar 2026
- `BE-SLM-0125-005-0_Sprührohr-SBG.pdf` — Sprühlanze (SLM), Januar 2025

Zahlen-Konvention im NNN-Block (am Sprühlanzen-Projekt am klarsten ablesbar):
- `000` = Hauptzusammenbau / Montagebaugruppe (MBG)
- `001` bis `099` = Schweißbaugruppen (SBG)
- `200` bis `299` = Dreh- und Drehteile (Rohre, Rundstahl)
- `400` bis `499` = Blechteile
- `700` bis `799` = Kaufteile / Zukaufartikel
- `900` bis `999` = Normteile (erscheinen nur in der Stückliste)

**Unterschied zum Volker-Bens-Projekt:** Wir nutzen dort `BE-LS-202603-XYZ-R` mit 2-Buchstaben-Kürzel und 6-stelliger Projekt-ID. Das ist eine historisch gewachsene Abweichung. Der Reiner-Standard ist systematischer. Für Folgeprojekte übernehmen.

## Schriftfeld-Bestandteile (Reiner-Standard)

Nach A2-Zusammenbau und A3-Einzelteil analysiert — beide Formate tragen dasselbe Schriftfeld-Layout, nur die Größe unterscheidet.

**Obere Zeile (klein):** Rev.-Nr. · Bearbeiter · Revisionsbeschreibung · Revisionsdatum

**Allgemeintoleranzen-Feld (Block links im Schriftfeld):**
- Überschrift: „Allgemeintoleranzen:"
- Längen und Winkelmaße / Form und Lage: `DIN EN ISO 2768 - mK`
- Schweißkonstruktionen: `DIN EN ISO 13920 - BF`
- Oberflächenangabe nach: `DIN EN ISO 1302`

**Projektion-Feld:** Symbol für Projektionsmethode (zwei konzentrische Kreise mit Linie = ISO E / Europäisch)

**Copyright-Text (vollständig, fester Wortlaut):**
> Weitergabe sowie Vervielfältigung dieser Unterlage, Verwertung und Mitteilung ihres Inhalts sind nicht gestattet, sowie nicht ausdrücklich zugestanden. Zuwiderhandlungen verpflichten zu Schadenersatz. Alle Rechte für den Fall der Patenterteilung oder Gebrauchsmuster-Eintragung vorbehalten.

**Standardfelder rechts:** Maßstab · Masse · Halbzeug · Material · Datum · Name · Bearb. · Gepr. · Norm

**Großes Titelfeld rechts unten (prominent):**
- Zeichnungsinhalt (= Bauteilname), fett und groß
- Darunter der Projektname (kleiner)

**Dokumentennummer (!):** Reiner nutzt das Label **„Dokumentennummer:"** — nicht „Zeichnungsnummer:" wie Fusion. In der Volker-Bens-Lieferung haben wir das Fusion-Label belassen; bei künftigen Reiner-Projekten dieses Label übernehmen.

**Logo-Position:** BENS EDELSTAHL mittig-unten im Schriftfeld, mit gesperrt geschriebener Tagline „E D E L S T A H L".

**Dateiname + Plotdatum** in der untersten Zeile als Metadaten-Referenz: `Dateiname: BE-STS-0126-200-0_Welle Kupplung.dft · Plotdatum: 25.02.2026`

**Halbzeug-/Material-Tabelle (bei Einzelteilen, rechts über dem Schriftfeld):** Kompakte 3-Spalten-Tabelle mit *Abmessung / dimension · Material / material* (zweisprachig DE/EN). Beispiel: `RD 30 | 172 | 1.4404`.

## Notizen auf der Zeichnung (Lebensmittel-Kontext, frei platziert)

Steht nicht im Schriftfeld, sondern als Textblock auf der Zeichnungsfläche (typisch oben rechts oder unterhalb einer Ansicht):

```
- Alle Kanten und Ecken gratfrei!
- Alle Teile absolut ölfrei, fettfrei und silikonfrei!
- Oberflächen gebeizt und passiviert
```

Das ist Reiners Äquivalent zum EHEDG-Info-Block — aber flexibel platziert statt als fester Rahmen. Bei Anwendungen außerhalb Lebensmittel (z.B. Schwenkteilsicherung) taucht er trotzdem auf, weil Edelstahl-Teile allgemein so ausgeliefert werden.

## Oberflächen-Legende (Einzelteil-spezifisch)

Jede Einzelteil-Zeichnung hat rechts oben eine Oberflächen-Legende mit Symbolen nach DIN ISO 1302 und Rz-Werten (100, 25, 6,3, 1), verknüpft mit DIN 3141 Reihe 2. Fertigungsrelevante Referenz — vereinfacht die Bauteilbeschriftung.

## Stücklisten-Spalten (Reiner-Standard)

Reihenfolge wie auf dem ZSB-Schwenkteilsicherung zu sehen:

| Pos. | Stück | Benennung | Zeichn.-Nr. | Halbzeug | Breite | Länge | Material | Bemerkung | Hersteller | Masse |

Zum Vergleich: Fusion-Export im Volker-Bens-Projekt liefert nur *Element, Anz., Bauteilnummer, Bauteilname, Beschreibung, Material, Masse* — deutlich dünner. Wer Halbzeug-Abmessungen sauber in der Stückliste will, muss das bei Fusion entweder als Teileigenschaft pflegen oder nachträglich aus der Teileliste ergänzen.

Spezialfall bei Normteilen: **Art.-Nr.-Feld** mit Hersteller-Artikelnummer, z.B. `Art.-Nr.: 9020002148`. Das haben wir bei Volker Bens für Mädler-SKF-Teile ebenfalls ergänzt, dort aber im Bemerkungs-Feld statt in einer eigenen Spalte.

## Projekt-Ordner-Struktur

Alle drei Projekte folgen derselben Phase-Nummerierung:

```
<Projektname>/
  06_Zeichnungen/
    <hauptzeichnung>.dft     # Solid Edge Draft
    <hauptzeichnung>.pdf     # PDF-Export
    <hauptzeichnung>.stp     # STEP 3D-Geometrie
    <einzelteil_001>.dft
    <einzelteil_001>.pdf
    ...
    <blech_400>.dxf          # DXF-Schnittdaten für Laser/Plasma
    ...
    DFT/  DWG/  DXF/  PDF/   # Format-basierte Archivierung
    ungültig/                # verworfene/überholte Stände
    <Projekt>_Zeichnungssatz_<Datum>.zip  # Paket-Version
```

Das `06_` legt eine Gesamt-Projektphasen-Nummerierung nahe (01_Anfrage, 02_Konzept, 03_Berechnung, 04_Konstruktion, 05_Produktdesign, 06_Zeichnungen, …). Typisch für Ingenieurbüros mit systematischer Aktenführung.

**`ungültig/` als „verbrannt"-Konzept:** Reiner verschiebt überholte Stände physisch in einen Unterordner, statt sie zu löschen. Entspricht unserer Keine-Recycling-Regel im Nummernregister, aber dateisystem-nativ. Beispiele aus Schwenkteilsicherung/ungültig: `BE-STS-0126-001-0.dft`, `BE-STS-0126-201-0_Abdeckung Kupplung----.dft` (der 4-Strich-Suffix scheint auch Reiners Markierung für „überholt" zu sein).

## Übertragbare Elemente für unser Pipeline-Setup

### Sofort einbaubar in v5-Mapping (für Reiner-PDFs, falls mal nötig)

Neue Anchor-Tokens die in Reiners Template garantiert enthalten sind — für zuverlässige Regel-Treffer:
- `Dokumentennummer:` — als `context_before` für die Zeichnungsnummer
- `Dateiname:` — als Anchor für Dateiname-Verweise (könnte gepatcht werden wenn sich Dateiname ändert)
- `Zeichnungsinhalt:` — als `context_before` für den Bauteilnamen
- `Allgemeintoleranzen:` — Marker für den Norm-Block

### Sofort einbaubar in v4-Info-Block

Neue Info-Block-Variante **„Reiner-kompatibel"** mit identischem Wortlaut zu seinem Template (falls wir Fusion-Exports an Reiner-Standard angleichen wollen ohne Fusion-Template umzubauen):

```
Allgemeintoleranzen:
Längen und Winkelmaße / Form und Lage: DIN EN ISO 2768 - mK
Schweißkonstruktionen: DIN EN ISO 13920 - BF
Oberflächenangabe nach: DIN EN ISO 1302
```

Plus optional einen zweiten Info-Block mit den Lebensmittel-Notizen (Kanten gratfrei / ölfrei / gebeizt) — frei auf der Zeichnung platziert, nicht im Schriftfeld-Bereich.

### Für neue Kunden-Projekte (Nummern-Schema)

Ab jetzt Reiners Schema übernehmen:

```
BE-<3-Buchst>-<MMYY>-<NNN>-<R>
```

Kürzel-Konvention ggf. mit Reiner abstimmen (er vergibt die wahrscheinlich intuitiv — bei Sprühlanze = SLM statt SLZ, bei Hebehilfe = HSC mit „Seitenrichtband Cavanna" Bezug).

### Für den Vault

Projekt-Ordner-Struktur für WEC-Kunden einheitlich anlegen:
```
03 Bereiche/WEC/Lieferung/<Kunde>/<Projekt>/
  06_Zeichnungen/
    DFT/  DWG/  DXF/  PDF/
    ungültig/
    <Projekt>_Zeichnungssatz_<YYYY-MM-DD>.zip
```

Die Montag-Session-Struktur vom Volker-Bens-Projekt war eher eine Arbeits-Session-Ablage. Für Liefer-Zustand gehört der „saubere" Stand ins `06_Zeichnungen/` des Projekts.

## Richtungsfrage (für Mo-Entscheidung)

Zwei Wege für die nächsten Projekte:

**A) Fusion-Ausgabe weiter mit v4/v5 nachbearbeiten.** Status quo. Pipeline ist jetzt erprobt (Volker-Bens-Lieferung heute), v4 ist format-aware, v5 hat den words-Resolver. Aufwand pro Projekt: moderat, weil Mapping angepasst werden muss aber die Scripts stabil sind.

**B) Fusion-Vorlage auf Reiner-Standard umbauen.** Einmaliger Aufwand in Fusion: Titelblock-Template bauen, das Reiners Layout 1:1 spiegelt (inkl. Allgemeintoleranzen-Block, Copyright, Dokumentennummer-Feld, Logo-Position, zweisprachige Halbzeug-Tabelle). Danach entfällt v4 fast vollständig, v5 bleibt nur noch für White-Label-Fixes und Werkstoff-Tippfehler. Folgeprojekte gehen dann deutlich schneller.

**C) Reiners Projekte direkt mit Solid Edge liefern lassen, nur Sebastians eigene Projekte durch die Pipeline.** Wenn es organisatorisch klar ist wer welches Projekt konstruiert, braucht die Pipeline Reiner gar nicht zu berühren.

Keine davon ist „richtig" ohne zu wissen wie die Rollenverteilung zwischen Sebastian (Fusion) und Reiner (Solid Edge) künftig aussieht — und ob die Lieferungen aus *einer Feder* aussehen müssen oder zwei Stile nebeneinander ok sind.

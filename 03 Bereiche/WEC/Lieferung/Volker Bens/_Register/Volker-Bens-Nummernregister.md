---
typ: nummernregister
kunde: Volker Bens (Bens Edelstahl GmbH)
schema: BE-LS-202603-XYZ-R
stand: 2026-04-21 abends
regel: keine-wiederverwendung
verantwortlich: Mo (Freigabe) / Reiner (fachliche Schema-Definition)
reiner-projektname: Drehmechanik Cavanna (interne WEC-Bezeichnung)
fertiger: Tomasz KM Metalworks PL (tomasz@kmmetalworks.pl) — arbeitet primär mit STEP-Dateien
---

# Nummernregister Volker Bens

**Schema:** `BE-LS-202603-XYZ-R`

- `BE` — Bens Edelstahl
- `LS` — Lagerschalenhalter (Projektfamilie)
- `202603` — Projekt-/Datumsbezug
- `X` — **Scope**
  - `0` = gemeinsam (in beiden Varianten identisch verbaut)
  - `1` = Variante V1 spezifisch
  - `2` = Variante V2 spezifisch
  - `7` = Kaufteile (Norm-/Katalogteile, ebenfalls gemeinsam)
- `Y` — **Hierarchie-Ebene** (aufsteigend nach Aggregationsgrad)
  - `1` = Einzelteil
  - `5` = Schweißgruppe
  - `9` = Zusammenbau
- `Z` — laufende Nummer innerhalb der (X,Y)-Gruppe (ab 1)
- `R` — Revisionsstand (Erstausgabe = `0`)

**Grundregel (mThreeD.io, 21.04.2026):** Zeichnungsnummern werden NIE wiederverwendet, auch nicht wenn ein Teil obsolet wird. Verbrannte Nummern unten bleiben dauerhaft gesperrt.

**Begründung Schema-Wechsel (vs. Umsetzungs-Tabelle_Reiner_v5):** Reiners ursprünglicher v5-Vorschlag hatte zwei Regel-Verletzungen: (a) `-200-0` sollte sowohl verbranntes Lagerhalter-Einzelteil als auch neuer Zusammenbau V2 sein; (b) mehrere Ziel-Nummern (`-201-0`, `-202-0`) hätten ebenfalls BOM-Altnummern recycelt. Neues Schema weicht auf `Y`-getrennte Ebenen (1/5/9) aus, damit alle Zielnummern garantiert frisch sind. Hierarchie-Lesbarkeit wird dadurch sogar besser: ein Blick auf `Y` sagt Einzelteil / Schweißgruppe / Zusammenbau.

---

## Aktiv — Einzelteile gemeinsam (X=0, Y=1)

| Nummer | Bauteil | Liefer-PDF | Anmerkung |
|---|---|---|---|
| `BE-LS-202603-011-0` | Scheibe t=1 | `Scheibe_t=1 Zeichnung.pdf` | Blech 1, Edelstahl 1.4404 |
| `BE-LS-202603-012-0` | Lagerhalter | `Lagerhalter Zeichnung.pdf` | Blech 10, Edelstahl 1.4404. In beiden Varianten identisch (je 2× im Zusammenbau, in Schweißgruppe) |
| `BE-LS-202603-013-0` | Lagerschale | `Lagerschale Zeichnung.pdf` | Rundstahl, Edelstahl 1.4404. Identisch in V1 und V2 |
| `BE-LS-202603-014-0` | Steg_Lagerschalenhalter | *keine eigenständige PDF im Staging* | BOM-Pos 3, Blech 5, Edelstahl 1.4404, Menge 2. Beim 1. v5-Run klären, ob eigene Zeichnung benötigt oder nur Stücklisten-Eintrag |

## Aktiv — Variante V1 (X=1)

| Nummer | Bauteil | Ebene | Liefer-PDF | Anmerkung |
|---|---|---|---|---|
| `BE-LS-202603-111-0` | Einzelteil Welle V1 (kurz, ohne Scheibe) | Einzelteil (Y=1) | `Welle_V1 Einzelteil Zeichnung.pdf` | Rundstahl, Edelstahl 1.4404. **Neu in v4 (21.04. abends):** aus Fusion/Onshape separat exportiert nach Umbenennung der Zeichnung, um die Namens-Kollision mit der Baugruppe aufzulösen |
| `BE-LS-202603-112-0` | Scheibe (5 mm Blech, für Welle-Baugruppen) | Einzelteil (Y=1) | `Scheibe_t=3 Zeichnung.pdf` | Gemeinsam für V1- und V2-Baugruppe. Dateiname veraltet: ursprünglich Scheibe_t=3, im Laufe der Projekt-Iterationen auf 5 mm Blech geändert. Teil gehört zu beiden Welle-Baugruppen (`-152-0` und `-252-0`). Entscheidung Mo 21.04. nachmittags |
| `BE-LS-202603-151-0` | Schweißgruppe_Halter V1 | Schweißgruppe (Y=5) | `Schweißgruppe_Halter Zeichnung.pdf` | Enthält `-012-0` + `-013-0` je 1×; Fertigungshinweis: *nach Schweißen planschleifen* |
| `BE-LS-202603-152-0` | Baugruppe Welle V1 (Welle + Scheibe) | Baugruppe (Y=5) | `Welle_V1 Baugruppe Zeichnung.pdf` | **Aus Fusion/Onshape Baugruppen-Ordner exportiert (v4).** Enthält `-111-0` + `-112-0`. Diese Zeichnung war vor v4 unter dem Namen `Welle_V1 Zeichnung.pdf` geführt — durch Namens-Kollision mit dem Einzelteil gleichen Namens hatte der Export nur eine der beiden Versionen erfasst. Ab v4 eindeutige Benennung in Fusion |
| `BE-LS-202603-191-0` | Zusammenbau V1 | Zusammenbau (Y=9) | *noch nicht als V1-only-PDF vorhanden* | Höchste Ebene V1. Stückliste: 2× `-151-0`, 1× `-152-0` (Baugruppe), 1× `-011-0`, 2× `-014-0`, Kauf- und Normteile. **Fusion-TODO**, nur falls Volker den V1-Zusammenbau auch benötigt |

## Aktiv — Variante V2 (X=2)

| Nummer | Bauteil | Ebene | Liefer-PDF | Anmerkung |
|---|---|---|---|---|
| `BE-LS-202603-211-0` | Einzelteil Welle V2 (lang, ohne Scheibe) | Einzelteil (Y=1) | `Welle_V2 Einzelteil Zeichnung.pdf` | Rundstahl. Historisch durch mehrere Zwischennummern gegangen (`-203`, `-206`, `-207-0`) — Altnummern verbrannt |
| ~~`BE-LS-202603-212-0`~~ | — | — | — | Entfällt — keine V2-spezifische Scheibe, gemeinsame Scheibe `-112-0` für beide Baugruppen. Nummer bleibt frei |
| `BE-LS-202603-251-0` | Schweißgruppe_Halter V2 | Schweißgruppe (Y=5) | *noch nicht existent* | Inhalt analog V1: je 1× `-012-0` + 1× `-013-0`. Zusammenbau V2 referenziert diese Nummer bereits. **Fusion-TODO** |
| `BE-LS-202603-252-0` | Baugruppe Welle V2 (Welle + Scheibe) | Baugruppe (Y=5) | `Welle_V2 Baugruppe Zeichnung.pdf` | **Neu in v4 (21.04. abends):** aus Fusion/Onshape Baugruppen-Ordner exportiert, analog zu `-152-0`. Enthält `-211-0` + `-112-0`. Zusammenbau V2 referenziert diese Nummer bereits |
| `BE-LS-202603-291-0` | Zusammenbau V2 | Zusammenbau (Y=9) | `Zusammenbau_Lagerschalehalter Zeichnung.pdf` *(kurze Variante, V2-only)* | Höchste Ebene V2. Stückliste: 2× `-251-0`, 1× `-252-0` (Baugruppe, NICHT Einzelteil), 1× `-011-0`, 2× `-014-0`, Kauf- und Normteile |

## Aktiv — Kaufteile (X=7)

| Nummer | Bauteil | Quelle |
|---|---|---|
| `BE-LS-202603-701-0` | Lager SKF Pendelkugellager 2202 E-2RS1TN9 | Mädler Art. 64773026 (2× im Zusammenbau) |
| `BE-LS-202603-702-0` | Klemmring Edelstahl 1.4305 Bohrung 15 mm + DIN 912 A2-70 | Mädler Art. 62399115 (1× im Zusammenbau) |

Norm-/Verbindungsteile (Innensechskantschrauben M8×40, Hutmuttern M8) bleiben ohne hauseigene Nummer — die tragen direkt ihre Normbezeichnung in der Stückliste.

---

## Verbrannt — NICHT wiederverwenden

Alle Nummern, die jemals auf einer ausgegebenen BOM oder einer Zeichnung mit Volker-Bezug standen. Dauerhaft gesperrt nach Keine-Recycling-Regel. Auch wenn Inhalt obsolet ist, bleibt die Nummer als historische Ident-Referenz reserviert.

| Nummer | Ursprünglich | Quelle / Weshalb verbrannt |
|---|---|---|
| `BE-LS-202603-000-0` | Zusammenbau_Lagerschalehalter (Fusion-Platzhalter) | BOM Stand 16.04.2026; Schema-Inkonsistenz, durch `-191-0` / `-291-0` ersetzt |
| `BE-LS-202603-1-0` | Schweißgruppe_Halter | BOM; Schema-Inkonsistenz (nicht 3-stellig); ersetzt durch `-151-0` |
| `BE-LS-202603-200-0` | Lagerhalter (Einzelteil V1) | BOM; Teil zu `-012-0` gewandert |
| `BE-LS-202603-201-0` | Lagerschale (Einzelteil V1) | BOM; Teil zu `-013-0` gewandert |
| `BE-LS-202603-202-0` | Steg_Lagerschalenhalter | BOM; Teil zu `-014-0` gewandert |
| `BE-LS-202603-203` *(ohne `-0`)* | Welle_V2 | BOM; Schema-Inkonsistenz + Kollision mit `-203-0`; Teil heute über `-207-0` zu `-211-0` umgezogen |
| `BE-LS-202603-203-0` | Scheibe t=1 | BOM; Teil zu `-011-0` gewandert |
| `BE-LS-202603-204-0` | Welle V1 (Haupt-Nummer) | BOM; konsolidiert mit `-206-0` zu `-111-0` |
| `BE-LS-202603-205-0` | Scheibe t=3/t=5 (doppelte BOM-Verwendung) | BOM; Teil zu `-212-0` bzw. `-112-0` gewandert |
| `BE-LS-202603-206-0` | Welle V1 (~recovered, Dublette) | BOM; konsolidiert zu `-111-0` |
| `BE-LS-202603-207-0` | Welle V2 (Zwischennummer von 21.04. morgens) | Aenderungsprotokoll Montag-Session; heute weiter zu `-211-0` umgezogen |
| `BE-LS-202603-700-0` | Lager SKF | BOM; Teil zu `-701-0` gewandert (Schema-Konsistenz X=7-Bereich ab Z=1) |
| `BE-LS-202603-704-0` | Klemmring | BOM; Teil zu `-702-0` gewandert |
| `BE-LS-202603-206-0` | Welle V2 (PDF-Schriftfeld-Stand) | Welle_V2 Zeichnung.pdf trägt aktuell diese Nummer (Fusion-Kollision: `-206-0` war parallel auch Welle_V1-Recovery-Dublette). v5 patcht sie direkt auf `-211-0`. Nummer verbrannt für beide historischen Verwendungen |

Aus der alten Reiner-v5-Planung (`Umsetzungs-Tabelle_Reiner_v5.md`) **nicht** zusätzlich verbrannt: `-100-0`, `-110-0`, `-111-0` (in alter Bedeutung Lagerhalter), `-112-0` (in alter Bedeutung Lagerschale), `-121-0`, `-122-0`, `-220-0`, `-221-0`, `-222-0` — diese Nummern standen nur als Planungsziel im internen Dokument, wurden nie auf eine ausgegebene BOM oder Zeichnung gedruckt. Einige davon werden im neuen Schema neu besetzt (`-111-0` = Welle V1, `-112-0` = Scheibe t=5, `-151-0` / `-251-0` = Schweißgruppen, `-191-0` / `-291-0` = Zusammenbauten), was mit der Regel vereinbar ist, weil nur **ausgegebene** Nummern verbrannt sind.

---

## Nächste freie Nummern (bei Bedarf)

- gemeinsame Einzelteile (`01Z-0`): `-015-0` bis `-019-0`
- gemeinsame Schweißgruppen (`05Z-0`): `-051-0` bis `-059-0`
- gemeinsame Zusammenbauten (`09Z-0`): `-091-0` bis `-099-0`
- V1 Einzelteile (`11Z-0`): `-113-0` bis `-119-0`
- V1 Schweißgruppen (`15Z-0`): `-152-0` bis `-159-0`
- V1 Zusammenbau (`19Z-0`): `-192-0` bis `-199-0`
- V2 Einzelteile (`21Z-0`): `-213-0` bis `-219-0`
- V2 Schweißgruppen (`25Z-0`): `-252-0` bis `-259-0`
- V2 Zusammenbau (`29Z-0`): `-292-0` bis `-299-0`
- Kaufteile (`70Z-0`): `-703-0` bis `-799-0` *(Achtung: `-704-0` verbrannt)*

Erweiterbare Slots, die noch nie adressiert wurden: `Y=2,3,4,6,7,8` innerhalb jeder `X`-Variante — insgesamt über 500 freie Nummern bei Bedarf.

---

## Fertigungsstückzahlen (Reiner-Freigabe 21.04.2026)

Quelle: handschriftliche Rot-Markierungen von Reiner auf dem Paket-Scan `doc00488220260419075722.pdf` vom 21.04.2026. E-Mail 21.04. 16:33 von Reiner an Volker Bens + CC Tomasz KM Metalworks PL, Betreff "Drehmechanik Cavanna", Text: *"anbei die jeweils 1x zu fertigenden Baugruppen"*.

Die Stückzahlen beziehen sich auf eine Fertigungs-Einheit (1× Zusammenbau V1 + 1× Zusammenbau V2 gleichzeitig). Skalierung für weitere Einheiten linear.

| Nummer | Bauteil | Menge | Ebene |
|---|---|---|---|
| `-011-0` | Scheibe t=1 | 2× | Einzelteil |
| `-012-0` | Lagerhalter | 4× | Einzelteil |
| `-013-0` | Lagerschale | 4× | Einzelteil |
| `-112-0` | Scheibe t=5 (Welle-Scheibe) | 2× | Einzelteil |
| `-111-0` | Welle V1 Einzelteil | 1× | Einzelteil |
| `-151-0` / `-251-0` | Schweißgruppe Halter | 4× gesamt (je 2× pro Zusammenbau) | Schweißbaugruppe |
| `-152-0` | Welle V1 Schweißbaugruppe | 1× | Schweißbaugruppe |
| `-211-0` | Welle V2 Einzelteil | 1× | Einzelteil |
| `-252-0` | Welle V2 Schweißbaugruppe | 1× | Schweißbaugruppe |
| `-191-0` | Zusammenbau V1 | 1× | Zusammenbau |
| `-291-0` | Zusammenbau V2 | 1× | Zusammenbau |

**Wichtig:** Welle V1 und V2 in den Zusammenbauten sind Schweißbaugruppen (Welle + Scheibe verschweißt), **nicht** nur Baugruppen. Die Welle_V*-Dateien, die im Fusion-Export "Baugruppe" heißen, sind inhaltlich Schweißbaugruppen (SBG) nach Reiners Standard (Y=5 mit Schweißsymbolen und *nach-Schweißen*-Hinweis). Klassifizierung präzisiert am 21.04. abends nach CSV-Analyse.

## Analyse-Basis (neu ab 21.04.2026 abends)

Analyse erfolgt künftig auf **CSV-Export** aus Fusion, nicht mehr auf PDF-Text-Extraktion. Pfad für Lagerschalenhalter: `.../Lagerschalenhalter Lebensmittelindustrie/2026-04-21 Montag-Session/_An_Volker/CSV/`. Enthält 11 strukturierte Stücklisten (Bauteilnummer, Name, Menge, Material, Masse). Diese sind die Wahrheit für Nummern-Mapping und Klassifizierung.

PDF-Generierung bleibt der Liefer-Output. CSV ist der Pipeline-Input. Für zukünftige Projekte: CSV pro Zeichnung von Fusion explizit mit-exportieren lassen.

## Verknüpfungen

- [[03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/mapping_lagerschalenhalter|v5-Patcher Mapping]] — wendet die neuen Nummern auf die Fusion-PDFs an
- [[03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/Umsetzungs-Tabelle_Reiner_v5|Umsetzungs-Tabelle Reiner v5]] — historischer Vorschlag, durch dieses Register abgelöst
- [[03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/2026-04-21 Montag-Session/Aenderungsprotokoll|Änderungsprotokoll Montag-Session]] — Historie der Nummern-Iterationen

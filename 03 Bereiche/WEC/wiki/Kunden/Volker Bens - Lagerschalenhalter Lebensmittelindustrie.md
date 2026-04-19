---
tags: [wiki, wec, kunde, bens, konstruktion, lagerschalenhalter]
date: 2026-04-15
status: aktiv
---

# Lagerschalenhalter — Überarbeitung Lebensmittelindustrie

> Basis: Zusammenbau_Lagerschalehalter_10_24_16042026.xlsx (Inventor-Export) + Lagerschalenhalter_Stueckliste_Lebensmittel.csv (veredelte Version mit BE-IS-Nummernsystem)
> Konstrukteur: Hartmann | Ingenieur: Woldrich | Projekt: AM_Lagerschale
> Kunde: Bens Edelstahl GmbH → Sachsenmilch
> Einsatz: Käsekarussell für Harzer Käse — Lagerschalenhalter für Riemenspannung
> **Liefer-Format: IGES** (Volker-Kompatibilität, älteres CAD-System — nicht STEP)
> **Zeichnungsnummern-Schema: `BE-IS-202631-XXX-X`** (Bens-intern)

## Zusammenfassung der Änderungen

Die Original-Stückliste wurde auf **EHEDG-konformes Hygienic Design** für den Einsatz in der Lebensmittelindustrie überarbeitet. Alle Änderungen sind unten markiert.

---

## Fehler im Original

| Problem | Details | Handlung |
|---|---|---|
| 🔴 **Lager-Bezeichnung falsch** | BOM schreibt "2203" — Konstruktion hat richtig **2202** E-2RS1TN9 (15x35x14mm) | BOM-Beschreibung korrigieren |
| 🔴 **Links falsch** | `moodfer.de` existiert nicht — korrekt ist `maedler.de` | Links korrigiert |
| 🟡 **Artikelnummer Lager** | Dummy in Konstruktion: 64773006 → korrekte Mädler-Nr: **64773026** | [Mädler Link](https://www.maedler.de/Article/64773026) |

---

## Überarbeitete Stückliste — Lebensmittelindustrie (EHEDG)

| Pos | Bauteil | Beschreibung | Menge | Material | Änderung |
|---|---|---|---|---|---|
| 1 | Lagerschale_Baugruppe | Hauptbaugruppe | 1 | — | — |
| 2 | Lagerhülse | Blech 10 | 2 | **1.4404** (316L) | ✅ bleibt |
| 3 | Lagerseite | Rundstahl | 1 | **1.4404** (316L) | ✅ bleibt |
| 4 | Steg_Lagerschalenhalter | Blech 5 | 1 | **1.4404** (316L) | ✅ bleibt |
| 5 | SKF Pendelkugellager | **2202 E-2RS1TN9** (15x35x14) — Mädler 64773026 | 1 | Stahl | 🟡 **Food-Grade Fett nötig** (siehe unten) |
| 6 | Scheibe t=1 | Blech 1 | 1 | **1.4404** (316L) | ✅ bleibt |
| 7 | Klemmring | Bohrung 15mm, geschlitzt | 1 | ~~1.4305~~ → **1.4404** | 🟡 **Material upgraden** |
| 7.1 | Scheibe t=3 | Blech 3 | 1 | **1.4404** (316L) | ✅ bleibt |
| 8 | Welle | Rundstahl | 1 | ~~nicht spezifiziert~~ → **1.4404** | 🔴 **Material war offen** |
| 9 | Innensechskantschraube M8x40 | DIN EN ISO 4762 | 2 | ~~Edelstahl A4~~ → **A4-80, 1.4404 poliert** | 🟡 **Hygienic Design** |
| 10 | Hutmutter M8 | DIN 985 | 3 | ~~Stahl 6~~ → **Edelstahl A4-80** | 🔴 **MUSS getauscht werden** |

---

## Detaillierte Änderungen

### Pos 5 — Lager: Edelstahl komplett ✅ ENTSCHIEDEN

**Entscheidung (laut finaler CSV-BOM vom 15.04.2026):** **SS2202-2RS Edelstahl komplett** (15x35x14mm, abgedichtet). Kein Nachfetten nötig, maximale Korrosionsbeständigkeit, Lebensmittel-tauglich ohne Zusatzmaßnahmen.

Quelle: [kugellager-shop.net/ss2202-2rs-edelstahl-pendelkugellager](https://www.kugellager-shop.net/ss2202-2rs-edelstahl-pendelkugellager.html)

**Früher erwogene Alternativen (verworfen):**
- SKF Food Line (2202 E-2RS1TN9 + NSF H1 Fett) — unnötig wenn Edelstahl komplett verfügbar
- Standardlager + Nachfetten NSF H1 — weniger sauber, Dokumentationsaufwand
- SKF W-Serie Edelstahl — teurer ohne Mehrwert gegenüber SS2202-2RS

**✅ Geklärt:** Welle ist 15mm → Lagergröße 2202 (15x35x14mm), nicht 2203 (17mm)!

### Pos 7 — Klemmring: Material upgraden

**Aktuell:** 1.4305 (AISI 303) — enthält Schwefel für Zerspanbarkeit, geringere Korrosionsbeständigkeit.
**Neu:** 1.4404 (AISI 316L) — schwefelarm, säurebeständig, lebensmittelkonform.

**Schraube am Klemmring:** DIN 912 A2-70 → **A4-80** (1.4404/1.4401)

Quelle Original: [Mädler Art. 62399115](https://www.maedler.de/Article/62399115) — 1.4305 Version.
Klemmring in 1.4404 ggf. bei [Hug Technik](https://www.hug-technik.com/Shop/Industrietechnik/Normteile/Vorrichtungselemente/Stellringe-Klemmringe-Klemmnaben/) oder als Sonderteil anfertigen.

### Pos 10 — Hutmutter: MUSS getauscht werden

**Aktuell:** Stahl 6, Einfach — **nicht zulässig** in der Lebensmittelindustrie.
**Neu:** Edelstahl A4-80 (1.4401 / 1.4404)

DIN 985 in A4 ist Standard-Katalogware bei Würth, Bossard, etc.

### Pos 9 — Schrauben: Hygienic Design ✅ ENTSCHIEDEN

**Entscheidung (laut finaler CSV-BOM vom 15.04.2026):** **Würth Sechskantschraube Hygienic Design M8x40**, niedriger Kopf, 1.4404 poliert (Ra < 0,8 µm), Artikelnummer **5099730840**.

Quelle: [Würth Art. 5099730840](https://eshop.wuerth.de/Sechskantschraube-niedriger-Kopf-im-Hygienic-Design-SHR-6KT-NIEDG-HYG-14404-POL-SW13-M8X40/5099730840.sku/de/DE/EUR/)

**Frühere Variante (verworfen):** DIN EN ISO 4762 A4 (Innensechskant) — Reinigungsproblem im Schraubenkopf, EHEDG-inkompatibel.

---

## Oberflächenanforderungen (EHEDG)

Für alle Bauteile mit Lebensmittelkontakt oder im Reinigungsbereich:

| Anforderung | Wert | Norm |
|---|---|---|
| **Oberflächenrauheit** | Ra ≤ 0,8 µm | EHEDG Doc. 8 |
| **Radien an Übergängen** | min. R6 (6mm) | EHEDG Doc. 8 |
| **Gewinde** | Abgedeckt oder außerhalb Produktzone | EHEDG Doc. 8 |
| **Toträume** | Keine — kein Produktstau möglich | EHEDG Doc. 8 |
| **Schweißnähte** | Bündig verschliffen, Ra ≤ 0,8 µm | DIN EN 1672-2 |

**Zeichnungshinweis:** Alle Einzelteile in der Zeichnung mit Ra-Angabe versehen!

---

## Normen und Zertifizierungen

| Norm | Inhalt | Relevant für |
|---|---|---|
| **EHEDG** | Hygienic Design Richtlinien | Gesamtkonstruktion |
| **DIN EN 1672-2** | Nahrungsmittelmaschinen — Sicherheit/Hygiene | Gesamtkonstruktion |
| **EC 1935/2004** | EU-Verordnung Lebensmittelkontaktmaterialien | Alle Werkstoffe |
| **FDA 21 CFR** | US-Lebensmittelzulassung (falls Export) | Werkstoffe, Schmierstoffe |
| **NSF H1** | Lebensmitteltaugliche Schmierstoffe | Lager, bewegliche Teile |

---

## Checkliste vor Freigabe

**Konstruktion/Werkstoffe (CSV-BOM v2026-04-15):**
- [x] ~~Wellenbohrung klären~~ → 15mm, Lagergröße 2202 ✅
- [x] ~~Lager-Bezeichnung~~ → BOM korrigiert: 2203 → 2202 ✅
- [x] ~~Lager-Variante~~ → SS2202-2RS Edelstahl komplett (kein Nachfetten nötig) ✅
- [x] ~~Schrauben-Typ~~ → Würth Hygienic Design M8x40, Art. 5099730840 ✅
- [x] ~~Sicherungsmuttern~~ → DIN 985 M8 A4-80 ✅
- [x] ~~Lebensmittelkontakt-Art~~ → Maschinenumfeld, trocken, manuelle Reinigung ✅
- [ ] Klemmring Pos 7 in 1.4404 beschaffen (Mädler liefert nur 1.4305 → Sonderanfrage oder Eigenfertigung)
- [ ] Ra ≤ 0,8 µm in alle Einzelteilzeichnungen eintragen (bei Inventor-Template prüfen)
- [ ] Radien R6 an allen Übergängen prüfen
- [ ] Gewinde im Produktbereich abdecken oder verlagern
- [ ] Material- und Konformitätserklärung (EC 1935/2004) anfordern

**Liefer-Format (Montag 21.04. mit Reiner):**
- [ ] IGES als Liefer-Format bestätigen (Fund: historische Lieferung in `07 Anhänge/Fusion360/.../Step/` enthält ausschließlich IGES-Dateien — nicht STEP)
- [ ] Bens-Schriftfeld-Vorlage aus `07 Anhänge/Bens_Vordruck.dwg` (70 KB, lokal) extrahieren und in Inventor-Template übernehmen
- [ ] BE-IS-202631-XXX-Nummernsystem in Zeichnungen und BOM konsistent prüfen

**White-Label (vor Übergabe an Bens):**
- [x] ~~BOM bereinigt~~ → `Lieferung/.../BOM_bereinigt.xlsx` (2026-04-18), 0 Restbefunde ✅
- [ ] PDF-Bereinigung (läuft): `Grundplatte Zeichnung.pdf` + `Zwischenplatte Zeichnung.pdf` (Schriftfeld-Text + Metadaten)
- [ ] Konstrukteur/Ingenieur-Felder L7/M7 → Reiner-Entscheidung (leer / VB / Bens-intern?)
- [ ] Historische Einzelteil-PDFs in `07 Anhänge/Fusion360/.../PDF/` gegen White-Label prüfen

---

## Verknüpfungen

- [[03 Bereiche/WEC/wiki/Kunden/Volker Bens - Profil]] — Kundenprofil
- [[03 Bereiche/WEC/CLAUDE]] — WEC-Regeln, u.a. Bens-Kunden-Spezifika (EHEDG)
- [[04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl]] — Lieferstandard
- [[03 Bereiche/Konstruktion/Konstruktion]]
- [[02 Projekte/WEC Neustart mit Reiner/WEC Neustart mit Reiner]]

### Quellen im raw-Layer

Rohdaten zum Projekt liegen in `03 Bereiche/WEC/raw/Kunden/Volker Bens/aktuelle Projekte/Lagerschalenhalter Lebensmittelindustrie/`:

- `Lagerhalter Zeichnung.pdf`
- `Lagerhalter.stp`
- `Zusammenbau_Lagerschalehalter_07_57_15042026.xlsx`
- `Zusammenbau_Lagerschalehalter_10_24_16042026.xlsx`
- `Grundplatte-3d-PDF.pdf`
- `Grundplatte-SM Zeichnung.pdf`
- `Gundplatte.pdf` *(Kunden-Originalname mit Tippfehler — bewusst nicht korrigiert)*
- `Zwichenplatte-SM Zeichnung.pdf` *(Kunden-Originalname mit Tippfehler — bewusst nicht korrigiert)*
- `Zwischenplatte-3D-PDF.pdf`

Kunden-übergreifende Material-Datenblätter in `03 Bereiche/WEC/raw/Kunden/Volker Bens/Standards & Vorlagen/`:

- `Bens Logo.jpg`
- `Datenblatt,Copper3D,antibakteriell,Datasheet A98 red.pdf`
- `Elastollan<sup>®<-sup>+–+Material+Properties.pdf` *(Dateiname mit HTML-Artefakten aus Web-Export)*
- `Herstellerbescheinigung MAXITHEN PA4CA2757OB Rot10082016_0000.pdf`

---

Sources:
- [SKF 2203 E-2RS1TN9 Datenblatt](https://www.skf.com/at/products/rolling-bearings/ball-bearings/self-aligning-ball-bearings/productid-2203%20E-2RS1TN9)
- [Mädler Klemmring 62399115](https://www.maedler.de/Article/62399115)
- [Würth Hygienic Design Edelstahl 1.4404](https://eshop.wuerth.de/Produktkategorien/Edelstahl-1.4404-poliert-Hygienebereich/14013511113601.cyid/1401.cgid/de/DE/EUR/)
- [EHEDG Anforderungen](https://der-maschinenbau.de/allgemein/hohe-ehedg-anforderungen/)
- [Lebensmittelindustrie Metall & Oberflächen](https://www.gemtec-metallbearbeitung.de/wissenswert/lebensmittelindustrie-metall-hygienisches-design-und-oberflaechen/)

---
tags: [projekt, wec, bens, korrekturauftrag]
date: 2026-04-21
status: offen
empfänger: Reiner
projekt: Lagerschalenhalter Lebensmittelindustrie
kunde: Volker Bens
---

← zurueck zum [[03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/_INDEX|Projekt-Landing-Pad]]


# Korrekturauftrag Re-Export — Lagerschalenhalter v5

**Stand:** 2026-04-21
**Basis:** White-Label-Lokalisierung in 10 Fusion-PDFs (`07 Anhänge/Fusion360/Baugruppen_Einzelteile_Lagerschalenhalter/PDF/`)
**Methode:** `pdfminer.six`-Textextraktion, regex-Abgleich gegen bekannte Fehlmuster.

---

## Fehlerklassen

| Klasse | Auftritt | Konsequenz |
|---|---|---|
| A — `SM_Lagerschale` als Projektgruppe | 2 PDFs | White-Label-Bruch: Sachsenmilch-Referenz sichtbar. Kritisch. |
| B — Werkstoff `1.44.04` statt `1.4404` | 15 Fundstellen über 8 PDFs | Syntaxfehler der DIN-Werkstoffnummer. Technisch falsch. |
| C — Zeichnungsnummer Welle_V2 `-203` | 6 Fundstellen | Kollidiert mit Scheibe_t=1 `-203-0`. In BOM bereits auf `-207-0` gezogen, PDFs hängen nach. |
| D — Zeichnungsnummer Schweißgruppe `-1-0` | 3 Fundstellen | Dreistellig-Schema gebrochen. In BOM bereits auf `-001-0` gezogen, PDFs hängen nach. |

---

## Zu korrigierende Punkte

| # | Zeichnung | Fundstelle | Fehler | Korrektur |
|---|---|---|---|---|
| A1 | Zusammenbau_Lagerschalehalter Zeichnung.pdf | Schriftfeld „Projektgruppe" | `SM_Lagerschale` | `Lagerschalenhalter` |
| A2 | Zusammenbau_Lagerschalehalter Zeichnung lang.pdf | Schriftfeld „Projektgruppe" | `SM_Lagerschale` | `Lagerschalenhalter` |
| B1 | Lagerhalter Zeichnung (~recovered).pdf | Teileliste, Material Lagerhalter | `1.44.04` | `1.4404` |
| B2 | Lagerschale Zeichnung.pdf | Teileliste, Material Lagerschale | `1.44.04` | `1.4404` |
| B3 | Scheibe_t=1 Zeichnung.pdf | Teileliste, Material Scheibe_t=1 | `1.44.04` | `1.4404` |
| B4 | Scheibe_t=3 Zeichnung.pdf | Teileliste, Material Scheibe_t=3 | `1.44.04` | `1.4404` |
| B5 | Welle_V1 Zeichnung.pdf | Teileliste, Material Welle_V1 + Scheibe_t=5 (2 Zeilen) | `1.44.04` × 2 | `1.4404` |
| B6 | Welle_V1 Zeichnung (~recovered).pdf | Teileliste, Material Welle_V1 | `1.44.04` | `1.4404` |
| B7 | Welle_V2 Zeichnung.pdf | Teileliste, Material Welle_V2 | `1.44.04` | `1.4404` |
| B8 | Schweißgruppe_Halter Zeichnung (~recovered).pdf | Teileliste, Material Lagerhalter + Lagerschale (2 Zeilen) | `1.44.04` × 2 | `1.4404` |
| B9 | Zusammenbau_Lagerschalehalter Zeichnung.pdf | Stückliste, Material-Spalte (3 Zeilen) | `1.44.04` × 3 | `1.4404` |
| B10 | Zusammenbau_Lagerschalehalter Zeichnung lang.pdf | Stückliste, Material-Spalte (4 Zeilen) | `1.44.04` × 4 | `1.4404` |
| C1 | Zusammenbau_Lagerschalehalter Zeichnung.pdf | Stückliste, Spalte Bauteilnummer | `BE-LS-202603-203` → Welle_V2 (2 Fundstellen: Pos-Nummer + Einzelreferenz) | `BE-LS-202603-207-0` |
| C2 | Zusammenbau_Lagerschalehalter Zeichnung lang.pdf | Stückliste, Spalte Bauteilnummer | `BE-LS-202603-203` → Welle_V2 (2 Fundstellen) | `BE-LS-202603-207-0` |
| C3 | Welle_V2 Zeichnung.pdf | Schriftfeld „Zeichnungsnummer" + Teileliste-Kopfzeile | `BE-LS-202603-206-0` + `BE-LS-202603-206` | `BE-LS-202603-207-0` + `BE-LS-202603-207` (Teileliste zeigt historisch die Welle_V1-Recovered-Referenz, Schriftfeld ebenso — komplette Zeichnung auf Welle_V2 mit neuer Nummer umstellen) |
| D1 | Zusammenbau_Lagerschalehalter Zeichnung.pdf | Stückliste, Spalte Bauteilnummer | `BE-LS-202603-1-0` Schweißgruppe_Halter | `BE-LS-202603-001-0` |
| D2 | Zusammenbau_Lagerschalehalter Zeichnung lang.pdf | Stückliste, Spalte Bauteilnummer | `BE-LS-202603-1-0` Schweißgruppe_Halter | `BE-LS-202603-001-0` |
| D3 | Schweißgruppe_Halter Zeichnung (~recovered).pdf | Schriftfeld „Zeichnungsnummer" | `BE-LS-202603-1-0` | `BE-LS-202603-001-0` |

---

## Zusätzliche Aufräum-Punkte

- **`~recovered`-Dateinamen entfernen:** drei Zeichnungen tragen das Onshape-Artefakt im Dateinamen (`Lagerhalter`, `Welle_V1`, `Schweißgruppe_Halter`). Neu exportieren als sauber benannte Datei ohne Suffix.
- **`Welle_V1 Zeichnung (~recovered).pdf`** ist inhaltliche Dublette zu `Welle_V1 Zeichnung.pdf`. Nur eine behalten, Welle_V1-Zeichnung unter Nummer `BE-LS-202603-204-0` führen (entspricht BOM-Stand nach Konsolidierung 2026-04-21).
- **`Welle_V2 Zeichnung.pdf` Teileliste-Inhalt prüfen:** aktuell ist die Welle_V1-Referenz in der Teileliste der Welle_V2 sichtbar. Teileliste auf die Welle_V2 selbst umstellen.

---

## Schriftfeld-Status (Entscheidung 2026-04-21, bestätigt)

- `Bearbeitet: Sebastian Hartmann` und `Geprüft: Woldrich` bleiben in allen Zeichnungen stehen — Fusion-Default, keine Korrektur nötig.
- Bens-Logo + Kopfzeile „Quality for Pharmacy" bleiben — Slogan, kein echter GMP-Kontext.
- Kontext Lebensmittel/EHEDG (Sachsenmilch Käsekarussell) erscheint **nicht** auf der Zeichnung.

---

## Nach Re-Export

1. Neue PDFs in `07 Anhänge/Fusion360_v5/` ablegen (flaches Set, keine Unterordner).
2. v4-Patcher (`02 Projekte/WEC/scripts/v4_patcher.py`) erneut drüberlaufen lassen — fügt Info-Block mit Oberfläche / Toleranz / Werkstoff hinzu.
3. Re-Verify mit `pdfminer`-Scan aus diesem Dokument — Erwartung: 0 Treffer für Klassen A–D.
4. Finale Ablage in `_An_Volker/PDF/` (dort aktuell der v3-Overlay-Stand, der durch v5 komplett ersetzt wird).
5. STEP AP203 für Einzelteile + Schweißgruppe aus Fusion nachlegen (aktuell fehlen 7 STEP-Dateien gegenüber der IGES-Vollständigkeit).

---

## Verknüpfungen

- [[04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl]]
- [[03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/2026-04-21 Montag-Session/Aenderungsprotokoll]]
- [[03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/2026-04-21 Montag-Session/_An_Volker/LIEFERUNG|LIEFERUNG.md]]
- [[02 Projekte/WEC/scripts/v4_patcher.py]]

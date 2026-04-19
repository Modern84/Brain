---
tags: [projekt, wec, konstruktion]
date: 2026-04-15
status: aktiv
---

# Mail an Reiner — Lagerschalenhalter Lebensmittelindustrie

> An: woldrich@w-ec.de
> Status: ENTWURF

---

**Betreff:** Lagerschalenhalter — Überarbeitung für Lebensmittelindustrie fertig 📋

---

Hey Reiner,

ich hab den Lagerschalenhalter für die Lebensmittelindustrie überarbeitet. Claude hat mir geholfen alles gegen EHEDG-Standard und Lebensmittelnormen zu prüfen. Hier die Zusammenfassung — kurz und knapp.

**Fehler die mir aufgefallen sind:**

1. **Lager falsch bezeichnet** — In der Stückliste steht SKF 2203 (17mm Bohrung), die Konstruktion hat aber richtig das SKF 2202 (15mm). Nur die BOM-Beschreibung war falsch. Ist korrigiert.

2. **Dummy-Artikelnummer** — Im CAD steht 64773006, korrekte Mädler-Nummer ist 64773026.

3. **Links** — Die moodfer.de-Links in der Stückliste funktionieren nicht. Richtig ist maedler.de.

**Was geändert werden muss für Lebensmittelindustrie:**

🔴 **MUSS:**

| Pos | Was | Problem | Lösung |
|---|---|---|---|
| 10 | Hutmutter DIN 985 | **Stahl 6** — geht gar nicht | → Edelstahl **A4-80** |
| 8 | Welle | Material war **nicht spezifiziert** | → **1.4404** (316L) |
| 5 | SKF Lager | Standardlager ist Chromstahl, nicht Edelstahl | → **SS2202-2RS Edelstahl komplett** |

🟡 **SOLLTE:**

| Pos | Was | Problem | Lösung |
|---|---|---|---|
| 7 | Klemmring | 1.4305 (Schwefel, weniger beständig) | → **1.4404** |
| 9 | Schrauben M8x40 | Innensechskant = Reinigungsproblem | → **Hygienic Design** (glatter Kopf, 1.4404 poliert) |
| alle | Oberflächen | Ra-Werte fehlen komplett | → **Ra ≤ 0,8 µm** in Zeichnungen eintragen |
| alle | Übergänge/Radien | Nicht spezifiziert | → min. **R6** (EHEDG) |

**Korrigierte Stückliste:**

| Pos | Bauteil | Material | Menge | Anmerkung |
|---|---|---|---|---|
| 1 | Lagerschale_Baugruppe | — | 1 | Zusammenbau |
| 2 | Lagerhülse (Blech 10) | 1.4404 ✅ | 2 | Ra ≤ 0,8 µm |
| 3 | Lagerseite (Rundstahl) | 1.4404 ✅ | 1 | Ra ≤ 0,8 µm |
| 4 | Steg (Blech 5) | 1.4404 ✅ | 1 | Ra ≤ 0,8 µm |
| 5 | Pendelkugellager SS2202-2RS | **Edelstahl komplett** | 1 | 15x35x14, [Kugellager-Shop](https://www.kugellager-shop.net/ss2202-2rs-edelstahl-pendelkugellager.html) |
| 6 | Scheibe t=1 (Blech 1) | 1.4404 ✅ | 1 | Ra ≤ 0,8 µm |
| 7 | Klemmring 15mm | ~~1.4305~~ → **1.4404** | 1 | Schraube A4-80 |
| 7.1 | Scheibe t=3 (Blech 3) | 1.4404 ✅ | 1 | Ra ≤ 0,8 µm |
| 8 | Welle | ~~offen~~ → **1.4404** | 1 | Ra ≤ 0,8 µm |
| 9 | Innensechskant M8x40 | ~~A4~~ → **A4-80 Hygienic Design** | 2 | 1.4404 poliert, glatter Kopf |
| 10 | Hutmutter M8 | ~~Stahl 6~~ → **A4-80** | 3 | DIN 985 Edelstahl |

**Rahmenbedingungen:**

- Kein direkter Lebensmittelkontakt — Maschinenumfeld
- Trockene Umgebung
- Keine CIP-Reinigung — manuelle Reinigung

Das Lager wird komplett auf Edelstahl umgestellt (SS2202-2RS statt Standard-Chromstahl). Kein Nachfetten nötig, kein Fett-Risiko. Die restlichen Materialänderungen (Hutmutter A4-80, Welle 1.4404, Oberflächen Ra ≤ 0,8 µm) sind Pflicht — Maschinenstandard für Lebensmittelumfeld.

Die komplette Analyse mit Normen (EHEDG, DIN EN 1672-2, EC 1935/2004) und Quellen hab ich im Brain gespeichert.

Basti

---

## Verknüpfungen

- [[01 Inbox/Lagerschalenhalter - Lebensmittelindustrie Überarbeitung]]
- [[02 Projekte/WEC Neustart mit Reiner/WEC Neustart mit Reiner]]

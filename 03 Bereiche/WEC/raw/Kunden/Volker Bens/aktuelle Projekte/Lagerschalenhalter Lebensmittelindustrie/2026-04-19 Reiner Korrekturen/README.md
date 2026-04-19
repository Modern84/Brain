---
tags: [bens, lagerschalenhalter, korrektur, reiner, eingang, scan, wec]
date: 2026-04-19
status: eingegangen
quelle: WhatsApp von Reiner (Chat A, 2026-04-17 15:14)
---

# Reiner Korrektur-Scans — 2026-04-17

## Herkunft

WhatsApp von Reiner, empfangen **Freitag 2026-04-17 um 15:14 Uhr**. Acht Handy-Fotos in Serie — Fotos der CAD-Teilelisten-Zeichnungen der Lagerschalenhalter-Baugruppe, vermutlich mit handschriftlichen Korrektur-Anmerkungen. Vorbereitung auf Montag 2026-04-21.

Kopiert aus WhatsApp-Shared-Storage (Chat-ID `@192418997661774`). Originale bleiben in WhatsApp-Historie + Downloads-Ordner intakt. md5-Integrität bei Kopie verifiziert.

## Dateien

| Datei | Größe | md5 | OCR-Inhalt (erkannte Bauteilnummer) |
|---|---:|---|---|
| `Reiner-Scan-c6c078f1-180846.jpg` | 180.846 | `eb0502a2b0824a24bdde41b42c3e5085` | **BE-LS-202603-700** Lager 64773026 · SKF Pendelkugellager 2202 · **BE-LS-202603-704** Klemmring 623991 |
| `Reiner-Scan-73cec1cd-177647.jpg` | 177.647 | `0a54c8846706840f9dba9a20b2dfc6b9` | **BE-LS-202603-200** Lagerhalter · **BE-LS-202603-201** Lagerschale (Hinweis: „nach Schweißen Planschleifen") |
| `Reiner-Scan-487aabea-175879.jpg` | 175.879 | `b73545dfbe1e892d0ce656cbef9ee92f` | **BE-LS-202603-700** Lager SKF 2202 · **BE-LS-202603-704** Klemmring · Details Bohrung/Schraube DIN 912 |
| `Reiner-Scan-3ff85e64-170336.jpg` | 170.336 | `b560677a1d25b63df398036d97a64448` | **BE-LS-202603-206** Welle_V1 · Rundstahl Edelstahl 1.4404 |
| `Reiner-Scan-c67c6a66-156886.jpg` | 156.886 | `b31fcf04ab0732e0119734ac5a12873e` | **BE-LS-202603-205** Scheibe_t=5 · Blech 3,57 · Bearbeiter: Sebastian Hamann, 2026-03-25 |
| `Reiner-Scan-97e7f638-148183.jpg` | 148.183 | `90138286fd9568033e7f95ca04f69019` | **BE-LS-202603-206** Welle_V1 · Rundstahl Edelstahl |
| `Reiner-Scan-627ef79c-147072.jpg` | 147.072 | `51ea93c4fba3efa30e7f1c54bcb1b365` | **BE-LS-202603-206** Welle + **BE-LS-202603-204** Scheibe_t=5 |
| `Reiner-Scan-54335b71-127621.jpg` | 127.621 | `e18c2a8c73c4514bf4acfe1384b8c860` | **BE-LS-202603-203** Scheibe_t=1 · Blech 1 · Edelstahl 1.4404 |

OCR-Rohtexte liegen in `ocr/` (tesseract, deu+eng). Zeichnungen selbst sind deutlich lesbarer als das OCR suggeriert — Handschrift-Korrekturen auf den Scans sind für tesseract nicht verlässlich, Montag mit Reiner visuell durchgehen.

## Hauptbefund — Zeichnungsnummern-Konflikt geklärt

Alle acht Scans zeigen **BE-LS-202603-XXX-X** als gültige Nummernserie. Damit ist klar:

- **BE-LS-202603** = richtig (Bens Edelstahl — Lagerschalenhalter — 202603)
- **BE-IS-202631** (wie in der alten CSV-Stückliste) = **falsch**, vermutlich Tippfehler oder veralteter Stand

### Identifizierte Baugruppen-Teile

| Nummer | Bauteil | Material |
|---|---|---|
| BE-LS-202603-200 | Lagerhalter | Blech 10, Edelstahl 1.4404 |
| BE-LS-202603-201 | Lagerschale | Rundstahl, Edelstahl (nach Schweißen Planschleifen) |
| BE-LS-202603-203 | Scheibe t=1 | Blech 1, Edelstahl 1.4404 |
| BE-LS-202603-204 | Scheibe t=5 | Blech 5, Edelstahl |
| BE-LS-202603-205 | Scheibe t=5 | Blech 3,57 |
| BE-LS-202603-206 | Welle_V1 | Rundstahl Edelstahl 1.4404 |
| BE-LS-202603-700 | Lager 64773026 | SKF Pendelkugellager 2202 2RS1TN9, Stahl |
| BE-LS-202603-704 | Klemmring 623991 | Geschlitzter Klemmring Edelstahl 1.4305 |

Alle Zeichnungen tragen das Bens-Branding „Quality for Pharmacy" — also korrekt Lebensmittel-/Pharma-Spezifikation.

## Offene Punkte

- [ ] **Montag 2026-04-21:** Mit Reiner die handschriftlichen Korrekturen auf den Scans durchgehen (OCR erfasst Handschrift nicht zuverlässig)
- [ ] CSV-Stückliste `Zusammenbau_Lagerschalehalter_*.xlsx` auf **BE-LS-202603** umstellen (BE-IS-202631 war falsch)
- [ ] `Lagerhalter Zeichnung.pdf` (im Parent-Ordner) mit den Scan-Befunden abgleichen
- [ ] Erkenntnisse → [[../../../../../../../04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl]] als Standard-Regel aufnehmen: „Zeichnungsnummer nach Muster BE-LS-YYYYNN-XXX"

## Chat B — nicht kopiert

Im selben WhatsApp-Ordner lag ein PDF (4 Seiten, 984 KB, 2026-04-04) von „Northolt Advice Ltd, 201a Victoria Street, SW1E 5NE London" — Geschäfts-/Rechtsschreiben, kein Bezug zum Lagerschalenhalter. Absender-ID `@198741675999482`, unklar wer das ist. Thumbnail liegt unter `/tmp/chatB-pdf-p1-1.png` falls visuelle Prüfung gewünscht. Dateien aus Chat B wurden **nicht** in den Vault kopiert.

## Verknüpfungen

- [[../../../../wiki/Kunden/Volker Bens - Lagerschalenhalter Lebensmittelindustrie|Volker Bens — Lagerschalenhalter Lebensmittelindustrie]]
- [[../../../../../../04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl]]
- Parent-Ordner `Lagerschalenhalter Lebensmittelindustrie/` — vorhandene PDF-Zeichnungen und XLSX-Stücklisten

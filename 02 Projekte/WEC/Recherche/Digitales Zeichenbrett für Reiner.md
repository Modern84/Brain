---
tags: [recherche, wec, hardware, reiner]
date: 2026-05-01
status: aktiv
priorität: A
owner: Sebastian
raum: WEC
---

# Digitales Zeichenbrett für Reiner

Recherche zur Auswahl eines Skizzier-Geräts für Reiner, das frei wie auf Papier funktioniert, ohne Cloud-Zwang läuft und Skizzen als PDF/PNG in einen lokalen Obsidian-Sub-Vault `WEC-Shared/Skizzen/` exportieren kann.

## Empfehlung

**reMarkable Paper Pro** (11,8″ Canvas-Color-E-Ink, Frontlicht, 12 ms Stift-Latenz, 64 GB) [1][2]. Begründung: papierähnliches Schreibgefühl ohne Glas-Glanz (anders als iPad/Surface), ein einziger fokussierter Zweck (kein Web/Mail/Spiele-Ablenkung), USB-Datenexport ohne Cloud nachweislich möglich [5][6]. Farbe (20.000 Farben) hilft Reiner, Bemaßung/Notiz/Geometrie farblich zu trennen.

## Backup

**reMarkable 2** (10,3″ monochrom, kein Frontlicht, 8 GB, ~400 USD) [3][4]. Plan B, falls Reiner auf Farbe verzichten kann und den Aufpreis scheut. Identischer USB-Export-Workflow, leichter (404 g vs. 525 g), aber kein Frontlicht und keine Farbcodierung.

## K.o.-Kriterien

- **Cloud-Pflicht für Grundfunktion** → disqualifiziert Gerät sofort.
- **Glasdisplay mit Glanz** → kein Papiergefühl, scheidet für Reiner aus (iPad).
- **Allzweck-Tablet mit Mail/Browser/Apps** → Ablenkung, kein Werkzeug-Charakter (iPad, Surface).
- **Stift-Latenz > 20 ms** → spürbar, stört flüssiges Skizzieren.
- **Akku-Laufzeit < 3 Tage bei realer Nutzung** → tägliches Laden ist für ein „Papierersatz"-Gerät untragbar.
- **Kein USB-/Lokal-Export** → Skizzen müssen durch fremde Cloud → unverhandelbar.

## Vergleichstabelle

| Kriterium | reMarkable Paper Pro | reMarkable 2 | iPad Pro 11″ (M4) | MS Surface Pro 11 |
|---|---|---|---|---|
| Display | 11,8″ E-Ink Color (Gallery 3), 229 ppi [1] | 10,3″ E-Ink mono, 226 ppi [4] | 11″ OLED, glänzend | 11″ LCD/OLED, glänzend |
| Frontlicht | ja [1] | nein | ja (Hintergrund) | ja (Hintergrund) |
| Stift-Latenz | 12 ms [1] | ~21 ms [2] | ~9 ms (Pencil Pro) | ~25 ms (Slim Pen 2) |
| Papiergefühl | sehr hoch | sehr hoch | gering (Glas) | gering (Glas) |
| Ablenkung | minimal (nur Notizen) | minimal | hoch (Apps, Web) | hoch (Windows) |
| Cloud-Pflicht | nein, USB-Web reicht [5] | nein, USB-Web reicht [5] | iCloud-Konto faktisch nötig | MS-Konto nötig |
| Speicher | 64 GB [2] | 8 GB [2] | 256 GB+ | 256 GB+ |
| Akku | bis ~2 Wochen [1] | bis ~2 Wochen | ~10 h aktiv | ~10 h aktiv |
| Gewicht | 525 g [2] | 404 g [2] | 444 g | ~895 g |
| Preis Gerät (DE, ca.) | ~639 EUR mit Marker | ~409 EUR mit Marker | ab ~1.200 EUR | ab ~1.100 EUR |
| Farbe | ja, 20.000 [1] | nein | ja, vollfarbig | ja, vollfarbig |
| Empfehlung für Reiner | ja | Plan B | nein | nein |

unsicher: EUR-Preise variieren je nach reMarkable-Shop-Stand 2026; Werte oben sind Richtgrößen aus Hersteller-Shop und Reviews [1][2]. Vor Kauf aktuellen Shop-Preis prüfen.

## Export-Workflow Detail (rM Paper Pro → Sebastians Mac)

Schritt für Schritt, ohne Connect-Abo:

1. **Reiner skizziert** auf rM Paper Pro.
2. **USB-Kabel** an Reiners Windows-PC anschließen. Auf dem Tablet erscheint Hinweis „USB Web Interface aktivieren" — bestätigen [5].
3. **Browser auf Windows-PC** öffnen, Adresse `http://10.11.99.1` (HTTP, nicht HTTPS) [5][6].
4. **Notebook auswählen** → Button „Export" → PDF wird heruntergeladen ins Windows-Standard-Download-Verzeichnis.
5. **Datei verschieben** in `C:\Users\Reiner\Documents\Obsidian\WEC-Shared\Skizzen\` (= Sub-Vault, der via Obsidian Sync Plus mit Sebastians Mac synchronisiert wird).
6. **Obsidian Sync Plus** überträgt automatisch in den Vault auf Sebastians Mac.
7. **Sebastian** öffnet PDF/PNG in Fusion 360 als Canvas und konstruiert darauf.

Alternative ohne USB-Web: **reMarkable Desktop-App für Windows** installieren. Im Tablet im Setup WLAN aktivieren, aber Geräte-Pairing kann vermieden bzw. nur lokal genutzt werden — unsicher: ob die offizielle Desktop-App komplett ohne Konto funktioniert. Quellenlage spricht dafür, dass Cloud-Pairing für Desktop-App-Sync vorausgesetzt wird [7]. Daher: **USB-Web-Interface ist der saubere Cloud-freie Weg**, Desktop-App nur als Komfort-Option mit Konto.

## Cloud-Vermeidungs-Status (Stand 2026)

**Geht ohne Connect-Abo / ohne reMarkable-Cloud:**
- Skizzieren, Notizen, Lesen — alle Kern-Funktionen lokal [8].
- Handschrift-zu-Text-Konvertierung (seit Update 2024 frei) [8].
- Datei-Import/-Export per **USB-Web-Interface** `http://10.11.99.1` (PDF, EPUB, PNG, JPG, max. 100 MB pro Datei) [5][6].
- E-Mail-Versand einzelner Dokumente vom Tablet (benötigt nur WLAN, kein Connect).
- Screen-Share (frei seit Update 2024) [8].

**Geht NICHT ohne Connect (3,99 USD/Monat, ~4,50 EUR):**
- Cloud-Sync zwischen Tablet, Desktop-App und Mobile-App ohne Datei-Verfall [8].
- Google-Drive- / Dropbox- / OneDrive-Integration [8].
- Handschrift-Suche über alle Notebooks [8].
- Erweiterte Garantie und Premium-Templates [8].

**Wichtig:** Ohne Connect werden Notebooks, die 50 Tage nicht geöffnet wurden, **aus der reMarkable-Cloud** gelöscht — auf dem Tablet bleiben sie [8]. Für Reiners Workflow irrelevant, weil wir die Cloud bewusst nicht nutzen.

**Konto-Pflicht bei Erst-Setup:** unsicher — Quellen deuten an, dass beim First-Boot ein reMarkable-Konto verlangt wird, das WLAN-Setup aber ohne Konto-Pairing möglich war auf rM 2 [9]. Für Paper Pro nicht eindeutig bestätigt. **TODO:** im Laden testen, ob Setup ohne Konto-Login durchläuft (Punkt 1 im Test-Protokoll).

## Test-Protokoll Laden (15 min, MediaMarkt o. ä.)

Reiner hakt vor Ort ab:

1. **Stift-Gefühl:** 30 Sekunden frei skizzieren, Linie verfolgen. Fühlt sich das nach Papier an oder nach Glas? ✅ / ❌
2. **Latenz:** Schnelle Wellenlinie zeichnen. Hinkt der Strich sichtbar dem Stift hinterher? ❌ wenn ja.
3. **Druckstufen:** Mit unterschiedlichem Druck zeichnen — wird die Linie dünner/dicker? ✅ erwartet.
4. **Farben (nur Pro):** Stift-Tool wechseln, mehrere Farben testen. Farbtreue auf E-Ink akzeptabel? ✅ / ❌
5. **Bedienung:** Kann Reiner OHNE Hilfe ein neues Notizbuch anlegen, eine Seite löschen, eine Skizze speichern?
6. **Gewicht/Haltung:** 5 Minuten ohne Tisch in der Hand halten — ermüdet?
7. **Setup-Frage am Verkäufer:** „Funktioniert das Gerät komplett ohne reMarkable-Konto und ohne Connect-Abo?" Antwort notieren.
8. **Frontlicht (nur Pro):** in dunkleren Bereich gehen, Frontlicht regeln — angenehm?

Wenn 1, 2, 5 nicht alle ✅ → Gerät ist nicht das richtige.

## Kosten-Aufstellung (EUR, ca., Stand 2026)

Empfehlung-Paket (rM Paper Pro):

- reMarkable Paper Pro mit Marker: **~639 EUR** [1]
- Marker Pro (mit Radierer, Aufpreis): **~50 EUR** (optional, empfohlen)
- Folio Premium: **~89–179 EUR** [1]
- Connect-Abo: **0 EUR** (nicht abschließen)
- **Summe Empfehlung: ~728 EUR** (ohne Folio: ~689 EUR)

Backup-Paket (rM 2):

- reMarkable 2 mit Marker: **~409 EUR** [3]
- Marker Plus (Radierer): **~50 EUR**
- Folio: **~79–149 EUR**
- **Summe Backup: ~538 EUR**

Vergleich Allzweck-Tablets (zur Einordnung, nicht empfohlen):

- iPad Pro 11″ M4 + Apple Pencil Pro + Folio: **~1.450 EUR**
- Surface Pro 11 + Slim Pen 2 + Cover: **~1.350 EUR**

unsicher: Preise sind Richtwerte aus reMarkable-DE-Shop und Apple/MS-DE 2026. Vor Kauf prüfen.

## Quellen

1. [reMarkable Paper Pro – Produktseite](https://remarkable.com/products/remarkable-paper/pro)
2. [reMarkable Paper Pro Review – eWritable](https://ewritable.net/brands/remarkable/tablets/remarkable-paper-pro/)
3. [reMarkable Paper Pro vs reMarkable 2 – Hersteller-Vergleich](https://remarkable.com/clp/remarkable-paper-pro-vs-remarkable-2)
4. [reMarkable 2 vs Paper Pro – wphtaccess.com (2026-03-11)](https://wphtaccess.com/2026/03/11/remarkable-2-vs-remarkable-paper-pro-specs-features-and-best-choice-explained/)
5. [How to transfer files to reMarkable Paper Pro (without cloud) – informaticar.net](https://www.informaticar.net/how-to-transfer-files-to-remarkable-paper-pro-without-cloud/)
6. [Importing and exporting files – reMarkable Support](https://support.remarkable.com/s/article/importing-and-exporting-files)
7. [Desktop app – reMarkable Support](https://support.remarkable.com/s/article/Desktop-app)
8. [About Connect Subscription – reMarkable Support](https://support.remarkable.com/s/article/About-Connect-Subscription)
9. [reMarkable 2 – No Cloud Setup with Hacks – postgradexpat / Medium](https://medium.com/@PostgradExpat/remarkable-2-cloudless-setup-with-hacks-offline-file-transfer-bookmarking-pinch-zoom-time-4faf51ffedc5)
10. [reMarkable Connect in 2026 – brandenbodendorfer.com](https://brandenbodendorfer.com/remarkable-connect-subscription-worth-it/)
11. [Using reMarkable without a subscription – reMarkable Support](https://support.remarkable.com/s/article/Using-reMarkable-without-a-subscription)

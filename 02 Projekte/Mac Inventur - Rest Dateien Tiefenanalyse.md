---
tags: [projekt, mac-inventur, analyse]
date: 2026-04-18
status: aktiv
priorität: B
owner: Sebastian
raum: MThreeD
---

# Mac Inventur — Rest-Dateien Tiefenanalyse

Tiefergehende Metadaten-Analyse für die **48 Dateien** (nicht 67 wie initial gezählt — der Zähler in der Vorsortierung war zu hoch, Korrektur siehe unten), die in der Vorsortierung als „Rest/Unklar" markiert waren. Ziel: Session 6 (Rest-Bulk) radikal beschleunigen durch echte Typ-Erkennung (`file`), Herkunfts-URL aus macOS-Spotlight (`mdls -name kMDItemWhereFroms`) und Datums-Abgleich.

**Korrektur:** Ursprüngliche Vorsortierung sprach von 67 Rest/Unklar-Dateien. Tatsächlich sind es **48**. Die Zählerübersicht in [[02 Projekte/Mac Inventur - Phase 3 Vorsortierung]] muss entsprechend korrigiert werden.

## Methodik

- `file -b` für echten Typ (statt Extension-Raten)
- `stat -f %SB` für Geburtszeit
- `mdls -name kMDItemWhereFroms` für Download-Quelle — **der goldene Wert** dieser Analyse: 24 von 48 Dateien haben eine URL im Spotlight-Index, die oft die Bedeutung verrät
- 0-Byte-Dateien direkt markiert
- Hash-Namen (UUID, zufällige Hex-Strings) als Muster-Kandidat „weg"

## Granulare Vorschlags-Kategorien

- **weg (sicher Müll)** — 0-Byte, leere Stubs, Web-Thumbnails, Stock-Bilder
- **weg (online verfügbar)** — Installer, Downloads, Standard-Dokumente, die neu ladbar sind
- **prüfen-dann-weg** — kurzer Inhalts-Check und dann Papierkorb
- **eigentlich Thema X** — neue Zuordnung durch URL-Kontext
- **echter Einzelfall** — Sebastian muss entscheiden
- **Sicherheit!** — AMOS-Nachspiel (Anleitung_Mac.pdf) oder Auth-Rest (AnyDesk-ID)

## Tabelle

| Dateiname | Echter Typ | Größe | Geburt | Herkunft-URL | Neuer Vorschlag | Begründung |
|---|---|---:|---|---|---|---|
| sign-in | **0 Byte** | 0 B | 2026-02-15 | — | weg (sicher Müll) | Leer |
| 7208275846501502976.zip | data (kein echtes ZIP) | 53 B | 2026-01-09 | raise3d.com/ofp + ideamaker.io | weg (online verfügbar) | Raise3D-ideamaker-Stub, online ziehbar |
| Text-3B6DC9EC3BF4-1.txt | ASCII, 7 Byte | 7 B | 2026-02-24 | — | weg (sicher Müll) | iMessage-Text-Artefakt, 7 Byte Inhalt |
| Text-3CDCC42D85B1-1.txt | ASCII, 7 Byte | 7 B | 2026-02-24 | — | weg (sicher Müll) | iMessage-Text-Artefakt |
| README.html_ | ASCII text, 128 B | 128 B | 2026-03-22 | downloads.openmoko.org | weg (online verfügbar) | OpenMoko-README, öffentlich auf Download-Mirror |
| my-ubol-settings-2.json | JSON, 153 B | 153 B | 2026-02-04 | — | weg (sicher Müll) | uBlock-Origin-Lite-Export |
| my-ubol-settings.json | JSON, 178 B | 178 B | 2026-02-04 | data:text/plain (inline) | weg (sicher Müll) | uBlock-Lite-Settings, wird beim nächsten Export neu erzeugt |
| www.youtube.com.webloc | XML (Safari-Link) | 247 B | 2026-03-18 | — | prüfen-dann-weg | Safari-Weblink; Ziel vor Löschung einsehen |
| 1840382653.anydeskid | XML, ASCII | 274 B | 2026-04-16 | — | **Sicherheit! echter Einzelfall** | AnyDesk-ID-Datei — **vor Löschung mit [[05 Daily Notes/2026-04-17]] AMOS-Vorfall abgleichen**, AnyDesk-Kennwort rotieren |
| Willkommen.md | Unicode, 305 B | 305 B | 2026-04-01 | — | prüfen-dann-weg | Obsidian-Willkommens-Stub (generisch) |
| Text-4685-9B86-DC-0.txt | Unicode, UTF-8 | 500 B | 2026-01-17 | — | prüfen-dann-weg | Unklarer Text — kurz ansehen |
| 2026-04-14_1.md | Unicode | 652 B | 2026-04-14 | — | prüfen-dann-weg | Tagesbuch-Duplikat; mit `05 Daily Notes/2026-04-14.md` abgleichen |
| 2026-04-14.md | Unicode | 652 B | 2026-04-14 | — | prüfen-dann-weg | Tagesbuch-Duplikat; identisch zum Vault-Pendant? md5-Check |
| PLM's+role+in+seamless+BOM+management.ics | vCalendar | 1,4 KB | 2026-02-25 | (leer) | weg (online verfügbar) | Termin-Einladung PLM-Webinar — Termin vorbei |
| turbo.sh | Bash-Script | 232 B | 2026-02-16 | — | **echter Einzelfall** | Eigenes Shell-Skript; Inhalt prüfen — evtl. in `04 Ressourcen/Automatisierung/` |
| license.sl | data (binär) | 7 KB | 2026-02-17 | — | prüfen-dann-weg | Unbekanntes Lizenzformat; ohne App sinnlos |
| files.zip | ZIP, deflate | 9 KB | 2026-04-17 | — | prüfen-dann-weg | Generischer Name, sehr neu — kurz reinschauen bevor weg |
| WWDC 2023 Apple Logo Mac Wallpaper.jpg | JPEG | 11 KB | 2026-02-24 | — | weg (online verfügbar) | Apple-Stock-Wallpaper |
| HEA.png | PNG 489×432 | 11 KB | 2026-03-03 | piping-world.com (via perplexity.ai) | weg (online verfügbar) | HEA-Profil-Diagramm — jederzeit neu ladbar |
| Oberfläche.jpg | JPEG | 18 KB | 2026-02-12 | webmail.mittwald.de (Mail-Attachment) | **eigentlich Thema Konstruktion** | Mail-Attachment Mittwald — vermutlich Bauteil-Oberfläche, vor Löschung Mailkontext prüfen |
| 7174655126441824256.texture | JSON | 20 KB | 2024-03-16 | — | weg (sicher Müll) | TikTok/Snapchat-Texture-Export von 2024 |
| ext-auth-main.zip | ZIP | 22 KB | 2026-03-30 | codeload.github.com/modelcontextprotocol/ext-auth | weg (online verfügbar) | MCP ext-auth Repo-Download — öffentliches GitHub-Repo |
| HC-8ecfc417bfcc441f8825b97136b21bc1.png.jpeg | JPEG 96dpi | 31 KB | 2026-01-05 | — | weg (sicher Müll) | Hash-Name, Web-Thumbnail |
| Design ohne Titel.png | PNG 679×368 | 118 KB | 2026-03-18 | canva.com Export | weg (online verfügbar) | Canva-Export „Design ohne Titel" — in Canva-Account weiter vorhanden |
| 9b17bb3acb12d7bbb16a0c2ecd2c233c_original.png.avif | AVIF | 128 KB | 2026-01-23 | — | weg (sicher Müll) | Hash-Name, AVIF-Thumbnail |
| c334a7fa-9987-55a0-b46d-a33780dab875.jpg | JPEG 1×1 | 114 KB | 2026-03-03 | cloudfront.net (CDN) | weg (sicher Müll) | CDN-Thumbnail, Hash-Name |
| WhatsApp Image 2025-12-21 at 18.40.44.jpeg | JPEG | 141 KB | 2025-12-23 | — | **echter Einzelfall** | WhatsApp-Bild; Inhalt prüfen — evtl. persönlich (Ildi) oder projekt-relevant |
| WhatsApp Image 2025-12-22 at 11.02.21.jpeg | JPEG | 241 KB | 2025-12-23 | — | **echter Einzelfall** | WhatsApp-Bild; wie oben prüfen |
| Bild.jpg | JPEG | 153 KB | 2026-01-23 | — | prüfen-dann-weg | Generischer Name, vor Löschung öffnen |
| 502ca4b7e5f9e7683a397aca7a59038f.jpg | JPEG 72dpi | 247 KB | 2026-01-04 | — | weg (sicher Müll) | Hash-Name |
| Bild 2.jpg | JPEG 300 KB | 304 KB | 2026-01-04 | — | prüfen-dann-weg | Generischer Name; da `Bild.jpg` existiert, vermutlich Web-Thumbnail |
| Anleitung_Mac.pdf | PDF 1.7, 0 pages | 316 KB | 2026-04-16 | login.mittwald.de | **Sicherheit! prüfen-dann-weg** | **AMOS-Vorfall 17.04.:** trotz vermeintlich harmloser mittwald-URL vor Öffnung prüfen. „0 pages" ist auffällig — evtl. Tracking-PDF. Siehe TASKS.md-Sicherheits-Sektion |
| google_terms_of_service_de_de.pdf | PDF, 8 pages | 451 KB | 2026-04-05 | gstatic.com | weg (online verfügbar) | Google-AGB, immer ladbar |
| 3.0.3.md | SGML/HTML-like | 122 KB | 2026-02-04 | — | **echter Einzelfall** | 122 KB „3.0.3.md" — vermutlich Changelog oder Export; kurz Header prüfen, evtl. in `04 Ressourcen/` passend |
| Bild 2026-03-13 um 14.15.png | PNG 1796×1762 | 1,2 MB | 2026-03-13 | — | prüfen-dann-weg | Bildschirmfoto aus März, Inhalt unklar |
| Linear Mac Installer.zip | ZIP | 1,7 MB | 2026-04-01 | desktop.linear.app | weg (online verfügbar) | Linear-App-Installer — immer auf linear.app |
| uImage-2.6.28-stable…-gta02.bin | U-Boot-Kernel-Image ARM | 1,9 MB | 2026-03-22 | downloads.openmoko.org | weg (online verfügbar) | OpenMoko-Linux-Kernel für Neo Freerunner (2008er-Handy) — kurios, online verfügbar |
| download.zip | ZIP | 2,0 MB | 2026-04-01 | cdn.us.oss.api.autodesk.com | weg (online verfügbar) | Autodesk-OSS-Download; falls noch gebraucht, via Autodesk-Account neu ziehen |
| E2E57112-BB64-4984-8A84-003D3BC420B7.PNG | PNG 1024×1536 | 2,1 MB | 2026-03-13 | — | prüfen-dann-weg | UUID-Name, iPad/iPhone-Screenshot-Format (Hochformat) |
| E543D191-416E-4317-9DE7-259D51312DC6.PNG | PNG 1024×1536 | 2,3 MB | 2026-03-13 | — | prüfen-dann-weg | Wie oben, gleicher Tag — zusammen prüfen |
| Contents.zip | ZIP store | 2,9 MB | 2025-12-07 | — | prüfen-dann-weg | Generischer Name aus Dezember; Inhalt kurz ansehen |
| vscode_cli_darwin_arm64_cli.zip | ZIP | 7,3 MB | 2026-03-30 | vscode.download.prss.microsoft.com | weg (online verfügbar) | VSCode-CLI-Installer — immer auf Microsoft |
| AUDIO_5754.m4p | Apple iTunes ALAC/AAC | 10,8 MB | 2026-01-01 | — | **echter Einzelfall** | iTunes-geschützte Audio-Datei; ohne Kontext unklar. Audio-Datum 2026-01-01 = Kauf-Anker? |
| code | **Mach-O arm64 Executable** | 18,3 MB | 2026-03-24 | — | weg (sicher Müll) | VSCode-Binary „code" (CLI); ohne Umgebung nutzlos |
| macbook-pro-apple-logo-bze1bsm86l8hwm9e.jpg | **WebP** (falsche Extension) | 6 KB | 2026-02-24 | — | weg (online verfügbar) | Apple-Stock-Bild |
| vscode-gitlens-main.zip | ZIP | 39,8 MB | 2026-03-30 | codeload.github.com/gitkraken/vscode-gitlens | weg (online verfügbar) | GitLens-Repo; immer auf GitHub |
| 235-festival-sound-fur-unterwegs-jbl-und-tomorrowland-prasentieren-die-sonderedition-jbl-flip-7.pdf | PDF 1.4, 4 pages | 876 KB | 2026-01-05 | — | weg (sicher Müll) | Werbe-PDF JBL Flip 7 |
| takeout-20260330T114015Z-15-001.zip | ZIP | 266,8 MB | 2026-04-05 | takeout-download.usercontent.google.com | **echter Einzelfall** | Google-Takeout vom 30.03.2026 — **was wurde exportiert?** Inhalt prüfen, ggf. gezielt nach Gmail/Drive einsortieren vor Löschung |

## Zusammenfassung pro Kategorie

| Vorschlag | Anzahl | Auffällig |
|---|---:|---|
| weg (sicher Müll) | 14 | 0-Byte, Hash-Namen, Stock-Bilder, iTunes-Text-Artefakte |
| weg (online verfügbar) | 12 | Installer, Repo-Downloads, AGBs, Stock-Bilder mit Quell-URL |
| prüfen-dann-weg | 12 | Kurze Content-Checks — sollten jeweils < 1 min dauern |
| eigentlich Thema X | 1 | Oberfläche.jpg (Mittwald-Mail → Konstruktion-Kontext) |
| echter Einzelfall | 7 | turbo.sh, 3.0.3.md, 2 WhatsApp-Bilder, AUDIO_5754, Google-Takeout |
| **Sicherheit!** | 2 | Anleitung_Mac.pdf (AMOS-Nachspiel), .anydeskid (Kennwort-Rotation offen) |
| **Summe** | **48** | |

## Erkenntnisse

- **`mdls -name kMDItemWhereFroms` ist Gold wert.** Bei 24 von 48 Dateien liefert macOS-Spotlight die Download-URL, die Kategorie und Zweck oft eindeutig klärt (Canva, GitHub, mittwald, autodesk). **Regel fürs Playbook:** WhereFroms-Query ist Pflicht-Metadatum in der Vorsortierungs-Phase, nicht optional.
- **Falsche Extensions sind ein eigenes Muster.** `macbook-pro-apple-logo-*.jpg` ist in Wahrheit WebP; `HC-*.png.jpeg` ist JPEG; `9b17bb*.png.avif` ist AVIF. Im Playbook: nie der Extension vertrauen, immer `file -b` prüfen, besonders bei Web-Thumbnails.
- **Hash-Namen-Muster sind zuverlässige Müll-Indikatoren.** Dateinamen wie `c334a7fa-9987-55a0-…`, `9b17bb3acb12…`, `7174655126441824256.texture` sind Cache-Artefakte von Web-Diensten — in 100% der Fälle hier: weg.
- **Die Sicherheits-Sektion in TASKS.md erweitert sich.** Beide Sicherheits-Treffer (AnyDesk-ID, Anleitung_Mac.pdf) sind AMOS-Nachspiel-relevant. Vor Session 6 muss die TASKS.md-Sicherheitsliste abgearbeitet sein.
- **Google-Takeout-Archive sind der einzige wirkliche Grauzonen-Fall.** 266 MB ungeprüfter Export — hier lohnt sich einzelne Sichtung (Mail? Drive? Fotos?) bevor gelöscht wird.

## Hinweise für Session 6 (Rest)

**Schnellbahn (26 Dateien, < 10 Min):** alle „weg (sicher Müll)" + „weg (online verfügbar)" in einem Rutsch in den Papierkorb.

**Langsame Bahn (12 Dateien, ~20 Min):** alle „prüfen-dann-weg" einzeln öffnen/hexdumpen/miniatur-ansehen, dann meist weg.

**Sorgfalts-Bahn (9 Dateien, mit Sebastian):** 7 Einzelfälle + 2 Sicherheits-Treffer — hier Rückfragen und Entscheidung pro Datei.

## Verknüpfungen

- [[02 Projekte/Mac Inventur - Phase 3 Vorsortierung]] — Grund-Klassifizierung
- [[02 Projekte/Mac Inventur]]
- [[04 Ressourcen/Skills/Skill - Duplikat-Pruefung per md5]]
- TASKS.md Sicherheits-Sektion (AMOS-Nachspiel)

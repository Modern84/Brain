---
tags: [inbox, mthreed, anthropic, mail-entwurf]
date: 2026-04-29
status: entwurf-v2
---

# Mail-Entwurf an Anthropic — API-Wechsel + Startup Program

**Empfänger:** support@anthropic.com
**Betreff:** Anfrage: API-Wechsel und Anthropic Startup Program für mThreeD.io
**Anhang geplant:** Screenshot Nutzungsfenster (Max 5x, Wochenlimit + Zusatznutzung)
**Zweck:** Sales/Support-Routing intern. Parallel separate Bewerbung über anthropic.com/startups geplant.

**v2-Änderungen gegenüber v1 (basierend auf CC-Faktencheck + Reiner-Strang ergänzt):**

1. AMOS-Vorfall: 17.04. statt 19.04. korrigiert
2. Security-Liste sachlich auf Belegstand zurückgeführt
3. „CAN-Bus stabil" → „CAN-Bus produktiv"
4. Steuer-Passus: „gerade" gestrichen
5. Drei weiche Formulierungen gestrafft („bevor ich blind …", „Ich vermute …", „dürft gerne …")
6. Nutzungs-Absatz auf groberen Wortlaut umgestellt — exakte Zahlen kommen über den Screenshot
7. **NEU: Reiner-Strang als eigener Block** — 30 Jahre Konstruktionswissen, KI als Brücke, Knowledge-Preservation als Use-Case
8. **NEU: LRS-Live-Beleg** — Audio-zu-strukturiertem-Text als konkretes Beispiel, was Claude für mich leistet

---

## Entwurf v2 (versandfertig nach finaler Sichtung)

Hallo Anthropic-Team,

ich melde mich, weil mein Nutzungsprofil über das hinausgewachsen ist, was Claude Max sinnvoll abdeckt. Es ist Zeit, das Setup direkt mit euch zu klären, bevor der nächste Zyklus startet. Der saubere Weg führt aus meiner Sicht Richtung API plus Anthropic Startup Program. Falls Sales/Startup-Programm der richtige Kanal ist, bitte intern weiterleiten.

**Wer ich bin**

Sebastian Hartmann, Konstrukteur im Bereich Additive Fertigung, aus Pirna (Sachsen). Werdegang in Stichworten: gelernter Tischler und Wasserinstallateur, autodidaktischer Umstieg auf CAD und 3D-Druck, eigene Firma „dreiB" mit über 4.000 verkauften Einheiten des „ostdeutschen Turboladers" (~200.000 € Umsatz über drei Jahre), nach Trennung vom Geschäftspartner aktuell Festanstellung als Konstrukteur bei WEC plus Aufbau meiner eigenen Marke mThreeD.io. Abgerechnet wird über ein kleines Gewerbe meiner Partnerin Ildikó in Ungarn (KATA), während ich operativ aus Deutschland arbeite — die DE/HU-Konstruktion wird mit Steuerberater geklärt.

Ich bin INTP, mit Lese-Rechtschreib-Schwäche. Das ist deshalb für euch relevant, weil es erklärt, was Claude für mich konkret leistet — und warum ich nicht der typische „Chat-Power-User" bin. Ich bin in komplexen technischen Systemen sehr stark, kämpfe aber mit unstrukturierter Routinearbeit und mit Schriftsprache. Texte zu schreiben ist für mich eine Mauer; sprechen geht. Diese Mail entsteht gerade, weil ich Claude diktiere und das System aus dem Audio-Stream einen sauberen, strukturierten Entwurf macht, den ich danach prüfe und freigebe. Der Mehrwert ist nicht „bequemer", sondern Zugang zu Kommunikationsformen, die mir sonst verschlossen wären. Das ist der ehrlichste Hebel, den ich je aus einem Tool gezogen habe.

**Was ich mit Claude konkret baue**

Drei Stränge, alle aktiv:

1) **WEC-Engineering-Pipeline** mit meinem Konstruktions-Kollegen Reiner (über 30 Jahre selbstständig im Maschinenbau, SolidWorks). Ziel: Kundenanfrage → Konstruktion → Zeichnung → BOM → PDF-Patcher → Versand, automatisiert. Aktueller Pilot: Lagerschalenhalter für die Lebensmittelindustrie (White-Label über Volker Bens). Bereits umgesetzt: zwei Generationen PDF-Patcher (`v4_patcher`, `v5_patcher`) auf pymupdf-Basis, mit Mapping-Files, Staging-Ordner, Audit-Liste und expliziter Freigabe-Stufe vor jedem Outbound. Mittelfristiges Ziel: das Ganze auf Cloudflare Workers/R2 als Backend.

2) **ProForge 5 / Klipper-Voron-Stack** — eigenes 3D-Drucker-Projekt mit Tool-Picker (5 swappable Hotend-Module PH1–PH5, Servo-Lock, EBB36-Carriage, Eddy Probe), Klipper auf Pi 5, eigener Service rund um Klipper/Voron-Debug in Vorbereitung. Aktueller Stand: alle 5 SO3-Toolhead-Boards mit individueller Firmware geflasht (v0.13.0-623, Pi-Reboot-persistent verifiziert), CAN-Bus produktiv, gs_usb-Watchdog mit systemd-Timer deployed, CVE-2025-68307-Patch verifiziert wirksam (0 Kernel-Events seit dem Fix), Architektur-Review abgeschlossen unter dem harten Constraint „5 vollständige Toolheads mit eigenem Extruder pro Material".

3) **Reiners zweites Gehirn** — und das ist der Strang, der mir am meisten am Herzen liegt. Reiner hat über 30 Jahre Ingenieurbüro-Wissen in Aktenordnern, Köpfen und SolidWorks-Dateien angesammelt. Durch finanzielle Rückschläge ist sein operativer Betrieb auf eine Mini-Operation reduziert; er arbeitet pragmatisch papierbasiert und kann am Computer zwei Ordner öffnen. Mein Ziel ist, dieses Wissen über einen geteilten Obsidian-Vault einzupflegen und ihm auf dieser Basis ein **Betriebssystem zu bauen, das sich an seine Realität anpasst, nicht umgekehrt**: Claude Desktop auf seinem Windows-PC mit gefiltertem Sub-Vault (nur WEC-Bereiche sichtbar), AnyDesk-Fernzugriff für Wartung durch mich, Sprache und Workflow auf seinem Niveau. Mittelfristig kommt Claude-Integration in Fusion und SolidWorks dazu (CAD-API → Geometrie + Stückliste + Zeichnungsableitung als zusammenhängender Prozess statt drei getrennter Schritte). Das ist Knowledge-Preservation für einen 70-jährigen Konstrukteur — KI als Brücke zwischen vorhandener Erfahrung und einer Person, die die digitalen Werkzeuge nicht mehr selbst durchdringen kann. Der Mehrwert für ihn ist existenziell, der Use-Case für eine alternde Industriebasis ist generalisierbar.

Dazu produktiv: Cloudflare Tunnel für `drucker.mthreed.io` mit Zero-Trust-Access (Sebastian, Reiner, Ildikó), Read-Only-Proxy für externe Mainsail-Gäste (aiohttp, schreibende JSON-RPC-Calls geblockt, Notaus erlaubt), Security-Hardening nach einem AMOS- und Odyssey-Vorfall am 17.04. (SSH-Key-Only auf Pi und Mac, Keychain-Migration laufend, Daily-Sync per launchd).

Claude Code (CLI, Opus 4.7) ist meine zentrale Arbeitsumgebung. Daneben pflege ich einen Obsidian-Vault als Single Source of Truth (eigene CLAUDE.md mit verbindlichen Regeln, Filesystem-Connector zu claude.ai), aus dem heraus zwei Claude-Instanzen koordiniert arbeiten: claude.ai als Kopf (Strategie, Recherche, Prompt-Entwurf) und Claude Code als Hände (Ausführung, Pi, Hardware). Reiner bekommt den gefilterten Sub-Vault auf seinem Windows-PC.

**Meine Nutzungs-Realität**

Claude Max (5x) im aktuellen Zyklus: gut die Hälfte des Wochenlimits verbraucht, dazu deutlich über 80 % des Monats-Top-Ups, Auto-Aufladung aktiv (Reset 1. Mai). Screenshot im Anhang. Das Muster der letzten Wochen war konstant: Max läuft voll, Auto-Top-Up zieht nach.

Mir ist klar, wo das herkommt. Die WEC-Pipeline und der Klipper-Service sind keine Chat-Workloads, das sind API-Workloads, die ich aus Bequemlichkeit über das Chat-Frontend gefahren habe. Das ist der teuerste mögliche Weg.

**Was ich von euch brauche**

Konkret zwei Fragen:

1. **Anthropic Startup Program** — qualifiziert sich mThreeD.io? Wir sind klein, aber real: eingetragenes Gewerbe, laufende Kundenarbeit, definierte Roadmap mit konkreten API-Use-Cases (PDF-Patcher → Workers, Klipper-Debug-Service, Engineering-Pipeline, CAD-API-Integration für Reiners Vault). Architektur-Skizzen, Code-Auszüge und Pipeline-Beschreibungen liefere ich auf Anfrage.

2. **Sinnvolle Konstruktion für mein Profil** — Max behalten für interaktive Arbeit über claude.ai/Claude Code, separater API-Account für Pipeline-Workloads. Falls es für dieses Lastprofil eine bessere Konstruktion gibt, gerne nennen.

Account-Einsicht ist freigegeben, das Profil spricht für sich. Architektur-Details, Logs oder Vault-Auszüge liefere ich auf Anfrage nach.

Viele Grüße
Sebastian Hartmann
mThreeD.io
Steinplatz 26 WG, 01796 Pirna, Deutschland
+49 162 9111531
modern3b@icloud.com

---

## Verknüpfungen

- [[00 Kontext/Über mich]]
- [[00 Kontext/MBTI - INTP Einordnung]]
- [[00 Kontext/WEC Kontakte/Profil Reiner]]
- [[03 Bereiche/Business MThreeD.io/Business MThreeD.io]]
- [[03 Bereiche/WEC/Shared Brain Architektur]]
- [[CLAUDE]] (Auftreten nach außen)
- [[TASKS]]

---

## Archiv: v1 + CC-Faktencheck

Vorgängerversion und vollständiger CC-Befund unter Versionsstand v1 verfügbar (vor v2-Edit gespeichert in Backup-Datei, falls Vergleich gebraucht wird). Korrekturen sind in v2 oben vollständig eingearbeitet.

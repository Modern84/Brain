---
tags: [skill, mthreed, produkt, klipper]
status: konzept
date: 2026-04-18
---

# Skill — Klipper KI-Debug-Tunnel

## Was das ist

**Das ist Sebastians eigenes Produkt unter der MThreeD-Marke** — ein Remote-Debug-Service für Voron- und Klipper-3D-Drucker. Kunden installieren auf ihrem Drucker-Host (Pi mit Klipper/Moonraker) einen Tunnel-Client, der auf Anfrage einen sicheren Kanal zu Sebastians Infrastruktur aufbaut. Sebastian (und Claude) analysieren dann live Logs, Konfigurationen und Fehlercodes und geben Fix-Vorschläge — auch direkt als Config-Patch.

**Wichtig: Das ist nicht Teil des WEC-Gemeinschaftsprojekts mit Reiner.** Es ist Sebastians eigene IP, eigener Bugfix-Katalog, eigenes Brain. Bei Arbeit daran nicht automatisch als Reiner-Thema framen.

## Wann anwenden

- Kunde meldet Drucker-Problem das er selbst nicht lösen kann
- Wiederkehrende Klipper-Fehler bei Kunden dokumentieren und als Wissensbasis aufbauen
- Landing-Page und Produktseite aufbauen (Entwurf liegt bereits im Eingang)
- Auslöser beim Sprechen: „eigenes Produkt", „mein Ding", „Debug-Service", „Klipper-Kunden"

## Wie (Kurzanleitung)

**Technische Grundlage (noch zu bauen):**

1. [[Skill - Cloudflare Tunnel]] als Transport-Schicht
2. Klipper/Moonraker-Installation beim Kunden (Voraussetzung)
3. Klient-Skript das Logs, printer.cfg und Moonraker-Status einsammelt und Sebastian zeigt
4. Sichere Authentifizierung (On-Demand-Tunnel, nicht dauerhaft offen)
5. Debug-Workflow: Claude analysiert → Patch vorschlagen → gemeinsam mit Kunde ausrollen

**Business-Seite:**

- Landing-Page auf mthreed.io (Entwurf: [[03 Bereiche/Business MThreeD.io/Entwurf - Landing-Page mThreeD.io Debug-Tunnel]])
- Preismodell: pro Debug-Session oder Abo
- Kundenakquise über Klipper/Voron-Community (Discord, Reddit, Discourse)

## Stand der Beherrschung

**konzept** — Strategische Richtung am 2026-04-17 geklärt ([[03 Bereiche/Business MThreeD.io/Strategie - mThreeD.io KI-Debug-Tunnel als eigenes Produkt]]). Landing-Page-Entwurf existiert. Technisch noch nichts umgesetzt.

**Nächste Meilensteine:**
- [[Skill - Cloudflare Tunnel]] erst beherrschen
- Prototyp-Setup auf eigenem ProForge5 als Demo
- Erster Testkunde aus der Community

## Abhängigkeiten

- [[Skill - Cloudflare Tunnel]] — ohne das kein Tunnel
- [[Skill - Klipper-Firmware flashen]] — Grundverständnis der Drucker-Plattform
- klipper-mcp (MCP-Server für Claude → Klipper) — bereits vorhanden
- Domain mthreed.io (vorhanden)

## Referenzen

- [[03 Bereiche/Business MThreeD.io/Strategie - mThreeD.io KI-Debug-Tunnel als eigenes Produkt]]
- [[03 Bereiche/Business MThreeD.io/Entwurf - Landing-Page mThreeD.io Debug-Tunnel]]
- [[03 Bereiche/Business MThreeD.io/Business MThreeD.io]]
- [[04 Ressourcen/Klipper/Klipper]]
- [[02 Projekte/ProForge5 Build]] — Sebastians eigener Drucker als Test-Plattform

## Lessons Learned

*Wird bei erster Umsetzung gefüllt.*

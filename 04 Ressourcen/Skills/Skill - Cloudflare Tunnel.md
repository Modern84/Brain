---
tags: [skill, netzwerk, cloudflare]
status: konzept
date: 2026-04-18
---

# Skill — Cloudflare Tunnel

## Was das ist

Cloudflare-Tunnel machen lokale Dienste (Pi, ProForge5, Drucker-Mainsail, Obsidian-Sync) **von überall auf der Welt erreichbar** — ohne Portweiterleitung, ohne feste IP, ohne VPN-Client beim Zugreifenden. Der Tunnel läuft als Daemon auf dem lokalen Gerät und baut eine ausgehende Verbindung zu Cloudflare auf. Zugriff erfolgt über eine eigene Subdomain (z.B. `proforge5.mthreed.io`).

## Wann anwenden

- Drucker von außen überwachen oder steuern (Mainsail/Fluidd)
- Auf Pi oder Mac SSH'en ohne Tailscale-Client
- Obsidian-Gehirn oder andere Dienste für Reiner/Kunden zugänglich machen
- **Kerntechnik für das MThreeD-Produkt** [[Skill - Klipper KI-Debug-Tunnel]]
- Auslöser beim Sprechen: „von außen", „remote", „Reiner soll zugreifen", „Debug-Service"

## Wie (Kurzanleitung)

1. `cloudflared` installieren (Mac: `brew install cloudflare/cloudflare/cloudflared` / Pi: apt)
2. `cloudflared login` — öffnet Browser, Cloudflare-Account (modern3b@icloud.com) autorisieren
3. `cloudflared tunnel create <name>` — erzeugt Tunnel-UUID
4. Config-Datei `~/.cloudflared/config.yml` anlegen mit Mapping `subdomain → lokaler Port`
5. DNS-Eintrag setzen: `cloudflared tunnel route dns <name> <subdomain.domain>`
6. Tunnel starten: `cloudflared tunnel run <name>`
7. Für Dauerbetrieb: als System-Service einrichten (launchd auf Mac, systemd auf Pi)

Detaillierte Schritte werden beim ersten Einsatz ergänzt.

## Stand der Beherrschung

**konzept** — Cloudflare-Account existiert und hat drei Domains (mthreed.io, mtreed.io, sebest184.cc). Tunnel sind geplant aber noch nicht eingerichtet. Erste Umsetzung: ProForge5 und Pi 5 extern erreichbar machen.

## Abhängigkeiten

- Cloudflare-Account (vorhanden)
- Domain auf Cloudflare (mthreed.io, mtreed.io, sebest184.cc — alle vorhanden)
- Gerät das immer online ist (Pi 5 oder Mac)
- [[Skill - Raspberry Pi headless Setup]]

## Referenzen

- [[04 Ressourcen/Cloudflare Access - Zugangsverwaltung]]
- [[03 Bereiche/KI-Anwendungen/KI-Anwendungen]]
- Cloudflare-Doku: https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/

## Lessons Learned

*Wird bei erster Umsetzung gefüllt.*

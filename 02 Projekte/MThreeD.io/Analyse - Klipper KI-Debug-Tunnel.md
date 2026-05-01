---
tags: [projekt, mthreed, mos-eigenes, strategie, klipper, ki-tunnel]
status: entscheidungsreif
date: 2026-04-17
abgrenzung: Mos eigene Produktspur — NICHT Reiner-WEC, NICHT Konstruktions-Pipeline
verknuepft: ["[[_MThreeD.io]]", "[[03 Bereiche/Business MThreeD.io/Strategie - mThreeD.io KI-Debug-Tunnel als eigenes Produkt]]", "[[03 Bereiche/Business MThreeD.io/Entwurf - Landing-Page mThreeD.io Debug-Tunnel]]"]
---

# Analyse — Klipper KI-Debug-Tunnel

> **Kurzform dieser Datei:** Strategische Einordnung und Entscheidungsstand. Vollständige Analyse mit allen Quellen und Modellen: [[03 Bereiche/Business MThreeD.io/Strategie - mThreeD.io KI-Debug-Tunnel als eigenes Produkt]]

---

## Was es ist

Ein KI-gestützter Remote-Debug-Service für Klipper-basierte 3D-Drucker. Der Nutzer startet ein Install-Script auf seinem Pi, öffnet einen zeitlich begrenzten Cloudflare-Tunnel, die KI liest `printer.cfg`, `klippy.log`, `dmesg`, CAN-Bus-Status — und liefert einen verifizierten Fix zurück. Komplett ohne Zugangsdaten-Speicherung auf der Anbieterseite.

Das ist Mos eigener ProForge-5-Debugging-Workflow, als Produkt verpackt.

---

## Markt

- Voron-Markt: über 15.000 gebaute Drucker (Stand 2025)
- Klipper-Gesamtmarkt (Sovol SV08, Troodon, Custom-Builds): sechsstellig
- ProForge 5 Kickstarter: 100 Backer à £1.714 — kleine, zahlungsstarke Nische
- Snapmaker U1 Kickstarter 2025: 20 Mio. Dollar, 20.206 Backer — Tool-Changer-Markt boomt

## Lücke

Obico/OctoEverywhere machen visuelle AI-Fehlererkennung (Webcam → Spaghetti-Detektion). Niemand macht: KI dockt via Tunnel an Klipper an, liest Configs/Logs, generiert Fix, spielt zurück, verifiziert.

---

## Strategische Modelle

| Modell | Beschreibung | Empfehlung |
|---|---|---|
| **A** | Makertech-Partnerschaft (Revenue-Share) | Bonus-Kanal nach PoC |
| **B** | Unabhängiger Klipper-Debug-Service für alle | ⭐ **MVP — jetzt** |
| **C** | Kickstarter: Voron-CAN-Upgrade-Kit + 12 Monate Flatrate | Wachstumsstufe nach B |

**Empfehlung: B als MVP, C als nächste Stufe.**

---

## Preismodell (zu testen)

- Pay-per-Session: 25 €
- Pro Flatrate: 10 €/Monat
- Beta: erste 5 Nutzer kostenlos gegen Feedback

---

## Technische Basis (bereits vorhanden)

- `drucker.mthreed.io` live, Cloudflare Tunnel + Access eingerichtet
- Read-Only-Proxy auf Pi (externe Gäste sehen Mainsail, können nichts steuern)
- Ephemerer Tunnel mit Session-Token — Zugangsdaten-Sicherheit strukturell gelöst

---

## Architektur-Match: Managed Agents (Beta)

**Befund 2026-05-01:** Anthropic Managed Agents (Beta `managed-agents-2026-04-01`) ist architektonisch genau auf dieses Profil zugeschnitten. Wörtlich aus der Overview-Doku: *„Long-running, Multi-Tenant-Sessions, Anthropic übernimmt Hosting + Auth-Refresh."*

Konkret passend:
- **Kunde startet die Session**, nicht Mo — die Session ist pro Drucker-Debug-Anfrage.
- **Long-running, multi-step, autonom** — exakt das Workload-Profil, für das die API laut Doku gebaut wurde.
- **Cloud-Container mit Tools** (Bash, File-Ops, Web) ohne dass Mo eine eigene Sandbox/Agent-Loop bauen muss.
- **MCP-Anbindung** an Klipper-Logs/Mainsail über den Cloudflare-Tunnel, den der Kunde eh hat.
- **Vault-IDs** für OAuth-Token-Refresh — Anthropic verwaltet Credentials, Mo betreibt keine Token-Infrastruktur.
- **Agent-Versionierung** — Prompt/Tools/MCPs lassen sich versionieren, ohne dass parallele Sessions kaputtgehen.

Status: Beta `managed-agents-2026-04-01`, alle API-Accounts haben Zugang per Default. Bestimmte Features (outcomes, multi-agent) sind Research-Preview mit Antrag.

**Konsequenz für PoC:** Statt eigene Agent-Loop + Container-Sandbox + Auth-Refresh bauen → Managed-Agents-Stack nutzen. Der PoC-Aufwand verschiebt sich von „Infrastruktur" auf „MCP-Server für Klipper-Logs" und „System-Prompt + Tool-Whitelist". Das ist der eigentliche Wert-Hebel.

Doku: https://platform.claude.com/docs/en/managed-agents/overview

Verworfener Pilot-Pfad: [[02 Projekte/Brain-Pflege-Agent (Managed-Agents-Pilot)]] — Brain-Vault ist als lokaler Use-Case ungeeignet, Klipper-Tunnel ist der echte Match.

---

## Markenkern

**mThreeD.io** = `.io` auf Englisch (input/output, Tech-SaaS-Konnotation) + `.io` auf Deutsch gelesen = „i.O." (in Ordnung, Qualitätsversprechen). Für einen Debug-Service quasi perfekt.

**Hook:** „Drucker nicht i.O.? → mThreeD.io"  
**Schreibweise:** immer **mThreeD.io** mit Großbuchstaben (Lesart: „em-Three-D-i-O")

---

## Nächste Schritte

- [ ] Makertech Discord + Voron-Forum still beobachten (2 Wochen, Top-10-Probleme auflisten)
- [ ] Technisches PoC: Install-Script + Cloudflare-Tunnel + Claude-Code-Session-Flow
- [ ] Landing-Page `mthreed.io`: E-Mail-Capture, Hook, drei-Schritte-Erklärung → [[03 Bereiche/Business MThreeD.io/Entwurf - Landing-Page mThreeD.io Debug-Tunnel]]
- [ ] Erste 5 Beta-Nutzer aus Voron-Discord, kostenlos gegen Feedback
- [ ] Preistest: 15 / 25 / 35 € Conversion-Quote messen
- [ ] Makertech kontaktieren erst **nach** PoC (partnership@makertech3d.com)
- [ ] AGB + DSGVO-Setup vor erstem bezahlten Kunden
- [ ] Markenrecht prüfen: „mThreeD" als Wortmarke in DE/EU eintragen lassen?

---

## Abgrenzung

| mThreeD.io Produktspur (Mo) | WEC / Reiner-Spur |
|---|---|
| Klipper KI-Debug-Tunnel | Automatisierte Konstruktions-Pipeline |
| Mos eigenes IP + Bugfixes | Gemeinsames Projekt mit Reiner |
| SaaS / Pay-per-Session | B2B Ingenieurbüro-Workflow |
| Skalierbar ohne Reiner | Setzt Solid Edge + Reiners Wissen voraus |

Beide Spuren können sich später über mThreeD.io-Infrastruktur treffen — strategisch und finanziell aber getrennt führen.

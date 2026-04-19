---
tags: [projekt, mthreed, dach-projekt]
status: aktiv
date: 2026-04-04
---

# MThreeD.io — Dach-Projekt

> **Hub-Notiz.** Dies ist die zentrale Anlaufstelle für alles rund um MThreeD.io. Sub-Projekte liegen in diesem Ordner, laufende Bereichsthemen in `03 Bereiche/Business MThreeD.io/`, Wissen in `04 Ressourcen/`.

## Ziel

Aufbau von MThreeD.io als eigenständige Firma im Bereich Design, additive Fertigung und digitale Service-Plattformen. Von der Planung über die Konstruktion bis zum fertigen Produkt — und perspektivisch auch als Dienstleister für andere im Klipper-/3D-Druck-Ökosystem.

## Status

In Aufbau. Technische Infrastruktur steht (ProForge5 + Cloudflare + Access). Geschäftsmodell wird gerade strategisch geschärft (siehe [[Analyse - Klipper KI-Debug-Tunnel]]).

## Baumstruktur — wo liegt was

### `02 Projekte/MThreeD.io/` — dieser Ordner
Aktive MThreeD-spezifische Initiativen mit konkretem Ziel.

- **[[_MThreeD.io|Dashboard]]** — dieses Dokument
- **[[Analyse - Klipper KI-Debug-Tunnel]]** — strategische Analyse potenzielles neues Geschäftsmodell (17.04.2026)

### `02 Projekte/` — eigenständige Subprojekte
Technische Bauprojekte die Grundlage für MThreeD sind, aber eigenen Scope haben:

- [[02 Projekte/ProForge5 Build|ProForge5 Build]] — Hardware-Bauprojekt, erste Druckkapazität
- [[02 Projekte/Cloudflare Tunnel Setup — ProForge 5|Cloudflare Tunnel Setup — ProForge 5]] — Remote-Access-Infrastruktur
- [[02 Projekte/Stone Wolf Build|Stone Wolf Build]] — Zweiter Drucker (geplant)

### `03 Bereiche/Business MThreeD.io/` — laufende Themen ohne Enddatum
Was dauerhaft gepflegt werden muss.

- [[03 Bereiche/Business MThreeD.io/Business MThreeD.io|Business MThreeD.io]] — Bereichs-Hub
- [[03 Bereiche/Business MThreeD.io/Domains und Branding|Domains und Branding]]

### `00 Kontext/` — strategische Referenzdokumente
- [[00 Kontext/Angebot]] — was MThreeD.io anbietet
- [[00 Kontext/ICP]] — Zielkunden
- [[00 Kontext/Branding]] — Markenführung
- [[00 Kontext/Schreibstil]] — Kommunikationston

### `01 Inbox/` — verwandte Ideen, noch nicht sortiert
- [[01 Inbox/Idee - ProForge5 als Live-Service-Plattform]] — Vorläufer-Idee, spezifisch für ProForge5 (17.04.2026 Vormittag)
- [[01 Inbox/Vision - Automatisierte Konstruktions-Pipeline]] — CAD-Pipeline (WEC/MThreeD)
- [[01 Inbox/Idee - Claude SolidWorks Integration]] — API-Anbindung für Reiner
- [[01 Inbox/Idee - Apple-Strategie für WEC und MThreeD.io|Idee - Apple-Strategie für WEC und MThreeD.io]]

### `04 Ressourcen/` — Wissen und Referenzmaterial
- [[04 Ressourcen/Klipper/Klipper|Klipper-Wissen]] — Fundament für KI-Debug-Tunnel-Produkt
- [[04 Ressourcen/ostdeutschenturbolader/ostdeutschenturbolader|Ostdeutscher Turbolader]] — Referenzprojekt

## Strategische Initiativen

Drei parallele Arbeitslinien die zusammen MThreeD.io formen:

### 1. Kern-Business — Design & additive Fertigung
- Individuelle Konstruktionen und Drucke für Industriekunden
- Hochtemperatur-Materialien (PEEK, PPS, PPF-CF), Spezialanfertigungen
- Treiber: ProForge5 + Stone Wolf als Produktionskapazität
- Siehe [[00 Kontext/Angebot]], [[00 Kontext/ICP]]

### 2. Digitale Service-Plattform — Klipper KI-Debug-Tunnel
- KI-gestützter Remote-Support für Klipper-/Voron-/Tool-Changer-Nutzer
- Skalierbares SaaS-Modell neben dem Hardware-Geschäft
- Technische Basis existiert bereits (Cloudflare Tunnel, Claude Code)
- Siehe [[Analyse - Klipper KI-Debug-Tunnel]]

### 3. Automatisierte Konstruktions-Pipeline — gemeinsam mit WEC
- Kundenanfrage → CAD → Zeichnung → BOM → PDF → Rechnung
- Zwei Gehirne als Substrat (Reiners + Sebastians Obsidian-Vaults)
- SolidWorks-/Fusion-API-Integration als technische Brücke
- Siehe [[01 Inbox/Vision - Automatisierte Konstruktions-Pipeline]]

## Referenzprojekte (bewiesen)

### Ostdeutscher Turbolader (3B)
- Über 4.000 Stück verkauft à 50 EUR (~200.000 EUR Umsatz über 3 Jahre)
- Komplett selbst konstruiert (Fusion 360) und gedruckt
- +0,5 PS auf dem Prüfstand bei Simson M53/M54 Zweitaktmotoren (zwangsgekühlt — weniger Kühlleistung = mehr Motor)
- #ostdeutscherturbolader auf Instagram — immer noch ein Begriff in der Szene
- Fusion-Dateien nicht mehr verfügbar (Zugangsrechte vom Ex-Partner entzogen), ausgedrucktes Modell bei Bens
- → [[04 Ressourcen/ostdeutschenturbolader/ostdeutschenturbolader]]

### Sachsenmilch Leppersdorf
- 3D-Druckteile (Formlabs Form 3B, Tough 1500)
- Bis heute im Einsatz in der Produktion
- Lebensmittelindustrie-Umfeld
- Beweis: Additive Fertigung funktioniert in der Industrie

### Druckziel ProForge5
- Hochtemperatur-Materialien: PEEK, PPS, PPF-CF (kohlefaserverstärkt)
- Semi-metallische Verbundwerkstoffe
- Industriequalität, 5 Materialien gleichzeitig
- Braucht: Metalleinhausung für PEEK-Temperaturen

## Marktposition

**Nische = Problemlöser.** Nicht Massenproduktion, sondern Spezialanfertigungen für Industrie. Einzelstücke und Kleinserien die sonst niemand macht. Ergänzt WEC perfekt. Die digitale Service-Plattform (Initiative 2) skaliert parallel, unabhängig von physischer Druckkapazität.

## Nächste Schritte (aktiv)

- [ ] Website / Online-Präsenz auf mthreed.io aufbauen
- [ ] Angebot & Preisstruktur definieren
- [ ] ProForge5 druckfertig bekommen → erste Produktionskapazität
- [ ] Entscheidung zu [[Analyse - Klipper KI-Debug-Tunnel]] treffen (Modell B empfohlen)
- [ ] Erste Referenzprojekte unter MThreeD-Marke dokumentieren

## Notizen

Die Struktur dieses Ordners folgt einem einfachen Prinzip: **Dach-Projekte mit mehreren Teilinitiativen werden Ordner, mit einem `_Name.md` als Hub.** Die Unterstrich-Konvention sortiert den Hub alphabetisch an die Spitze. Sub-Projekte mit eigenem Scope und klarem Enddatum können hier liegen, oder — wenn sie auch unabhängig von MThreeD Sinn ergeben — in `02 Projekte/` direkt.

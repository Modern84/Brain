---
tags: [bereich, mthreed, business, idee]
date: 2026-04-17
status: zur-ausarbeitung
---

# Idee — ProForge5 als Live-Service-Plattform

## Der Kern-Gedanke

Der ProForge5 ist jetzt über `drucker.mthreed.io` von überall der Welt erreichbar — mit Login-Schutz, Live-Temperaturen, Konsole, Status. Das ist nicht nur ein Werkzeug, das ist eine **Demo-Plattform** und potenziell ein **Kundenservice-Kanal**.

## Anwendungsfälle (Sebastians Vision)

### 1. Reiner zeigen was möglich ist
- Reiner versteht Technik — wenn er sieht, dass ein Drucker in Pirna von überall steuerbar/überwachbar ist, versteht er sofort den Wert für WEC-Kunden
- Konkret: Reiner bekommt kurzen Zugang zu `drucker.mthreed.io`, sieht Live-Status, Temperaturen, Druckfortschritt
- Ziel: Gemeinsame Sprache für Infrastruktur-Aufbau bei WEC

### 2. Kunden-Demo — "Wir drucken gerade für Sie"
- Kunde kriegt temporären Link / OTP-Zugang
- Sieht live den Druck seines Bauteils laufen (Temperaturen, Fortschritt, Webcam wenn installiert)
- Kein physisches Treffen nötig, kein "Vertrauen Sie mir"
- Professioneller Auftritt: eigene Domain, Firmenlogo, gesicherter Zugang

### 3. Ferndiagnose als Dienstleistung
- Wenn ein Kunde einen 3D-Drucker selbst betreibt und Probleme hat
- Sebastian (oder Reiner) bekommt temporären Zugang zu Klippy/Mainsail des Kunden-Druckers
- Fehler auslesen, Config prüfen, live debuggen — ohne Hausbesuch
- Abrechnungsmodell: Stundensatz für Remote-Support

### 4. Reparaturüberwachung / Fernmonitoring
- Kunde schickt Drucker nicht ein, sondern Sebastian verbindet sich remote
- Monitoring-Abo: "Wir beobachten Ihren Drucker, melden wenn etwas schiefläuft"
- Alerts bei Temperaturabweichungen, Druckabbrüchen, Fehlern
- Skalierbar: 1 Drucker = 1 Instanz, 10 Drucker = 10 Instanzen

### 5. ProForge5 verkaufen — Infrastruktur als Bonus
- Wenn Sebastian den ProForge5 irgendwann verkaufen sollte: Infrastruktur (Tunnel, Access, Monitoring) ist mit dabei
- Käufer bekommt nicht nur einen Drucker, sondern einen fertig eingerichteten Remote-Access-Stack
- Differenzierungsmerkmal gegenüber anderen gebrauchten Druckern

## Technische Basis (bereits vorhanden)

- ✅ `drucker.mthreed.io` — läuft
- ✅ Cloudflare Access — E-Mail OTP, nur Whitelist kommt rein
- ✅ Klipper/Mainsail — Live-Status, Konsole, Temperaturen
- 🔜 Webcam (Crowsnest) — fehlt noch, wäre für Kunden-Demo wichtig
- 🔜 Mainsail Gast-Modus — für "nur anschauen" Zugang

## Nächste Schritte für dieses Konzept

### Sofort (Privat-Zugänge)
- Ildiko: E-Mail in Cloudflare Access Policy eintragen → rein → rausnehmen
- Reiner: gleicher Weg, bei nächstem Treffen live zeigen

### Kurzfristig (Kunden-tauglich machen)
- Webcam installieren (Crowsnest) — damit Drucker auch visuell sichtbar ist
- Mainsail Gast-Modus aktivieren (nur Lesen, kein Steuern)
- Klares Konzept: Was darf ein Gast sehen? Was nicht?

### Mittelfristig (Business-Modell)
- Landing Page auf `mthreed.io` mit "Live Demo" Button
- Buchbares Remote-Support-Angebot (Calendly + Zugangslink)
- Preisstruktur definieren (Erstdiagnose X€, Monitoring-Abo Y€/Monat)

### Langfristig (Skalierung)
- Mehrere Drucker, mehrere Tunnel
- Kundenportal wo jeder Kunde seinen eigenen Drucker-Status sieht
- Automatische Alerts an Kunden bei Druckfehlern

## Verknüpfungen

- [[02 Projekte/ProForge5 Build]]
- [[02 Projekte/Cloudflare Tunnel Setup — ProForge 5]]
- [[03 Bereiche/Business MThreeD.io/Business MThreeD.io]]
- [[01 Inbox/Idee - Apple-Strategie für WEC und MThreeD.io]]

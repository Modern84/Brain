---
typ: entwurf
status: erster-wurf
datum: 2026-04-17
tags: [eingang, entwurf, mthreed, landing-page, mos-eigenes, marketing]
abgrenzung: Mos eigene Produktspur, NICHT Reiner-WEC
verknuepft: [[Strategie - mThreeD.io KI-Debug-Tunnel als eigenes Produkt]]
---

# Entwurf — Landing-Page mThreeD.io (Debug-Tunnel)

**Hinweis:** Erster Wurf, nicht final. Morgen mit frischem Kopf schärfen. Ne-Impuls heute mitnehmen, Ti-Prüfung morgen.

---

## Above the fold

### Headline (Hook)

> **Drucker nicht i.O.?**

### Subline (Claim)

> KI-Debug für Klipper — Fehler auslesen, Fix generieren, zurückspielen. In Minuten, nicht in Stunden.

### Call-to-Action

**[ Beta-Zugang sichern ]** (E-Mail-Capture)

*Noch 5 kostenlose Beta-Plätze.*

### Visueller Anker

Split-Screen:
- Links: Mainsail-Console mit rotem CAN-Timeout-Error, `klippy.log` offen
- Rechts: gleiche Konsole, grün, „Klipper ready" — dazwischen ein Pfeil mit „mThreeD.io"

---

## Sektion 1 — Was es ist (ein Satz)

> mThreeD.io ist ein KI-Debug-Service für Klipper-basierte 3D-Drucker. Du öffnest einen zeitlich begrenzten Tunnel, die KI liest deine Configs und Logs, generiert den Fix und spielt ihn auf deine Bestätigung zurück.

---

## Sektion 2 — So funktioniert es (drei Schritte)

**1. Install-Script ausführen**

```
curl -sSL install.mthreed.io/debug | bash
```

Läuft auf deinem Pi / Host. Startet einen Einmal-Tunnel.

**2. Session öffnen**

Du bekommst einen Link: `mthreed.io/session/<id>`. Gültig eine Stunde.

**3. KI debuggt mit dir**

Die KI liest `printer.cfg`, `klippy.log`, `dmesg`, fragt gezielt nach. Zeigt dir den Fix als Diff. Du bestätigst. Fix wird eingespielt, Klipper neu gestartet, verifiziert.

Am Ende: komplettes Session-Log als Markdown in dein Postfach.

---

## Sektion 3 — Für welche Drucker

- ProForge 5 (Makertech 3D)
- Voron 0.2, Trident, V2.4, Switchwire, Legacy
- Sovol SV08, SV07, SV06 ACE
- Troodon 2.0 (Fombot)
- Prusa MK4/MK3.9 mit Klipper-Mod
- Jeder Custom-Build mit Klipper + Moonraker + Mainsail/Fluidd

Nicht dabei? Schreib uns, wir schauen.

---

## Sektion 4 — Was die KI kann

- CAN-Bus-Probleme erkennen (EBB36, U2C, UUID-Mismatch, Timer-too-close)
- Config-Fehler in `printer.cfg` finden und korrigieren
- Flash-Issues diagnostizieren (DFU, Bootloader, Firmware-Mismatch)
- Input-Shaper-Kalibrierung durchgehen
- Pressure Advance, PID, Eddy-Probe-Setup
- Log-Analyse für MCU-Timeouts, Thermal Runaways, Stepper-Fehler
- Deine Commissioning-Doku mitliefern (pro Session ein Markdown-Log für dein Brain)

---

## Sektion 5 — Deine Daten bleiben deine

- **Wir speichern keine Zugangsdaten.** Der Tunnel wird von dir gestartet, läuft über Cloudflare Zero Trust, schließt sich nach einer Stunde automatisch.
- **Jede Session ist protokolliert.** Du bekommst das vollständige Log.
- **Kein Persistenzspeicher auf unserer Seite.** Nach der Session ist weg, was in der Session war.
- **Keine Daten an Dritte.**

---

## Sektion 6 — Preise (Platzhalter — morgen entscheiden)

| | |
|---|---|
| **Einzel-Session** | 25 € — eine Stunde Tunnel, ein Problem gelöst |
| **Pro Flatrate** | 10 €/Monat — unbegrenzte Sessions, Priority-Support |
| **Community** | GitHub Sponsors / Ko-fi — unterstütze das Projekt, bekomme Beta-Zugang |

*Beta-Phase: Die ersten fünf Kunden kostenlos gegen ehrliches Feedback.*

---

## Sektion 7 — Wer steckt dahinter

Sebastian Hartmann. 3D-Drucker-Techniker aus Sachsen, Partner von WEC (Werkzeug- und Fertigungskonstruktion), selbst Klipper- und Voron-Nutzer. Baut mThreeD.io aus einem simplen Grund: weil niemand anderes diesen Service macht, und weil ich meine eigenen Debugging-Sessions sowieso schon so führe.

Mehr auf [mThreeD.io](https://mthreed.io) · [GitHub](https://github.com/mthreed)

---

## Footer

mThreeD.io · input/output · in Ordnung
Ein Service aus Pirna, Sachsen
[Impressum] · [Datenschutz] · [AGB]

---

# Offene Fragen — morgen klären

## Inhaltlich
- [ ] Preistest: sind 25 € pro Session das richtige Signal? Zu günstig wirkt unseriös, zu teuer killt Conversion. Referenz: ein Elektriker-Hausbesuch kostet 80-120 €, eine Druckerreparatur beim Hersteller 100-200 € plus Versand.
- [ ] CTA: E-Mail-Capture oder direkt Stripe Checkout? E-Mail = Lead-Liste aufbauen; Stripe = sofort Geld, aber höhere Schwelle.
- [ ] Sprache: deutsch, englisch, oder beides? Voron-Community ist international englisch. Deutsche SEO bringt deutschsprachige Nischenkunden. Vermutlich beides, englisch primär.
- [ ] Brauchen wir ein Video-Demo? Zwei Minuten Screencast „Wie eine Session aussieht" wäre Gold wert für Conversion.

## Technisch
- [ ] Deploy auf Cloudflare Pages (astro-blog-starter-template als Basis nehmen?)
- [ ] E-Mail-Capture: Cloudflare Worker + KV Store, oder Convertkit/Buttondown?
- [ ] Stripe Checkout: sobald Preistest durch
- [ ] Install-Script hosten unter `install.mthreed.io` (separater Worker)
- [ ] Session-Backend: `api.mthreed.io` mit Ephemeral-Token-Logik

## Rechtlich
- [ ] Impressum (deutsche Pflicht, Wohnsitz/Geschäftssitz Ungarn-Klärung mit Steuerberater)
- [ ] Datenschutzerklärung (DSGVO-konform, speziell für Session-Logs und E-Mail-Capture)
- [ ] AGB mit klarem Haftungsausschluss „DIY-Drucker, Eigenrisiko"
- [ ] Markenrecht prüfen: „mThreeD" als Wortmarke in DE/EU/UK eintragen lassen?

## Strategisch
- [ ] Klare Abgrenzung zu Reiners WEC-Spur im Footer / Impressum (unterschiedliche Rechtsstrukturen, unterschiedliche Kontakte)
- [ ] Soll ProForge 5 namentlich auf der Seite stehen, oder erst wenn Makertech-Kontakt geklärt ist? Risiko: wenn die sauer werden, haben wir ein PR-Problem, bevor wir ein Produkt haben.

---

## Hinweise an mich selbst für morgen

- Nicht perfektionieren wollen. Eine Landing-Page im Beta-Status darf rau aussehen. Sie muss nur **einen** Satz klar sagen und **einen** CTA haben.
- Vorbild im Tonfall: Honeybadger, Plausible, Supabase — ehrlich, direkt, kein Marketing-Geschwurbel.
- Vorbild in der Struktur: obico.io ist okay, aber zu viel Fluff. octoeverywhere.com ist knapper, aber auch generisch. Die Lücke ist: glaubwürdig-persönlich statt AI-Startup-Standard.

---
tags: [ressource, cloudflare, zugang, proforge5]
date: 2026-04-17
---

# Cloudflare Access — Zugangsverwaltung drucker.mthreed.io

## Policy "WEC-Zugang"

| Person | E-Mail | Zugang seit |
|---|---|---|
| Sebastian | modern3b@icloud.com | 17.04.2026 |
| Reiner | woldrich@w-ec.de | 17.04.2026 |
| Ildiko | kormos1975@icloud.com | 17.04.2026 |

**Session-Dauer:** 24h, dann erneuter OTP-Code per Mail

## Login-Anleitung (für alle)

1. https://drucker.mthreed.io öffnen
2. E-Mail eingeben → **"Send me a code"**
3. Code aus Mail eingeben → **Sign in**
4. Mainsail lädt — Temperaturen, Status, alles live

## E-Mail für Gäste temporär hinzufügen

Um jemanden kurz reinzulassen:
1. Cloudflare Zero Trust Dashboard → Zugriffssteuerungen → Anwendungen → `drucker.mthreed.io` → Bearbeiten
2. Policy "WEC-Zugang" → E-Mail eintragen
3. Gast schaut rein
4. Danach E-Mail wieder entfernen

**Oder via Claude Code:**
```
Cloudflare Access Policy erweitern.
App-ID: f4ff7e08-d44b-4a28-a4c3-cc30d8c04ec7
Account-ID: 02025e3157272b61ebf85faf21264a2b
Token: [Apple Schlüsselbund: "Cloudflare Access Token proforge5-access (cfat)"]
E-Mail hinzufügen: [E-Mail des Gastes]
```

> ⚠️ **Token gehört NICHT in den Vault** — bitte nur über Apple Schlüsselbund abrufen.

## Verknüpfungen

- [[02 Projekte/Cloudflare Tunnel Setup — ProForge 5]]
- [[03 Bereiche/Business MThreeD.io/Idee - ProForge5 als Live-Service-Plattform]]

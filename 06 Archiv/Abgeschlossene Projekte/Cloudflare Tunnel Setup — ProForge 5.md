---
tags: [projekt, cloudflare, proforge5, remote]
date: 2026-04-17
status: abgeschlossen
---

> [!success] Abgeschlossen am 2026-04-17
> **Ergebnis:** Mainsail läuft öffentlich unter `https://drucker.mthreed.io`. Kein Port-Forwarding, kein VPN nötig.
> **Tunnel-ID:** `378a4792-1636-4a40-b97f-b17ae4184755`
> **Protokoll:** `http2` (iPhone-Hotspot blockt QUIC/UDP:7844 — bei echtem WLAN auf QUIC umstellbar)
> **Auth-Weg:** Umweg über Browser-Login ging nicht (Super-Admin-Rolle fehlte im Dashboard). Stattdessen Konto-API-Token mit passendem Scope → Tunnel, DNS, Config, systemd via Claude Code vollautomatisch eingerichtet.
> **Nginx/Moonraker:** Vier Forwarded-Header (`X-Forwarded-For`, `X-Real-IP`, `X-Forwarded-Proto`, `Cf-Connecting-Ip`) in beiden Moonraker-Locations geleert, damit `trusted_clients` die 127.0.0.1-Quelle akzeptiert. `moonraker.conf` `cors_domains` um `*://drucker.mthreed.io` erweitert.
> **Zugriffsschutz:** Cloudflare Access ist aktiv. Zero-Trust-Team `mthreed` → `mthreed.cloudflareaccess.com`. Access-App `ProForge 5 Mainsail` (ID `f4ff7e08-d44b-4a28-a4c3-cc30d8c04ec7`, Session 24 h, IdP `onetimepin`).
>
> **Policy `WEC-Zugang`** (ID `35da1cb2-1105-470b-87ee-81c6761d9478`, `decision: allow`) — zugelassene E-Mails:
> - `modern3b@icloud.com` (Sebastian)
> - `woldrich@w-ec.de` (Reiner) — eingetragen 17.04.2026
> - `kormos1975@icloud.com` (Ildiko) — eingetragen 17.04.2026
>
> Gäste erweitern: Policy via API (PUT `/access/apps/{app_id}/policies/{policy_id}`) um weitere `{"email": {"email": "…"}}` ergänzen. Browser-Test 17.04.2026 ✅ bestanden (E-Mail-Code → Mainsail lädt).
>
> **Read-Only für externe Gäste (17.04.2026 ✅):** Cloudflare-Traffic wird im nginx via `map $http_cf_connecting_ip` auf den Read-Only-Proxy `127.0.0.1:2096` umgeleitet (Python-aiohttp-Service `moonraker-readonly-proxy`). Der Proxy filtert schreibende JSON-RPC-Methoden (WebSocket) und modifizierende POST/DELETE (REST), `printer.emergency_stop` bleibt erlaubt. Tailscale/LAN geht unverändert direkt auf Moonraker `127.0.0.1:7125`. Konsequenz: Wer über `drucker.mthreed.io` kommt, sieht Mainsail live und kann nichts steuern. Wer über `http://100.90.34.108` oder `proforge5.local` kommt, hat vollen Admin-Zugang.

# Cloudflare Tunnel Setup — ProForge 5 Remote-Zugriff

**Ziel:** ProForge 5 Mainsail-Dashboard via `drucker.mthreed.io` von überall erreichbar machen, ohne Port-Forwarding oder VPN.

**Voraussetzungen:**
- ✅ Cloudflare-Account (`modern3b@icloud.com`)
- ✅ Domain `mthreed.io` in Cloudflare
- ✅ Cloudflare MCP-Connector in Claude Code verbunden
- ✅ ProForge 5 läuft auf Pi (`proforge5.local` oder Tailscale IP `100.90.34.108`)

---

## Schritt 1 — Cloudflared auf Pi 5 installieren

**SSH ins Pi:**
```bash
ssh m3d@100.90.34.108
# oder via mDNS:
ssh m3d@proforge5.local
```

**Cloudflared installieren:**
```bash
# Offizielles Cloudflare-Repo hinzufügen
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null

echo "deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflared.list

# Installieren
sudo apt update
sudo apt install cloudflared -y

# Version prüfen
cloudflared --version
```

**Erwartete Ausgabe:** `cloudflared version 2024.x.x` oder ähnlich

---

## Schritt 2 — Cloudflare Tunnel erstellen

**Auf dem Pi:**
```bash
# Login (öffnet Browser-Fenster, dort mit modern3b@icloud.com anmelden)
cloudflared tunnel login

# Tunnel erstellen
cloudflared tunnel create proforge5

# Tunnel-ID notieren — sieht aus wie: 12345678-1234-1234-1234-123456789abc
cloudflared tunnel list
```

**Wichtig:** Die **Tunnel-ID** kopieren und hier eintragen:
```
TUNNEL_ID=___________________
```

**Credentials-Datei liegt hier:**
```
~/.cloudflared/<TUNNEL_ID>.json
```

---

## Schritt 3 — DNS-Eintrag erstellen

**Via Cloudflare MCP (in Claude Code auf dem Mac):**

```
Erstelle einen CNAME-Eintrag:
- Name: drucker
- Target: <TUNNEL_ID>.cfargotunnel.com
- Domain: mthreed.io
- Proxied: true
```

**Oder manuell via Cloudflare Dashboard:**
1. Cloudflare Dashboard → Domains → mthreed.io → DNS
2. Add Record:
   - Type: CNAME
   - Name: drucker
   - Target: `<TUNNEL_ID>.cfargotunnel.com`
   - Proxy status: Proxied (Orange Cloud)
3. Save

---

## Schritt 4 — Tunnel-Config erstellen

**Auf dem Pi:**
```bash
sudo mkdir -p /etc/cloudflared

sudo nano /etc/cloudflared/config.yml
```

**Inhalt:**
```yaml
tunnel: <TUNNEL_ID>
credentials-file: /home/m3d/.cloudflared/<TUNNEL_ID>.json

ingress:
  - hostname: drucker.mthreed.io
    service: http://localhost:7125
  - service: http_status:404
```

**Wichtig:**
- `<TUNNEL_ID>` durch echte ID ersetzen
- Port `7125` ist Moonraker (Mainsail-Backend)

**Speichern:** `Ctrl+O`, `Enter`, `Ctrl+X`

---

## Schritt 5 — Tunnel testen

**Tunnel manuell starten:**
```bash
cloudflared tunnel run proforge5
```

**Im Browser öffnen:**
```
https://drucker.mthreed.io
```

**Erwartetes Ergebnis:** Mainsail-Dashboard lädt

**Wenn es funktioniert:** `Ctrl+C` drücken (Tunnel stoppen)

---

## Schritt 6 — Tunnel als systemd-Service einrichten

**Auf dem Pi:**
```bash
# Service installieren
sudo cloudflared service install

# Service aktivieren
sudo systemctl enable cloudflared

# Service starten
sudo systemctl start cloudflared

# Status prüfen
sudo systemctl status cloudflared
```

**Erwartete Ausgabe:**
```
● cloudflared.service - cloudflared
   Loaded: loaded (/etc/systemd/system/cloudflared.service; enabled)
   Active: active (running)
```

**Logs checken:**
```bash
sudo journalctl -u cloudflared -f
```

**Wenn "connection registered" erscheint → alles läuft ✅**

---

## Schritt 7 — Firewall-Check (falls aktiviert)

**Prüfen ob ufw läuft:**
```bash
sudo ufw status
```

**Falls aktiv:** Cloudflared braucht ausgehende HTTPS-Verbindungen (443), keine eingehenden Ports — sollte automatisch funktionieren.

---

## Troubleshooting

### Fehler: "tunnel credentials file not found"
```bash
# Prüfen wo die Credentials liegen
ls -la ~/.cloudflared/

# Config anpassen auf richtigen Pfad
sudo nano /etc/cloudflared/config.yml
```

### Fehler: "404 when accessing drucker.mthreed.io"
- DNS-Propagation dauert 1-5 Minuten → warten
- CNAME-Eintrag prüfen: `dig drucker.mthreed.io`
- Tunnel-Logs checken: `sudo journalctl -u cloudflared -f`

### Fehler: "connection failed"
- Port 7125 prüfen: `curl http://localhost:7125` auf dem Pi
- Moonraker läuft? `systemctl status moonraker`

---

## Nach Abschluss

**Dokumentiert ✅ (17.04.2026):**
- [x] Tunnel-ID: `378a4792-1636-4a40-b97f-b17ae4184755`
- [x] Daily Note 2026-04-17 ergänzt: Tunnel läuft ✅
- [x] TASKS.md: abgehakt
- [x] Cloudflare Access aktiv — E-Mail-OTP, nur `modern3b@icloud.com`
- [x] Read-Only-Proxy für externe Gäste aktiv (Python-aiohttp, `127.0.0.1:2096`)

**Nächste Schritte:**
1. Bei echtem WLAN (statt Hotspot): Protokoll in `config.yml` von `http2` auf `quic` umstellen
2. Optional: Zweiten Tunnel für Pi 5 generell (SSH, Ollama)

---

**Stand:** 2026-04-17 — Produktionsreif


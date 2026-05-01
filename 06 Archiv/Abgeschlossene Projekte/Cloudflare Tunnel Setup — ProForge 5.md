---
tags: [archiv, projekt, cloudflare, proforge5]
date: 2026-04-17
status: abgeschlossen
---

# Cloudflare Tunnel Setup — ProForge 5

**Abgeschlossen:** 2026-04-17  
**Archiviert:** 2026-04-19

## Ergebnis

- Tunnel live: `https://drucker.mthreed.io`
- Tunnel-ID: `378a4792-1636-4a40-b97f-b17ae4184755`
- Protokoll: `http2` (Hotspot blockt QUIC)
- cloudflared v2026.3.0 via `.deb`, systemd-Service persistent
- nginx/Moonraker-Header bereinigt
- Cloudflare Access: Zero-Trust-Team `mthreed`, App `ProForge 5 Mainsail`, Policy `WEC-Zugang` (Sebastian, Reiner, Ildiko), E-Mail-OTP, Session 24h
- Read-Only-Proxy für externe Gäste aktiv (Port 2096)

## Verknüpfungen

- [[02 Projekte/ProForge5 Build/ProForge5 Build]]

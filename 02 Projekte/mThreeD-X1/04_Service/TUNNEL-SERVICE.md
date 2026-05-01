---
projekt: mThreeD-X1
abgrenzung: NICHT Reiner-WEC
status: konzept
erstellt: 2026-04-30
---

# Tunnel-Service — mThreeD.io Hub

## Konzept

Drucker beim Kunden → Cloudflare Tunnel → mThreeD.io Hub → Claude/lokales LLM → Antwort + Aktion

## Komponenten

- Cloudflare Tunnel (Account modern3b@icloud.com aktiv, mthreed.io)
- mTLS pro Kunde (Cloudflare Access)
- mThreeD-MCP-Server auf Drucker-Mini-PC
- Customer-Portal: Mainsail-Embed + Claude-Chat + Telemetrie
- Storage: TrueNAS Scale + Off-Site-Replikation R2

## Service-Stufen

- **Bronze**: Tunnel + Klipper-Hilfe via Chat
- **Silber**: + Echtzeit-AI-Monitoring + Anomalie-Erkennung
- **Gold**: + Custom Fine-Tuning + 24/7 On-Call

## Datenmodell pro Druck

G-Code + Sensor-Streams (Parquet) + Kamera (H.265 + Keyframes) + Slicer-Metadaten + Endbewertung
Retention pro Kundenvertrag

## KI-Pipeline

- Edge: Jetson AGX Orin (Echtzeit-Vision, < 50ms Latenz)
- Hub: RTX PRO 6000 Blackwell (Heavy-Inferenz, Fine-Tuning)
- Modelle: YOLO11 (Vision), Whisper (Akustik), Qwen2.5-VL (Reasoning)
- Vector-DB Qdrant für RAG über Klipper-Docs + Kunden-Historie

## Anbindung an Mo-Produktspur

Diese Tunnel-Architektur ist generischer mThreeD.io-Service, gilt für jeden Klipper-Drucker beim Kunden. Die X1 ist Premium-Anwendungsfall, nicht Voraussetzung für den Service.

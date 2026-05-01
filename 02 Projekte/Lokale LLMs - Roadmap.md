---
tags: [projekt, ki, hardware, strategie, verworfen]
date: 2026-04-24
status: verworfen
verworfen_am: 2026-04-24
priorität: —
---

# Lokale LLMs - Roadmap

> **Status: VERWORFEN am 2026-04-24.** Hypothese am Vormittag aufgestellt, am Nachmittag nach echten Tests zurückgenommen. Entscheidung + Begründung in [[05 Daily Notes/2026-04-24#Lokale LLMs Revert]].
>
> Kurz: 70B läuft nicht auf 64 GB MacBook (OOM bei normaler App-Nutzung), 32B läuft aber mit sachlich schwacher Qualität und 882 MB RAM-Puffer. Cloud-Claude ist für WEC-Fachtiefe überlegen und reicht praktisch — Offline-Szenarien sind selten und per Handy-Hotspot überbrückbar. Re-Evaluierung sobald Mac Studio Ultra 256GB da ist (Juli+).
>
> Datei bleibt als historischer Anker. Inhalte unten sind der ursprüngliche Plan — nicht mehr aktuell.

---

# ⚠️ Inhalt ab hier ist historisch (Stand Vormittag 2026-04-24)

**Ziel:** Komplett offline-fähige AI-Infrastruktur für sensitive WEC-Arbeit

---

## Warum lokale LLMs?

### Use-Cases (konkret, nicht theoretisch)

**1. Sensitive WEC-Daten**
- Reiners Fahrrad-Federungssystem (TOP SECRET)
- Kundenkonstruktionen (vertraulich)
- IP-kritische Projekte (Rüstung, Medizintechnik)
- → **Dürfen NIEMALS in die Cloud** (weder Anthropic noch OpenAI)

**2. Offline-Fähigkeit**
- Arbeit ohne Internet (Zug, Remote-Locations)
- Unabhängigkeit von API-Verfügbarkeit
- Keine Latenz bei Netzwerk-Problemen

**3. Unbegrenzte Nutzung**
- Keine API-Kosten nach Hardware-Kauf
- Keine Rate-Limits
- Beliebig viele Anfragen

---

## Hardware-Anforderungen

### RAM-Bedarf für LLMs

| Modell-Größe | RAM benötigt | Intelligenz-Level | Beispiele |
|--------------|--------------|-------------------|-----------|
| 7B | ~8GB | Basis | LLaMA 3.2 7B |
| 13B | ~16GB | Gut | Mistral 7B |
| 70B | ~40-50GB | Sehr gut | LLaMA 3.3 70B, Qwen 72B |
| 405B | ~200GB+ | Exzellent | LLaMA 3.1 405B |

**MacBook Pro M1 2021:**
- RAM: 64GB (korrigiert)
- → Theoretisch 70B Q4, **praktisch nicht** (OOM sobald Apps parallel) — siehe Revert in Daily Note

**Mac Studio M5 Ultra 256GB:**
- RAM: 256GB Unified Memory
- → Kann 405B Modelle problemlos
- → Re-Evaluierung wenn Hardware da

---

## Software-Stack (ursprünglich geplant)

### Core Infrastructure

**1. Ollama** — getestet, am 2026-04-24 nachmittags wieder deinstalliert.

**2. Modelle (getestet)**
- **LLaMA 3.3 70B Q4** (42 GB) — OOM auf 64 GB RAM bei normaler App-Nutzung
- **Qwen 2.5 32B** (20 GB) — lief, aber sachlich schwach bei Maschinenbau-Fachfragen
- **LLaMA 3.2 3B** — zu klein, Spielzeug

**3. Integration** — nicht umgesetzt.

---

## Roadmap (überholt)

### ~~Phase 1: Hardware beschaffen (Juni-Juli 2026)~~
Wird unabhängig von lokalen LLMs gemacht (Mac Studio Ultra aus anderen Gründen sinnvoll).

### ~~Phase 2-4~~
Auf Eis. Re-Evaluierung wenn Ultra da ist und echte Anforderungen sichtbar werden.

---

## Hybrid-Strategie (revidiert)

**Cloud-Claude (Anthropic):**
- Alle Arbeit, auch WEC-sensitive — solange Anthropic-DPA akzeptabel bleibt
- Memory-System (kennt Mo's Kontext)
- Fachlich stärker als getestete lokale Modelle

**Lokales LLM:** aktuell kein Platz im Workflow.

**Offline-Szenarien:** Handy-Hotspot, seltene kurze Lücken akzeptabel.

---

## Lessons

1. **Moonlock hat Realität verzerrt** (57 GB RAM belegt durch Malware-Remnant). Erster 70B-Crash wirkte wie reines Moonlock-Problem, war aber zusätzlich echte Hardware-Grenze.
2. **64 GB sind zu knapp für 70B + Produktivsystem.** Physik, nicht Software.
3. **Qualität lokaler Modelle vs. Cloud-Claude** war überraschend deutlich schwächer bei Fach-Deutsch (Maschinenbau-Terminologie).
4. **Hypothesen kosten Zeit im Testen, aber Revert ohne Scham ist günstiger als schlechter Workflow für 6 Monate.**

---

## Verknüpfungen

- [[05 Daily Notes/2026-04-24]] — Revert-Entscheidung
- [[02 Projekte/WEC Neustart mit Reiner/Sessions/2026-04-24 Hardware-Strategie Update]]
- [[03 Bereiche/WEC/CLAUDE]] (Datenschutz-Regeln)

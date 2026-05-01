---
tags: [projekt, wec, hardware, session]
date: 2026-04-24
status: aktiv
priorität: A
---

# Hardware-Strategie Update — 24.04.2026

**Session:** Mo + Claude, Hardware-Architektur für Mo + Reiner Kollaboration

---

## Kontext

Ursprüngliche Hardware-Planung (16.04.2026): 
- Mac Mini M5 Pro für Reiner (~2.000€)
- Mac Studio M5 Max 128GB für Mo (~4.000€)

**Heute geklärt:**
- Mo will "Maximum rausholen", 128GB sind "fast schon grenzwertig"
- Mac Studio M5 **Ultra** 256GB ist das eigentliche Ziel
- MacBook Pro M1 2021 bleibt als Mo's Mobile-Workstation
- Lokale 70B LLMs waren nur theoretisch, nicht Hauptziel

---

## Kern-Erkenntnis: "Claude als Betriebssystem"

**Wichtigster Insight:**
Obsidian + Claude + Shared Brain = **das eigentliche Betriebssystem**

Hardware ist nur Runtime-Environment dafür.

**Konsequenz:**
Reiner nutzt Obsidian + Claude eh über Mo als Filter (siehe [[03 Bereiche/WEC/Shared Brain Architektur]]).  
→ Reiner braucht **keine** High-End-Hardware für seine Nutzung.

---

## Drei Hardware-Szenarien

### Szenario A: Ultra + Mini (Software-First Approach)

**Mo:**
- MacBook Pro M1 2021 (mobil, behalten, läuft perfekt)
- Mac Studio M5 Ultra 256GB (Desktop, Maximum-Power) ~8.000€

**Reiner:**
- Mac Mini M5 (Basis-Modell) (~1.200€)
- Obsidian läuft, Claude läuft, Office läuft
- Kein Fusion 360, kein Heavy-Lifting

**Total: ~9.200€**

**Vorteile:**
✅ Mo hat absolutes Maximum (256GB RAM)
✅ Reiner hat solides, wartungsarmes System
✅ MacBook Pro als Mobile + Backup
✅ Obsidian Sync verbindet beide digital
✅ Günstigste Variante für Maximum-Power

**Nachteile:**
❌ Reiner kann nicht selbst konstruieren (falls das später kommt)

---

### Szenario B: Ultra + Mini Pro

**Mo:**
- MacBook Pro M1 2021 (mobil)
- Mac Studio M5 Ultra 256GB (Desktop) ~8.000€

**Reiner:**
- Mac Mini M5 Pro (Mid-Tier) (~2.000€)
- Kann Fusion 360 leicht nutzen
- Kann SolidWorks-Reviews machen

**Total: ~10.000€**

**Vorteile:**
✅ Mo hat Maximum
✅ Reiner hat Wachstumsraum (kann lernen zu konstruieren)
✅ Beide eigenständig arbeitsfähig

**Nachteile:**
❌ +800€ vs Szenario A
❌ Reiner's Hardware möglicherweise overpowered für Nutzung

---

### Szenario C: 2× Mac Studio M5 Max

**Mo:**
- MacBook Pro M1 2021 (mobil)
- Mac Studio M5 Max 128GB (Desktop) ~4.000€

**Reiner:**
- Mac Studio M5 Max 128GB (identisch) ~4.000€

**Total: ~8.000€**

**Vorteile:**
✅ Beide haben massive Power
✅ Identische Systeme → einfacher Support
✅ Redundanz (einer fällt aus → anderer läuft)
✅ Mo spart 4.000€ vs Ultra

**Nachteile:**
❌ Mo hat nicht "Maximum" (128GB statt 256GB)
❌ Reiner's Hardware stark overpowered

---

## Offene Fragen für Entscheidung

- [ ] **Braucht Mo wirklich 256GB RAM?** Was sind die konkreten Use-Cases?
- [ ] **Wird Reiner jemals selbst konstruieren?** Oder bleibt er bei Skizzen + Delegation an Mo?
- [ ] **Budget-Realität:** Privat oder über MThreeD.io? Steuerliche Abschreibung?
- [ ] **Timing:** Wirklich bis WWDC Juni 2026 warten oder früher starten?

---

## Obsidian Sync - Plattform-Argument (KRITISCH)

**iCloud Sync funktioniert NUR auf:**
- Mac ✅
- iPhone/iPad ✅

**Obsidian Sync funktioniert auf:**
- Mac, Windows, Linux, iOS, Android ✅

**Reiner's aktuelle Situation:**
- Arbeitet auf **Windows PC** (WEC, kein Admin)
- **iCloud Sync geht da nicht**

**Geplante Situation:**
- Mac Mini M5 (Pro) nach WWDC
- Aber: **Übergangszeit bis dahin = Windows**

**Konsequenz:**
Obsidian Sync ist **nicht optional**, sondern **die einzige Lösung** für Mo + Reiner Kollaboration während der Übergangszeit.

**Kosten:** 2× 4€/Monat = 96€/Jahr (bei jährlicher Zahlung)

---

## Nächste Steps

- [ ] Mo entscheidet: Szenario A, B oder C?
- [ ] Obsidian Sync für Mo aktivieren (4€/Monat)
- [ ] Obsidian Sync für Reiner aktivieren (4€/Monat)
- [ ] Hardware-Budget final klären (privat vs MThreeD.io)
- [ ] WWDC Juni 2026 abwarten für finale Specs + Preise

---

## Verknüpfungen

- [[02 Projekte/WEC Neustart mit Reiner/Reiners Gehirn - Setup Plan]] — Original Hardware-Strategie
- [[03 Bereiche/WEC/Shared Brain Architektur]] — Obsidian Sync Architektur
- [[03 Bereiche/WEC/README]] — WEC Einstiegspunkt

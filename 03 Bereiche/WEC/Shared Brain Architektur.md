---
tags: [bereich, wec, architektur, obsidian-sync]
date: 2026-04-24
status: aktiv
priorität: A
owner: Mo + Reiner
---

# Shared Brain Architektur — Mo + Reiner

> **Entscheidung:** Ein Vault, intelligente Präsentation statt manuelle Trennung

**Datum:** 2026-04-24  
**Kontext:** Obsidian Sync Setup für WEC-Kollaboration

---

## Problem

**Alt-Ansatz (verworfen):**
- Zwei separate Vaults: "Brain" (Mo privat) + "WEC" (geteilt)
- Problem: "Wo speicher ich das?" → mentale Steuer, Dinge gehen verloren
- Reiner und Mo haben beide neue Berührungspunkte mit Second Brain
- Zusätzliche Trennung würde Friction erhöhen

---

## Lösung — Ein Vault, Claude als Filter

### Setup

**Ein Vault** (Mo's aktueller Brain)
- Beide haben Obsidian Sync Zugriff (je 4€/Monat)
- Volle Vault-Synchronisation über Obsidian Sync Server

### Zugriffsmuster

**Mo:**
- Arbeitet wie bisher — alles in Brain
- Keine Entscheidung "wo hin" nötig
- Voller Zugriff auf alles (privat + WEC)

**Reiner:**
- Nutzt Obsidian nur über Claude als Interface
- Browst nicht selbst im Vault
- Claude präsentiert nur WEC-relevanten Kontext

### Wie Claude filtert

**Für Reiner (über Claude):**
- Zeigt: `02 Projekte/WEC/`, `03 Bereiche/WEC/`, relevante Ressourcen
- Zeigt NICHT: Mo's Daily Notes, private Projekte, persönliche Bereiche
- Reiner kann WEC-Notizen erstellen (landen in Brain, aber Claude weiß dass sie von ihm sind)

**Für Mo:**
- Voller Zugriff wie gewohnt
- Kann in allen Bereichen arbeiten
- Brain bleibt sein primäres Second Brain

---

## Technische Umsetzung

### Obsidian Sync

- **Kosten:** 2× 4€/User/Monat = 8€/Monat (bei jährlicher Zahlung = 96€/Jahr)
- **Features:** End-to-End Encryption, Version History, Shared Vault Collaboration
- **Kommerzielle Nutzung:** Frei seit Feb 2026 (keine Extra-Business-Lizenz nötig)

### Vault-Struktur

Brain behält aktuelle Struktur:
```
Brain/
├── 00 Kontext/          ← Mo privat (Reiner sieht nicht)
├── 01 Inbox/            ← beide nutzen
├── 02 Projekte/
│   └── WEC/             ← Reiner sieht nur diesen Teil
├── 03 Bereiche/
│   ├── WEC/             ← gemeinsamer Arbeitsbereich
│   ├── Finanzen/        ← Mo privat
│   └── ...
├── 04 Ressourcen/       ← selektiv (WEC-relevante Teile für Reiner)
├── 05 Daily Notes/      ← Mo privat
└── TASKS.md             ← beide nutzen (gefiltert)
```

---

## Vorteile

✅ **Keine mentale Steuer** — Mo muss nicht entscheiden wo etwas hin gehört  
✅ **Ein System** — alles an einem Ort, keine Synchronisations-Probleme  
✅ **Intelligente Präsentation** — Claude kontrolliert was Reiner sieht  
✅ **Skalierbar** — bei Bedarf weitere Filter/Views für andere Kollaboratoren  
✅ **Natürlicher Workflow** — Reiner nutzt Obsidian eh nur über Claude  

---

## Nächste Steps

- [ ] Obsidian Sync für Mo aktivieren (4€/Monat, jährlich)
- [ ] Obsidian Sync für Reiner aktivieren (4€/Monat, jährlich)
- [ ] Reiner's Obsidian App mit Sync verbinden
- [ ] Claude-Filter-Regeln in `03 Bereiche/WEC/CLAUDE.md` dokumentieren
- [ ] Test: Reiner erstellt erste Notiz über Claude, Mo sieht sie im Brain

---

## Verknüpfungen

- [[03 Bereiche/WEC/README]] — WEC Einstiegspunkt
- [[CLAUDE]] — Root-CLAUDE.md
- [[02 Projekte/WEC Neustart mit Reiner/Reiners Gehirn - Setup Plan]]

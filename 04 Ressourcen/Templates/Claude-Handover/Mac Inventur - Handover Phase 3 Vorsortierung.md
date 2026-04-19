---
tags: [projekt, handover, claudecode]
date: 2026-04-18
---

# Handover an Claude Code — Phase 3 Vorsortierung

> **Zweck:** Am Anfang der nächsten Session diesen Prompt in Claude Code kopieren. Er sortiert die 190 Dateien in `05_Projekt_Material/` nach Themen vor, damit Sebastian in Session 1 (Bens) nur bestätigen muss statt jede Datei einzeln zu analysieren.

---

## Prompt für Claude Code

```
Mac-Inventur Phase 3 — Vorsortierung.

## Kontext laden
1. CLAUDE.md im Vault-Root
2. 02 Projekte/Mac Inventur.md (aktueller Stand Etappe 1 Phase 2 komplett)
3. 02 Projekte/WEC-Geraete Pilotscope.md (Ziel-Profile)
4. 05 Daily Notes/2026-04-18.md (gestriger Stand)

## Aufgabe

Analysiere alle ≈ 190 Dateien in ~/Mac-Inventur/05_Projekt_Material/ 
(inkl. der zurückverschobenen: Bild 2.jpg, P5FW_alt/aktuell.zip, 
ProForge-5-main_snapshot*.zip, Proforge4_Referenzmodell*.STEP).

Schreibe Vorschläge in:
02 Projekte/Mac Inventur - Phase 3 Vorsortierung.md

Format: Markdown-Tabelle mit Spalten
  Dateiname | Größe | Typ | Vorschlag-Thema | Konfidenz | Begründung

Vorschlag-Themen (fest, in dieser Priorität sortiert):
- Bens (WEC-Kunde, Lebensmittel/Pharma) — Dateinamen mit "bene_gmbh-", 
  "Bens", "Lagerschalen", "Lagerhalter", "Grundplatte", "Zwischenplatte", 
  "Elastollan" (Materialzertifikat), "Maxithen"
- Knauf (WEC-Kunde, Bau/Gips) — falls Dateien gefunden
- ProForge5 (Sebastians aktives Hardware-Projekt) — "ProForge", "P5FW", 
  "Octopus", "EBB36", "SO3", "printer.cfg", "moonraker"
- Konstruktion (eigene Fusion/CAD ohne Kundenbezug) — .f3d, .step ohne 
  Kundenkontext, Modern3D-Ableger
- Finanzen (Bescheide, DATEV, Rechnungen, Abgaben) — "Bescheid", 
  "Bewilligungs", "Leistungsnachweis", "Einstiegsgeld", "Invoice"
- 1Password-Migration (zu entsorgen) — "1Password", "_recovery-code", 
  "_backup_code"
- Reiner-Innovation (Patente, Fahrrad, Fördermittel — top secret) — 
  sollte bei Sebastians Material nicht vorkommen, aber prüfen
- ItsLitho-Artefakte (private 3D-Print-Experimente) — "ItsLitho_"
- Raspberry-Pi-Setup — "raspberry-pi-id-", "raspios", "m3d"
- CAN-Bus / Klipper-Doku — "CAN-Bus", "Klipper", "Katapult"
- Rest/Unklar

Konfidenz:
- hoch: Dateiname enthält eindeutigen Marker (siehe oben)
- mittel: Typ + Kontext plausibel, aber nicht eindeutig
- niedrig: weder Name noch Kontext geben Hinweis

Nach der Tabelle drei Abschnitte:

### Zusammenfassung pro Thema
Tabelle: Thema | Anzahl Dateien | Gesamtgröße | Empfohlene Session-Reihenfolge

### Querverbindungen aus 01 Inbox
Scanne 01 Inbox/ nach Notizen die thematisch zu Phase 3 passen. 
Klare Kandidaten die wir schon kennen:
- "Plan - Chrome zu Safari Migration und Schluesselbund.md" → 1Password-Migration
- "Mail - 1Password Kuendigung.md" → 1Password-Migration
- "Lagerschalenhalter - Lebensmittelindustrie Überarbeitung.md" → Bens
- "Idee - Apple-Strategie für WEC und MThreeD.io.md" → Pilot-Kontext

Prüfe ob weitere dazugekommen sind, liste alle Verbindungen auf.
**Nicht verschieben** — nur bewusst machen.

### Offene Fragen an Sebastian
Dateien mit „niedrig"-Konfidenz hier auflisten mit kurzer Frage, 
was Sebastian zur Zuordnung weiß.

## Zeitbudget
Ziel: unter 10 Minuten Laufzeit. Wenn Analyse länger braucht: 
Zwischenstand zeigen, Sebastian entscheidet ob weitermachen.

## Nach Abschluss
Kurze Bilanz: Wie viele Dateien pro Thema, welche Session macht als 
Erstes am meisten Sinn (Vorschlag: Bens weil WEC-Priorität und klarer 
Zielordner 03 Bereiche/WEC/raw/Bens/).
```

---

## Anweisung für Sebastian

1. Terminal öffnen, Claude Code über `brain`-Alias starten
2. Prompt-Block oben zwischen den ``` kopieren und einfügen
3. Ergebnis ansehen — die Tabelle in *Mac Inventur - Phase 3 Vorsortierung.md*
4. Mit Claude.ai (hier) besprechen: welche Session als erstes, was mit „niedrig"-Konfidenz?

## Verknüpfungen

- [[02 Projekte/Mac Inventur]] — Pilot-Plan
- [[02 Projekte/Mac Inventur - Handover Claude Code]] — der ursprüngliche Handover
- [[02 Projekte/WEC-Geraete Pilotscope]] — Ziel-Profile
- [[04 Ressourcen/Skills/Skill - Mac-Inventur Methode]] — Methode-Skill

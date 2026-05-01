---
tags: [bereich, wec, konstruktion, idee]
date: 2026-04-15
status: idee
raum: wec
priorität: niedrig
---

# Idee — Claude + Solid Edge Integration

> **Korrektur 2026-05-01:** Notiz lag ursprünglich als „Claude SolidWorks Integration" vor (Werkzeug-Verwechslung). Reiner arbeitet mit **Solid Edge (Siemens, 4 Lizenzen 2021)**. Inhalt entsprechend überarbeitet — die Grundidee bleibt, die API-Details sind anders.

## Kontext

Reiner arbeitet seit Jahren mit Solid Edge. Dort steckt enormer Kontext: Vorlagen, vordefinierte Profile, Materialien, Zeichnungsableitungen (.dft), Kundenspezifikationen. Die Frage ist ob Claude über die Solid-Edge-API mit Reiners Modellen arbeiten kann.

## Einschätzung

**Realistisch?** Ja — mittelfristig. Solid Edge bietet eine ausgereifte Automation-Schicht:

- **COM-Automation** (Windows-only, seit vielen Versionen stabil)
- **.NET-API** (C#, VB.NET — von Siemens primär unterstützt)
- **Python via `pywin32`** möglich (COM-Wrapper, Community-Beispiele vorhanden)
- Zugriff auf: Parts (`.par`), Sheet Metal (`.psm`), Assemblies (`.asm`), Drawings (`.dft`), Stücklisten, Custom Properties

**Was möglich wäre:**

- Zeichnungen (.dft) aus 3D-Modellen ableiten — semi-automatisch nach Vorlagen-Schema
- Stücklisten exportieren (CSV/Excel) und im Gehirn ablegen
- Custom Properties (Kunde, Projekt, Material, Werkstoff) auslesen + pflegen
- Repetitive Schritte automatisieren (Standard-Bohrungen, Normteile aus DIN-Bibliothek, Materialzuweisung)
- Norm-/Qualitäts-Checks beim Speichern (Schriftfeld-Vollständigkeit, Werkstoff-Code, EHEDG-Marker)

**Was dafür nötig wäre:**

- Claude Code auf Reiners Windows-PC (oder via Tailscale-Fernzugriff)
- Python-Setup mit `pywin32`, oder C#-Wrapper-Service den Claude per Subprocess anspricht
- Solid Edge muss laufen + lizenziert sein
- Erst Lese-Operationen (Properties, BOMs, Drawings exportieren), dann schreibend (neue Drawings ableiten, Properties setzen)

## Unterschiede zur Fusion-360-Schiene

| | Solid Edge | Fusion 360 |
|---|---|---|
| API-Zugriff | COM/.NET, lokal | Cloud-API + lokales Python-Skript |
| Plattform | Windows only | macOS + Windows |
| Reife | Sehr ausgereift, große Bestands-Codebase in Industrie | Jünger, schneller im Wandel |
| Bei WEC | Reiners 30-Jahre-Korpus | Sebastians Werkzeug |

→ Beide Schienen nebeneinander relevant — Reiner-Pfad (Bestand veredeln) vs. Sebastian-Pfad (neu konstruieren). Brücke über STEP/DXF + Properties.

## Priorität

Nicht jetzt — erst Reiners Gehirn einrichten, dann Solid-Edge-Brücke bauen. Reihenfolge: lesendes Property-/BOM-Auslesen vor schreibender Drawing-Ableitung. Definitiv ein Zukunftsprojekt mit hohem Hebel auf den 30-Jahre-Bestand.

## Verknüpfungen

- [[02 Projekte/WEC Neustart mit Reiner/WEC Neustart mit Reiner]]
- [[02 Projekte/WEC Neustart mit Reiner/Strategie - Korpus-Auslesen und KI-Pipeline]]
- [[03 Bereiche/WEC/WEC Vision - Automatisierte Pipeline]]
- [[03 Bereiche/Konstruktion/Konstruktion]]

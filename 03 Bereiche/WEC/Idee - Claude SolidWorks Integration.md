---
tags: [bereich, wec, konstruktion, idee]
date: 2026-04-15
---

# Idee — Claude + SolidWorks Integration

## Kontext

Reiner arbeitet seit Jahren mit SolidWorks. Dort steckt enormer Kontext: Vorlagen, vordefinierte Profile, Materialien, Zeichnungsableitungen, Kundenspezifikationen. Die Frage ist ob Claude über eine API mit SolidWorks arbeiten kann.

## Einschätzung

**Realistisch?** Ja — mittelfristig. SolidWorks hat eine robuste API:
- COM/OLE Automation (Windows)
- VBA-Makros direkt in SolidWorks
- Python via `win32com` oder `sldworks` Package
- Zugriff auf: Parts, Assemblies, Drawings, BOM, Custom Properties, Materialien

**Was möglich wäre:**
- Zeichnungen aus 3D-Modellen ableiten (automatisch)
- Stücklisten exportieren und im Gehirn ablegen
- Materialien und Profile auslesen
- Repetitive Konstruktionsschritte automatisieren (Bohrungen, Normteile, etc.)
- Custom Properties (Kunde, Projekt, Material) automatisch pflegen

**Was dafür nötig wäre:**
- Claude Code auf Reiners Windows-PC (oder Fernzugriff)
- Python + SolidWorks API Zugriff
- SolidWorks muss laufen (Lizenz aktiv)
- Stück für Stück anlernen — erst lesen, dann schreiben

## Priorität

Nicht jetzt — erst Gehirn einrichten, dann SolidWorks-Brücke bauen. Aber definitiv ein Zukunftsprojekt mit enormem Potenzial.

## Verknüpfungen

- [[02 Projekte/WEC Neustart mit Reiner/Konzept Zwei Gehirne]]
- [[03 Bereiche/Konstruktion/Konstruktion]]

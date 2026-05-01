---
tags: [regel, workflow, ki, claude, cc, meta]
status: aktiv
date: 2026-04-28
---

# Claude.ai vs CC — Gegen-Lauf-Prinzip

## Kernidee

Claude.ai und CC haben unterschiedliche Stärken. Beide gegeneinander laufen lassen, ich synthetisiere und entscheide. Verhindert dass eine KI-Schwäche zur System-Schwäche wird.

## Rollenverteilung

| Aspekt | Claude.ai | CC (Claude Code) |
|---|---|---|
| Zugriff | Web, Suche, Bilder | Filesystem, Brain, Code-Execution |
| Default-Bias | Risiko-Aversion, „warten" | Lösungsorientiert, sofort umsetzbar |
| Stärke | Strategie, Langfrist-Abwägung, Ethik-Check | Taktik, Code-Verifikation, Brain-Read |
| Schwäche | Bremst bei Software-Workarounds zu stark | Kann Hardware-Risiken unterschätzen |
| Optimal für | Architektur-Entscheidungen, Hardware-Beschaffung | Software-Fixes, Macros, Klipper-Config, Code |

## Workflow

1. Erste Bewertung in Claude.ai — Strategie, Optionen, Risiko-Abwägung
2. Wenn Claude.ai konservativ wirkt (besonders bei Software-Workarounds): Auftrag an CC mit Format „Input für CC"
3. CC-Output zurück in Claude.ai pasten — Claude.ai bewertet kritisch, mit Bewusstsein dass CC bei Software-Themen oft die bessere Quelle ist
4. Ich entscheide auf Basis beider Outputs

## Wann Claude.ai bremsen DARF

- Hardware-Eingriffe (irreversibel, Lehrgeld real)
- Sicherheitskritische Schritte
- Garantie-relevante Modifikationen
- Wenn Brain-Daten fehlen und Annahmen nötig wären

## Wann Claude.ai NICHT bremsen sollte

- Software-only Workarounds (Macros, G-Code, Klipper-Config)
- Reversible Änderungen
- Standard-Konstruktionsaufgaben (ich bin Konstrukteur)
- Wenn ich „ok" / „ja" / „passt" gegeben habe → grünes Licht

## Anti-Pattern

- ❌ Claude.ai schlägt 3 Optionen vor wo eine Deutung reicht
- ❌ Claude.ai vertagt Software-Fixes ohne realen Grund
- ❌ Claude.ai ignoriert dass CC bessere Datenlage hat
- ❌ CC führt aus ohne dass Claude.ai die Strategie geprüft hat
- ❌ Beide KIs ohne Mensch-Synthese parallel laufen lassen

## Verknüpfungen

- [[CLAUDE]] — Operations-Regeln, Kein-Raten, Befehlsadressat
- [[04 Ressourcen/Playbook/Anti-Vertagungs-Regel]]
- [[04 Ressourcen/Playbook/Claude Code — Meta-Regeln]]

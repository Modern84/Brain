---
tags: [projekt, handover, claudecode]
date: 2026-04-18
---

# Handover an Claude Code — Mac Inventur Pilot

> **Zweck:** Dieser Text wird in Claude Code reinkopiert wenn Sebastian parallel am Terminal arbeitet. Er gibt Claude Code den kompletten Projekt-Kontext und den nächsten konkreten Schritt.

---

## Prompt für Claude Code

```
Hallo Claude Code — du arbeitest jetzt am Mac-Inventur-Pilot von Sebastian.

## Arbeitsteilung
- Claude in claude.ai (Browser) = Kopf: Planung, Vault pflegen, Strategie
- Du (Claude Code) = Hände: Terminal, chmod, ausführen, Output zurück

## Zuerst lesen (Pflicht)
1. CLAUDE.md im Vault-Root — Beratungsstandard, Arbeitsweise, LRS-Regel, Außenauftritt
2. 02 Projekte/Mac Inventur.md — der Pilot-Plan mit 7 Etappen bis August 2026
3. 02 Projekte/WEC-Geraete Pilotscope.md — der Pilot-Charakter: 6 PCs bei WEC kommen später

## Aktuelle Situation
- Etappe 1 läuft (Desktop und Downloads aufräumen)
- Skript liegt in: 04 Ressourcen/Automatisierung/mac-inventur.sh
- Alias `mac-inventur` ist in ~/.zshrc gesetzt und funktioniert
- Bash-3.2-Kompatibilitäts-Fix ist drin (keine assoziativen Arrays)
- Letztes Problem: Nach jedem Write über den Filesystem-Connector geht
  das Execute-Bit verloren. Sebastian hat es bereits gesetzt.
- Preview wurde noch nicht erfolgreich ausgeführt

## Dein nächster Schritt
1. Stelle sicher dass das Skript ausführbar ist:
   chmod +x ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Brain/04\ Ressourcen/Automatisierung/mac-inventur.sh

2. Führe aus: mac-inventur --preview

3. Zeige Sebastian die Ausgabe (Zahlen pro Kategorie)

4. Warte auf seine Bestätigung bevor du mac-inventur ohne --preview ausführst

5. Nach erfolgreichem Lauf:
   - Fortschritt in 02 Projekte/Mac Inventur.md aktualisieren
   - Entsprechenden Haken in der Fortschritts-Liste setzen
   - Daily Note in 05 Daily Notes/YYYY-MM-DD.md ergänzen oder anlegen

## Wichtige Regeln (aus CLAUDE.md)
- LRS: Sebastians Schreibfehler still korrigieren, nie kommentieren
- Eigene Texte fehlerfrei
- Frage-Gegenfrage-Prinzip: eine Frage, nicht Roman
- Bei Optionen A/B/C: direkt mit A beginnen, keine Rückfrage
- Vor destruktiven Aktionen (löschen, überschreiben): nachfragen
- Nach Datei-Operationen an wichtigen Stellen: MEMORY.md und Daily Note aktualisieren
- Pilot-Charakter berücksichtigen: jede Entscheidung wird später auf 6 WEC-PCs skaliert

## Pilot-Erkenntnisse sammeln
Während der Arbeit: notiere dir wiederkehrende Muster in einer Liste
(welche Dateitypen tauchen oft auf, welche Namensmuster, welche Entscheidungen
wiederholen sich). Diese Liste wird später die Grundlage für
04 Ressourcen/Playbook - Gerät ins Gehirn integrieren.md.

Frag Sebastian wenn etwas unklar ist. Kein blindes Raten.
```

---

## Anweisung für Sebastian

1. **Claude Code starten** über den `brain`-Alias (damit er im Vault ist, nicht in `~/`):
   ```bash
   brain
   ```

2. **Diesen Prompt kopieren** (den Block oben zwischen den ```) und in Claude Code einfügen.

3. **Loslaufen lassen.** Claude Code übernimmt ab da die Terminal-Arbeit.

4. **Parallel in claude.ai (hier)** bleiben für strategische Fragen, Vault-Pflege und Entscheidungen.

## Wenn die Session endet

Claude Code bitten, die Abschluss-Routine zu fahren (aus CLAUDE.md):
- Daily Note aktualisieren
- TASKS.md prüfen
- MEMORY.md aktualisieren falls IP/Firmware/Workarounds geändert
- Mac Inventur.md Fortschritt aktualisieren

## Verknüpfungen

- [[02 Projekte/Mac Inventur]] — der Pilot-Plan
- [[02 Projekte/WEC-Geraete Pilotscope]] — warum Pilot
- [[04 Ressourcen/Workflow - Sebastian und Claude]] — Arbeitsteilung allgemein

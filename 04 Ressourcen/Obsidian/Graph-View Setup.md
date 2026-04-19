---
tags: [ressource, obsidian, graph, setup]
date: 2026-04-19
status: aktiv
---

# Graph-View Setup

Dokumentiert die Einstellungen der globalen Graph-View in `.obsidian/graph.json`. Diese Datei ist in `.gitignore` (Obsidian schreibt bei jeder Zoom-/Layout-Änderung rein → würde Git-History zumüllen). Stattdessen liegen die Werte hier als Referenz — bei Neu-Setup, anderem Gerät oder Reiners Gehirn reproduzierbar.

## Anwendung

1. Obsidian → Graph View öffnen (Cmd+G global, oder aus der Seitenleiste)
2. Rechts oben Zahnrad → Einstellungen
3. Werte unten eintragen
4. Farbgruppen einzeln anlegen (Reihenfolge = Priorität von oben nach unten)

Nach Änderungen an `.obsidian/graph.json` direkt: **`Cmd+R`** (Obsidian neu laden), damit die Datei gelesen wird.

## Kräfte-Parameter — Neuronale Physik

Zentrale Idee: Cluster bilden sich natürlich durch Abstoßung + Verbindungszug. Kein zentraler Anker-Ball.

| Parameter | Wert | Wirkung |
|---|---|---|
| `repelStrength` | **10** | Cluster trennen sich voneinander (Neuronen-Gebiete statt Ball) |
| `linkStrength` | **1.0** | Verbindungen ziehen Knoten zusammen — Synapsen |
| `centerStrength` | **0.08** | Minimale Zentrierung, kein Schwarzes Loch in der Mitte |
| `linkDistance` | **160** | Adern sichtbar lang |
| `lineSizeMultiplier` | **0.5** | Verbindungslinien erkennbar (0.1 wäre unsichtbar) |
| `nodeSizeMultiplier` | **1.0** | Normale Knotengröße |
| `textFadeMultiplier` | **-1.5** | Labels früh lesbar beim Reinzoomen |
| `showArrow` | **false** | Organisch, keine Pfeile |

### Feintuning

- Netz zu chaotisch → `repelStrength` **10 → 5** (Cluster enger)
- Netz zu dicht → `repelStrength` **10 → 15** (Cluster weiter auseinander)

Das sind die zwei Hauptregler.

## Farbgruppen — Kontrast und Binnenstruktur

Reihenfolge wichtig: spezifischere Pfade zuerst (höhere Priorität), Defaults zuletzt.

### Grund-Schichten (Kontrast hell/dunkel)

| Schicht | Query | Farbe | Wirkung |
|---|---|---|---|
| Archiv | `path:"06 Archiv"` | `#2D1B3C` dunkles Lila | gedämpft, fast Hintergrund |
| Clippings | `path:"Clippings"` | `#C084FC` helles Lila | leuchtet, klar erkennbar |
| Anhänge Default | `path:"07 Anhänge"` | gedämpftes Ocker | ruhig |

### Binnenstruktur im Anhänge-Ring

Statt uniformer gelber Ring → farbige Inseln nach Unterordner:

| Query | Farbe |
|---|---|
| `path:"07 Anhänge/Datensatz_SK"` | tiefes Violett |
| `path:"07 Anhänge/Profil"` | Dunkel-Rosa |
| `path:"07 Anhänge/Screenshots"` | Blassblau |
| `path:"07 Anhänge/Schwenkteilsicherung"` | Salbei-Grün |
| `path:"07 Anhänge/Fusion360"` | Altgold |
| `path:"07 Anhänge/Reiners_Gehirn"` | WEC-Orange |

### WEC-Binnenstruktur

| Query | Farbe |
|---|---|
| `path:"03 Bereiche/WEC/Operationen"` | WEC-Orange hell |
| `path:"03 Bereiche/WEC/Sessions"` | WEC-Orange mittel |
| `path:"03 Bereiche/WEC/Lieferung"` | WEC-Orange dunkel |

### Ressourcen-Binnenstruktur (Teal/Blau-Nuancen)

| Query | Farbe |
|---|---|
| `path:"04 Ressourcen/Klipper"` | Teal dunkel |
| `path:"04 Ressourcen/Obsidian"` | Teal mittel |
| `path:"04 Ressourcen/Scripts"` oder `Prompts` | Teal hell |
| `path:"04 Ressourcen/Templates"` | Blau mittel |
| `path:"04 Ressourcen/Playbook"` | Blau dunkel |

### Meta-Hubs hervorheben

| Query | Farbe | Sinn |
|---|---|---|
| `file:TASKS` | Eigene Signal-Farbe | sichtbarer Ankerpunkt |
| `file:MEMORY` | Eigene Signal-Farbe | sichtbarer Ankerpunkt |

## Verknüpfungen

- [[Claude - Selbstkarte.canvas]] — Eigene Selbstkarte (Canvas, nicht Graph-View)
- [[Gehirn - Neuronale Karte.canvas]] — Vault-Neuralstruktur (Canvas)
- [[Gehirn - Selbstanalyse.base]] — lebende tabellarische Analyse

Die Graph-View ist das *dynamische* Pendant zu diesen Karten — sie zeigt den Ist-Zustand aller Verknüpfungen live.

---
tags: [ressource, obsidian, graph, config]
date: 2026-04-21
status: aktiv
---

# Graph-Config-Rationale

Datenbasiert neu gerechnete Graph-Config für Reiners ersten Blick auf den Vault. Ziel: Donut-Optik (Attachment-Ring) weg, PARA-Cluster sofort lesbar.

## Datenbasis (2026-04-21)

- Markdown-Notizen gesamt: **232**
- Verteilung: 00 Kontext 28 · 01 Inbox 3 · 02 Projekte 44 · 03 Bereiche 61 · 04 Ressourcen 53 · 05 Daily Notes 13 · 06 Archiv 6 · 07 Anhänge 11 · Clippings 1
- Attachments (PDF/Bild/Video): **1900**
- Wiki-Links gesamt: **923** → Dichte **3,98 Links/Notiz** (sehr gut vernetzt)
- Waisen-Anteil geschätzt: **<40 %** (Dichte 3,98 spricht gegen viele isolierte Knoten)

## Parameter-Änderungen

- **showAttachments**: false → false. Begründung: Donut-Eliminierung — 1900 Attachments vs. 232 Notizen würden den Wissensgraph überlagern. Datenbasis: Attachment/Notiz-Ratio 8,2.
- **showOrphans**: false → true. Begründung: Link-Dichte 3,98 → Waisen-Anteil <40 %, Waisen sichtbar machen hilft beim Aufspüren isolierter Notizen. Datenbasis: 923 Links / 232 Notizen.
- **showTags**: true → true. Begründung: Struktur-Signal (MOC-Tags etc.) bleibt erhalten.
- **hideUnresolved**: true → true. Begründung: tote `[[...]]`-Links würden als Geisterknoten erscheinen.
- **showArrow**: true → true. Begründung: Richtung der Verlinkung ist semantisch relevant.
- **linkDistance**: 180 → **350**. Begründung: Formel `max(150, min(350, 40000/sqrt(n)))` → bei 232 Notizen clamped auf Maximum 350. Cluster bekommen Luft. Datenbasis: n=232.
- **repelStrength**: 8 → **10**. Begründung: leicht stärkere Abstoßung gegen Überlappung bei 232 Knoten.
- **linkStrength**: 0.8 → **1.2**. Begründung: verknüpfte Cluster stärker bündeln, sichtbare Themen-Inseln.
- **centerStrength**: 0.3 → **0.5**. Begründung: moderater Center-Pull, Cluster atmen statt kleben.
- **nodeSizeMultiplier**: 1.5 → **1.0**. Begründung: ruhigere Erstsicht für Reiner, weniger visuelles Gewicht.
- **lineSizeMultiplier**: 1.2 → **1.0**. Begründung: Standard, konsistent mit nodeSize.
- **textFadeMultiplier**: 2 → **0**. Begründung: Labels sofort sichtbar, Reiner kann beim ersten Blick Themen lesen ohne reinzoomen.
- **scale**: 1 → **0.6**. Begründung: leichter rausgezoomt, alle Hauptcluster direkt im Blickfeld.

## Farbgruppen

- Alle 15 Pfad-Regeln verifiziert — keine toten Ordner.
- Reihenfolge angepasst: spezifische Pfade zuerst (z. B. `03 Bereiche/WEC` vor `03 Bereiche`), damit Obsidian die spezifischere Regel anwendet.
- Neu: `file:README` (9 README.md im Vault — Einstiegsdateien sichtbar markieren).
- Entfernt: keine (alle bestehenden Einträge gültig).
- `file:MEMORY` nicht aufgenommen (MEMORY.md liegt außerhalb des Vaults).

## Rollback

```bash
cp "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain/.obsidian/graph.json.backup-20260421-1806" \
   "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain/.obsidian/graph.json"
```

Danach Obsidian mit `Cmd+Q` beenden und neu starten, damit graph.json neu gelesen wird.

## Farbpalette — Nord-Revision 2026-04-21 18:17

Umgestellt von gemischter Pastell-Palette auf **Nord-Theme** (nordtheme.com) — 16 harmonisch abgestimmte Farben, speziell für Dark Mode entwickelt, Branchen-Standard in Dev-Tools (VSCode, JetBrains, iTerm). Wirkt professionell statt verspielt, ruhig statt bunt.

| Pfad / Tag / File | Semantik | Hex | Dezimal |
|---|---|---|---|
| `00 Kontext` | Neutral dunkel (Struktur-Backbone) | `#3b4252` | 3883602 |
| `01 Inbox` | Neutral mittel (temporär) | `#434c5e` | 4410462 |
| `02 Projekte` | Frost-Blau hell (aktive Arbeit) | `#81a1c1` | 8495553 |
| `03 Bereiche/WEC` | Aurora-Grün (WEC-Akzent) | `#a3be8c` | 10731148 |
| `03 Bereiche/Business MThreeD.io` | Aurora-Violett (MThreeD-Akzent) | `#b48ead` | 11833005 |
| `03 Bereiche/Konstruktion` | Frost-Blau dunkel | `#5e81ac` | 6193580 |
| `03 Bereiche/KI-Anwendungen` | Frost-Cyan hell | `#88c0d0` | 8962256 |
| `03 Bereiche/Finanzen` | Polar-Nacht dunkelgrau | `#4c566a` | 5002858 |
| `03 Bereiche/Ildi` | Polar-Nacht dunkelgrau | `#4c566a` | 5002858 |
| `03 Bereiche` (Fallback) | Frost-Teal | `#8fbcbb` | 9419963 |
| `04 Ressourcen/Playbook` | Aurora-Orange (Referenz-Hotspot) | `#d08770` | 13666160 |
| `04 Ressourcen/Musterbeispiele-Reiner` | Aurora-Gelb | `#ebcb8b` | 15453067 |
| `04 Ressourcen` (Fallback) | Snow-Storm hell | `#d8dee9` | 14212841 |
| `05 Daily Notes` | Neutral mittel | `#434c5e` | 4410462 |
| `06 Archiv` | Neutral dunkel | `#3b4252` | 3883602 |
| `tag:#moc` | Snow-Storm sehr hell (Leitknoten) | `#eceff4` | 15527924 |
| `file:CLAUDE` | Aurora-Rot (Regel-Doku) | `#bf616a` | 12542314 |
| `file:README` | Snow-Storm hell | `#e5e9f0` | 15067632 |
| `file:TASKS` | Aurora-Orange | `#d08770` | 13666160 |

Alle 19 Einträge auf Nord-Werte umgestellt. Parameter (Kräfte, Skalen, Flags) unverändert.

### Rollback Nord-Revision

```bash
cp "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain/.obsidian/graph.json.backup-nord-20260421-1817" \
   "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain/.obsidian/graph.json"
```

Obsidian mit `Cmd+Q` beenden und neu starten.

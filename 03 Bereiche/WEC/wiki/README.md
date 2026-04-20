---
tags: [bereich, wec, wiki, regeln]
date: 2026-04-17
---

# wiki/ — Lebende Wissensbasis (Claude pflegt, Mensch verifiziert)

> **Hier kompiliert Claude Wissen aus `raw/` in strukturierte Artikel.**
> Mensch korrigiert, Claude lernt aus der Korrektur.

---

## Was hier reinkommt

| Ordner | Inhalt |
|---|---|
| `Kunden/` | Pro Kunde ein Profil: Anforderungen, Standards, Eigenheiten, Lieferformate |
| `Normen/` | EHEDG, DIN, ISO — relevant für WEC-Branchen |
| `Standards WEC/` | Reiners 30 Jahre Wissen extrahiert: Zeichnungsableitung, Stücklisten, Nummerierung |
| `BWL-Filter/` | Claudes Schutzfunktion: Bonität, Verträge, Warnsignale |

---

## Pflicht-Format jeder Wiki-Datei

Kopfdaten:
```yaml
---
tags: [wiki, wec, <kategorie>]   # kategorie: kunde ODER norm ODER standard ODER bwl — genau eines
date: YYYY-MM-DD
status: kompiliert   # oder: in-arbeit / verifiziert
quellen: [raw/Kunden/.../datei1.pdf, raw/.../datei2.step]
---
```

Inhalt:
- **Kurz-Zusammenfassung** (3 Zeilen) ganz oben
- **Detail-Sektionen** strukturiert nach Thema
- **Quellverweise** auf raw/-Dateien (mit Wikilink)
- **Querverweise** zu anderen Wiki-Artikeln
- **Offene Punkte** als TODO-Marker — nie raten

---

## Workflow

1. **Ingest** — Sebastian sagt: "Neue Daten in raw/Volker Bens, kompilier"
2. **Compile** — Claude liest raw/, schreibt/aktualisiert Wiki-Artikel
3. **Verify** — Sebastian/Reiner prüfen, korrigieren wenn nötig
4. **Lint** — Claude prüft regelmäßig: tote Links? veraltete Infos? Inkonsistenzen?

→ Details in `Operationen/`

---

## Wer schreibt hier rein

- **Claude** — primär. Pflegt Artikel, fügt Querverweise ein, hält Wiki konsistent.
- **Sebastian / Reiner** — korrigieren direkt im Artikel, Claude lernt aus Korrektur.

**Wichtig:** Bei Korrekturen kommentiert der Mensch nicht "Claude, ändere X" — er ändert direkt. Claude erkennt die Änderung beim nächsten Lint.

---

## Was hier NICHT reinkommt

- ❌ Original-CAD-Dateien (gehören in `raw/`)
- ❌ Persönliche Notizen ohne Bezug zu kompiliertem Wissen (gehören in `01 Inbox/` oder `05 Daily Notes/`)
- ❌ Aktive Projekt-To-Dos (gehören in `02 Projekte/` oder `TASKS.md`)

Faustregel: Wenn die Info **stabil** und **referenzierbar** ist → wiki. Wenn flüchtig → woanders.

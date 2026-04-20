---
tags: [kontext, meta, system-health]
date: 2026-04-19
status: baseline
---

# System-Health — Gehirn-Zustand

> Periodischer Snapshot. Kein Prosa-Bericht — nur Zahlen und Muster.

---

## Baseline 2026-04-19 (nach Schema-Durchlauf)

### Volumen

| Bereich | Dateien (.md) |
|---|---|
| 00 Kontext | 17 + Meta/ |
| 01 Inbox | 4 |
| 02 Projekte | 12 (nach Cleanup) |
| 03 Bereiche | 43 |
| 04 Ressourcen | ~40 (mit Scripts + Prompts + Templates) |
| 05 Daily Notes | 10 |
| 06 Archiv | 7 (inkl. 2 neue Archivierungen) |
| Clippings | 1 |

### Qualität

- **Tag-Konsistenz**: ✅ alle Daily Notes auf `tagesbuch`
- **Kaputte Tags**: ✅ gefixt 2026-04-20 — war kein echter Tag im Einsatz, nur irreführender Pipe-Platzhalter im Wiki-README-Template. Umgestellt auf `<kategorie>`-Platzhalter mit Kommentar.
- **Kopfdaten-Abdeckung**: ⚠️ 3 Referenz-Projekte migriert, Rest lazy
- **Broken Wikilinks**: nicht gemessen — Baseline durch `brain-lint.sh` offen
- **Orphans**: viele (ersichtlich aus Graph) — akzeptiert weil Attachments

### Strukturelle Schichten

| Schicht | Status |
|---|---|
| Karpathy-Pattern (raw/wiki) | ✅ in WEC |
| Raum-Auto-Erkennung | ✅ in CLAUDE.md, 9 Räume |
| Meta-Selbstreflexion | ✅ dieser Ordner angelegt |
| Semantic Search (Embeddings) | ❌ Smart Connections nicht installiert |
| MCP-Vault-Zugriff | ❌ aus Someday → sollte aktiv werden |
| Dataview-Felder | ⚠️ Schema definiert, Migration offen |

### Claude-Arbeitsqualität (Session 2026-04-19)

| Regel | Einhaltung |
|---|---|
| R1 max eine Tabelle | ❌ mehrfach verletzt |
| R2 keine a/b/c-Fragen | ❌ mehrfach verletzt |
| R3 Substanz-Check zuerst | ❌ nicht praktiziert bis explizit nachgefragt |
| R4 Feedback laut integrieren | ⚠️ teilweise |
| R5 Emojis bedeutungstragend | ❌ dekorativ eingesetzt |
| R6 Parallel-Instanz-Schutz | ❌ Edi-Regression nicht vermieden |

→ Basis für nächste Session: diese Spalte soll mehr ✅ haben.

---

## Offene Entscheidungen (blockieren Fortschritt)

1. **Datensatz_SK** (4,1 GB) — externe SSD oder 06 Archiv?
2. **Solid-Edge-Profil** (144 MB) — komplett zu WEC oder selektiv?
3. **Smart Connections** — Sebastian muss Plugin installieren
4. **Git-Remote** — GitHub Private / Gitea / nur lokal?

---

## Nächster Check

**Sonntag 2026-04-26** — erste wöchentliche Retro.

Template: [[Retrospektive-Template]]

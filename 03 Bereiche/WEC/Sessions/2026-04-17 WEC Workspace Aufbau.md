---
tags: [bereich, wec, session, kontext]
date: 2026-04-17
status: abgeschlossen
---

# Session 2026-04-17 — WEC Workspace Aufbau

> **Was hier passiert ist:** Konzeption und Aufbau der WEC-Operationszentrale nach Karpathys LLM-Wiki-Pattern.
> **Anschluss:** Nächster WEC-Tab nutzt [[03 Bereiche/WEC/README]] als Einstieg.

---

## Was besprochen wurde

### Ausgangslage
- Sebastian wollte einen WEC-Connector-Tab in claude.ai
- Sorge: pro Tab ein Thema (Performance, Fokus)
- Frage: optimale Struktur für WEC im Brain — verbaue ich mir was?

### Erkenntnisse
1. **Andrej Karpathys LLM-Wiki-Pattern** als Vorbild
   → YouTube: "LLM Wiki Tutorial — So baut KI dir eine Wissensbasis"
   → Drei Layer: `raw/` (unantastbar) + `wiki/` (Claude pflegt) + `schema` (CLAUDE.md)
   → Drei Operationen: ingest, query, lint

2. **WEC ist kein normaler Bereich** — fast ein Vault im Vault. Kunden, NAS-Daten, Reiners 30-Jahre-Wissen, BWL-Filter.

3. **Bestehendes nicht zerstören** — `00 Kontext/WEC Kontakte/`, `02 Projekte/WEC Neustart mit Reiner/`, `04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl.md`, `07 Anhänge/Reiners_Gehirn/` bleiben wo sie sind, werden via Wikilinks angebunden.

4. **CAD-Software-Korrektur:** Reiner nutzt **SolidWorks 2020** (steht im Profil Reiner — Sebastian war früher unsicher). Sebastian nutzt Fusion 360.

### Entscheidung: Hybrid-Struktur

```
03 Bereiche/WEC/
├── CLAUDE.md          ← WEC-spezifische Regeln
├── README.md          ← Einstiegspunkt für jeden Claude-Tab
├── raw/               ← UNANTASTBAR (NAS-Daten via T9)
├── wiki/              ← Claude-kompiliert (Kunden, Normen, Standards, BWL)
├── Operationen/       ← Ingest, Query, Lint
└── Sessions/          ← Pro Chat-Tab eine Notiz (diese hier ist die erste)
```

### Datei-Frage entschieden
- `04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl.md` **bleibt** wo sie ist (stabiler menschengeschriebener Standard, keine Karpathy-Layer-Verschiebung sinnvoll)
- wiki/Kunden/Volker Bens - Profil.md wird zur **lebenden Zusammenfassung** mit Querverweis

---

## Was angelegt wurde

| Datei | Inhalt |
|---|---|
| `README.md` | Einstiegspunkt für WEC-Bereich |
| `CLAUDE.md` | WEC-spezifische Claude-Regeln (ergänzt Root) |
| `raw/README.md` | Regeln für die unantastbare Schicht |
| `wiki/README.md` | Regeln für die lebende Wissensbasis |
| `Operationen/Ingest.md` | Wie neue Daten einkommen |
| `Operationen/Query.md` | Wie Wissen abgefragt wird |
| `Operationen/Lint.md` | Wie Konsistenz geprüft wird |
| `wiki/Kunden/Volker Bens - Profil.md` | Erster Stub, wartet auf T9-Ingest |
| `wiki/BWL-Filter/Kundenbonität.md` | Prüfprozess für Reiners Schutz |
| `wiki/BWL-Filter/Vertragsprüfung.md` | Checkliste vor Unterschrift |
| `wiki/BWL-Filter/Warnsignale.md` | Frühindikatoren-Katalog |

Leer angelegt (warten auf Inhalt):
- `raw/Kunden/Volker Bens/`
- `raw/Kunden/Knauf/`
- `wiki/Kunden/`, `wiki/Normen/`, `wiki/Standards WEC/`

---

## Offene Punkte für Folge-Sessions

- [ ] **NAS-Zugriff klären** — Reiner besorgt T9, befüllt sie mit Volker-Bens-Projektdaten (Anleitung: [[02 Projekte/WEC Neustart mit Reiner/Anleitung Reiner - Externe SSD Projektspiegel]])
- [ ] **Erste Ingest-Lieferung** — wenn T9 da ist, raw/ befüllen, Claude kompiliert ins wiki/
- [ ] **EHEDG-Norm-Eintrag** in wiki/Normen/
- [ ] **Standards WEC** aus Reiners Erfahrung extrahieren (im Gespräch mit Reiner)
- [ ] **Knauf-Profil** anlegen wenn erste Daten da
- [ ] **Reiners Mac Mini M5** (Juni/Juli) → eigenes Gehirn aktivieren mit gleicher Struktur

---

## Anschluss für nächsten Tab

Nächster Claude-Tab in claude.ai für WEC-Themen:
1. Tab öffnen
2. Sagen: "Lies `03 Bereiche/WEC/README.md`"
3. Claude hat sofort vollen WEC-Kontext

---

## Verknüpfungen

- [[03 Bereiche/WEC/README]]
- [[03 Bereiche/WEC/CLAUDE]]
- [[03 Bereiche/WEC/Operationen/Ingest]]
- [[03 Bereiche/WEC/wiki/Kunden/Volker Bens - Profil]]
- [[02 Projekte/WEC Neustart mit Reiner/Reiners Gehirn - Setup Plan]]

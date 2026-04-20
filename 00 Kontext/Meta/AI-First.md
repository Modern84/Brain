---
tags: [kontext, meta, ai-first, manifest]
date: 2026-04-19
status: richtungsentscheidung
---

# AI-First — Gehirn als KI-natives System

> Entscheidung 2026-04-19: Das Gehirn wird nicht länger als **"aufgeräumtes Wiki mit KI-Hilfe"** verstanden, sondern als **KI-natives System das Menschen bedienen**. Umkehr der Polarität.

---

## Was sich dadurch ändert

| Schicht | Vorher (human-first) | Nachher (AI-first) |
|---|---|---|
| Primäres Interface | File-Browser in Obsidian | Query an Claude (via MCP) |
| Such-Mechanik | Volltext, Tags, Wikilinks | Embeddings + strukturierte Felder |
| Einheit einer Notiz | Artikel (langer Fließtext) | Atomare Einheit mit Kontext-Lead |
| Kopfdaten | Ornament über dem Inhalt | **Primärinhalt**, Prosa ist Kommentar |
| Navigation | Ordner + Wikilinks manuell | Queries + semantische Nähe automatisch |
| Claudes Rolle | Assistent der hilft | Owner der pflegt, Sebastian gibt Feedback |
| Daily Notes | Tagesbuch für Sebastian | Session-Log für Claude, auswertbar |
| Ordner-Struktur | tief geschachtelt, Bedeutung im Pfad | flach wo möglich, Bedeutung in Feldern |

---

## Vier Prinzipien

**P1 — Felder sind Wahrheit, Prosa ist Kommentar.** Status, Kunde, Risiko, Owner — das sind keine Ornamente. Das sind die Fakten. Der Fließtext kann veralten, die Felder müssen stimmen.

**P2 — Atomar vor Umfassend.** Ein Artikel über "Volker Bens" hat nicht 10 Kapitel. Er hat Felder + knappe Fakten + Verweise auf eigenständige Sub-Notizen. Jede Sub-Notiz soll einzeln Embedding-tauglich sein (genug Kontext in sich).

**P3 — Kontext-Lead zuerst.** Jede Datei beginnt nach den Kopfdaten mit einem 2–3-Satz-Block "Was ist das, für wen, warum wichtig". Nicht für Sebastian — für das nächste Claude-Modell das die Notiz in 8 Monaten erstmals sieht.

**P4 — Queries sind Interface.** Statt eines Ordners "aktive Projekte" gibt es eine Query. Statt eines Kunden-Registers gibt es eine Query. Views werden materialisiert wenn gebraucht, nicht statisch gepflegt.

---

## Die drei Hebel (die echte Substanz)

Diese drei bringen das Gehirn substanziell auf AI-first. Reihenfolge nach Wirkung:

**Hebel 1 — Smart Connections Plugin (A — hoch)**
- Liefert lokale Embeddings. Claude findet thematisch ähnliche Notizen ohne Tags.
- **Einzige Abhängigkeit:** Sebastian installiert in Obsidian → Community Plugins → Browse → "Smart Connections".
- Erste Indexierung 10–20 Min, dann permanent.
- Ohne das bleibt das Gehirn auf Wikilink-Navigation beschränkt.

**Hebel 2 — Obsidian-MCP-Server (A — hoch)**
- Erlaubt Claude strukturierte Queries statt File-Read.
- Status: aus "Someday" in TASKS → nach "Aktiv" hochgezogen.
- Vorbereitung: Setup-Anleitung schreiben, MCP-Config vorbereiten. Installation ist ein Sebastian-Abend.

**Hebel 3 — Kopfdaten-Migration abschließen (A — hoch)**
- Schema ist definiert ([[04 Ressourcen/Kopfdaten-Standard]]), 3 Referenz-Dateien migriert.
- Rest lazy oder in einem Rutsch durch Claude Code (Handover liegt bereit: [[04 Ressourcen/Templates/Claude-Handover/Kopfdaten-Migration]]).
- Ohne volle Migration bleibt das Home-Dashboard halbleer.

---

## Neue Notizen-Regel ab heute

Jede **neue** Notiz folgt diesem Minimum:

```yaml
---
tags: [...]
date: YYYY-MM-DD
status: ...
owner: ...
raum: ...
# weitere Felder je nach Typ — siehe Kopfdaten-Standard
---
```

Danach **Kontext-Lead** (max 3 Sätze): *Was ist das? Für wen? Warum wichtig?*

Dann Fakten oder Inhalt.

**Alt-Notizen** werden bei Berührung migriert. Kein Massen-Umbau.

---

## Was NICHT geändert wird

- **Ordnerstruktur bleibt** (PARA + Meta + WEC-Pattern). Umzug wäre hoher Aufwand für geringen Gewinn.
- **Obsidian bleibt** Haupt-Client für Sebastian.
- **Markdown bleibt** Format. Es ist Embedding-tauglich, mensch-lesbar, versionierbar.
- **Deutsche Begriffe bleiben** (Tagesbuch, Eingang etc.).
- **Reiners Gehirn bleibt einfach** — AI-first heißt für ihn nur dass Claude aktiver pflegt.

---

## Erfolgsmessung

In 4 Wochen (2026-05-17) soll gelten:

- [ ] Smart Connections installiert + indexiert
- [ ] Obsidian-MCP konfiguriert, Claude greift via Query zu
- [ ] Mindestens 80 % aller aktiven Projekte haben volle Kopfdaten
- [ ] Home-Dashboard zeigt echte Daten in allen 7 Queries
- [ ] Mindestens 5 neue Notizen im AI-first-Stil (Kontext-Lead, atomar)

Messbar über [[System-Health]]-Update am 2026-05-17.

---

## Verknüpfungen

- [[CLAUDE]] — wird durch dieses Manifest ergänzt
- [[00 Kontext/Meta/README]] — Meta-System-Übersicht
- [[04 Ressourcen/Kopfdaten-Standard]] — das Schema
- [[00 Kontext/Home]] — das Dashboard das davon lebt
- [[04 Ressourcen/Templates/Claude-Handover/Kopfdaten-Migration]] — der Migrations-Auftrag

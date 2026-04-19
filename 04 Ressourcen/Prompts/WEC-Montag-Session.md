---
tags: [ressource, prompt, wec, session]
date: 2026-04-19
---

# WEC-Montag-Session — Vorbereitung für Reiner-Treffen

> **Zweck:** Sonntagabend vor einem Montag-Treffen mit Reiner einen frischen claude.ai-Tab hochfahren, der alle relevanten Unterlagen aufbereitet.

---

## Prompt

```
Wir bereiten morgen eine WEC-Session mit Reiner vor.

Thema: [z.B. Volker Bens Lagerschalenhalter / Flanschlager / neuer Kunde ...]

Bitte lies in dieser Reihenfolge:
1. 03 Bereiche/WEC/CLAUDE.md — WEC-Regeln (White-Label, BWL-Filter etc.)
2. 03 Bereiche/WEC/README.md — Bereichsübersicht
3. Relevante raw-Daten zum Thema (nur Metadaten, keine großen Dateien)
4. Wiki-Artikel zum Thema in 03 Bereiche/WEC/wiki/
5. Letzte Session-Notizen in 03 Bereiche/WEC/Sessions/ (falls vorhanden)

Dann:
- Stichpunkt-Liste was ich Reiner zeigen will (max 5 Punkte)
- Offene Fragen die WIR klären müssen (max 3)
- Warnsignale aus BWL-Filter-Sicht (falls zutreffend)
- Konkrete Dokumente die ich mitnehmen sollte

Keine Roman-Antwort. Nur die Punkte.
```

---

## Nach der Session — Session-Notiz

```
Wir hatten heute Session mit Reiner zu [Thema].

Lege eine neue Datei an:
03 Bereiche/WEC/Sessions/YYYY-MM-DD - [Thema].md

Mit Kopfdaten:
---
tags: [bereich, wec, session]
date: YYYY-MM-DD
teilnehmer: [Reiner, Sebastian, ...]
thema: [...]
---

Ich diktiere jetzt was besprochen wurde — du strukturierst:
- Entscheidungen (mit ✅)
- Offene Punkte (mit 🔲)
- Lessons Learned (für Standards WEC / Kunden-Profil)
- Nächste Schritte (in TASKS.md übernehmen wenn relevant)

[Diktat folgt]
```

---

## Prinzipien

- **Lazy Loading** — nicht blind alles aus raw/ lesen. Nur was zum Thema passt.
- **Reiners Schutz** — BWL-Filter mitdenken, auch wenn Reiner selbst nicht danach fragt.
- **White-Label-Regel** — bei Kundenartikeln immer prüfen ob Endkunde (z.B. Sachsenmilch) unsichtbar bleiben muss.
- **Reiner-Ton** — keine langen Analysen, sondern Stichpunkte die er lesen kann ohne Kaffee zu verschütten.

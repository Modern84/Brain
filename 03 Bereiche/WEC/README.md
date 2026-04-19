---
tags: [bereich, wec, einstieg]
date: 2026-04-17
status: aktiv
---

# WEC — Operationszentrale

> **Einstiegspunkt für jeden Claude-Tab der über WEC arbeitet.**
> Kurz lesen, dann weiß Claude wo was ist.

---

## Was ist WEC

**WOLDRICH ENGINEERING + CONSULTING** — Ingenieurbüro, Sitz Sebnitz (Umzug Pirna August 2026).
Inhaber: Reiner Woldrich. Konstrukteur: Sebastian Hartmann. Claude: dritter im Bund.

Geschäftsfelder: Lebensmittel/Pharma (Bens), Bau/Gips (Knauf), Anlagenbau, F&E Biogene Rohstoffe.

→ Vollständige Übersicht: [[02 Projekte/WEC Neustart mit Reiner/WEC Neustart mit Reiner]]

---

## Aufbau dieses Bereichs (Karpathy LLM-Wiki-Pattern)

```
03 Bereiche/WEC/
├── CLAUDE.md          ← WEC-spezifische Regeln (über Root-CLAUDE.md hinaus)
├── README.md          ← diese Datei
├── raw/               ← UNANTASTBAR — Rohdaten von NAS, Kundendateien, PDFs
├── wiki/              ← Claude-kompiliert — Kundenprofile, Standards, Normen
├── Operationen/       ← Wie Claude das System pflegt (Ingest, Query, Lint)
└── Sessions/          ← Pro Claude-Tab eine Einstiegs-Notiz
```

**Drei Layer, drei Regeln:**

1. **`raw/`** — nur lesen, nie ändern. Quelldaten bleiben unberührt.
2. **`wiki/`** — Claude pflegt, Mensch verifiziert. Lebende Wissensbasis.
3. **`schema`** — `CLAUDE.md` definiert die Regeln. Sonst nichts.

---

## Wo finde ich was

| Was | Wo |
|---|---|
| Personenprofile (Reiner, Volker, Bens, Knauf) | [[00 Kontext/WEC Kontakte]] |
| WEC-Neustart-Projekt (Umzug, Mails, Strategie) | [[02 Projekte/WEC Neustart mit Reiner/WEC Neustart mit Reiner]] |
| Lieferstandard Bens Edelstahl | [[04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl]] |
| Reiners Gehirn (Template für T9) | `07 Anhänge/Reiners_Gehirn/` |
| Kundenprofile (Claude-gepflegt) | `wiki/Kunden/` |
| Reiners 30-Jahre-Wissen extrahiert | `wiki/Standards WEC/` |
| Schutz vor Insolvenz/Ausnutzung | `wiki/BWL-Filter/` |

---

## Wer ist wer

- **Sebastian** — Konstrukteur, Fusion 360, INTP, LRS. Stark in Komplexem, Werkzeuge fürs Banale.
  → [[00 Kontext/Über mich]]
- **Reiner Woldrich** (~70) — Inhaber, SolidWorks 2020, NAS-Besitzer, INTP-ähnlich, anti-IT, BWL-Vakuum.
  → [[00 Kontext/WEC Kontakte/Profil Reiner]]
- **Volker Bens** — Hauptkunde, Bens Edelstahl GmbH, Pharma/Lebensmittel, Halle Pirna.
  → [[00 Kontext/WEC Kontakte/Volker Bens]]

---

## Aktive Sessions

→ `Sessions/` — pro Claude-Tab eine Einstiegs-Notiz mit Kontext was besprochen wurde.

---

## Verknüpfungen

- [[CLAUDE]] — Root-CLAUDE.md des gesamten Brains
- [[03 Bereiche/WEC/CLAUDE]] — WEC-spezifische Ergänzungen
- [[02 Projekte/WEC Neustart mit Reiner/WEC Neustart mit Reiner]]
- [[02 Projekte/WEC Neustart mit Reiner/Reiners Gehirn - Setup Plan]]

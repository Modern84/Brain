# LIEFERUNG — Lagerschalenhalter Lebensmittelindustrie

> **🔴 STATUS: 3D-IGES komplett, STEP-Einzelteile + PDFs ausstehend (Fusion-Export)**

**Projekt:** Lagerschalenhalter Lebensmittelindustrie
**Zeichnungsnummer-Stamm:** `BE-LS-202603-XXX-X`
**Ansprechpartner (Lieferant):** Hartmann
**Datum:** 2026-04-21

---

## Paket-Inhalt (Stand 2026-04-21)

### 3D-Daten (vollständig IGES, STEP nur Zusammenbau)

```
3D/
├── Lagerhalter_Zusammenbau.stp          STEP AP203 — Zusammenbau
├── Zusammenbau_Lagerschalehalter.iges   IGES — Zusammenbau
├── Schweißgruppe_Halter.iges            IGES — Schweißgruppe
└── Einzelteile/
    ├── Lagerhalter.iges
    ├── Lagerschale.iges
    ├── Welle_V1.iges
    ├── Welle_V2.iges
    ├── Scheibe_t=1.iges
    └── Scheibe_t=5.iges
```

### Stückliste

```
Stueckliste/
├── BOM_bereinigt.xlsx
└── BOM_bereinigt.csv
```

### Begleitdokument

- `LIESMICH.txt` — White-Label-Kurzbrief

---

## Technische Angaben

### Werkstoffe

- **Alle Fertigungsteile:** Edelstahl **1.4404** (X2CrNiMo17-12-2, V4A) — durchgängig
- **Normteile:** Edelstahl **A4-80**
  - Innensechskantschraube DIN EN ISO 4762 – M8 × 40
  - Hutmutter/Sicherungsmutter DIN 985 – M8
- **Lager:** SKF Pendelkugellager **SS2202-2RS** (2202 E-2RS1TN9), Edelstahl, zweireihig, abgedichtet, Ø15/35 × 14 mm (Mädler Art. 64773026)
- **Klemmring:** Edelstahl **1.4305** (Mädler Art. 62399115)

### Oberflächen

- **Oberflächengüte:** **Ra ≤ 0,8 µm** (Lebensmittel-Kontaktflächen, EHEDG-konform)
- **Kantenradius:** **R6 min.** an Hygiene-relevanten Übergängen
- **Nachbehandlung:** Beizen und passivieren der Fertigungsteile

### Hygiene-/Normen-Kontext

- **Einsatzbereich:** Lebensmittelindustrie (Sachsenmilch Käsekarussell — intern, nicht auf Zeichnung)
- **Normen-Stack:** EHEDG Doc. 8, DIN EN 1672-2, EC 1935/2004
- **Kein Pharma/GMP.**

### 3D-Format

- **IGES** ist das primäre Liefer-Format (Volker-Werkzeugkette)
- **STEP AP203** wird **zusätzlich** geliefert (Lesbarkeit in modernen Systemen)
- Aktuell als STEP vorhanden: **nur Zusammenbau**. Einzelteile + Schweißgruppe werden im Fusion-Re-Export nachgezogen.

---

## Zeichnungsnummern — Änderungen in dieser Lieferung

| Alt | Neu | Bauteil | Grund |
|---|---|---|---|
| `BE-LS-202603-203` | `BE-LS-202603-207-0` | Welle_V2 | Kollision mit Scheibe_t=1 `-203-0` aufgelöst |
| `BE-LS-202603-206-0` | `BE-LS-202603-204-0` | Welle_V1 | `~recovered`-Dublette konsolidiert auf Haupt-Nummer |
| — | — | Steg_Lagerschalenhalter | Suffix `(~recovered)` aus Bauteilnamen entfernt |
| `BE-LS-202603-1-0` | `BE-LS-202603-001-0` | Schweißgruppe_Halter | dreistelliges Schema vereinheitlicht |
| Pos 12 / 12.1 / 12.2 | gestrichen | Schweißgruppe-Dublette | Onshape-Export-Artefakt, Mengenlogik über Pos 11 × 2 bereits vollständig |

**Wichtig für PDF-Re-Export:** Die neue Nummer `-207-0` muss auf dem Welle_V2-Zeichnungsblatt erscheinen.

---

## 🔴 Ausstehend — vor Versand an Volker zwingend nachzuliefern

- [ ] **STEP AP203 für Einzelteile + Schweißgruppe** — aktuell liegt nur der Zusammenbau als STEP vor. Fehlen:
  - `Schweißgruppe_Halter.stp`
  - `Einzelteile/Lagerhalter.stp`
  - `Einzelteile/Lagerschale.stp`
  - `Einzelteile/Welle_V1.stp`
  - `Einzelteile/Welle_V2.stp`
  - `Einzelteile/Scheibe_t=1.stp`
  - `Einzelteile/Scheibe_t=5.stp`
- [ ] **PDF-Zeichnungen (12 Blatt)** aus Fusion re-exportieren — Zusammenbau, Schweißgruppe, 10 Einzelteile. Auf dem Welle_V2-Blatt muss die aktualisierte Nummer `BE-LS-202603-207-0` stehen. Schriftfeld Hartmann/Woldrich bleibt (Fusion-Default, Entscheidung 2026-04-21).

---

## White-Label-Verifikation

Rekursiver Grep durch `_An_Volker/` (case-insensitive) gegen: `Hartmann`, `Woldrich`, `WEC`, `w-ec`, `Sachsenmilch`, `SM_`, `hartwire`, `mthreed`, `Modern3b` → **0 Treffer** in IGES/STEP/TXT/CSV/XLSX (Stand 2026-04-21).

Hartmann/Woldrich verbleiben im PDF-Schriftfeld (Fusion-Default, bewusste Entscheidung).

---

## Verknüpfungen

- Kundenprofil: `04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl.md`
- Änderungsprotokoll der Session: `../Aenderungsprotokoll.md`
- Briefing: `03 Bereiche/WEC/wiki/Kunden/Volker Bens - Lagerschalenhalter Lebensmittelindustrie.md`

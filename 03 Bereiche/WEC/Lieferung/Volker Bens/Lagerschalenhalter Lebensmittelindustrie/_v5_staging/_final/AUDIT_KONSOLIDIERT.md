# v5-Patcher Konsolidiertes Audit — Bens Lagerschalenhalter Lieferung

**Stand:** 2026-04-21 nachmittags
**Kunde:** Volker Bens (Bens Edelstahl GmbH)
**Schema:** `BE-LS-202603-XYZ-R` (siehe [[_Register/Volker-Bens-Nummernregister]])

Dieser Ordner (`_final/`) enthält die 8 sauber gepatchten PDFs aus zwei v5-Runs, bereit für die visuelle Stichprobe und anschließend v4-Info-Block-Stufe.

## Herkunft der Dateien

| PDF | Run | Mapping-Erfolg |
|---|---|---|
| `BE-LS-202603-011-0_Scheibe_t1.pdf` | `v5_run_2026-04-21_133322` | drawing_number + 1.44.04 |
| `BE-LS-202603-012-0_Lagerhalter.pdf` | `v5_run_2026-04-21_134154` | drawing_number + 1.44.04 (nach words-Resolver-Fix) |
| `BE-LS-202603-013-0_Lagerschale.pdf` | `v5_run_2026-04-21_133322` | drawing_number + 1.44.04 |
| `BE-LS-202603-111-0_Welle_V1.pdf` | `v5_run_2026-04-21_133322` | drawing_number + 1.44.04 + ~recovered-Entfernung |
| `BE-LS-202603-112-0_Scheibe_Welle_V1.pdf` | `v5_run_2026-04-21_133322` | drawing_number (von `-205-0` aus), 1.44.04 |
| `BE-LS-202603-151-0_Schweissgruppe_Halter_V1.pdf` | `v5_run_2026-04-21_133322` | drawing_number + 1.44.04 |
| `BE-LS-202603-211-0_Welle_V2.pdf` | `v5_run_2026-04-21_133322` | drawing_number (von `-206-0` aus), 1.44.04 + ~recovered-Entfernung |
| `BE-LS-202603-291-0_Zusammenbau_V2.pdf` | `v5_run_2026-04-21_133322` | drawing_number + SM_Lagerschale + 1.44.04 |

## Rauschen im Audit (nicht blockend, Notiz für später)

- **AM_Lagerschale → `not_found` im kurzen Zusammenbau:** der Token steht laut PDF-Inspektion in der Datei, pymupdfs `search_for` findet ihn aber nicht. Vermutlich als Text-Fragment oder in zusammengesetzter Form gespeichert. Nicht-blockend, `required: false`. Beobachtungsliste für die nächste Runde.
- **SM_/AM_/~recovered → `not_found` in 6 Einzelteil-PDFs:** erwartet — diese Tokens existieren nur in den Zusammenbau-Exporten und in Welle_V1 (für `~recovered`). Reines Audit-Rauschen.

## Lieferungs-Status

**Bestandteil der Lieferung (8 PDFs):** alle oben gelisteten.

**Nicht Bestandteil — Fusion-TODO:**

- `Zusammenbau_Lagerschalehalter Zeichnung lang.pdf` — Konstruktionsfehler (V1+V2 auf einem Blatt). Muss als reiner V1-only-Zusammenbau neu exportiert werden (Ziel `-191-0`).
- Schweißgruppe_Halter V2 — fehlt komplett (Ziel `-251-0`, neu zu konstruieren).
- Steg_Lagerschalenhalter — klären ob eigene Zeichnung nötig (Ziel `-014-0`).

## Offene Schritte

1. **Visuelle Stichprobe** (Schritt 4): 2–3 PDFs öffnen, Schriftfeld-Position und Schriftgröße der gepatchten Nummern prüfen.
2. **v4-Patcher (Info-Block) drüber:** Oberfläche / Toleranz / Werkstoff-Allgemein auf alle 8 PDFs.
3. **Paket-Build:** explizite Dateiliste, ZIP oder Ordner-Struktur für Volker.
4. **Mo-Freigabe** vor Rausgang.

## Verknüpfungen

- [[../../2026-04-21 Montag-Session/Aenderungsprotokoll]] — volle Historie des Tages
- [[../../Volker Bens/_Register/Volker-Bens-Nummernregister]] — aktive und verbrannte Nummern
- [[../../mapping_lagerschalenhalter]] — v5-Regeln
- Original-Audit Run 1: `v5_run_2026-04-21_133322/02_audit/audit_2026-04-21_133322.md`
- Original-Audit Run 3: `v5_run_2026-04-21_134154/02_audit/audit_2026-04-21_134154.md`

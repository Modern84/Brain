---
tags: [ressource, cad, zeichnungs-generator, schema]
date: 2026-05-01
status: design-entwurf
verknuepft:
  - "[[02 Projekte/WEC/Zeichnungs-Generator/Konzept]]"
  - "[[04 Ressourcen/CAD-Workflows/Fusion 360 Drawing Template L7]]"
---

# YAML-Sidecar-Schema — Zeichnungs-Generator

Pflege-Schema für `<Bauteil>.yaml` neben `<Bauteil>.step`. Generator merged: **Kunde-Default ← Sidecar ← Mapping-CSV** (rechts überschreibt links für White-Label-Felder).

---

## 1. Zweck und Abgrenzung

Drei Quellen für Schriftfeld-Daten, klare Aufteilung:

| Quelle | Inhalt | Pflege-Ort |
|---|---|---|
| **Sidecar (`.yaml`)** | Konstrukteurs-Wissen pro Bauteil: Material, Toleranz, kritische Maße, Bemerkung | Sebastian, manuell |
| **Mapping-CSV (v5-Patcher)** | White-Label-Übersetzungen: intern→Bens-Nummer, Bezeichnung-WL | bestehender v5-Patcher-Workflow |
| **Fusion-iProperties** | Aus 3D ableitbar: Gewicht, Volumen, Boundingbox | automatisch durch Fusion |

**Regel:** Wenn aus Fusion ableitbar (Gewicht, Volumen) → iProperties. Wenn White-Label (Nummer, Bezeichnung-extern) → Mapping. Alles andere → Sidecar.

---

## 2. Pflichtfelder

```yaml
zeichnungsnr: BE-LS-202605-001-1   # vollqualifiziert (interne Form ODER bereits Bens-Form)
benennung: Lagerschalenhalter klein
werkstoff: 1.4404
bearbeiter: Sebastian Hartmann      # Default
geprueft: ""                         # leer bis Reiner prüft
rev: "00"                            # String, führende Null erlaubt
kunde: bens                          # bens | knauf | wec-direkt
```

---

## 3. Optionale Felder

```yaml
toleranzklasse: ISO 2768-mK
oberflaeche: Ra 1.6
ehedg: true                          # nur sinnvoll bei Lebensmittel-Bauteilen
gewicht_kg: 0.234                    # nur falls iProperty-Auslesen scheitert (Override)
bemerkung: "Schweißnähte schleifen, Lebensmittelkontakt"
lieferdatum: 2026-06-15
massstab_overrides:
  front: "1:2"
  iso: "1:5"
kritische_masse:
  - mass: "32"
    toleranz: "±0.05"
    bezug: "Lagersitz Innen"
  - mass: "120"
    toleranz: "+0.1/-0"
    bezug: "Gesamtlänge"
```

---

## 4. Default-Profile pro Kunde

Liegen in `04 Ressourcen/CAD-Workflows/sidecar-defaults/`:

- **`bens.yaml`** — `werkstoff: 1.4404`, `oberflaeche: Ra 1.6`, `ehedg: true`, `toleranzklasse: ISO 2768-mK`. White-Label-Mapping kommt aus v5-Patcher-CSV, nicht hier.
- **`knauf.yaml`** — Stahlbau-Defaults (S235JR, Ra 6.3, kein EHEDG, ISO 2768-m). Kein White-Label.
- **`wec-direkt.yaml`** — Standard WEC-Konfiguration, Bearbeiter Sebastian Hartmann, geprüft Reiner Woldrich.

Generator-Merge-Reihenfolge: `kunde-default.yaml` ← `<bauteil>.yaml` ← Mapping-CSV.

---

## 5. Integration mit v5-Patcher-Mapping

**Aufteilung der Hoheit:**

| Feld | Quelle | Begründung |
|---|---|---|
| `zeichnungsnr` | Sidecar | Sebastian schreibt direkt die Form rein, die im Schriftfeld erscheinen soll (intern für WEC-direkt, Bens-Form für Bens-Lieferung). Keine Auto-Übersetzung in Phase 1. |
| `benennung` | Sidecar | gleiche Logik — Sebastians Verantwortung, was im Schriftfeld steht |
| `werkstoff`, `toleranzklasse`, `oberflaeche`, `bemerkung`, `kritische_masse` | Sidecar | Konstrukteurs-Wissen |
| `gewicht_kg`, `volumen_cm3` | Fusion-iProperties | aus 3D-Geometrie, **separater Pfad** (nicht Teil der Schriftfeld-Merge-Kette) |
| `bearbeiter`, `geprueft`, `rev`, `lieferdatum` | Sidecar (Defaults aus Kunde-Profil) | Workflow-Metadaten |

**Kollisions-Regel — Schriftfeld-Merge-Kette (Phase 1):**
1. **Kunde-Default-Profil** bildet Basis (z.B. `bens.yaml` setzt `werkstoff: 1.4404`, `ehedg: true`)
2. **Sidecar** überschreibt Default (alles, was im `<bauteil>.yaml` steht, gewinnt)
3. **Fusion-iProperties** sind ein **separater Pfad** für aus-3D-ableitbare Felder (Gewicht, Volumen) — nicht Teil der Schriftfeld-Kette, sondern direkter Auto-Fill für jene zwei Felder.

Mapping-CSV-Schicht ist in Phase 1 **nicht aktiv** — siehe §8 (Phase-2-Veredelung).

---

## 6. Beispiel — `R_Blech_Klein.yaml`

```yaml
# R_Blech_Klein.yaml — neben R_Blech_Klein.step im selben Ordner
zeichnungsnr: WEC-2026-05-001
benennung: Blechwinkel klein (Pilot)
werkstoff: 1.4404
bearbeiter: Sebastian Hartmann
geprueft: ""
rev: "00"
kunde: wec-direkt

toleranzklasse: ISO 2768-mK
oberflaeche: Ra 3.2
ehedg: false

bemerkung: "Pilot-Bauteil — Generator-Validierung"
massstab_overrides:
  front: "1:1"

kritische_masse:
  - mass: "50"
    toleranz: "±0.2"
    bezug: "Schenkellänge A"
  - mass: "30"
    toleranz: "±0.2"
    bezug: "Schenkellänge B"
```

---

## 7. Dateinamen-Konvention

- Sidecar liegt **im selben Verzeichnis** wie STEP, mit identischem Stamm:
  ```
  Lagerschalenhalter/
    ├── R_Blech_Klein.step
    └── R_Blech_Klein.yaml
  ```
- Generator findet Sidecar per Namensgleichheit (`os.path.splitext + .yaml`).
- Falls Sidecar fehlt: Generator-Lauf bricht mit Fehlermeldung „Sidecar fehlt für `<bauteil>`" — kein Auto-Default-Lauf, weil Pflichtfelder ungeklärt.
- Falls Sidecar unvollständig (Pflichtfeld fehlt): Generator bricht mit Liste fehlender Pflichtfelder.

---

## 8. Phase-2-Veredelung — Mapping-CSV-Integration

In Phase 1 trägt Sebastian die Bens-Form der Zeichnungsnummer **manuell** ins Sidecar ein. Das ist pragmatisch, aber Doppelpflege (gleiche Übersetzung lebt im v5-Patcher-Mapping und im Sidecar).

**Phase-2-Idee (nicht jetzt bauen):**
- Generator liest `kunde: bens` und schlägt im v5-Patcher-Mapping-CSV nach.
- Übersetzung intern → Bens-Form passiert automatisch im Generator.
- Sidecar enthält dann nur noch die **interne** Nummer; White-Label-Form fließt zur Laufzeit ein.

**Voraussetzungen für Phase 2:**
- v5-Patcher-Mapping-CSV-Schema dokumentiert (Spalten, Pflichtfelder, Encoding).
- Generator-Phase 1 läuft stabil (mehrere reale Bens-Lieferungen ohne Bug).
- Sebastian entscheidet, ob die Doppelpflege schmerzhaft genug ist, um Mapping-Layer zu rechtfertigen.

**Trigger:** erst nach Generator-Phase-1-Stabilität neu evaluieren. Bis dahin: Sidecar ist Single-Source-of-Truth fürs Schriftfeld.

---

## Out-of-Scope (in dieser Phase)

- Default-Profile mit echten Bens-Mapping-Werten füllen (kommt wenn v5-Patcher-CSV-Schema bekannt)
- Schema in Code (kein YAML-Parser-Bau, kein Schema-Validator)
- Validierungs-Regeln (Wertebereiche, Pflicht-Logik) — kommt mit Generator-Bau
- Multi-Sheet-Drawings (mehrere Sheets pro Sidecar) — Phase 2

---

## Status

Design-Entwurf, **wartet auf Sebastians Validierung** (insbesondere Kollisions-Regel in §5).

---
typ: umsetzungs-plan
projekt: Lagerschalenhalter Lebensmittelindustrie
kunde: Volker Bens
partner: Reiner / WEC
stand: 2026-04-21
status: offen - umzusetzen in Fusion 360 (Mo)
quelle: Reiner-Scans 2026-04-19 + Mail Reiner 2026-04-21
---

← zurueck zum [[_INDEX|Projekt-Landing-Pad]]

# Umsetzungs-Tabelle v5 — Reiners Zeichnungsnummer-Schema

**Reiner hat in den Scans vom 2026-04-19 ein vollstaendiges, hierarchisches 
Nummernsystem vorgegeben. Dieses ziehen wir 1:1 durch.**

## Reiners Schema (3-stellig, hierarchisch)

Basis: `BE-LS-202603-XYZ-0`

| Stelle | Wert | Bedeutung |
|--------|------|-----------|
| X (erste) | 0 | Gemeinsam (in beiden Varianten) |
| X (erste) | 1 | Variante V1 (mit Welle_V1) |
| X (erste) | 2 | Variante V2 (mit Welle_V2) |
| Y (zweite) | 0 | Zusammenbau-Ebene |
| Y (zweite) | 1 | Schweissgruppe-Ebene |
| Y (zweite) | 2 | Einzelteil-Ebene |
| Z (dritte) | 0-9 | Laufende Nummer innerhalb der Ebene |

## Umsetzungs-Reihenfolge in Fusion 360

**Wichtig: von unten nach oben arbeiten** (Einzelteile zuerst, dann 
Schweissgruppen, dann Zusammenbauten). Sonst verlieren hoehere Baugruppen 
die Referenz auf umbenannte Teile.

### Reihenfolge-Ebene 1: Gemeinsame Teile (in beiden Varianten)

- [ ] Scheibe_t=1: `BE-LS-202603-203-0` → `BE-LS-202603-**001**-0`

### Reihenfolge-Ebene 2: Einzelteile V1

- [ ] Lagerhalter (in SG V1): `BE-LS-202603-200-0` → `BE-LS-202603-**111**-0`
- [ ] Lagerschale (in SG V1): `BE-LS-202603-201-0` → `BE-LS-202603-**112**-0`
- [ ] Welle_V1 (Einzelteil): `BE-LS-202603-206-0` → `BE-LS-202603-**121**-0`
- [ ] Scheibe_t=5 (zu Welle_V1): `BE-LS-202603-205-0` → `BE-LS-202603-**122**-0`

### Reihenfolge-Ebene 3: Einzelteile V2

- [ ] Welle_V2 (Einzelteil): `BE-LS-202603-207-0` → `BE-LS-202603-**221**-0`
- [ ] **TODO: In Fusion 360 pruefen, ob eine Scheibe_t=3 fuer V2 existiert.**
      Falls ja, umbenennen auf: `BE-LS-202603-**222**-0`. 
      Falls nein, keine Aktion.

### Reihenfolge-Ebene 4: Schweissgruppen

- [ ] Schweissgruppe V1 (Lagerhalter + Lagerschale): 
      `BE-LS-202603-1-0` → `BE-LS-202603-**110**-0`
      + Fertigungshinweis aufnehmen: *"nach Schweissen planschleifen"*
- [ ] **NEU erstellen:** Schweisszeichnung V2 
      — Zeichnungsnummer: `BE-LS-202603-**220**-0`
      — Inhalt: analog zu V1 (Lagerhalter + Lagerschale als Schweissgruppe)
      — Reiners Anmerkung auf Scan: *"es fehlt zusammenbau/Schweisszeichnung Welle_V2"*

### Reihenfolge-Ebene 5: Zusammenbauten

- [ ] Zusammenbau V1: Zeichnungsnummer setzen auf `BE-LS-202603-**100**-0`
      **+ Stueckliste anpassen: Position 8 (Welle_V2) streichen.**
      In V1-Variante darf Welle_V2 nicht in der Teileliste stehen — Reiners 
      expliziter Hinweis aus Mail 2026-04-21.
- [ ] Zusammenbau V2: Zeichnungsnummer setzen auf `BE-LS-202603-**200**-0`
      (aktuell steht im PDF noch `BE-LS-202603-000-0`)

## Kaufteile bleiben unveraendert

- Lager `BE-LS-202603-700-0` (SKF Pendelkugellager) — **nicht aendern**
- Klemmring `BE-LS-202603-704-0` — **nicht aendern**

## Weitere offene Punkte aus v4-Arbeit (gelten weiterhin)

- White-Label: `SM_Lagerschale` im Zusammenbau-Projektgruppen-Feld ersetzen durch `Lagerschalenhalter` (Projektgruppe V1 und V2)
- Werkstoff-Tippfehler: `1.44.04` in allen Teilelisten ersetzen durch `1.4404`
- BOM-Fixes (bereits in BOM v4 dokumentiert, Umsetzung in Fusion-Stuecklisten noch offen):
  - Pos 10 Hutmutter: Stahl 6 → A4-80 (Lebensmittelkonformitaet)
  - Pos 6 Klemmring: 1.4305 → 1.4404 (Lebensmittelkonformitaet)

## Gesamt-Workflow nach Umsetzung

1. Mo aendert in Fusion 360 gemaess dieser Tabelle (Reihenfolge einhalten)
2. Mo exportiert neue PDFs nach `07 Anhaenge/Fusion360_v5/`
3. v4-Patcher laeuft erneut drueber (Info-Block auf jedem PDF)
4. BOM v4 aktualisieren: neue Zeichnungsnummern einsetzen, in `_An_Volker/Stueckliste/` kopieren
5. STEP AP203 Exporte mitmachen (7 fehlen laut vorheriger Pruefung)
6. Finale Zusammenstellung in `_An_Volker/PDF/`
7. Paket an Volker Bens

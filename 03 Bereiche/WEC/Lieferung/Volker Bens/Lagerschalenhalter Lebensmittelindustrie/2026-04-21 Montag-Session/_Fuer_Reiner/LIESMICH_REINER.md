---
tags: [lieferung, reiner, intern, bens, pilot]
date: 2026-04-21
vertraulichkeit: intern-wec-reiner
nicht-weitergeben: volker-bens
---

# 🔴 INTERN — Pilot-Paket Reiner, Volker Bens Lagerschalenhalter

> **Vertraulichkeit:** Nur Reiner ↔ Sebastian. Die PDFs enthalten im Schriftfeld noch den Konstrukteur-Eintrag „Sebastian Hartmann" bzw. „Woldrich" — das muss durch Fusion-Template-Reexport gegen Bens-Daten getauscht werden, bevor irgendetwas an Volker geht. **Volker darf weder Inhalt noch Existenz dieses Ordners kennen.**

---

## Pilot ohne Tablet — Arbeitsweise heute

Keine Tablet-Einrichtung. Reiner arbeitet auf **Papier-Ausdrucken** der PDFs, wie gewohnt. Digital-Abgleich am Mac/Screen bei Sebastian während der Session. Ergebnis-Entscheidungen fließen zurück in:

- `../Aenderungsprotokoll.md` (Teile 3+4 + neuer Teil 5 „Reiner-Session")
- `../_An_Volker/` (Volker-Liefer-Spiegel — **erst nach PDF-Template-Fix**)

---

## Inhalt dieses Ordners

### `Zeichnungen_PDF/` — 12 PDFs zum Ausdrucken

**Hauptbaugruppen (Schweißgruppe, Zusammenbau):**
- `Zusammenbau_Lagerschalehalter Zeichnung.pdf`
- `Zusammenbau_Lagerschalehalter Zeichnung lang.pdf` — Langversion
- `Schweißgruppe_Halter Zeichnung (~recovered).pdf`

**Platten (derzeit im Session-Ordner-Root, ursprüngliche Liefer-Kandidaten):**
- `Grundplatte Zeichnung.pdf`
- `Zwischenplatte Zeichnung.pdf`

**Einzelteile (`Einzelteile/`):**
- `Lagerhalter Zeichnung (~recovered).pdf`
- `Lagerschale Zeichnung.pdf`
- `Scheibe_t=1 Zeichnung.pdf`
- `Scheibe_t=3 Zeichnung.pdf`
- `Welle_V1 Zeichnung.pdf` + `Welle_V1 Zeichnung (~recovered).pdf`
- `Welle_V2 Zeichnung.pdf`

Druck-Empfehlung: A3 (kleinere Blätter skalieren automatisch), zweiseitig aus, Graustufen sind okay.

### `Reiner-Scans_Referenz/` — 8 JPGs seiner Korrektur-Scans vom 2026-04-19

Referenz während der Session: was Reiner an den Ursprungsdateien angemerkt hat (liegt parallel aus raw/).

---

## Entscheidungen, die heute fallen müssen

- [ ] **B16 Welle_V2 Nummernkonflikt** — `BE-LS-202603-203` vs. B12 Scheibe_t=1 `-203-0`. Vorschlag: `BE-LS-202603-207-0` für Welle_V2. Check im Aenderungsprotokoll Teil 3.
- [ ] **L7-Feld (Konstrukteur)** — leer / `VB` / Bens-interne Konvention?
- [ ] **M7-Feld (Ingenieur/Prüfer)** — leer / `VB` / Bens-interne Konvention?
- [ ] **Pharma vs. Lebensmittel** — „Quality for Pharmacy" als Slogan oder echte GMP-Anforderung? Wenn GMP: Normen-Stack (EHEDG, FDA 21 CFR, EU 1935/2004) nachziehen.
- [ ] **Format-Wahl für Volker** — STP (AP203) primär, IGES als Fallback. Oder umgekehrt?
- [ ] **Fusion-Template-Fix** — Bens-Schriftfeld aus `07 Anhänge/Bens_Vordruck.dwg` in Inventor-/Fusion-Template einbauen, alle 12 PDFs neu exportieren. **Blocker für Volker-Lieferung.**

---

## Nach der Session — was ins Brain zurück muss

1. `Aenderungsprotokoll.md` Teil 5 schreiben: Entscheidungen, Begründungen, neuer Stand
2. BOM_bereinigt.xlsx ggf. mit `207-0` aktualisieren (Variante für Reiner-Check)
3. Wenn PDF-Fix durch: bereinigte PDFs in `_An_Volker/Zeichnungen_PDF/` kopieren
4. Playbook „WEC Kundenordner - Muster und Ableitungen" mit dem Bens-Learnings ausbauen

---

## Verknüpfungen

- [[03 Bereiche/WEC/wiki/Kunden/Volker Bens - Lagerschalenhalter Lebensmittelindustrie|Haupt-Briefing]]
- [[03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/2026-04-21 Montag-Session/Aenderungsprotokoll|Aenderungsprotokoll]]
- [[04 Ressourcen/CAD-Datenuebergabe Standard - Bens Edelstahl|Bens-Lieferstandard]]
- [[05 Daily Notes/2026-04-21|Daily Note heute]]

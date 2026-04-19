---
tags: [bens, lagerschalenhalter, korrektur, reiner, ocr, erkenntnis, montag-vorbereitung]
date: 2026-04-19
status: erkenntnis
category: antwort
quelle: OCR aus 8 WhatsApp-Scans von Reiner, empfangen 2026-04-17 15:14
---

# Erkenntnisse aus Reiners Korrektur-Scans

> **Kurzfassung:** 8 Scans liefern mehr als nur die Nummernbestätigung. Das Fusion-Template ist bereits Bens-gebrandet, Pharma ist Positionierung, Kaufteile-Schema (700er) ist systematisch.

## Identifikation der 8 Scans

| Hash | Größe | Bauteil | Zeichnungsnummer | Inhalt |
|---|---|---|---|---|
| `73cec1cd` | 177KB | Schweißgruppe (Lagerhalter+Lagerschale) | `BE-LS-202603-1` | Baugruppen-Zeichnung, "nach Schweißen Planschleifen" |
| `c6c078f1` | 180KB | Gesamt-Teileliste/BOM | alle Positionen | Vollständige BOM |
| `487aabea` | 175KB | Kaufteile-Liste | `-700`, `-704` | Pendelkugellager SKF 2202, Klemmring Mädler 62399115 |
| `627ef79c` | 147KB | Welle + Scheibe | `-206`, `-204` | Kombinations-Zeichnung |
| `97e7f638` | 148KB | Welle_V1 Einzelteil | `-206-0` | Detail-Zeichnung |
| `3ff85e64` | 170KB | Welle_V1 (recovered) | `-206-0` | Recovered-Version |
| `54335b71` | 127KB | Scheibe t=1 | `-203` | Einzelteil |
| `c67c6a66` | 156KB | Scheibe t=5 | `-205-0` | Sebastian 2026-03-25 |

---

## Erkenntnis 1 (A — hoch): Zeichnungsnummern-Konflikt gelöst

**Alle 8 Scans bestätigen übereinstimmend:** `BE-LS-202603-XXX`

- ✅ **BE-LS-202603 ist die offizielle Nummernserie** (Reiner-geprüft)
- ❌ **BE-IS-202631** in der CSV-Stückliste war **Fehler**
- ✅ Zusammenbau-PDF (`BE-LS-202603-000-0`) hatte es schon richtig

### Erforderliche Korrekturen:

1. **CSV-Stückliste** `Lagerschalenhalter_Stueckliste_Lebensmittel.csv`:
   - Alle `BE-IS-202631-XXX` → `BE-LS-202603-XXX`
2. **Bereinigte BOM** `Lieferung/.../BOM_bereinigt.xlsx`:
   - Prüfen ob Nummern dort schon falsch übernommen wurden
   - Falls ja: korrigieren
3. **Lagerschalenhalter-Wiki**: Nummernkonflikt als gelöst markieren
4. **CAD-Datenübergabe-Standard**: Beide-Nummern-parallel-Dokumentation konsolidieren auf `BE-LS-202603`

---

## Erkenntnis 2 (A — hoch): Fusion-Template ist bereits Bens-gebrandet

**Alle Scans zeigen im Schriftfeld:**
```
BENS - EDELSTAHL
Quality for Pharmacy
```

**Das verändert unser Bild komplett:**
- Wir dachten heute Nachmittag: "Fusion-Template muss White-Label angepasst werden"
- **Tatsächlich:** Das Bens-Template existiert bereits und ist in Benutzung
- Die Working-Copies in `raw/.../Fusion360/` sind **ältere Vor-Branding-Version** (noch mit Hartmann/Woldrich/SM_Lagerschale)
- Reiner hat **die finale Version** die Volker bekommt

**Frage für Montag an Reiner:** Wo liegt die aktuelle Fusion-360-Datei mit Bens-Schriftfeld? Kann Sebastian sie kriegen, damit er in Zukunft selbst im Bens-Design exportieren kann?

---

## Erkenntnis 3 (A — hoch): Bens ist Pharma-Zulieferer

**Schriftfeld-Slogan:** *"Quality for Pharmacy"*

**Implikationen:**
- Bens positioniert sich nicht nur auf Lebensmittel, sondern auch auf **Pharma-Markt**
- Regulatorische Anforderungen: **EHEDG + GMP** (nicht nur EHEDG)
- Lagerschalenhalter könnte für Pharma-Maschinen genutzt werden (nicht nur Sachsenmilch)
- Materialien/Oberflächen müssen GMP-konform dokumentiert sein

**Konsequenz für Volker-Bens-Profil:**
- Kundenprofil um "Pharma-Zulieferer" ergänzen
- Normen-Stack erweitern: EHEDG, DIN EN 1672-2, EC 1935/2004 **+ ggf. GMP, FDA 21 CFR, EudraLex**

---

## Erkenntnis 4 (A — hoch): Bens-Positions-Nummern-System entdeckt

Aus den 8 Scans erkennbare Logik:

```
BE-LS-202603-XXX-V
              │   │
              │   └── Variante (0, 1, ...)
              └────── Positions-Nummer (3-stellig)
```

**Nummern-Gruppen:**
- `100`-`199`: Blechteile-Baugruppe?
- `200`-`299`: Einzelteile (Rundstahl, Scheiben)
  - `-200` Lagerhalter (Blech 10mm, 0.07kg)
  - `-201` Lagerschale (Rundstahl, 0.05kg)
  - `-203` Scheibe t=1 (Blech 1, 0.00kg)
  - `-204` letzte Position (Welle?)
  - `-205` Scheibe t=5 (Blech 5/3.5?, 0.02kg)
  - `-206` Welle_V1 (Rundstahl, 0.40kg)
- `700`-`799`: **Kaufteile** (systematisches Präfix!)
  - `-700` Lager SKF Pendelkugellager 2202 (Art. 64773026)
  - `-704` Klemmring Mädler 62399115

**Das ist die fehlende Systematik** die ich heute im CAD-Standard als "unbekannt" markiert hatte. Muss in den Standard eingepflegt werden.

---

## Erkenntnis 5 (B — mittel): Fertigungshinweise direkt auf Zeichnung

Scan `73cec1cd` (Schweißgruppe):
> "nach Schweißen Planschleifen"

Das ist eine **konkrete Fertigungs-Anweisung** auf der Zeichnung — relevant für Oberflächenqualität Ra ≤ 0,8 µm (EHEDG-konform).

**Muster für CAD-Standard:** Fertigungshinweise gehören auf die Zeichnung, nicht nur in separate Dokumente.

---

## Erkenntnis 6 (B — mittel): Material-Bezeichnung standardisieren

OCR zeigt durchmischte Schreibweisen auf Scans:
- `1.4404` (korrekt)
- `1.44.04` (mit Punkten, OCR-Lesefehler?)
- `44.04` (OCR-Lesefehler)
- `A422` (unklar — evtl. Bemaßungs-Text falsch erkannt)

In CSV-Stückliste einheitlich `1.4404 (316L)`.

**Für Bereinigung:** Auf einheitliche Schreibweise `1.4404 (316L)` konsolidieren in allen Artefakten.

---

## Erkenntnis 7 (C — niedrig): Recovered-Zeichnungen bestätigt

`Welle_V1 (recovered)` taucht auch in Reiners finalen Scans auf (Scan `3ff85e64`). 

**Das heißt:** Die `~recovered`-PDFs in `07 Anhänge/Fusion360/.../PDF/` sind **gültige Versionen**, kein Abfall. Fusion-Crash hat alle Beteiligten getroffen, recovered-Varianten sind der aktuelle Stand.

---

## Handlungsliste (priorisiert, für Montag oder früher)

### Muss vor Montag-Termin (A):
1. CSV-Stückliste korrigieren: alle BE-IS-202631 → BE-LS-202603
2. BOM_bereinigt.xlsx prüfen + ggf. korrigieren

### Besprechen am Montag (A):
3. Wo liegt aktuelle Fusion-360-Quelldatei mit Bens-Schriftfeld?
4. Pharma-Positionierung bestätigen — wirkt sich auf Kundenprofil aus
5. Nummernsystem 100/200/700 finalisieren + im CAD-Standard dokumentieren
6. Welche Positionen haben welche Nummern? (Tabelle aus Scans vs. CSV abgleichen)

### Nach Montag (B):
7. CAD-Datenübergabe-Standard erweitern: Nummernsystem, Fertigungshinweise, Pharma-Normen
8. Volker-Bens-Profil: Pharma-Zulieferer-Positionierung
9. Fusion-Template aus raw/ abgleichen mit Reiners finaler Version

---

## Verknüpfungen

- [[README]] — Ordner-Übersicht
- [[../../../../../../../CAD-Datenuebergabe Standard - Bens Edelstahl]]
- [[../../../wiki/Kunden/Volker Bens - Profil]]
- [[../../../wiki/Kunden/Volker Bens - Lagerschalenhalter Lebensmittelindustrie]]
- [[../../../Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/2026-04-21 Montag-Session/Aenderungsprotokoll]]

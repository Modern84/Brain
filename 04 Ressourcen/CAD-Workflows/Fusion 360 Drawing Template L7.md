---
tags:
  - ressource
  - cad
  - fusion-360
  - template
  - wec
date: 2026-05-01
status: aktiv
priorität: A
owner: Sebastian
raum: WEC
---

# Fusion 360 Drawing Template — WEC L7-Schriftfeld

> **Zweck:** WEC.dwg (vorhandener WEC-Standard-Vordruck) als Title Block in Fusion 360 Drawing einsetzen, Custom-iProperties für dynamische Felder anschließen, als wiederverwendbares Drawing Template speichern.
>
> **Strategische Einordnung:** Diese Anleitung baut das **WEC-eigene Template** für Fusion-direkte Aufträge (MThreeD/WEC-direkt). Bens-Lieferungen laufen weiterhin parallel in Solid Edge. Eine Bens-Klon-Variante (mit `Bens_Vordruck.dwg`) folgt analog, sobald sie gebraucht wird.
>
> **Hinweis Ausführung:** CC kann Fusion 360 nicht bedienen — diese Anleitung ist ein Schritt-für-Schritt-Skript für Mo am Mac.

---

## Quell-Dateien

- **Primär:** `03 Bereiche/WEC/raw/Standards WEC/Templates/WEC.dwg` (120 KB, Stand 2025-10-20)
- Sicherheits-Backup vor Modifikation: `WEC.bak` (285 KB) liegt bereits daneben.
- Solid-Edge-Originale (`Zeichnungsblöcke_neu Ausführung.dft`, `Zeichnungsvordrucke.dft`) bleiben unangetastet — Referenz, nicht Quelle für Fusion.

---

## Phase A — DWG für Fusion vorbereiten

> **Wichtig:** WEC.dwg in `raw/` **nicht modifizieren** (Drei-Layer-Disziplin, [[03 Bereiche/WEC/CLAUDE]]). Erst kopieren, dann am Kopierling arbeiten.

```
mkdir -p ~/Konstruktion/Templates/WEC-Fusion-L7/
cp "/Users/sh/Brain/03 Bereiche/WEC/raw/Standards WEC/Templates/WEC.dwg" \
   ~/Konstruktion/Templates/WEC-Fusion-L7/WEC_TitleBlock_v1.dwg
```

### A.1 — DWG-Editor wählen
Mo hat (Stand 2026-05-01) kein AutoCAD. Optionen:
- **DraftSight Free** (Dassault) — DWG-nativ, kostenlos für Privatnutzung. **TODO:** Lizenzbedingung gewerblich klären, falls nötig.
- **LibreCAD** — Open Source, kann DWG via TeighaFileConverter importieren.
- **Fusion 360 selbst kann DWG öffnen** über `Insert → Insert DWG`, aber nicht alle Objekt-Typen sauber editieren.

Empfehlung: **Fusion-Insert-Test zuerst.** Wenn WEC.dwg die Anforderungen unten ohne Vorbereitung erfüllt (untere rechte Ecke bei 0,0, keine verbotenen Objekte), entfällt der Editor-Schritt.

### A.2 — Anforderungen an die DWG (Autodesk-Doku)

| Anforderung | Aktion bei Verstoß |
|---|---|
| Alles im **Model Space**, kein Paper Space | Paper-Space-Layouts ignorieren; relevante Geometrie in Model Space übertragen |
| Untere rechte Ecke des Schriftfelds = WCS-Ursprung (0,0) | Verschieben (`MOVE`-Befehl) so dass `bottom_right = 0,0` |
| Border-Geometrie passt zur Fusion-Blattgröße | Auf A3-Querformat 420×297 mm prüfen |
| **Keine** Blocks, Block-Definitionen, Xrefs, Fields, 3D-Geometrie, Custom Objects, Point Clouds, Geolokalisation | `EXPLODE` für Blocks, `PURGE` für Definitionen, manuelle Löschung sonstiger Verbote |
| Eindeutiger Dateiname | wie oben: `WEC_TitleBlock_v1.dwg` |
| Bilder via `IMAGEATTACH` einbinden | Fusion fügt automatisch Rand um Bilder hinzu (kosmetisch beachten) |

### A.3 — Attribute definieren (`ATTDEF`)

Für **jedes dynamische Feld** im Schriftfeld einen Attribute-Definition-Eintrag setzen:
- **Tag** = interne ID (Pflicht, eindeutig)
- **Prompt** = Klartext-Bezeichnung wie sie in Fusion gezeigt wird
- **Default** = optionaler Vorbelegungswert
- **Lock position** = aktivieren, damit Mo das Feld in Fusion nicht aus Versehen verschiebt

**Pflicht-Attribute (basierend auf [[Schriftfeld DIN ISO 7200 L7]]):**

| Tag | Prompt | Default | Quelle in Fusion |
|---|---|---|---|
| `BENENNUNG` | Benennung | — | Drawing iProperty: Component Name |
| `ZEICHNR` | Zeichnungs-Nr. | — | Drawing iProperty: Part Number |
| `WERKSTOFF` | Werkstoff | — | Component-Material |
| `HALBZEUG` | Halbzeug | — | Custom iProperty (manuell) |
| `MASSSTAB` | Maßstab | `1:1` | View-Scale |
| `FORMAT` | Format | `A3` | Sheet-Size |
| `GEWICHT` | Gewicht | — | Physical-Properties (auto) |
| `BEARBEITER` | Bearbeitet | `Hartmann` | iProperty (Default-Wert hier) |
| `GEPRUEFT` | Geprüft | `Woldrich` | iProperty (Default-Wert hier) |
| `DATUM` | Date of issue | — | Drawing-Property: Creation Date |
| `REV` | Rev. | `00` | Custom iProperty (manuell) |
| `BLATT` | Blatt | `1/1` | Sheet-Number |
| `TOLERANZ` | Allg.-Toleranz | `ISO 2768-mK` | Custom iProperty |

> **Hinweis L7/M7:** „L7"/„M7" bezeichnen im Bens-Solid-Edge-Layout die Zell-Adressen für Bearbeiter/Geprüft. Im Fusion-Template mappen wir das auf die Tags `BEARBEITER` und `GEPRUEFT` — gleicher Inhalt, andere technische Bezeichnung. Default `Hartmann` / `Woldrich` (Nachname-only, pro Auftrag iProperty-überschreibbar).

### A.4 — DWG speichern
Standard-DWG-Format (kein „Simplified DWG", Autodesk-Doku-Mythos). Speichern als `WEC_TitleBlock_v1.dwg`.

---

## Phase B — Title Block in Fusion erstellen

1. Fusion 360 öffnen.
2. Beliebige Drawing öffnen oder neu anlegen (für den Title-Block-Editor reicht ein leeres Drawing).
3. Im Browser-Tree: **Sheet Settings** → **Title Block** → Rechtsklick → **„New Title Block"**.
4. Dialog: **„From DWG File"** wählen → vorbereitete `WEC_TitleBlock_v1.dwg` laden.
5. Eindeutigen Namen eingeben: `WEC L7 Standard A3`.
6. OK → Title-Block-Editor öffnet sich.
7. Im Editor prüfen: alle Attribute sichtbar, Position passt, Rand schneidet nicht in Geometrie.
8. **„Finish Title Block"** klicken.

> **Falls Editor Fehler meldet** (häufigster Grund: nicht erlaubte Objekte in DWG): zurück zu Phase A.2, `PURGE`/`EXPLODE` ausführen, neu speichern, neu laden.

---

## Phase C — Als Drawing Template speichern

1. Drawing mit dem neuen Title Block öffnen.
2. Sheet auf A3 Querformat setzen.
3. View-Defaults setzen (Linienstärken Standard, Maßeinheit mm, Toleranz-Stil ISO).
4. **File → Save As Drawing Template** → Name `WEC L7 A3 Querformat`.
5. Fusion legt das Template im Cloud-Projekt unter „Drawing Templates" ab.

> **Backup-Strategie:** zusätzlich Drawing als `.f3d` lokal exportieren und in `~/Konstruktion/Templates/WEC-Fusion-L7/` ablegen — Cloud-Version kann verloren gehen, lokales `.f3d` ist Anker.

---

## Phase D — Validierung am Pilot-Teil R_Blech_Klein

1. Neues Drawing aus `R_Blech_Klein.f3d` (oder Insert STEP).
2. Beim Anlegen: Template `WEC L7 A3 Querformat` wählen.
3. Vier Ansichten platzieren: Drauf / Vorder / Seite / Iso.
4. iProperties befüllen:
   - Benennung: `L-Blech klein`
   - Zeichnungs-Nr.: `WEC-LB-202601` (Convention TODO klären)
   - Werkstoff: `1.4301`
   - Halbzeug: `Bl. 1,5 mm`
   - Bearbeiter: `Hartmann`
   - Geprüft: `Woldrich`
   - Rev.: `00`
5. Bemaßung: Außenkontur, 2× Ø6,5, Position der Bohrungen, Materialdicke (am Schnitt), Hinweis „Alle Kanten gebrochen".
6. Export PDF: `File → Export → PDF`, Maßstab 1:1, Auflösung 300 DPI, Linien schwarz.

**Akzeptanz-Kriterien für PDF:**
- Schriftfeld L7 zeigt `Hartmann`, M7 `Woldrich` (extern korrekt, kein Vorname)
- Date of issue automatisch befüllt
- Rev. `00` sichtbar
- Maße lesbar bei 100 % Bildschirm-Zoom
- Keine Vektor-Text-Einträge à la „Sebastian Hartmann" wie in den Lehrgeld-PDFs vom 2026-04-21

---

## Bekannte Stolperfallen

- **Attributes vs. einfache Texte:** Wenn ATTDEF im DWG nicht gesetzt ist und stattdessen normaler Text steht, sind die Felder in Fusion statisch — nicht-dynamisch befüllbar. Kompletter Re-Build der DWG nötig.
- **Origin nicht bei 0,0:** Title Block erscheint in Fusion „verschoben". Symptom: Border ragt über Sheet-Rand.
- **PDF-Export schreibt User-Namen in Vektor-Text:** Bekanntes Fusion-Verhalten (Lehrgeld 2026-04-21). Workaround: vor Export Account-Name anonymisieren oder Patcher v4 nachgeschaltet verwenden.

---

## Verknüpfungen

- [[04 Ressourcen/CAD-Workflows/Schriftfeld DIN ISO 7200 L7]] — Spezifikation der Felder
- [[04 Ressourcen/CAD-Workflows/Fusion 360 Add-Ins]] — Sheet Metal DXF Creator (parallel installieren)
- [[04 Ressourcen/CAD-Uebergabe an Claude]]
- [[04 Ressourcen/Playbook/Fusion-zu-Liefer-Pipeline]]

## Quellen

- [Autodesk: Prepare an AutoCAD DWG title block](https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-D6DB9443-A21B-4E23-8C4F-B275102715AB)
- [Autodesk: Create or edit a title block](https://help.autodesk.com/view/fusion360/ENU/?guid=DWG-CREATE-NEW-TITLE-BLOCK)
- [Autodesk: How to import a drawing template in Fusion](https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/How-to-import-a-drawing-template-in-Fusion-360.html)

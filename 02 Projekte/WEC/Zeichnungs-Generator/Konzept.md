---
tags: [projekt, wec, zeichnungs-generator, fusion-api]
date: 2026-05-01
status: konzept-pfad-c-bestaetigt-revidiert
raum: WEC
owner: Sebastian
priorität: hoch
verknuepft:
  - "[[02 Projekte/WEC/Idee - Zeichnungs-Generator aus Konstruktion]]"
  - "[[04 Ressourcen/CAD-Workflows/Fusion 360 Drawing Template L7]]"
  - "[[04 Ressourcen/Playbook/Fusion-zu-Liefer-Pipeline]]"
---

# Zeichnungs-Generator — Konzept (Pfad A)

**Auslöser:** R_Blech_Klein heute manuell durchgespielt. Workspace-Wechsel, Ansichten platzieren, Schriftfeld füllen — 10–30 Min stupider Klick-Marathon pro Bauteil. Nicht das Zeichnen ist das Bottleneck (8 Jahre Erfahrung), sondern die Reihenfolge der Klicks.

**Ziel:** STEP + YAML-Sidecar rein → A3-PDF/DXF mit gefülltem L7-Schriftfeld raus. Manuelle Nacharbeit nur noch kritische Bemaßungen.

---

## 1. Architektur-Optionen

| Variante | Wo läuft's | Trigger | Aufwand | Wartbarkeit | Status |
|---|---|---|---|---|---|
| **A — Add-In** | IN Fusion | GUI-Button | mittel | Code in Fusion-Add-In-Ordner | aktiv (Teil von C) |
| **B — Headless via Python-API** | AUSSER Fusion (CLI) | Watchfolder/Cron | — | — | **VERWORFEN** — Mac-Fusion hat keinen Headless-Modus, kein `--script`-Launch (siehe [[Recherche-Ergebnisse]] Punkt 1) |
| **C — Hybrid** | Add-In als GUI-Wrapper, Logik in externer .py | Button ODER File-Drop | hoch initial, danach niedrig | Logik testbar ohne Fusion | **BESTÄTIGT** |

**Pfad C bestätigt** (statt nur empfohlen). Begründung nach Recherche-Schritt 1:
- Mac-Fusion hat keinen Headless-Modus, keine CLI-Skript-Ausführung. Python-API läuft ausschließlich in einer aktiven GUI-Session als Add-In.
- Add-In allein (A) verklebt UI und Logik — schlecht testbar.
- Hybrid: Add-In ist dünner Wrapper, lädt externes Python-Modul. Modul mit Mock-Fusion-Objekten unit-testbar.

---

## 1.5 Vorgaben aus Recherche (verbindlich für Schritt 2 + 3)

Aus [[Recherche-Ergebnisse]] (2026-05-01) abgeleitete harte Vorgaben:

- **K — Schriftfeld als benannte Sketch-Texte (nicht ATTDEF):** Die `Attributes`-Collection-API ist defekt — Title-Block-ATTDEFs sind nach Drawing-Erstellung effektiv read-only. Schritt 2 (Template L7) **muss** alle Schriftfeld-Felder als Sketch-Texte mit eindeutigen Sketch-Namen anlegen (z.B. `tb_zeichnungsnr`, `tb_benennung`, `tb_werkstoff`). Generator findet sie per Name, ersetzt den Text-String. ATTDEF darf zusätzlich existieren (Lese-Komfort in Fusion), ist aber nicht Schreib-Pfad.

- **L — Template-Auflösung-Spike als allererster Hello-World-Test:** Punkt 6 der Recherche bleibt Hypothese (lokal `.f2d`-Pfad vs. Cloud-Library-ID unklar). Schritt 3 muss als ALLERERSTEN funktionalen Test `Drawings.add(<lokaler .f2d Pfad>)` ausführen. **Showstopper-Check:** wenn nur Cloud → Architektur muss Cloud-Storage für Template einbauen; Sebastians Sidecar-Workflow ändert sich.

- **Bend-Line-Filter im DXF-Post-Processing pflicht:** Sheet-Metal-Flat-Pattern-DXF-Export liefert Multi-Layer (Kontur, Stanzungen, Biegelinien getrennt). Generator-Phase muss Layer-Filter haben — Fertiger Tomasz braucht klare Layer-Trennung, Biegelinien als eigener Layer (nicht als Schnittkontur).

- **Layout-Engine ist Eigenbau:** Kein Auto-Maßstab, keine Default-View-Positionen, keine Kollisionserkennung. Generator muss eigene Layout-Logik haben (Maßstab aus Bounding-Box + Sheet-Größe, View-Positionen aus Template-Slots, Iso-Position fix).

- **N — Phase 1 nutzt Fusion-Standard-Schriftfeld als Template-Basis** (Revision 2026-05-01): Sketch-Text-Anker werden im Fusion-Standard-Schriftfeld benannt, nicht aus DWG-Import von Null gebaut. Begründung: DWG-Direkt-Import landet im Volumenkörper-Workspace, der Title-Block-from-DWG-Pfad ist Fusion-spezifisch verwinkelt — Aufwand vs. Ertrag stimmt für Phase 1 nicht. Hauptziel ist der Generator (Klick-Marathon entfernen), nicht der WEC-Look. WEC-Schriftfeld-Optik (DWG-Import, L7-DIN-Layout pixelgenau) ist **Phase-2-Veredelung**. Verbindlich: Anker existieren im Standard-Schriftfeld, sonst kann Generator nichts ersetzen. Details + Mapping: [[04 Ressourcen/CAD-Workflows/Fusion-Standard-Schriftfeld - Sketch-Anker]].

---

## 2. Recherche-Punkte (vor Bau zu klären)

1. **Headless auf Mac:** Kann Fusion 360 via `Fusion360.app --script <pfad>` o.ä. ohne sichtbare GUI laufen? Oder muss eine GUI-Session offen sein? (Web-Recherche Autodesk-Forum + API-Doku)
2. **Schriftfeld L7 via API:** Kann `Drawing.titleBlock` Custom-iProperties setzen? Oder muss Schriftfeld-Befüllung über `Drawing.sketches` (Text-Sketch im Title-Block-Layer) laufen? Vault-Verweis: [[04 Ressourcen/CAD-Workflows/Fusion 360 Drawing Template L7]] Phase B nutzt ATTDEF-Attribute aus DWG — sind diese via API beschreibbar?
3. **PDF-Export:** `Drawing.exportManager` Standard-Pfad — gleiche Qualität wie GUI-Export? Vektor oder Raster? Schriftfeld scharf?
4. **Flat-Pattern-DXF:** Sheet-Metal-Body mit Flat-Pattern — `FlatPattern.exportToDXF()` existiert? Liefert es DXF-Layer-konform für Fertiger (Kontur außen, Stanzungen innen, Biegelinien getrennt)?
5. **YAML-Sidecar-Schema:** Pflichtfelder (`zeichnungsnr`, `benennung`, `werkstoff`, `bearbeiter`, `geprüft`, `rev`, `kunde`); optional (`toleranzklasse`, `kritische_masse[]`, `oberfläche`, `ehedg`). Default-Werte für Bens vs. Knauf vs. WEC-direkt.
6. **Drawing-Template-Zugriff:** Wie referenziert die API ein gespeichertes Drawing-Template (`.f2d`)? Per Datei-Pfad oder Cloud-ID? **Blocker:** Template aus Phase B (WEC.dwg → Fusion-Title-Block) ist noch nicht gebaut.
7. **Ansichts-Platzierung:** `Drawing.drawingViews.add()` mit Standard-Layout (Front/Top/Right/Iso) — wo platziert die API die Views per Default? Maßstab automatisch oder Pflicht-Parameter? Kollisionserkennung?

---

## 3. Abhängigkeiten (vor Bau-Start)

- **A1 — WEC-Drawing-Template L7 fertig.** Phase B aus [[04 Ressourcen/CAD-Workflows/Fusion 360 Drawing Template L7]] muss durchgezogen sein. Ohne Template kein Schriftfeld zum Befüllen. **Blocker.**
- **A2 — YAML-Sidecar-Schema festgelegt** (Recherche-Punkt 5 abgeschlossen, Schema in `04 Ressourcen/CAD-Workflows/Sidecar-Schema.md` dokumentiert).
- **A3 — R_Blech_Klein als Referenz-Output.** Heute manuell erzeugte PDF + DXF als `tests/golden/R_Blech_Klein.{pdf,dxf}` archiviert — Generator muss bit-nah-äquivalentes (oder visuell identisches) Ergebnis liefern.
- **A4 — Fusion-Sandbox-Konstruktion.** Eine Throwaway-Fusion-Datei zum API-Experimentieren, nicht R_Blech_Klein produktiv anfassen.

---

## 4. Integration mit Bestehendem

**v5-Patcher (`02 Projekte/WEC/scripts/v5_patcher.py`):**
- Komplementär, **keine Ablöse.** Patcher arbeitet auf bestehenden PDFs (Reiner-Solid-Edge-Output), tauscht Schriftfeld + Nummern für White-Label-Lieferung. Generator erzeugt PDFs neu aus Fusion (Sebastians Konstruktionen).
- Zwei Quellen, eine Senke (Bens-Staging). Output-Format identisch (A3-PDF, gleiche Nummern-Konvention `BE-LS-YYYYMM-XXX-Y`).

**Mapping-Schema gemeinsam nutzen:**
- Patcher hat Mapping-CSV (intern→Bens-Nummer, Original-Bezeichnung→White-Label-Bezeichnung).
- Generator soll **gleiches Mapping lesen**, nicht eigenes YAML-Pflege-Silo aufmachen. Sidecar-YAML ergänzt nur Felder, die in der Konstruktion nicht stehen (Toleranzklasse, kritische Maße).
- Ergebnis: eine Wahrheit für Nummern/Bezeichnung, beide Tools ziehen daraus.

**Output-Pfade:**
- Staging: `/tmp/zeichnungs-generator-staging/<zeichnungsnr>/{pdf,dxf,flat-pattern.dxf}`
- Audit-Liste vor Freigabe (Staging-vor-Raus-Regel aus CLAUDE.md)
- Nach Freigabe → `03 Bereiche/WEC/Lieferung/<Kunde>/<Projekt>/`

---

## 5. Nächste 3 Schritte

1. **Recherche-Punkte 1–7 klären** (1 Tag, Sebastian + Web + API-Doku).
   Output: `02 Projekte/WEC/Zeichnungs-Generator/Recherche-Ergebnisse.md` mit Antworten + Vault-Quellen-Links. CC-Prompt dafür wird nach Konzept-Freigabe nachgereicht.

2. **NEU — Sketch-Text-Anker im Fusion-Standard-Schriftfeld benennen** (0,5 Tag, Sebastian).
   Statt WEC.dwg-Import (zu aufwendig für Phase 1, siehe Vorgabe N): im Standard-Fusion-A3-Querformat-Drawing den Title-Block-Edit-Modus öffnen, vorhandene Sketch-Texte lokalisieren, gemäß `tb_<feldname>`-Konvention umbenennen, fehlende Pflicht-Anker (Werkstoff, Toleranzklasse, Oberfläche, Bemerkung) als neue Sketch-Texte ergänzen. Anleitung: [[04 Ressourcen/CAD-Workflows/Fusion-Standard-Schriftfeld - Sketch-Anker]]. Output: Template-`.f2d` mit benannten Ankern + lokaler Pfad in TASKS.md. **Phase-2-Veredelung** (DWG-Import für WEC-Look) bleibt geparkt: [[04 Ressourcen/CAD-Workflows/Template L7 Build-Anleitung]].

3. **Hello-World-Add-In mit Showstopper-Check** (0,5–1 Tag, Sebastian).
   Test-Reihenfolge im Add-In strikt einhalten:
   - **(a)** Add-In lädt, Konsole-Hello („Generator aktiv").
   - **(b)** Aktuelles Dokument identifizieren (Name, Body-Count, Sheet-Metal-Status).
   - **(c) SHOWSTOPPER-CHECK:** `Drawings.add(<lokaler .f2d Pfad>)` mit Template aus Schritt 2. Wenn nur Cloud-Library-ID akzeptiert wird → STOP, Architektur-Re-Eval (Cloud-Storage-Strategie für Template).
   - **(d)** Erst nach grünem (c): weitere Funktionen (Sketch-Text-Befüllung, View-Add, Export).
   Zweck: Add-In-Loader funktioniert + Template-Auflösungs-Hypothese (Punkt 6) wird final geklärt. Kein Logik-Code in dieser Phase.

---

## Out-of-Scope (explizit nicht in dieser Phase)

- Korpus-Pipeline / RAG / KI-Schicht — separates Projekt [[02 Projekte/WEC Neustart mit Reiner/Strategie - Korpus-Auslesen und KI-Pipeline]]
- Reiner-Workflow — er bleibt bei Solid Edge + Papier
- Bemaßungs-Automatik — kritische Maße bleiben manuell
- Fertiger-Integration — Tomasz arbeitet aus STEP, läuft
- Multi-Kunden-Templates — Phase 1 nur WEC-direkt + Bens-Klon

---

## Status

**Konzept, nicht Strategie.** Sebastian liest, korrigiert, dann CC-Prompt für Schritt 1 (Recherche).

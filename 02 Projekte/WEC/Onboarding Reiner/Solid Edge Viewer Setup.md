---
tags: [projekt, wec, onboarding, reiner, solid-edge]
date: 2026-05-01
status: aktiv
priorität: A
owner: Reiner
raum: WEC
---

# Solid Edge Viewer — Setup für Reiner

> **Zweck:** Reiner installiert auf seinem Windows-PC den kostenlosen Solid Edge Viewer (Siemens) und liefert ein PDF-Druckbild des Bens-Schriftfeld-Originals (`Vordruck.dft` / `Bens_Vordruck.dwg`) als Referenz für das Fusion-360-Klon-Template.
>
> **Warum nicht Online-Konverter:** Bens-Konstruktionsdaten verlassen den lokalen Rechner nicht („Selbst ist Sicherheit. Sicherheit ist Selbst."). Offizieller Siemens-Viewer auf Reiners Windows-PC ist der einzige saubere Weg.
>
> **Kontext:** Reiner arbeitet mit **Solid Edge** (Siemens), nicht SolidWorks. Dateiendung `.dft` = Solid Edge Draft, `.dwg` = AutoCAD-kompatibles Austauschformat.

---

## Schritt 1 — Download (Reiner, Windows-PC)

1. Browser öffnen, Adresse eingeben:
   **https://resources.sw.siemens.com/en-US/download-solid-edge-free-viewer/**
2. Auf der Seite Formular ausfüllen (Name, Firma, E-Mail). Siemens schickt anschließend einen Download-Link an die angegebene Adresse.
   - Firma: `Bens Edelstahl GmbH` (passt zur Verwendung) oder `WEC Pirna`. Beides legitim.
3. Im Download-Link: Installer (.exe, ca. 200–400 MB) herunterladen.

> **Hinweis:** Nicht von Drittseiten wie filecr.com oder software.informer.com herunterladen — nur direkt von Siemens.

---

## Schritt 2 — Installation

1. Heruntergeladene `.exe` per Doppelklick starten.
2. Standard-Installation (Sprache: Deutsch, Pfad: Default `C:\Program Files\Siemens\Solid Edge Viewer\`).
3. Beim ersten Start: keine Lizenz nötig — es ist ein reiner Viewer, kein Editor.
4. Falls nach Konto gefragt: **abbrechen** funktioniert (Viewer braucht kein Siemens-Konto zur Anzeige).

---

## Schritt 3 — Bens-Vordruck öffnen und PDF drucken

**Quell-Dateien (im Brain-Vault, bei Reiner über Obsidian Sync sichtbar sobald aktiv):**
- `03 Bereiche/WEC/raw/Kunden/Volker Bens/Standards & Vorlagen/Vordruck.dft`
- `03 Bereiche/WEC/raw/Kunden/Volker Bens/Standards & Vorlagen/Bens_Vordruck.dwg`

> **Falls Obsidian Sync noch nicht aktiv:** Mo schickt die Dateien per Stick oder direkt-USB.

**Ablauf:**
1. Solid Edge Viewer starten.
2. `Datei → Öffnen` → `Vordruck.dft` auswählen.
3. Im Viewer prüfen: Schriftfeld unten rechts sichtbar, Felder lesbar.
4. `Datei → Drucken` → Drucker: **„Microsoft Print to PDF"** (vorinstalliert auf Win 10/11).
5. Format: **A3 Querformat** (so wie das Original gezeichnet ist).
6. Speichern unter: `Vordruck_OriginalScan.pdf`.
7. Schritte 2–6 für `Bens_Vordruck.dwg` wiederholen.

---

## Schritt 4 — Ablage im Vault

PDFs in den geteilten Sync-Ordner legen:
```
WEC-Shared/Bens/Vordruck_OriginalScan.pdf
WEC-Shared/Bens/Bens_Vordruck_OriginalScan.pdf
```

Sobald die Dateien bei Mo ankommen, startet er **Schritt 2 des Fusion-Template-Pilots** (Klon des echten Originals, nicht des aktuellen Fusion-Versuchs).

---

## Falls etwas hakt

- **Viewer öffnet `.dft` nicht:** Datei könnte aus älterer Solid-Edge-Version stammen (z.B. ST4). Aktueller Viewer ist abwärtskompatibel. Falls Fehler: Dateinamen + Fehlermeldung an Mo.
- **Schriftfeld unleserlich klein im PDF:** im Viewer vor dem Druck zoomen, oder Druckskalierung auf „auf Seite anpassen" stellen.
- **Druckdialog zeigt kein „Microsoft Print to PDF":** in Windows-Einstellungen → Drucker → Drucker hinzufügen → „Microsoft Print to PDF" aus der Liste wählen.

---

## Nächste Schritte (nach Lieferung)

- [ ] Mo prüft Original-PDF gegen die Layout-Rekonstruktion in [[04 Ressourcen/CAD-Workflows/Schriftfeld DIN ISO 7200 L7]]
- [ ] Mo klont Bens-Layout 1:1 in Fusion 360 als Drawing Template
- [ ] L7/M7-Inhalt im Template fixieren: `Hartmann` (L7) / `Woldrich` (M7), beide Nachname-only

---

## Quellen

- [Solid Edge Free Viewer — Siemens (offiziell)](https://resources.sw.siemens.com/en-US/download-solid-edge-free-viewer/)
- [Solid Edge Free Software Übersicht](https://solidedge.siemens.com/en/free-software/overview/)

## Verknüpfungen

- [[04 Ressourcen/CAD-Workflows/Schriftfeld DIN ISO 7200 L7]] — Schriftfeld-Spezifikation, wartet auf Original-Referenz
- [[03 Bereiche/WEC/wiki/Kunden/Volker Bens - Profil]]
- [[03 Bereiche/WEC/CLAUDE]] — White-Label-Regel

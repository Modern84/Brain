---
tags: [projekt, wec, zeichnungs-generator, recherche]
date: 2026-05-01
status: recherche-abgeschlossen
---

# Zeichnungs-Generator — Recherche-Ergebnisse Fusion-360-API

Fact-finding zur Architektur-Entscheidung **Pfad B (rein extern/headless)** vs. **Pfad C (Add-In-Hybrid)**. Quellen-Stand: 2026-05-01. Methodik: Autodesk-Doku + Forum + community-Praxis. Kein Code, nur Faktenbasis.

---

## Punkt 1 — Headless auf Mac

**Frage:** Kann Fusion 360 auf macOS via CLI ohne GUI laufen? `--script <path>`-Modus, Hidden-Window, Cron/launchd? Falls nein: nächstbeste Lösung?

**Antwort:** **FAKT — Nein, kein echter Headless-Modus.** Fusion 360 ist eine reine GUI-Anwendung ohne Command-Line-Interface im Sinne von AutoCAD. Es gibt **keinen `--script`-Launch-Parameter**, keinen Hidden-Window-Mode und keine offizielle Headless-Option. Die einzigen „Command"-Funktionen sind die internen Text-Commands (View → Show Text Commands, Option+Cmd+C auf Mac) — die laufen aber **innerhalb der laufenden GUI** und sind laut Autodesk „for internal testing purposes". Skripte/Add-Ins werden ausschließlich aus der laufenden GUI heraus über den „Scripts and Add-Ins"-Dialog gestartet, oder per „Run on Startup"-Flag automatisch beim GUI-Start eines Add-Ins ausgeführt. Cron/launchd-Aufruf eines Skripts ohne offene GUI ist **nicht vorgesehen**.

**Nächstbeste Lösung:** Fusion morgens manuell öffnen → Add-In mit `runOnStartup=true` lädt sich → Watcher-Logik (Datei-Polling im Add-In oder externer Trigger über Filesystem-Marker/HTTP-Lokalport) reagiert tagsüber auf neue STEP+YAML-Eingänge. Add-In bleibt im Speicher der GUI-Session. Alternative: AppleScript/`open -a Fusion` + Auto-Run-Add-In, aber GUI ist immer geöffnet (kein wirklich „headless").

**Quelle:**
- [Product Design Online — Does Fusion 360 have a Command-Line?](https://productdesignonline.com/tips-and-tricks/does-fusion-360-have-a-command-line/) (2026-05-01)
- [Autodesk Forum — Run Fusion Script from Terminal/Command Prompt, Thread 10285701](https://forums.autodesk.com/t5/fusion-api-and-scripts-forum/run-fusion-script-from-terminal-command-prompt/td-p/10285701) (2026-05-01, 403 für WebFetch — bestätigt durch Suchsnippets)
- [Autodesk Help — Creating a Script or Add-In](https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-9701BBA7-EC0E-4016-A9C8-964AA4838954) (2026-05-01)
- [Autodesk Forum — Run on startup, Thread 7226109](https://forums.autodesk.com/t5/fusion-api-and-scripts/run-on-startup/td-p/7226109) (2026-05-01)

**Konsequenz:** **Pfad B (rein extern) entfällt** — die Fusion-Brücke muss zwingend in einem Add-In innerhalb laufender GUI leben.

---

## Punkt 2 — Schriftfeld L7 via API

**Frage:** Kann API ein Custom-Drawing-Template-Schriftfeld befüllen? ATTDEF aus DWG-Import beschreibbar? iProperties bidirektional? Fallback Text-Sketch?

**Antwort:** **FAKT — Nur eingeschränkt, in der Praxis problematisch.** Title-Block-Attribute aus AutoCAD-ATTDEF werden beim DWG-Import gemappt; Autodesk listet eine feste Liste „erlaubter" Attributnamen, die auf Fusion-Properties (Part Number, Description, Material, Author etc.) auflösen — abweichend benannte werden zu Custom-Attributes. Die programmatische Befüllung über die `Attributes`-Collection des `DrawingDocument` ist laut mehreren Forum-Threads **defekt bzw. liefert leere Collection** — User berichten, dass `Attributes` für Title-Block-Inhalte 0 Elemente zurückgibt, und dass Title-Block-Attribute nach Drawing-Erstellung „read-only" sind und nur per Doppelklick im UI änderbar. Für Modell-getriebene Felder (Part Number etc.) kann der Umweg über Modell-`Properties` gehen, aber freie L7-Schriftfeld-Inhalte (Werkstoff, Norm, WEC-Auftragsnummer etc.) sind nicht zuverlässig per API setzbar.

**Fallback:** **Text-Sketch im Title-Block-Layer** des Templates, dessen Sketch-Text-Inhalte über `SketchText.text`-Property gesetzt werden — dieser Weg ist gangbar, aber bricht das saubere ATTDEF-Konzept und macht Template-Pflege fragiler.

**Quelle:**
- [Autodesk Forum — Assign values to title block attributes programmatically, Thread 10493395](https://forums.autodesk.com/t5/fusion-api-and-scripts-forum/assign-values-to-title-block-attributes-programmatically/td-p/10493395) (2026-05-01)
- [Autodesk Support — Title block attribute definitions in Fusion 360](https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Title-block-attribute-definitions-in-Fusion-360.html) (2026-05-01)
- [Autodesk Support — Set a custom name or other attribute in a title block](https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Set-a-custom-name-or-other-attribute-in-a-title-block-in-Fusion-360.html) (2026-05-01)

**Konsequenz:** L7-Feldfüllung muss als Text-Sketch im Template-Layer realisiert werden, nicht über native Title-Block-Attribute — Architektur-Risiko, einplanen.

---

## Punkt 3 — PDF-Export

**Frage:** `Drawing.exportManager` — Vektor oder Raster? Schriftfeld-Text scharf? A3-Querformat-Erhalt? Multi-Sheet?

**Antwort:** **FAKT — Vektor-PDF, Sheet-Größe wird aus dem Drawing übernommen.** Die API stellt `DrawingExportManager.createPDFExportOptions(filename)` bereit; das Ergebnis ist das Standard-Drawing-PDF, das Fusion auch über das UI erzeugt — und das ist **vektor-basiert** (Linien, Bemaßung, Text scharf, Linewidths erhalten). Sheet-Größe (A3 quer) wird aus dem im Drawing eingestellten Format übernommen, nicht in den ExportOptions überschrieben. **Multi-Sheet:** Das offizielle UI-Verhalten ist „alle Sheets in eine PDF" — die API folgt diesem Verhalten standardmäßig (per Forum-Bestätigung), eine selektive Sheet-Wahl ist nicht dokumentiert.

**Quelle:**
- [Autodesk Help — DrawingExportManager.createPDFExportOptions Method](https://help.autodesk.com/cloudhelp/ENU/Fusion-360-API/files/DrawingExportManager_createPDFExportOptions.htm) (2026-05-01)
- [Autodesk Forum — Drawing PDF Export: How to access the new export manager, Thread 9940719](https://forums.autodesk.com/t5/fusion-api-and-scripts-forum/drawing-pdf-export-how-to-access-the-new-export-manager/td-p/9940719) (2026-05-01)
- [Autodesk Support — How to export Fusion Drawings in PDF, DWG, CSV, or DXF](https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/How-to-export-Fusion-360-Drawings.html) (2026-05-01)

**Konsequenz:** PDF-Pfad ist sauber und unkritisch — Vektor-Output garantiert.

---

## Punkt 4 — Flat-Pattern-DXF

**Frage:** Sheet-Metal-Body Flat-Pattern → DXF via API? `FlatPattern.exportToDXF()`? Layer-Trennung?

**Antwort:** **FAKT — Möglich, aber mit Layer-Limitierung.** Die API hat keine `FlatPattern.exportToDXF()`-Methode mit diesem Namen, aber das Vorgehen ist dokumentiert: aus dem Sheet-Metal-Component das `FlatPattern`-Objekt holen (`component.flatPattern`), und dann via Sketch- oder Drawing-Workflow als DXF exportieren. Der **Standard-DXF-Export aus Flat-Pattern enthält automatisch alle Layer**: outer profiles, interior profiles, **Bend Center Lines, Bend Extent Lines** sowie Text — getrennt auf eigene DXF-Layer. **Negativ-FAKT:** Bend-Lines lassen sich beim Export **nicht abwählen** — sie sind immer dabei. Wer eine pure Konturlinie braucht, muss nachträglich einen Filter-Pass machen (DXF re-importieren, Layer abschalten, neu exportieren) oder direkt im DXF-Empfänger filtern.

**Quelle:**
- [Autodesk Forum — Fusion 360 Python Script Flat Pattern & Export to DXF, Thread 12169763](https://forums.autodesk.com/t5/fusion-api-and-scripts-forum/fusion-360-quot-python-quot-script-flat-pattern-amp-export-to/td-p/12169763) (2026-05-01)
- [Autodesk Support — Exported DXF flat patterns contain extent lines](https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/Exported-DXF-flat-patterns-contain-extent-lines-in-Fusion-360.html) (2026-05-01)
- [Autodesk Help — FlatPattern.bendLinesBody Property](https://help.autodesk.com/cloudhelp/ENU/Fusion-360-API/files/FlatPattern_bendLinesBody.htm) (2026-05-01)

**Konsequenz:** DXF-Output mit Layer-Trennung ist gegeben — Bend-Line-Filter-Schritt im externen Tool einplanen, falls Laser-Cutter pure Kontur braucht.

---

## Punkt 6 — Drawing-Template-Referenzierung (HYPOTHESE)

**Frage:** Wie referenziert Fusion-API ein gespeichertes Drawing-Template `.f2d`? Datei-Pfad oder Cloud-ID? Lokal oder Cloud-Pflicht?

**Antwort:** **HYPOTHESE (Doku unvollständig).** Sicher dokumentiert: Drawing-Templates werden in Fusion über das UI als `.f2d`-Datei gespeichert und können in Cloud-Ordnern oder lokal abgelegt werden; die UI bietet beim „New Drawing"-Dialog explizit die Wahl eines Templates. Die `createFromTemplate`-Methode existiert für CAM-Setups, ist aber für Drawings **nicht 1:1 dokumentiert** und der CAM-Setup-Variant ist laut Doku „retired". **Hypothese:** Die saubere API-Route geht über `Documents.open(templatePath)` und Save-As-New-Document-Workflow, oder über Aufruf des Drawing-Workspace-Commands per `executeTextCommand`. Ob lokale `.f2d`-Pfade direkt funktionieren oder ob der Cloud-Hub-Pfad (`Data Panel`-URN) zwingend ist, ist **nicht eindeutig** — Forum-Threads zu Drawing-Templates gehen meist über die UI; API-Beispiele für `Drawings.add(templatePath)` fehlen in der offiziellen Doku.

**Quelle:**
- [Autodesk Help — Setup.createFromTemplate Method (CAM, retired)](https://help.autodesk.com/cloudhelp/ENU/Fusion-360-API/files/Setup_createFromTemplate.htm) (2026-05-01)
- [Autodesk Support — How to set up a custom drawing template in Fusion](https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/How-to-set-up-a-custom-drawing-template-in-Fusion-360.html) (2026-05-01)
- [Autodesk Help — Drawing templates](https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-7D66F0CF-97BD-4EFB-9EB2-37CF89F76C56) (2026-05-01)
- [Autodesk Forum — template path in API local, Thread 10885619](https://forums.autodesk.com/t5/fusion-360-api-and-scripts/template-path-in-api-local/td-p/10885619) (2026-05-01)

**Konsequenz:** Im Add-In-Spike als allererster Schritt validieren — Template-Auflösung ist potenziell Showstopper für Automatisierung; wenn nur Cloud-URN funktioniert, muss Template einmalig zentral abgelegt werden.

---

## Punkt 7 — Ansichts-Platzierung

**Frage:** `Drawing.drawingViews.add()` — Auto-Maßstab? Default-Positionen? Kollisionserkennung? Iso-Standard-Winkel?

**Antwort:** **FAKT (teilweise) / nicht eindeutig (Auto-Layout).** Die API stellt `DrawingViews.add(...)` bzw. `addBaseView(...)` bereit; Pflichtparameter sind Referenz-Component, Sheet, Position (Point2D) und **expliziter Maßstab**. Es gibt **keinen Auto-Scale-Modus** im API-Aufruf — der aufrufende Code muss Maßstab vorab berechnen (Bounding-Box des Bauteils ÷ Sheet-Größe minus Reserve). Default-Positionen pro View-Typ existieren ebenfalls **nicht automatisch** — der Aufrufer übergibt Koordinaten. **Iso-Standard-Winkel:** Über die Orientation-Konstanten (Front, Top, Right, Iso) anwählbar, aber Erstwinkel- vs. Drittwinkel-Projektion folgt dem **Drawing-Standard des Templates**, nicht dem API-Aufruf — also über das Template steuern (DIN/ISO-Erstwinkel). **Kollisionserkennung:** Nicht vorhanden, der Aufrufer ist zuständig dafür, dass Views nicht überlappen.

**Quelle:**
- [Autodesk Help — Fusion API Reference Manual](https://help.autodesk.com/cloudhelp/ENU/Fusion-360-API/files/ReferenceManual_UM.htm) (2026-05-01)
- [Autodesk Fusion 360 API GitHub Samples](http://autodeskfusion360.github.io/) (2026-05-01)
- [Autodesk Help — Drawing views](https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-7AA7A8E9-D423-40A0-8139-7B09AE073DC7) (2026-05-01)

**Konsequenz:** Layout-Logik (Maßstabswahl, View-Positionierung, Kollisionsvermeidung) muss in Eigenregie programmiert werden — das ist ein eigener Engineering-Task, kein API-Geschenk.

---

## Architektur-Konsequenz

**Pfad B (rein extern/headless) ist tot.** Punkt 1 schließt headless-Betrieb auf Mac kategorisch aus — es gibt keinen `--script`-Mode, keine GUI-lose Ausführung. **Pfad C (Add-In-Hybrid) bleibt einzig gangbar:** Fusion läuft mit GUI als Daemon, ein Auto-Run-Add-In übernimmt die Drawing-Erzeugung, Maß­stab und View-Layout werden vom Add-In berechnet, externes Python kümmert sich nur um STEP+YAML-Vorbereitung, Trigger und Post-Processing (DXF-Layer-Filter, PDF-Ablage). Zusätzliche Risiken aus Punkt 2 (ATTDEF-API-Bug → Text-Sketch-Fallback) und Punkt 6 (Template-Auflösung unklar → Spike priorisieren) sind beherrschbar, müssen aber im Add-In-Prototyp als erste Schritte validiert werden, bevor Layout-Logik gebaut wird.

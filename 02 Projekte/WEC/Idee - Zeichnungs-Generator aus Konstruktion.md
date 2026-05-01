---
typ: idee
status: festgehalten
datum: 2026-04-21 abends
verknuepft:
  - "[[03 Bereiche/WEC/WEC Vision - Automatisierte Pipeline]]"
  - "[[03 Bereiche/WEC/Idee - Claude SolidWorks Integration]]"
  - "[[04 Ressourcen/Playbook/Fusion-zu-Liefer-Pipeline]]"
---

# Idee — Zeichnung weg, nur noch Konstruktion + Export

Gedanke von Mo am Tagesende 21.04.2026, nach dem Volker-Bens-Marathon. Nicht zur Umsetzung, nur festhalten.

## Kerngedanke

Reiner (bzw. ich in Fusion) soll in Zukunft **keine Zeichnungen mehr zeichnen**. Nur noch die 3D-Konstruktion machen, plus ein paar Metadaten anfügen — Material, Toleranzen, kritische Maße, Bearbeitungshinweise.

Den Rest übernimmt ein automatisierter Prozess:
- Ansichten (Front, Seite, Oben, Iso) aus der 3D-Geometrie projizieren
- Bemaßungen setzen — Standard-Maße automatisch, kritische Maße aus Markierung des Konstrukteurs
- Schriftfeld füllen aus Metadaten (Nummer, Name, Material, Masse, Datum, Prüfer)
- Stückliste aus Assembly-Struktur generieren
- Info-Block (Allgemeintoleranzen, EHEDG-Hinweise, Werkstoff-Normtext) aus Kunden-Template einfügen
- PDF/DXF/STEP-Output in einem Rutsch

Ziel: was heute pro Bauteil 10–30 Minuten Zeichnen ist, fällt auf 1–2 Minuten Metadaten-Pflege zusammen.

## Warum das Sinn macht

- Die heutige Session hat gezeigt: 80 % der Zeichnungs-Probleme sind **Metadaten-Inkonsistenzen** (Tippfehler im Material, Nummern-Kollisionen, Name aus Copy-Paste nicht aktualisiert). Wenn Metadaten strukturiert als einzige Quelle der Wahrheit gepflegt werden und die Zeichnung daraus generiert wird, können diese Fehlerklassen nicht mehr auftreten.
- Die 3D-Geometrie ist eh die Wahrheit — der Fertiger arbeitet mit STEP. Die 2D-Zeichnung ist nur noch **Lese-Artefakt für Menschen** (Werker, Qualitätsprüfer, Kunden-Dokumentation). Ein Lese-Artefakt aus einer Quelle zu generieren ist trivial verglichen mit "zwei parallele Wahrheiten pflegen".
- Reiners Papier-Stift-Scan-Workflow funktioniert für ihn, aber er hinterlässt keine maschinenlesbaren Spuren. Eine Metadaten-first-Pipeline würde seine pragmatische Denkweise (was muss 1×/2×/4× gefertigt werden) direkt maschinenlesbar machen, ohne ihn zu verbiegen.

## Was dafür gebaut werden müsste

Grob, nicht als Plan:
- Metadaten-Template (YAML-Frontmatter pro Bauteil, parallel zur STEP-Datei)
- Markierungs-Konvention in Fusion: welche Kanten sind "kritisches Maß", welche Oberfläche hat Toleranz X, welches Feature ist ein Bearbeitungsschritt
- Ein Renderer der aus STEP + Metadaten + Kunden-Template eine fertige PDF-Zeichnung baut (Python + ezdxf oder FreeCAD-Headless oder Fusion-API)
- Kunden-Templates als Konfiguration (Bens-Standard, Mädler-Standard, …)
- Integration in die bestehende v5-Patcher-Infrastruktur — dann wird aus "Patcher" eine vollwertige Pipeline-Stufe

## Verhältnis zu existierenden Visionen

Die bestehende **"Automatisierte Konstruktions-Pipeline"** beschreibt den Workflow auf einer höheren Ebene: Kundenanfrage → Konstruktion → Lieferung. Diese Idee hier ist der konkrete **"Zeichnungs-Generator"-Baustein** innerhalb dieser Vision. Er kann als Einzelbaustein gebaut werden, ohne den Rest der Pipeline fertig zu haben.

## Status

Parken. Nicht jetzt. Erst wenn der WEC-Arbeitsalltag mit Reiner stabil läuft und der Bedarf aus realen Wiederholprojekten klar ist — sonst Lösung auf der Suche nach einem Problem.

Wiedervorlage: in drei Monaten prüfen, ob das Thema noch heiß ist.

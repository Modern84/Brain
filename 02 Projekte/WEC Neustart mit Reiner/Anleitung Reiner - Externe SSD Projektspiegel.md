---
created: 2026-04-17
updated: 2026-04-17
type: anleitung
tags: [projekt, reiner, wec, backup, hardware]
---

# Externe SSD als Projektspiegel für Mo — und dein Welcome-Kit zurück

> ⚠️ **Status (17.04.2026 Nachmittag):** Reiner prüft wegen der Kosten einen **alternativen Hersteller**. Die konkrete Samsung-T9-Empfehlung unten ist nicht mehr gesetzt. **Pflicht-Anforderungen** bleiben: 2 TB Kapazität, USB-C, Lese-/Schreibrate auf T9-Niveau (Richtwert ≥ 1.000 MB/s). Alles andere (Modell, Hersteller, Preis) ist offen. Sobald Reiner ein Modell ausgewählt hat, wird dieser Abschnitt aktualisiert.

## Worum geht's?

Mo braucht eine Kopie aller aktuellen Projektdaten auf einer externen Festplatte, damit er unabhängig von deinem Rechner daran arbeiten kann. Nichts wird gelöscht oder verschoben — die Daten werden nur zusätzlich auf die Platte kopiert.

**Die SSD macht eine Runde:**
1. Du kaufst die Platte, kopierst deine NAS-Projektdaten drauf.
2. Du gibst die Platte Mo.
3. Mo übernimmt deine Daten auf seinen Mac.
4. **Mo bereitet dein neues Gehirn vor** (Obsidian-Vault, Claude-Regeln, Ordnerstruktur, Installer) und legt alles auf dieselbe Platte.
5. Du bekommst die Platte zurück — mit deinen alten Daten plus deinem startklaren neuen Arbeitssystem.

Die Platte ist also gleichzeitig Transport und Willkommens-Paket. Ein Weg hin, ein Weg zurück, zwei Aufgaben erledigt.

## Was du brauchst

**Festplatte:** Samsung Portable SSD T9, **2 TB**, USB-C  
**Modellnummer:** MU-PG2T0B/EU (schwarz)  
**Preis:** ca. 188–250 € (Stand April 2026, Geizhals-Vergleich Deutschland)  
**Wo:** Amazon, Alternate, Mindfactory, Cyberport, computeruniverse, Saturn, MediaMarkt  
**Warum 2 TB statt 1 TB:** 30 Jahre SolidWorks-Daten sind überraschend kompakt — realistisch 500 GB bis 1,5 TB. Mit 2 TB haben wir Luft für PDFs, Stücklisten und Dokumentation. Kein zweiter Upgrade nötig.

**Im Lieferumfang:** Zwei Kabel (USB-C auf USB-C und USB-C auf USB-A). Passt sowohl an deinen Windows-PC als auch an Mos Mac ohne Adapter.

**Warum genau die T9:**
- 2.000 MB/s — die gesamten 2 TB in unter 20 Minuten kopiert
- Sturzsicher bis 3 Meter, gummiertes Gehäuse
- 5 Jahre Samsung-Garantie
- AES-256 Hardware-Verschlüsselung
- 122 Gramm, passt in jede Tasche

## Einmalige Vorbereitung

### 1. Platte formatieren (exFAT)

Die T9 kommt ab Werk meist schon in exFAT formatiert — dann kannst du diesen Schritt überspringen. Falls nicht oder falls du auf Nummer sicher gehen willst:

1. Platte einstecken
2. Windows-Taste → „Datenträgerverwaltung" eingeben → öffnen
3. Die neue Platte finden (Vorsicht: nicht die Systemplatte!)
4. Rechtsklick auf die Partition → „Formatieren"
5. Dateisystem: **exFAT** auswählen
6. Volumebezeichnung: **WEC-Projekte**
7. „OK" klicken

**Alternative:** Mo kann die Formatierung am Mac in 30 Sekunden erledigen, falls du das lieber ihm überlässt.

### 2. Ordnerstruktur anlegen

Auf der Platte zwei Hauptbereiche erstellen:

```
WEC-Transfer/
│
├── 01_WEC-Projekte/       ← DEIN Bereich: NAS-Daten hier reinkopieren
│   ├── SolidWorks/          ← alle .sldprt, .sldasm, .slddrw
│   ├── Zeichnungen-PDF/     ← exportierte PDFs
│   ├── Stuecklisten/        ← BOMs als .xlsx oder .csv
│   ├── Dokumentation/       ← Anleitungen, Notizen, Bilder
│   └── _Archiv/             ← alte/abgeschlossene Projekte
│
└── 02_Reiner-Gehirn/      ← MO befüllt diesen Bereich vor Rückgabe
    ├── Gehirn/              ← kompletter Obsidian-Vault, startklar
    ├── Installer/           ← Obsidian + Claude Desktop (Win & Mac)
    └── Einrichtung.pdf      ← Schritt-für-Schritt für dich
```

Du legst Bereich 01 an und füllst ihn mit deinen NAS-Daten. Bereich 02 legt Mo an und füllt ihn, wenn die Platte bei ihm ist.

### 3. Daten kopieren

Alle aktuellen Projektdaten in die passenden Ordner kopieren. Einfach per Drag & Drop im Explorer.

**Wichtig:** Nichts ausschneiden, nur kopieren! Auf deinem Rechner bleibt alles wie gehabt.

## Bei jedem Update (optional, für später)

Wenn sich Daten ändern und Mo eine aktuelle Version braucht:

1. Platte einstecken
2. Geänderte Dateien in den passenden Ordner kopieren (überschreiben)
3. Platte sicher auswerfen (Taskleiste → USB-Symbol → Auswerfen)

## Volume-Name

Wenn du formatierst, gib der Platte den Namen **WEC-Transfer** (nicht "WEC-Projekte" — die Platte transportiert ja beides, Projekte und Gehirn).

## Fragen?

Einfach Mo oder Claude fragen.

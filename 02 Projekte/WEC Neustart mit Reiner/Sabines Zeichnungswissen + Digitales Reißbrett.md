---
tags: [projekt, wec, wissenstransfer]
status: aktiv
date: 2026-04-15
---

# Idee — Sabines Zeichnungswissen sichern

## Problem

Sabine (ältere Mitarbeiterin) geht bis Ende August 2026 in Rente. Sie hat enormes Wissen über:
- Zeichnungsableitung (2D aus 3D)
- Bemaßung nach Norm
- DIN-Vorschriften
- Schweißzeichen
- Oberflächenangaben
- Toleranzen

Dieses Wissen existiert nur in ihrem Kopf. Wenn sie geht, ist es weg.

## Herausforderung

Sabine ist konservativ und hält Sebastian für einen Spinner. Sie wird sich wahrscheinlich nicht vor ein Mikrofon setzen und ihr Wissen diktieren.

## Reiners Rolle — Update 16.04.2026

Reiner arbeitet ausschließlich auf Papier. Kein CAD, kein Solid Edge, kein Fusion — will auch keins. Das ist kein Problem, das ist eine Arbeitsteilung:
- **Reiner = Kopf.** Denkt Lösungen, kennt Kunden, generiert Aufträge. 30 Jahre Erfahrung.
- **Sebastian + KI = Rest.** Konstruktion in Fusion 360, Ableitung, Stückliste, PDF, Versand.
- **Ziel:** Reiners Körper wird so wenig wie möglich beansprucht. Sein Kopf denkt, alles andere läuft automatisch.

## Digitales Reißbrett für Reiner — Analyse und Entscheidung (16.–17.04.2026)

**Problem:** Reiners Papier-Skizzen vom Kunden sind nicht zugänglich und gehen verloren.

**Lösung:** E-Ink-Gerät mit echtem Digitizer + Stylus. Fühlt sich an wie Papier, kein Bildschirm-Leuchten, Skizzen landen automatisch als PDF in geteiltem Ordner. Claude liest Bemaßungen per Vision aus. Sebastian konstruiert in Fusion 360 auf Basis der ausgelesenen Parameter.

### Wichtige Hardware-Erkenntnis — nicht jedes E-Ink-Gerät taugt

**Kritischer Unterschied zwischen E-Readern und E-Notes:**
- **Reine E-Reader** (z.B. PocketBook Verse Pro, Kindle Basic, Kobo Clara) haben nur **kapazitiven Touchscreen** — wie ein Smartphone. Keine Stiftdruck-Erkennung, kein Wacom-Layer. Jeder Stift verhält sich wie ein Finger. **Untauglich für Skizzen**, auch mit Custom-Firmware (KOReader etc.).
- **Echte E-Notes** (z.B. PocketBook InkPad One, InkPad X Pro, reMarkable, Supernote, Onyx Boox Note) haben einen **separaten Digitizer unter dem Display** — erkennt ausschließlich Stifteingabe, Druck, Neigung, Handballen-Ablage funktioniert.

**Umprogrammieren eines reinen E-Readers zum Skizzen-Gerät geht nicht.** Die Hardware fehlt, keine Software kann das kompensieren.

### Geräte-Kandidaten für Reiners Skizzen-Gerät

| Gerät | Preis | Schreibgefühl | Besonderheit |
|---|---|---|---|
| **PocketBook InkPad One** | ~320€ | OK | 10,3", Linux, Wacom-Stylus 2 dabei, PDF+DRM, PocketBook Cloud |
| **reMarkable Paper Pro** | ~580€ | Sehr gut | 11,8" Farb-E-Ink, Hintergrund-Licht, Premium-Schreibgefühl |
| **Supernote A5 X2** | ~500€ | Sehr gut | 10,3", verschachtelte Notizbücher, von Konstrukteuren bevorzugt |
| **reMarkable 2** | ~400€ | Sehr gut | 10,3" S/W, klassische Variante, keine Farbe |

**Empfehlung:** PocketBook InkPad One als Einstieg (~320€) — reicht technisch für unseren Use-Case (Skizzen + Bemaßungen + PDF-Export). Schreibgefühl laut Reviews schlechter als reMarkable, aber akzeptabel. Wenn Budget da ist und Reiner täglich damit arbeitet: reMarkable Paper Pro als Premium-Variante.

### Entscheidung (17.04.2026)

**Arbeitsteilung auch hardwareseitig:**
- **Reiner** → PocketBook InkPad One oder reMarkable Paper Pro (mit echtem Stylus, für Skizzen/Bemaßungen beim Kunden)
- **Sebastian** → PocketBook Verse Pro (bereits vorhanden, als Fokus-Reader für Fachbücher, Normen, technische PDFs, Referenz am Drucker)

**Verse Pro ist nicht untauglich — nur nicht fürs Reißbrett:** Weiterhin sinnvoll als Lese-Gerät (Klipper-Docs, Octopus-Pinout, Obsidian-Notizen als PDF export, wasserdicht am Drucker).

## Mögliche Ansätze

1. **Indirekt:** Sebastian fragt Sabine bei konkreten Aufgaben um Hilfe → dokumentiert die Antworten im Gehirn. Kein formelles "Wissenstransfer-Projekt", sondern im Arbeitsalltag mitschreiben.

2. **Über Reiner:** Reiner bittet Sabine, Zeichnungsvorlagen und Checklisten zu erstellen. Nicht als KI-Projekt, sondern als "Dokumentation für den Übergang".

3. **Reverse Engineering:** Sabines fertige Zeichnungen als Vorlagen nehmen und die Regeln daraus ableiten. Claude analysiert die Zeichnungen und extrahiert die Muster.

## Zeitfenster

Bis Ende August 2026 — ca. 4 Monate.

## Verknüpfungen

- [[02 Projekte/WEC Neustart mit Reiner/WEC Neustart mit Reiner]]
- [[03 Bereiche/WEC/WEC Vision - Automatisierte Pipeline]]

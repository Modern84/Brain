---
tags: [projekt, handover, claudecode]
date: 2026-04-18
---

# Handover an Claude Code — Drei Abschluss-Aufgaben 2026-04-18

> Claude Code war heute in Bestform. Drei Aufgaben ohne Mo-Rückfragen, alle mit echtem Pilot-Wert. Mo kann den Prompt unten kopieren und einfügen.

---

## Prompt für Claude Code

```
Drei Abschluss-Aufgaben für heute — alle ohne Mo-Rückfragen 
durchführbar, alle hochwertig.

Qualität vor Breite. Wenn eine Aufgabe länger braucht als 15 Minuten: 
stoppen, Zwischenstand melden, Rest für morgen lassen.

=== AUFGABE A: ProForge5-Session vorbereiten ===

Laut Vorsortierung sind 22 Dateien ProForge5-relevant. Die nächste Session 
(Session 2) wird sie migrieren. Bereite sie so vor, wie wir es für Bens 
gemacht haben:

1. Prüfe ob 02 Projekte/ProForge5 Build/ existiert oder eine einzelne .md ist.
   Falls einzelne Datei: schlage Umwandlung in Ordner vor — mit vorhandener 
   .md als Hauptdatei und Unterstruktur für Rohdaten.

2. Vorgeschlagene Unterstruktur analog zum WEC-Schema:
   - Firmware/ (P5FW_aktuell, P5FW_alt, firmware.bin, Repo-Snapshots)
   - Referenzmodelle/ (Proforge4_Referenzmodell, Proforge Display Case.3mf/stl)
   - Konfiguration/ (backup-mainsail*.json, ProForge 300/4.1 orca_printer, 
     ProForge5_CAN-Bus_Setup_*.md, config-20260320-131253.zip)
   - Logs & Testprints/ (logs-20260322-110833.zip, Z-OffsetTest_0.30mm.stl, 
     print_history.csv, LDC_CALIBRATE_DRIVE_CURRENT.textClipping, Docking 
     Bracket.3mf)
   - oder flacher — entscheide nach Datei-Beziehungen, nicht nach 
     künstlichem Schema

3. Sonderfrage — die drei Transkripte:
   - EBB36_Gen2_Review_Transcript.txt
   - FirstLook_Bigtreetech_EBB_GEN2_Transcript.txt
   - FromTheBench_Episode2_U2C_CAN_Transcript.txt
   
   Sind das projekt-spezifische ProForge5-Logs oder eher Klipper/Hardware-
   Referenzmaterial? Schau auf den ersten 30 Zeilen jeweils rein und 
   entscheide: ins Projekt oder nach 04 Ressourcen/Klipper/.
   Keine Verschiebung jetzt, nur Vorschlag in der Vorsortierung.

4. md5-Check auf die Firmware-Duplikate:
   P5FW_aktuell_2026-03-19.zip vs P5FW_alt_2026-03-19.zip — wir haben die 
   bei Phase 2d als „versioniert beide behalten" markiert. Kurz 
   bestätigen dass md5 wirklich verschieden ist und die größere neuer.
   firmware.bin (42 KB) — was ist das? Header prüfen mit file- oder 
   xxd-Command.

5. Schreibe 02 Projekte/Mac Inventur - Handover ProForge5 Session.md 
   im gleichen Stil wie die existierende Phase-3-Handover-Notiz.
   Prompt-Block für Claude Code, fertig zum Kopieren.

6. Vorsortierungs-Notiz aktualisieren:
   Bei den 22 ProForge5-Dateien konkrete Zielpfade eintragen 
   (Spalte „Zielpfad" oder in Begründung).

=== AUFGABE B: Rest/Unklar-67 tiefer analysieren ===

Die Vorsortierung hat 67 Dateien als „Rest/Unklar" — das ist der größte 
unklare Block. Tiefere Analyse macht Session 6 (Rest) viel schneller.

Für jede der 67 Dateien folgende Metadaten ermitteln:

1. Dateityp per file-Command (echte Erkennung, nicht nur Extension)
2. 0-Byte-Dateien identifizieren (können direkt als „weg" vorgeschlagen werden)
3. Erstelldatum vs. letztes Zugriffsdatum
4. Download-Quelle aus kMDItemWhereFroms (macOS-Metadaten) falls vorhanden:
   mdls -name kMDItemWhereFroms "DATEI" 2>/dev/null
   Das verrät oft die Herkunft (URL) — sagt viel über Bedeutung
5. Hash-Namen-Muster erkennen (UUID, Base64, Zufalls-Hash = meist Müll-Kandidaten)

Schreibe eine erweiterte Tabelle nach:
02 Projekte/Mac Inventur - Rest Dateien Tiefenanalyse.md

Spalten: Dateiname | echter Typ | Größe | Alter | Herkunft-URL | 
Neuer Vorschlag | Begründung

Neue-Vorschlag-Kategorien (granularer als vorher):
- weg (sicher Müll)
- weg (online verfügbar, wenn nötig neu)
- prüfen-dann-weg (wahrscheinlich Müll, kurzer Check)
- eigentlich Thema X (neue Zuordnung)
- echter Einzelfall (Mo muss entscheiden)

In der Vorsortierung am Ende einen Hinweis ergänzen:
„Rest-Detailanalyse → [[Mac Inventur - Rest Dateien Tiefenanalyse]]"

=== AUFGABE C: Skill „Session-Handover an Claude Code" ===

Das Muster das wir heute mehrfach gebaut haben (Handover-Prompt aus 
claude.ai an Claude Code in Markdown-Form) ist ein eigenständiger Skill.

Lege an: 04 Ressourcen/Skills/Skill - Session-Handover an Claude Code.md

Nach existierender Vorlage [[_Vorlage Skill]]:

- Was das ist: ein wiederverwendbares Muster für die claude.ai → Claude 
  Code Übergabe. Markdown-Datei im Gehirn mit Prompt-Block den Mo 
  kopiert, kein flüchtiger Chat-Text.

- Wann anwenden: wenn eine Aufgabe so groß ist, dass sie einen neuen 
  Claude-Code-Kontext braucht (nach Compact, bei Session-Wechsel, bei 
  klarer Arbeitsteilung Planung/Ausführung)

- Wie (Kurzanleitung): 
  * Struktur der Handover-Datei (Frontmatter + Kontext laden + Aufgabe 
    + Regeln + „Nach Abschluss")
  * Speicherort-Konvention: 02 Projekte/<Projekt> - Handover <Kontext>.md
  * Prompt-Block in ```-Fences für sauberes Kopieren
  * Was Claude Code zuerst lesen soll (CLAUDE.md, Projektdatei, Kontext)
  * Explizite Regeln mitgeben (LRS, Frage-Gegenfrage, Pilot-Charakter)

- Stand: beherrscht (mehrfach angewendet heute)

- Abhängigkeiten: [[Skill - Obsidian Brain pflegen]], CLAUDE.md existent

- Lessons Learned (aus heute):
  * Claude Code fragt zurück bei Regelkonflikten — gut. Im Prompt 
    explizit sagen „Bei Unklarheiten stoppen und fragen"
  * Zielpfade müssen VOR Prompt-Bau verifiziert werden (WEC-Pfad 
    war „Volker Bens" nicht „Bens")
  * Lange Aufgaben in Blöcke mit Abbruch-Kriterium aufteilen 
    („wenn mehr als X Minuten: stoppen")
  * Am Ende explizit „Zusammenfassung zeigen" fordern — sonst fehlt 
    die Rückkopplung an Mo

Beispiel-Links:
- [[02 Projekte/Mac Inventur - Handover Claude Code]] (erste Version)
- [[02 Projekte/Mac Inventur - Handover Phase 3 Vorsortierung]] 
- (nach Fertigstellung) [[02 Projekte/Mac Inventur - Handover ProForge5 Session]]

Skills.md-Index entsprechend aktualisieren: neuer Eintrag unter 
Kategorie „Arbeitssystem".

=== ALLGEMEINE REGELN ===

- Keine Datei in Mac-Inventur LÖSCHEN oder VERSCHIEBEN — alle Aufgaben 
  sind Analyse/Vorbereitung, nicht Ausführung.
- Nichts in raw/ schreiben.
- Bei Rückfragen die Mo-Input brauchen: stoppen und dokumentieren 
  welche Info fehlt.
- Frontmatter auf jeder neuen Datei korrekt setzen.

=== NACH ABSCHLUSS ===

Finale Bilanz mit drei Abschnitten:
- Was erledigt (pro Aufgabe stichpunktartig)
- Was nicht erledigt und warum
- Empfehlung: Was wäre als Nächstes sinnvoll (eine Zeile)
```

---

## Verknüpfungen

- [[02 Projekte/Mac Inventur]]
- [[02 Projekte/Mac Inventur - Handover Claude Code]]
- [[02 Projekte/Mac Inventur - Handover Phase 3 Vorsortierung]]
- [[02 Projekte/Mac Inventur - Phase 3 Vorsortierung]]

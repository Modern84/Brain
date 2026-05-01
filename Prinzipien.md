---
tags: [kontext, prinzipien, regeln]
status: aktiv
date: 2026-04-29
---

# Prinzipien — Operations-Grundregeln

Kondensierte Grundregeln für die Zusammenarbeit zwischen Mo, claude.ai und Claude Code. Ergänzt [[CLAUDE]] (dort: Trigger-Wörter, Räume, Vault-Struktur, Zusammenarbeits-Regeln 13–16).

## Kern-Regeln

### Kein Raten
100 % Sicherheit, 0 % Fehler nach außen. Keine Antwort aus dem Gedächtnis, keine Hypothese als Fakt. Bei Unsicherheit: Brain lesen, CC-Test laufen lassen, **eine** konkrete Rückfrage. Nie zweimal hintereinander im Kreis raten. Beim Schreiben einer Antwort merken „ich rate" → sofort stoppen und nachschauen.

### Befehlsadressat-Kennzeichnung
Jeder Befehl/Code-Block bekommt einen Präfix: `**CC-Auftrag:**`, `**In Mainsail-Konsole:**`, `**SSH direkt:**`, `**Im Browser bei [URL]:**`. Mo darf nie raten müssen, wohin der Befehl geht. Ohne Kennzeichnung = Fehler.

### Anti-Vertagung
Wenn Mo physisch am Drucker/Pi steht: alles jetzt erledigen, nie auf morgen verschieben. Firmware-Fehler entdeckt → sofort fixen und nachflashen. Workarounds sofort dokumentieren — undokumentierte Workarounds werden zu Zeitbomben.

### Tiefen-Recherche-Pflicht vor Empfehlung
Vor finaler Architektur-/Roadmap-Empfehlung: Constraints klären (siehe Regel 13 in [[CLAUDE]]), CC-Faktencheck (Regel 15), offizielle Quellen prüfen (Klipper-Doku, BTT-GitHub, MakerTech). Web-Recherche ohne Realdaten-Abgleich = Hypothese, nicht Empfehlung.

### Daily-Note-Verkettung bei Wert-Edits
Bevor ein Wert in `variables.cfg`, `printer.cfg` oder einer Brain-Datei geändert wird, der bereits dokumentiert ist: **alle Daily-Notes ab dem Mess-/Setz-Datum lesen, nicht nur das Mess-Datum selbst.** Werte werden iterativ korrigiert (Beispiel zero_select_x: 26.04. -90 gemessen → 27.04. auf -99 erprobt). Wer nur das früheste Note liest, überschreibt fremde Korrekturen. Verankert nach Vorfall 2026-04-30.

### Sleep-Check ab 01:00
Ab 01:00 Mo-Zeit aktiv prüfen ob die Session weitergehen soll. Müdigkeit + Forensik-Themen + Hardware-Wert-Edits sind eine Risiko-Kombination. Nicht warten bis Mo selbst Stop sagt — claude.ai schlägt Pause vor wenn (a) Uhrzeit nach 01:00, (b) heute schon ein abgefangener Brain-Fehler oder Crash, (c) nächste Aktion irreversibel oder hardware-relevant ist.

### Constraint-First — auch bei kleinen Aufträgen
Nicht nur bei Architektur-Empfehlungen (Regel 1 in CLAUDE.md). Auch bei scheinbar einfachen Aufträgen (Slicer-Setup, Tool installieren) zuerst fragen: "Was ist seit der letzten Session in diesem Raum offen oder blockiert?" Beispiel 30.04.: Servo-EMI-Crash-Klasse war 36 h vor Slicer-Setup dokumentiert, hätte direkt zum Single-Tool-Constraint geführt. Stattdessen kam der Constraint erst über Brain-Lese-Pfad — vermeidbarer Umweg.

### CC-Faktencheck VOR Empfehlung (Regel 17)
Bei jeder Hardware-/Architektur-/Migrations-Empfehlung: claude.ai entwickelt These → CC verifiziert mit Hardware-Realität (Brain + Pi-Status) BEVOR finale Empfehlung formuliert wird. Empfehlungen ohne CC-Faktencheck sind explizit als „Hypothese" zu labeln, nicht als „Empfehlung". Verschärfung von Regel 15.

### Konkrete Verifikations-Kriterien (Regel 18)
Statt vager Zeitfenster („24h Stabilphase") konkrete Akzeptanzkriterien. Beispiele: „0 ENOBUFS während 20-Min-Druck", „FIRMWARE_RESTART übersteht ohne can1-Manual-Up", „Pi-Reboot bringt System ohne manuelle Schritte zurück". Wenn ich „24h beobachten" oder ähnliches schreibe — sofort umformulieren.

### Realitäts-Check vor Plan (Regel 19)
Bei jedem „wir machen jetzt X"-Auftrag: dreifacher Realitäts-Check BEVOR Plan vorgeschlagen wird:
1. Brain-Status (was ist dokumentiert?)
2. CC-Status (was ist Live-Realität auf Pi/Drucker?)
3. Sebastian-Energie (Aufgabe realistisch im aktuellen Zeit-/Müdigkeits-Kontext?)

Wenn Realitäts-Check zeigt „unrealistisch": ehrlich sagen statt durchziehen.

### Drucker-Physische-Realität via Sebastian (Regel 20)
Bei Druck-/Tool-/Mechanik-Themen NIEMALS aus Klipper-Status ableiten was physisch ist. Pflicht-Fragen vor Druck-Operationen:
- Welches Tool hängt am Schlitten? (oder leer?)
- In welchem PH ist welches Material?
- Servo-Position visuell?
- Bett sauber?

Sebastians visuelle Antwort > Klipper-Status.

### Filesystem-MCP-Fallback (Regel 21)
Wenn Filesystem-Tool timeoutet oder hängt: nicht nochmal versuchen, sondern sofort auf CC-Pasting umschwenken (CC liest, pasted Inhalte). Nicht so tun als wäre Filesystem verfügbar wenn es nicht ist.

### Slicer-/Druck-Vorbereitung als eigene Phase (Regel 22)
„Test-Druck machen" ist nie ein 10-Min-Auftrag. Standard-Aufwand:
- Slicer-Vorbereitung: 15–30 Min
- Drucker-Setup: 5–10 Min
- Druck: 15+ Min
- Beobachtung + Doku: 10 Min

Bei „Test-Druck"-Anfrage zuerst klären: fertige Datei vorhanden? Wenn nein: Slicen ist eigene Phase, möglicherweise nicht jetzt.

## Querverweise

- [[CLAUDE]] — Trigger-Wörter, Räume, Vault-Regeln, Zusammenarbeits-Regeln (13–16)
- [[00 Kontext/Claude Code - Brain Context]] — Handover für Claude Code
- [[04 Ressourcen/Playbook/Claude Code — Meta-Regeln]] — kondensierte Regeln aus früheren Piloten

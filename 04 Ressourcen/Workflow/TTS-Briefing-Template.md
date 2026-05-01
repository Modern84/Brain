---
tags: [workflow, ai, tts, audio, briefing]
status: aktiv
date: 2026-04-29
---

# TTS-Briefing-Template — Audio-Zusammenfassungen für Pendelfahrt

Bewährt 2026-04-29: knappe Sätze, Erzähl-Tonfall, keine Aufzählungen mit harten Pausen. Ergebnis war TTS-tauglich, ~2:20 Sprechzeit.

## Standard-Prompt-Skelett

Fasse [TOPIC] zusammen. Sprich auf Deutsch in natürlichem Erzählstil, als wärst du ein Kollege der Sebastian auf dem Weg zur Arbeit informiert. Tonfall sachlich, knappe Sätze, keine Floskeln, keine euphorischen Übertreibungen.

Erzähl in dieser Reihenfolge:
- Erstens: [WAS PASSIERT IST, chronologisch]
- Zweitens: [WICHTIGSTER BEFUND mit Zahlen]
- Drittens: [AKTUELLER STATUS]
- Viertens: [WAS NOCH ZU TUN IST kurzfristig]
- Fünftens: [WAS LÄNGERFRISTIG WARTET]
- Schluss: [STRATEGISCHE EINORDNUNG, ein Satz]

Halte die gesamte Audio-Länge unter zweieinhalb Minuten. Sprich flüssig, ohne harte Aufzählungs-Pausen. Erzähl es so wie ein Kollege im Auto den Stand zusammenfassen würde.

## Stil-Regeln (was funktioniert hat)

- Zahlen ausschreiben für TTS-Aussprache (fünftausend statt 5000)
- Keine Markdown-Formatierung im Output (keine **, ##, -)
- Konkrete Daten und Zeitstempel einbauen, kein Generisches
- Keine Floskel-Schlüsse wie „ich hoffe das hilft"
- Pendel-Kontext direkt ansprechen (Fahrt zur Arbeit, etc.)

## Verwendung

Topic + Datenpunkte einsetzen, Prompt an Gemini Audio oder ähnliches TTS-System geben. Bei längeren Themen Inhalt auf 5 Punkte aggregieren, nicht alle Details in den Prompt ziehen.

## Verknüpfungen

- [[CLAUDE]] für Trigger-Wörter
- [[00 Kontext/Schreibstil]] für Kommunikations-Standards

---
tags: [projekt, wec, workflow, idee]
date: 2026-04-17
status: zur-diskussion
für: [Sebastian, Reiner]
---

# Idee — Audio-Workflow für Sebastian und Reiner

## Der Kerngedanke

Sebastian und Reiner nehmen **auditiv und visuell** besser auf als über Text. Das Gefühl wie etwas gesagt wird, Rhythmus, Pausen, Betonung — das trägt Information die in Buchstaben verloren geht. Lange Texte, Tabellen und Normwerke bremsen beide aus, obwohl sie inhaltlich klarkommen würden.

Beide haben dieselbe Arbeitsweise beim tiefen Denken: **Augen zu, Kopf sortieren, laut reden**. Sebastian beim Diktieren, Reiner beim Konzentrieren. Das ist kein Zufall, das ist ein geteiltes Betriebssystem.

## Die Vision

**Morgendliches Audio-Briefing.** Claude erstellt jeden Morgen eine gesprochene Zusammenfassung: Was ist offen, was hat sich geändert, welche Einschätzungen gibt es für anstehende Entscheidungen. Sebastian und Reiner hören das zusammen beim Kaffee — oder jeder für sich auf dem Weg zur Arbeit — und entscheiden dann wo's langgeht.

Bidirektional: Audio rein, Audio raus. Diktieren statt tippen, hören statt lesen.

## Warum das strategisch wichtig ist

Das ist nicht nur Komfort. Das ist eine Stärke die aus einer vermeintlichen Schwäche wird:

- **Sebastian hat LRS** — jedes geschriebene Wort ist Arbeit gegen das eigene Gehirn. Sprechen ist flüssig.
- **Reiner ist kein Text-Mensch** — 30 Jahre Konstruktion im Kopf, aber Lesen langer Tabellen ermüdet.
- **Beide haben ein Gespür** für Qualität, Echtheit, Risiko. Dieses Gespür aktiviert sich über Ton und Stimme anders als über Text.
- **Gemeinsames Hören** statt getrennter Lektüre schafft geteilten Kontext — Grundlage für gute Entscheidungen zu zweit.

Wenn das funktioniert, arbeiten Sebastian und Reiner in ihrem natürlichen Modus. Das macht schneller, besser, stabiler.

## Was heute schon geht

**Schritt 0 — sofort einsetzbar:**

- **macOS Vorlesefunktion** (Rechtsklick auf markierten Text → Sprachausgabe starten). Deutsche Stimmen sind brauchbar, nicht schön aber funktional.
- **macOS Diktierfunktion** läuft bei Sebastian bereits stabil — das ist die "Eingangsseite"
- **iOS Diktierfunktion** auf dem iPhone ist exzellent, unterwegs die beste Option

**Schritt 1 — nächster Schritt, geringer Aufwand:**

Jeden Morgen schreibe ich ein kurzes Briefing als Datei `05 Daily Notes/Briefing-YYYY-MM-DD.md` — Claude-Einschätzung zu offenen Projekten, Tagesempfehlung, wichtige Termine, Warnsignale. Du markierst den Text, macOS liest vor. Eine Woche testen ob das Format sitzt.

## Wenn Schritt 1 hält — Ausbau

**Schritt 2 — bessere Stimmen:**

- **ElevenLabs** oder **OpenAI Text-to-Speech** — klingen fast menschlich, deutsche Stimmen sehr gut
- Kostet monatlich etwas, aber im Rahmen
- Ein kleines Skript auf dem Mac liest die Briefing-Datei und erzeugt eine MP3

**Schritt 3 — automatisierter Sync:**

- Briefing landet automatisch als MP3 auf iPhone (iCloud Drive oder Shortcut)
- Sebastian und Reiner hören es unabhängig voneinander
- Auto-Generierung nachts um 5 Uhr, fertig beim Aufstehen

**Schritt 4 — Rückweg:**

- Sebastian/Reiner diktieren Reaktion auf Briefing als Audio
- Whisper (lokal oder API) transkribiert
- Claude sortiert die Gedanken ins Gehirn ein
- Eingang wächst nicht mehr durch Tippen, sondern durch Reden

## Konkrete Fragen für Reiner

Ob das überhaupt für euch beide passt, hängt von Reiners Rückmeldung ab:

1. **Passt das Konzept "gemeinsam Audio hören" zu Reiners Alltag?** Oder lieber jeder für sich, asynchron?
2. **Wann ist der beste Zeitpunkt?** Morgens vor der Arbeit, mittags als Pausenbriefing, abends als Tagesrückblick?
3. **Wie lang darf's sein?** 2 Minuten knackig? 5 Minuten mit Details? Variable Länge je nach Tag?
4. **iPhone-Frage:** Hat Reiner ein iPhone? Dann ist iOS die bessere Diktier- und Hörplattform als Windows.

## Technische Vorarbeit die schon steht

Was für diesen Workflow bereits da ist und nicht neu gebaut werden muss:

- Obsidian-Vault als zentrale Wissensbasis — hier steht alles was ins Briefing einfließt
- Daily Notes sauber strukturiert — Claude weiß jeden Morgen was gestern war
- TASKS.md als offene-Punkte-Quelle
- Claude Filesystem-Connector — direkter Schreib- und Lesezugriff auf das Gehirn
- Claude Code auf dem Mac für Skripte und Automatisierung

Heißt: Das Gerüst steht. Der Audio-Workflow wäre eine **zusätzliche Ausgabe-Schicht**, nicht ein neues System.

## Risiken und offene Fragen

- **Stimmenqualität** — macOS-Stimmen sind steif. Eine Woche damit testen, dann bewerten.
- **Datenschutz bei TTS-Diensten** — ElevenLabs und OpenAI hosten in USA. Bei Kundendaten Vorsicht, bei internen Briefings unkritisch. Später zu klären.
- **Reiner als Mithörer** — wenn das Konzept für Reiner nicht passt, macht Sebastian das allein. Kein Problem, aber dann reduziert sich der Nutzen.
- **Windows-Seite** — Reiner ist aktuell auf Windows. Die Apple-Strategie (→ [[01 Inbox/Idee - Apple-Strategie für WEC und MThreeD.io]]) entscheidet ob sich das langfristig ändert.

## Verbindung zum größeren Plan

Das hängt zusammen mit:

- **Apple-Strategie** → wenn Reiner auf Apple umsteigt, wird der Audio-Workflow reibungslos
- **Reiners Wissen sichern** → Audio-Diktate von Reiner sind oft reichhaltiger als seine getippten Notizen. Systematisches Abgreifen über Audio könnte 30 Jahre Erfahrung ins Gehirn bringen.
- **WEC-Kundenarbeit** → Briefings zu Kundenkommunikation, Warnsignalen, anstehenden Angeboten hört man besser als man sie liest

## Verknüpfungen

- [[00 Kontext/WEC Kontakte/Profil Reiner]]
- [[00 Kontext/Über mich]]
- [[01 Inbox/Idee - Apple-Strategie für WEC und MThreeD.io]]
- [[02 Projekte/WEC Neustart mit Reiner/Konzept Zwei Gehirne]]

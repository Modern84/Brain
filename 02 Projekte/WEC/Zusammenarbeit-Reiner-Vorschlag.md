---
typ: vorschlag
empfaenger: Reiner
thema: Zusammenarbeit mThreeD.io <-> WEC
stand: 2026-04-21
status: entwurf-zur-diskussion
---

← zurueck zum [[03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/_INDEX|Projekt-Landing-Pad]]

# Zusammenarbeit mThreeD.io und WEC — Vorschlag

**Stand: 2026-04-21 — Entwurf zur Diskussion, nichts festgelegt**

## Worum es geht

Die Lagerschalenhalter-Lieferung fuer Volker Bens hat in dieser Session gezeigt, 
wo unsere bisherige Zusammenarbeit Friktion hat: Status unklar, mehrfache 
Rueckfragen "wo stehen wir?", Dateien an verschiedenen Orten, Versionen 
driften auseinander.

Vorschlag fuer einen tragfaehigeren Arbeitsmodus — basierend auf dem Muster, 
das wir heute praktisch getestet haben.

## Das Muster

### Ein Einstiegspunkt pro Projekt

Jedes Projekt bekommt eine einzige Datei: `_INDEX.md`. Darin steht:

- Was das Projekt ist
- Wer beteiligt ist
- Was aktueller Stand ist
- Wo alle Dateien liegen
- Was als Naechstes zu tun ist
- Welche Entscheidungen gefallen sind (mit Datum)

Pilot fuer Lagerschalenhalter Volker Bens existiert bereits — 14 Artefakte 
sauber verlinkt, in 30 Sekunden erfassbar.

### Arbeitsteilung wie sie sich ergibt

- **Mo**: Pipeline, Scripts, Paket-Build, Aussen-Kommunikation
- **Reiner**: Konstruktion, CAD-Datenhoheit, fachliche Korrektheit
- **Gemeinsam**: Entscheidungen zu Kundenanforderungen, Qualitaetsfragen, 
  Lieferfreigabe

### Bruecke zwischen beiden Arbeitsplaetzen

- Du bekommst bei jedem Sync ein Paket (ZIP) mit: dem aktuellen Landing-Pad 
  fuer das Projekt, allen relevanten Dateien, einem Delta-Report (*"was hat 
  sich seit letztem Sync geaendert"*)
- Du arbeitest auf deinem PC an den Fusion-Daten
- Rueckflow von dir zu mir: neue Dateien in vereinbarten Ordner, plus eine 
  kurze Notiz im Landing-Pad
- Keine Mail-Ping-Pong-Runden mehr um Status zu klaeren — Status steht 
  im Landing-Pad

## Was das konkret loesen wuerde

Aus der letzten Session:

- BOM-Master und BOM-Spiegel waren divergent → mit Landing-Pad: genau ein 
  Master-Pfad, dokumentiert, keine Zweifelsfaelle
- "Welcher Stand ist aktuell?" → steht im Landing-Pad, mit Datum
- "Wer hat was zuletzt geaendert?" → Daily Notes + Delta-Report im Sync-Paket
- Kunden-Anforderungen verstreuen sich ueber Mails → eine Entscheidungs-
  Historie im Landing-Pad, chronologisch

## Was noch nicht fertig ist

- Sync-Bruecke (Script `make-reiner-kit.sh`) existiert als Konzept, nicht 
  als Code. Bauen wir wenn du einverstanden bist mit der Richtung.
- Dein Brain-Setup auf deinem PC ist vorbereitet (Vault + Claude Desktop), 
  aber noch nicht fertig uebertragen.
- Manifest-Format fuer "was gehoert in dein Kit" muss gemeinsam definiert 
  werden — du kennst dein Arbeitsumfeld besser als ich.

## Was ich von dir brauche

Kein Ja oder Nein. Schau dir das Muster am Beispiel Volker-Bens-Landing-Pad 
einmal an, wenn wir das naechste Mal persoenlich reden. Entscheide dann, ob 
das fuer dich funktioniert, ob du es anders haben willst, oder ob's komplett 
danebenliegt. Dein Feedback aendert die Architektur, nicht umgekehrt.

## Warum ueberhaupt so viel Struktur

Kurzfristig wirkt das wie Overhead. Mittelfristig ist es die Grundlage fuer 
das, was wir ohnehin zusammen vorhaben: automatisierte Konstruktions-Pipeline. 
Die setzt voraus, dass Projekte deterministisch abrufbar sind — sonst kriegen 
wir sie nie skaliert. Der Lagerschalenhalter-Workflow war der erste echte 
Test. Das Muster hat gehalten. Darauf kann man aufbauen.

---

**Mo**

*mThreeD.io*

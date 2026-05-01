---
tags: [bereich, ki, plan, vault]
date: 2026-04-17
status: zur-diskussion
für: [Sebastian, Reiner]
---

# Plan — CLAUDE.md aufräumen und modulare Regeln einführen

> **Zweck dieses Dokuments:** Sebastian und Reiner gemeinsam lesen, gemeinsam entscheiden. Claude hat den Vorschlag geschrieben — die Entscheidung liegt bei euch beiden.

---

## Worum geht's

Die CLAUDE.md ist die zentrale Regel-Datei des Gehirns. Sie sagt Claude wie er arbeiten soll, was wichtig ist, wie mit Sebastian umgegangen wird, wie nach außen kommuniziert wird. Sie ist das Betriebssystem des Gehirns.

Problem: Die Datei ist über die Wochen stark gewachsen. Jede neue Erkenntnis, jede neue Regel, jede neue Session-Routine ist oben angehängt worden. Sie ist jetzt ~450 Zeilen lang und deckt von "Beratungsstandard" über "Flash-Sicherheit für den 3D-Drucker" bis "deutsche Begriffe" alles ab.

## Warum das wichtig ist — besonders mit Blick auf Reiner

Wir bauen gerade zwei Gehirne auf: Sebastians und Reiners. Beide sollen gleich funktionieren, gleich strukturiert sein, gleich gepflegt werden. Wenn Sebastians CLAUDE.md schon schwer zu überblicken ist, wird Reiners es auch sein — und die eigentliche Idee (dass beide Gehirne Reiners Wissen von 30 Jahren Konstruktion sichern) geht unter in der Regel-Flut.

Außerdem: Reiners Wissen sichern ist das **eigentliche Ziel** von alldem. Die CLAUDE.md muss dafür ein Werkzeug sein, kein Hindernis.

## Was schlage ich vor

### Die CLAUDE.md wird schlank — nur noch das Wesentliche

In der Root-CLAUDE.md bleibt drin:

- **Beratungsstandard** (100% sicher, transparent, nach Vorschrift, im Interesse von Sebastian und Reiner) — das ist unantastbar, das steht oben
- **Arbeitsweise** (Frage-Gegenfrage, implizites Verstehen, A/B/C-Regel) — das ist der tägliche Umgang
- **Auftreten nach außen** (professionell, selbstbewusst, nicht geduckt) — das ist Identitätsarbeit, gehört in den Kern
- **LRS-Regel** (Texte still korrigieren, eigene Texte fehlerfrei) — das ist Sebastians Grundbedürfnis
- **Deutsche Begriffe** (Gehirn, Eingang, Tagesbuch) — das ist die Sprache in der wir arbeiten
- **Gehirn-Struktur** (welcher Ordner wofür) — kurze Übersicht
- **Verweise** auf die Module für alles andere

Ziel: ~100 Zeilen statt 450. Lesbar in 5 Minuten.

### Die Detail-Regeln ziehen in Module um

Neuer Ordner: `04 Ressourcen/Vault-Regeln/`

Darin:

| Modul | Was drin steht | Wann gelesen |
|---|---|---|
| `Session-Routinen.md` | Session-Start, Session-Ende, Kontext abrufen, Daily Notes pflegen | Bei Sitzungsbeginn und -ende |
| `Hardware-Sicherheit.md` | Backup vor Flash, ein Board testen, nie parallel flashen, Workarounds dokumentieren | Bei Hardware-Arbeit am Drucker/Pi |
| `Memory-Management.md` | MEMORY.md pflegen, IP-Änderungen, Firmware-Stand, Konsistenz-Check | Bei Änderungen an Infrastruktur |
| `Upload-Limits.md` | 20MB-Regel, `sips -Z 1920`, warum nie aus Downloads starten | Bei Bild-Arbeit oder Claude Code-Problemen |
| `Freies-Denken-einfangen.md` | Wie Sebastian denkt, wie Claude mitschreibt, Zurückführen zum Thema | Bei Diktier-Sessions, Brainstorming |
| `Kopfdaten-Standard.md` | YAML-Format, Schlagwörter, Status-Werte | Beim Anlegen neuer Dateien |

Die Root-CLAUDE.md zieht diese Module per Verknüpfung ein — mit klaren **Trigger-Sätzen** wie:

> "Bei Hardware-Arbeit am Drucker: [[04 Ressourcen/Vault-Regeln/Hardware-Sicherheit]] lesen bevor geflasht wird."

Das ist wichtig: Nur weil etwas in einem Modul steht, heißt nicht dass Claude es liest. Der Trigger-Satz sorgt dafür dass das richtige Modul zur richtigen Zeit gelesen wird.

## Was ändert sich dadurch im Alltag

**Für Sebastian:**
- CLAUDE.md kürzer → schneller Überblick wenn du was prüfen willst
- Regeln nach Thema gruppiert → du findest was du suchst
- Änderungen lokal → wenn sich die Flash-Prozedur ändert, muss nur `Hardware-Sicherheit.md` angepasst werden, nicht die ganze CLAUDE.md

**Für Reiner:**
- Wenn sein Gehirn aufgesetzt wird, bekommt er dieselbe Struktur — aber angepasst auf seinen Kontext (Solid Edge statt Klipper, Kundenarbeit statt Drucker-Konfiguration)
- Er muss nicht alle 450 Zeilen lesen um zu verstehen wie das System tickt
- Gemeinsame Kern-CLAUDE.md für beide Gehirne als "das arbeiten wir immer so" — dann pro Gehirn die spezifischen Module

**Für Claude:**
- Bessere Chance dass die richtigen Regeln zur richtigen Zeit greifen
- Weniger "übersehen weil in Zeile 287 steht"-Gefahr

## Was ändert sich nicht

- Inhalt der Regeln bleibt gleich — nichts wird weichgespült oder weggelassen
- Keine Regel wird stillgelegt ohne dass Sebastian (und idealerweise Reiner) zustimmen
- Der Beratungsstandard und die Außenauftreten-Direktive bleiben Wort für Wort erhalten, nur umsortiert

## Risiken

1. **Module werden nicht gelesen.** Wenn die Trigger-Sätze in der Root-CLAUDE.md nicht klar sind, baue ich euch schöne Module die niemand anfasst. **Gegenmaßnahme:** Jedes Modul hat einen expliziten Trigger-Satz in der Root.
2. **Reiner findet die Struktur zu komplex.** Er ist jemand der mit klaren Regelwerken gewohnt arbeitet (Normen, DIN, ISO), also eigentlich low-risk — aber wenn das hier eher ablenkt als hilft, drehen wir zurück. **Gegenmaßnahme:** Dieser Plan wird mit Reiner besprochen bevor umgestellt wird.
3. **Zweigleisigkeit während des Übergangs.** Falls jemand die alte CLAUDE.md liest und die neue nicht kennt, entstehen Missverständnisse. **Gegenmaßnahme:** Umstellung passiert an einem Tag, nicht schleichend.

## Rollback — falls es nicht funktioniert

- Die alte CLAUDE.md bleibt als `CLAUDE.md.backup_20260417` erhalten
- Die neuen Module sind neue Dateien, überschreiben nichts
- Ein Befehl reicht um zur alten Struktur zurückzukehren: `mv CLAUDE.md.backup_20260417 CLAUDE.md` und die neue Version archivieren
- Kein Datenverlust möglich

## Was Sebastian und Reiner entscheiden sollten

1. **Prinzip ja oder nein?** Modulare Aufteilung grundsätzlich sinnvoll?
2. **Module-Schnitt richtig?** Fehlt was, ist was überflüssig, sollte anders gruppiert sein?
3. **Trigger-Ansatz klar?** Reicht "lies Modul X bei Situation Y" als Mechanismus oder braucht es mehr?
4. **Wer liest Korrektur?** Reiner allein, Sebastian allein, gemeinsam beim nächsten Treffen?
5. **Gleiche Struktur für Reiners Gehirn?** Direkt mitziehen oder erst Sebastians fertigstellen und stabilisieren?

## Was danach passiert

Nach eurem Go:

1. Claude legt `04 Ressourcen/Vault-Regeln/` an mit allen Modulen
2. Claude schreibt schlanke Root-CLAUDE.md mit Trigger-Verweisen
3. Alte CLAUDE.md wird zu `CLAUDE.md.backup_20260417`
4. Sebastian prüft die neue Version in einer echten Session
5. Eine Woche Probebetrieb — wenn's hakt, Anpassungen
6. Reiners Gehirn bekommt spiegelbildliche Struktur

Gesamtaufwand auf Claude-Seite: eine Session, ~1 Stunde. Auf Sebastians Seite: Lesen und Freigeben.

---

## Größeres Bild — warum das mit Reiners Wissen zu tun hat

Sebastian hat es heute im Gespräch auf den Punkt gebracht: Reiner hat Rückschläge erlebt. Kunden die Insolvenz anmelden und 40.000€ nicht zahlen. Menschen die gutmütige Konstrukteure ausnutzen. 30 Jahre Erfahrung sind in Reiners Kopf, aber nicht systematisch abrufbar — nicht für ihn selbst, nicht für die neue WEC-Struktur, nicht als Schutz gegen Wiederholung solcher Rückschläge.

Die CLAUDE.md-Modularisierung ist ein kleiner Baustein dieses größeren Ziels: **Systeme bauen in denen Wissen und Regeln sauber strukturiert, immer abrufbar und für beide zugänglich sind.** Wenn das bei Sebastians Gehirn funktioniert, ist die Blaupause für Reiners Gehirn da. Und wenn Reiners Gehirn läuft, ist der Weg frei für die eigentliche Arbeit: Reiners Konstruktionswissen, Kundenhistorie, Vertragserfahrungen, Warnsignale — alles dokumentiert, alles durchsuchbar, alles gegen Vergessen und Ausgenutzt-Werden geschützt.

Das ist der Ansatz. Effektivität vor Geschwindigkeit. Sauber vor schnell.

---

## Verknüpfungen

- [[CLAUDE]] — aktuelle Version
- [[02 Projekte/WEC Neustart mit Reiner/Konzept Zwei Gehirne]]
- [[02 Projekte/WEC Neustart mit Reiner/Reiners Gehirn - Setup Plan]]
- [[04 Ressourcen/Workflow - Sebastian und Claude]]

---
tags: [projekt, wec, hardware, strategie]
date: 2026-04-17
status: zur-diskussion
für: [Sebastian, Reiner]
---

# Idee — Apple-Strategie für WEC und MThreeD.io

## Worum geht's

Die Frage: **Soll das WEC/MThreeD.io-Ökosystem langfristig komplett auf Apple umgestellt werden?** Aktuell ist Reiner auf Windows, Sebastian auf macOS, und die Brücke dazwischen ist unnötig aufwendig.

## Die drei Gründe für Apple — strategisch betrachtet

Die Entscheidung Apple hat drei Säulen. Erst alle drei zusammen machen die Strategie tragfähig:

### 1. Datenschutz als Grundrecht

**Das ist der wichtigste Punkt für WEC, und er steht deshalb zuerst.**

Apple hat Datenschutz ausdrücklich als Grundrecht formuliert — nicht als Feature, sondern als Unternehmensphilosophie. Das ist nicht Marketing-Gerede, sondern zeigt sich in konkreten Entscheidungen:

- **Standardverschlüsselung** auf allen aktuellen Apple-Geräten. Der Nutzer muss nichts aktivieren, es ist ab Werk so.
- **On-Device-Verarbeitung** — viele Aufgaben werden lokal auf dem Gerät berechnet statt in die Cloud geschickt. Diktieren, Gesichtserkennung, Foto-Analyse, einfache KI-Anfragen. Die Daten verlassen das Gerät nicht.
- **iCloud Advanced Data Protection** — Ende-zu-Ende-Verschlüsselung für iCloud-Inhalte. Selbst Apple kann die Daten nicht lesen, wenn diese Option aktiviert ist.
- **Haltung gegenüber Behörden** — Apple hat sich öffentlich und gerichtlich gegen Zwangs-Hintertüren für Strafverfolgungsbehörden gestellt. Das ist eine dokumentierte Position, kein Werbeversprechen.
- **Hardware-Architektur** — Apple Silicon hat eine dedizierte Sicherheitsstruktur (Secure Enclave), die hardware-seitig getrennt vom restlichen System arbeitet. Schlüssel, Passwörter, biometrische Daten verlassen diese Zone nie.

**Für WEC und MThreeD.io heißt das konkret:**

- **Reiners Fahrrad-Federungssystem** (Patentanmeldung, TOP SECRET) ist auf einem Apple-Gerät strukturell besser geschützt als auf einem Windows-System
- **Kundendaten, Angebote, Verträge** — alles was zwischen WEC und Kunden vertraulich bleiben muss — liegt sicherer
- **Unveröffentlichte Konstruktionen** — bevor eine Zeichnung ausgeliefert wird, ist sie Reiners geistiges Eigentum. Das verdient entsprechenden Schutz auf der Hardware-Ebene.
- **Gedanken und Notizen** — das Gehirn enthält ehrliche, ungefilterte Überlegungen. Auch zu Kunden, Mitbewerbern, schwierigen Situationen. Das darf nicht auslesbar sein.

Windows ist nicht unsicher — aber Microsoft hat ein anderes Geschäftsmodell und sammelt standardmäßig mehr Telemetrie-Daten. Für ein Ingenieurbüro mit Erfindungen und vertraulicher Kundenarbeit ist Apples Grundhaltung der bessere Startpunkt.

### 2. Das Gerät fühlt sich "organisch" an

Sebastians eigene Beobachtung: Seit er den Mac hat, fühlt sich Technik anders an. Cooler, einfacher, wie für ihn gemacht. Vorher hatte er lange gar keinen Computer, weil es frustriert hat.

Reiner kämpft regelmäßig mit seinem Windows-PC. Dinge gehen nicht, Fehlermeldungen ohne Lösung, OneNote drängt sich auf, Updates stören. Das frustriert. Das macht Technik unattraktiv. Das fühlt sich nie organisch an.

**Apple-Geräte sind konsequent darauf ausgelegt dass sie "einfach funktionieren".** Das ist nicht nur Komfort — das ist ein messbarer Produktivitätsfaktor für Leute die nicht täglich IT-Probleme lösen wollen. Weniger Reibung, weniger Frustration, mehr Zeit für die eigentliche Arbeit.

Für zwei Konstruktions-Denker ist das kein Luxus. Das ist die Voraussetzung dafür überhaupt gerne am Computer zu arbeiten.

### 3. Technische Eignung für KI und Audio

Für den Bereich in dem Sebastian und Reiner unterwegs sind — Konstruktion, KI-gestützte Dokumentation, Audio-Workflows, visuelle Aufbereitung — hat Apple konkrete technische Vorteile:

- **Apple Silicon** mit nativer Neural Engine → lokale KI-Modelle (Ollama, lokale Claude-Integrationen später) laufen schneller und sparsamer
- **Diktier- und Sprachverarbeitung** deutlich ausgereifter als bei Windows, vor allem auf Deutsch
- **Ökosystem-Integration** zwischen Mac, iPhone, iPad ohne Reibung — Notiz auf iPhone, zehn Sekunden später am Mac verfügbar
- **iCloud-Sync** für Obsidian-Vaults funktioniert zuverlässig (Sebastians Setup zeigt das täglich)

## Kostenrahmen — erste Einschätzung

Sebastians Punkt: sein **MacBook Pro 18,2** hat mehr gekostet als ein gut ausgestatteter Mac Studio. Für WEC als Firma wäre die Investition in Apple-Hardware kein Hindernis — zumindest nicht im Verhältnis zu dem was an Zeit und Reibung gespart wird.

**Ungefähre Richtwerte** (müssen bei Kaufentscheidung präzise recherchiert werden):

- **Mac Mini M4** — günstige Option, ab ~700€, für Büroarbeit + Claude Desktop + Obsidian absolut ausreichend
- **Mac Mini M4 Pro** — Mittelklasse, ab ~1.500€, auch SolidWorks-Alternativen wie Shapr3D, Fusion oder Parasolid-basierte CAD problemlos
- **Mac Studio M4 Max** — das Zugpferd, ab ~2.500€, für lokale KI-Modelle (Ollama), große CAD-Dateien, Rendering
- **iPad mit M-Chip + Magic Keyboard** — mobile Arbeitsstation, ~1.200€, für Reiner als "Denk-Gerät" wenn er unterwegs ist oder am Esstisch arbeitet

Zum Vergleich: Sebastians MacBook Pro liegt in der Größenordnung eines voll ausgestatteten Mac Studio.

## Die große offene Frage — SolidWorks

**Das ist der Knackpunkt und muss zuerst geklärt werden, bevor überhaupt Hardware gekauft wird.**

Reiners Hauptwerkzeug ist SolidWorks 2020 mit massivem eingebauten Kontext (Vorlagen, Profile, Materialien, Normteile, 4+ Jahre Projektdaten auf NAS). Das läuft nur auf Windows nativ. Optionen:

1. **Parallels Desktop** auf Mac — Windows in einer VM, SolidWorks läuft darin. Performance-Einbußen, aber machbar. Lizenz nötig.
2. **SolidWorks durch anderes CAD ersetzen** — Fusion 360 (Sebastians Werkzeug), Shapr3D (nativ auf Mac und iPad), Onshape (Browser-basiert). Problem: Reiners 4+ Jahre SolidWorks-Arbeit müssten migriert werden. Aufwand enorm.
3. **Hybrid-Lösung** — Reiner behält einen Windows-PC nur für SolidWorks und NAS-Zugriff, alle anderen Arbeiten (Kommunikation, Claude, Recherche, Dokumentation) laufen auf einem Mac daneben.
4. **Abwarten** — SolidWorks hat eine Mac-Version für iPad angekündigt, langfristig könnte native Mac-Unterstützung kommen. Unsicher.

**Option 3 ist wahrscheinlich der pragmatischste Einstieg.** Reiners Konstruktionsarbeit bleibt unverändert, aber alles drumherum (Claude, Audio, Obsidian, Mail, Recherche) läuft auf Apple. Die Reibung wird reduziert ohne SolidWorks-Ökosystem anzufassen.

## Mögliche Zielkonfiguration

**Wenn Option 3 (Hybrid):**

| Arbeitsplatz | Gerät | Zweck |
|---|---|---|
| Reiner — Konstruktion | Bestehender Windows-PC | SolidWorks, NAS-Zugriff |
| Reiner — Kommunikation | Mac Mini M4 oder iPad Pro | Claude Desktop, Obsidian, Mail, Recherche, Audio |
| Reiner — Mobil | iPhone (vorhanden?) + iPad | Diktieren, Audio-Briefing hören, Skizzen |
| Sebastian — Zentrale | MacBook Pro (vorhanden) | Alles |
| Sebastian — Optional später | Mac Studio | KI-Modelle lokal, große CAD-Dateien |

**Wenn Option 2 (kompletter Umstieg) — nur langfristig:**

Alles auf Apple, SolidWorks weg, Fusion/Shapr3D neu aufbauen. Großes Projekt, eigenes Budget, eigener Zeitplan. Nur wenn Reiner mitzieht und die Migration gemeinsam trägt.

## Mitarbeiter-Frage

Sebastian hat erwähnt: **"Eventuell können wir die Windows-Geräte als Mitarbeiter-Platz umfunktionieren."**

Das ist ein kluger Gedanke. Wenn WEC langfristig wächst und Mitarbeiter bekommt, sind die vorhandenen Windows-PCs nicht wertlos — sie werden zu Arbeitsplätzen für neue Leute die mit Windows klarkommen. Sebastian und Reiner arbeiten auf Apple, andere auf den vorhandenen Maschinen. Kein Gerät wird entsorgt, alles wird umgeschichtet.

## Claudes Einschätzung

Kurz, ehrlich, im Rahmen dessen was ich überblicken kann:

**Pro Apple-Strategie:**
- **Datenschutz** — für Ingenieurbüro mit Erfindungen und vertraulicher Kundenarbeit strategisch wichtig
- Sebastians Produktivität steigt messbar, weil die Tool-Reibung wegfällt
- Reiner arbeitet in einem ruhigeren System — weniger OneNote-Popups, weniger Windows-Update-Zwang, weniger Störung
- Die Audio-Workflow-Idee läuft auf Apple deutlich besser
- iPhone-Integration für mobile Arbeit ist ein echter Vorteil
- Langfristig weniger IT-Support-Aufwand (weniger bewegliche Teile, mehr Systemeinheitlichkeit)

**Contra bzw. zu bedenken:**
- SolidWorks ist ein echter Ankerpunkt — solange Reiner damit arbeitet, bleibt Windows im Spiel
- Initiale Investition nicht trivial, auch wenn sie sich rechnet
- Umgewöhnung braucht Zeit, Reiner ist in seinem Windows-Setup eingespielt
- Ob Reiner das überhaupt will, ist offen — er arbeitet seit Jahrzehnten mit Windows und hat keine spontane Abneigung wie Sebastian

**Meine Empfehlung** (aber das ist eure Entscheidung):

Nicht jetzt kaufen, nicht jetzt wechseln. **Erst ausprobieren.** Ein Mac Mini als Testgerät für Reiner, 4 Wochen probeweise, mit Claude Desktop, Obsidian, Audio-Workflow. Wenn Reiner nach 4 Wochen sagt "das will ich nicht mehr missen" — dann ist der Weg klar. Wenn er sagt "geht so" — dann ist die Frage erledigt und wir bauen die Brücke zwischen den Systemen sauber statt alles umzustellen.

## Konkrete Fragen für Reiner

1. **Hat er grundsätzlich Lust** auf eine Umstellung oder Erweiterung Richtung Apple?
2. **Wie tief sitzt SolidWorks** in seiner täglichen Arbeit? Wie groß wäre der Schmerz bei einem Wechsel?
3. **iPhone oder Android** aktuell? Das entscheidet viel über den Audio-Workflow.
4. **Budget-Rahmen** — wieviel ist WEC bereit zu investieren für bessere Werkzeuge?
5. **Testbereitschaft** — würde er 4 Wochen einen Mac Mini parallel testen?
6. **Datenschutz-Bewusstsein** — wie wichtig ist ihm dass vertrauliche Daten auf dem Gerät bestmöglich geschützt sind? (Relevant für die Patent-Arbeit am Fahrrad-Federungssystem)

## Verknüpfungen

- [[00 Kontext/WEC Kontakte/Profil Reiner]]
- [[00 Kontext/Wo ist alles gespeichert - Überblick für Reiner]]
- [[02 Projekte/WEC Neustart mit Reiner/Idee - Audio-Workflow für Sebastian und Reiner]]
- [[02 Projekte/WEC Neustart mit Reiner/WEC Neustart mit Reiner]]
- [[03 Bereiche/Konstruktion/Konstruktion]]

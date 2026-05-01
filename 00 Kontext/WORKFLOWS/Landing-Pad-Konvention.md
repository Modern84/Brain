---
typ: workflow
gilt-fuer: alle-projekte
eingefuehrt: 2026-04-21
---

# Landing-Pad-Konvention

## Was ist das?

Jedes aktive Projekt bekommt eine `_INDEX.md` im Projekt-Wurzelordner. Diese
Datei ist der **Navigations-Hub**: Wer das Projekt aufnimmt (Claude-Session,
Reiner, Mo in drei Monaten), liest **ausschliesslich** diese Datei und weiss
in 30 Sekunden Stand, Pfade, naechste Aktion.

## Wann wird ein _INDEX gebaut?

- Sobald ein Projekt mehr als 3 Artefakte an verschiedenen Orten hat
- Sobald mehr als eine Session daran gearbeitet hat
- Sobald externe Partner involviert sind (Kunden, Lieferanten)

## Wie wird er gebaut?

1. Template aus `00 Kontext/Templates/_INDEX-Template.md` kopieren
2. Ablegen am Projekt-Wurzelordner als `_INDEX.md` (Unterstrich vorne = sortiert oben)
3. Alle existierenden Artefakte als Wikilinks eintragen
4. YAML-Frontmatter ausfuellen (`typ: projekt-index` ist Pflicht)
5. CC-Verify laufen lassen: alle Wikilinks muessen gegen echte Dateien matchen

## Wie wird er gepflegt?

- **Nach jeder Session** wird die Section "Aktueller Stand" aktualisiert
- **Neue Artefakte** bekommen einen Breadcrumb-Link `← [[_INDEX]]` am Kopf
- **Entscheidungen** kommen in die Historie mit Datum
- `letzte-aktivitaet` und `phase` im Frontmatter wandern mit

## Warum dieses Muster?

Ohne Landing-Pad: jede neue Session braucht 10-15 Minuten um Kontext zu
rekonstruieren, Divergenzen zu finden, Stand zu verifizieren.

Mit Landing-Pad: 30 Sekunden zum Ueberblick, direkt produktiv.

## Pilot

Erster Landing-Pad gebaut: Lagerschalenhalter Volker Bens (2026-04-21).
14/14 Wikilinks verifiziert.

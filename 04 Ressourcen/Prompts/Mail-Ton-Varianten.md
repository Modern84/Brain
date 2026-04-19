---
tags: [ressource, prompt, mail, ton]
date: 2026-04-19
---

# Mail-Ton — Varianten je Empfänger

> **Zweck:** Schnellzugriff auf die drei WEC/MThreeD-Tonalitäten. Beim Mail-Entwurf richtigen Ton wählen bevor Claude schreibt.

---

## Ton-Matrix

| Empfänger | Länge | Einstieg | Ende | Signatur |
|---|---|---|---|---|
| **Reiner (intern)** | sehr kurz | "Reiner," | "Gruß, Sebastian" | Vorname |
| **Volker Bens (Kunde)** | kurz-mittel | "Sehr geehrter Herr Bens," | "Mit freundlichen Grüßen" | Name + WEC-Signatur |
| **Sonstige Kunden** | mittel | "Sehr geehrte Damen und Herren," oder konkret | "Mit freundlichen Grüßen" | Name + WEC oder MThreeD |
| **Behörde** | strukturiert | "Sehr geehrte Damen und Herren," + Aktenzeichen | "Mit freundlichen Grüßen" | Vollname + Adresse |
| **Geschäftspartner / Lieferant** | mittel | "Sehr geehrte/r Herr/Frau [Name]," | "Mit freundlichen Grüßen" | Name + Firma |

---

## Reiner-Ton — Prompt

```
Schreib eine Mail an Reiner. Er weiß was läuft — kein Kontext nötig.

Inhalt: [Worum geht's]

Regeln:
- Max 5 Sätze
- Keine Höflichkeitsformel außer "Gruß"
- Anrede "Reiner,"
- Direkt auf den Punkt
- Wenn Frage: konkret machen, nicht "kannst du mal schauen"
```

---

## Kunden-Ton — Prompt (WEC via Reiner als Absender)

```
Schreib eine Mail an [Kundenname] im Namen von WEC (Reiner = Absender).

Inhalt: [Worum geht's]

Regeln:
- Sehr geehrte/r [Name]
- Klar, strukturiert, selbstbewusst — WIR sind ein Ingenieurbüro
- Keine entschuldigenden Formulierungen ("ich hoffe...", "falls möglich...")
- Absätze trennen bei Themenwechsel
- Signatur: WOLDRICH ENGINEERING + CONSULTING
- Wenn EU-Förderung relevant: Hinweis "Gefördert durch BMWK, kofinanziert von der EU"
- Bei Volker Bens: White-Label beachten (keine WEC-Erwähnung in Anhängen/Zeichnungen)
```

---

## Behörden-Ton — Prompt

```
Schreib eine Antwort an [Behördenname].

Aktenzeichen: [...]
Frist: [...]
Anlass: [...]

Regeln:
- Aktenzeichen in Betreff und Kopfzeile
- Strukturierte Absätze (Sachverhalt → Stellungnahme → Forderung / Frage)
- Selbstbewusst, NICHT defensiv — wir sind im Recht, bzw. klären sachlich
- Nummerierung bei mehreren Punkten
- Fristkonform
- Signatur mit vollständiger Adresse
```

---

## Partner-Ton — Prompt (Geschäftsbeziehung)

```
Schreib eine Mail an [Partner] (Lieferant / Kooperationspartner / Dienstleister).

Inhalt: [Worum geht's]

Regeln:
- Professionell auf Augenhöhe
- Falls erste Kontaktaufnahme: kurzes WIR-Kontext
- Konkrete Anfrage oder Vorschlag
- Deadline wenn relevant ("Ich warte auf Rückmeldung bis [Datum]")
- Keine Bittsteller-Sprache
```

---

## Allgemeine Regeln (gelten IMMER)

**Innen/Außen-Trennung:** Intern darf Sebastian verletzlich/locker sein. Nach außen: selbstbewusst, präzise, klar. Keine Heuchelei — legitime strategische Kommunikation.

**Verbotene Formulierungen nach außen:**
- "Ich hoffe, das passt"
- "Falls es möglich wäre"
- "Tut mir leid zu stören"
- "Wenn Sie Zeit haben"
- "Vielleicht könnten Sie..."

**Ersetzt durch:**
- "Ich bitte um Rückmeldung bis [Datum]"
- "Bitte senden Sie mir..."
- "Für die Bearbeitung benötige ich..."
- "Ich erwarte Ihre Antwort bis..."

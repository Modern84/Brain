---
tags: [bereich, wec, operation, query]
date: 2026-04-17
---

# Operation: Query — Wissen abfragen

> **Zweck:** Wenn Sebastian oder Reiner eine Frage hat, antwortet Claude aus dem **Wiki**, nicht aus dem Raw.

---

## Grundprinzip

**Wiki ist das Gedächtnis. Raw ist das Archiv.**

Bei jeder Frage:
1. Claude liest **zuerst Wiki** (kompiliertes Wissen)
2. Findet eine vollständige Antwort? → antwortet, verlinkt Wiki-Artikel
3. Findet nur Teilantwort? → ergänzt aus Wiki, markiert was fehlt
4. Findet nichts im Wiki? → schaut in Raw, kompiliert neuen Wiki-Eintrag, antwortet

**Niemals direkt aus Raw antworten ohne den Wiki-Eintrag zu erzeugen.**
Sonst geht das Wissen wieder verloren beim nächsten Mal.

---

## Beispielfragen und Routing

| Frage | Wo Claude liest | Wo Claude antwortet aus |
|---|---|---|
| "Was sind Volker Bens' Lieferanforderungen?" | wiki/Kunden/Volker Bens - Profil.md | Wiki direkt |
| "Wie ist Volker zahlungstechnisch?" | wiki/BWL-Filter/* + wiki/Kunden/Volker Bens | beides |
| "Welche Norm gilt für Lebensmittelkontakt?" | wiki/Normen/EHEDG.md | Wiki |
| "Wie hat Reiner das Lager letztes Jahr konstruiert?" | raw/ → kompilieren → wiki | Wiki nach Kompilation |
| "Hat Reiner sowas schon mal gemacht?" | wiki/Standards WEC/* | Wiki |

---

## Wenn Wiki lückenhaft ist

Claude antwortet ehrlich:
> "Im Wiki steht nur X. Im Raw gibt es noch Datei Y, soll ich daraus kompilieren?"

Nie raten. Nie aus Halbwissen antworten.

---

## Spezialfall: Reiner fragt direkt (über sein eigenes Gehirn)

Wenn Reiner über sein Gehirn (T9-Setup, später Mac Mini) eine Frage stellt:
- Claude antwortet **kurz und konkret**
- Visuell wenn möglich
- Kernpunkt früh, Details auf Nachfrage
- Bei BWL-Themen: Claude warnt, lässt Reiner entscheiden

---

## Verknüpfungen

- [[03 Bereiche/WEC/Operationen/Ingest]]
- [[03 Bereiche/WEC/Operationen/Lint]]
- [[03 Bereiche/WEC/wiki/README]]

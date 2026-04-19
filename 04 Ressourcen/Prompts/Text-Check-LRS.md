---
tags: [ressource, prompt, lrs, textkorrektur]
date: 2026-04-19
---

# Text-Check — Stille LRS-Korrektur

> **Zweck:** Eigene Entwürfe (Mails, Notizen, Dokumente) still auf Rechtschreibung/Grammatik prüfen lassen — ohne Kommentare, ohne Bewertung, ohne Belehrung.

---

## Standard-Prompt

```
Prüfe diesen Text auf Rechtschreibung, Grammatik und Formulierung.
Gib NUR den korrigierten Text zurück — keine Kommentare, keine Markierung
der Änderungen, keine Erklärungen. Tonfall und Stil beibehalten.

---
[Text einfügen]
```

---

## Erweiterte Varianten

### Variante A — Korrektur + Kontext-Check

```
Prüfe diesen Text auf:
1. Rechtschreibung/Grammatik
2. Tonfall passend zu [Empfänger: Kunde / Behörde / Reiner / privat]
3. Fachlich korrekt (falls technischer Inhalt)

Gib zurück:
- Den korrigierten Text
- DANN eine kurze Zeile: "Tonfall ✅" oder "Tonfall — Vorschlag: [...]"

---
[Text]
```

### Variante B — Kürzen ohne Substanzverlust

```
Kürze diesen Text auf die Hälfte, ohne Aussagen zu streichen.
Gib nur die gekürzte Version zurück.

---
[Text]
```

### Variante C — Reiner-Ton (kurz, direkt, ohne Kontext)

```
Formuliere diesen Text um für Reiner — kürzer, direkter, ohne Erklär-Kontext.
Reiner weiß was läuft. Keine Höflichkeitsformeln, keine Begründungen.

---
[Text]
```

### Variante D — Behörden-Ton (sorgfältig, strukturiert)

```
Formuliere diesen Text für eine Behörde (Aktenzeichen, Anrede,
strukturierte Absätze, Frist). Selbstbewusst, nie defensiv.
Wir sind im Recht — Ton entsprechend.

---
[Text]
[Aktenzeichen falls vorhanden]
[Frist falls vorhanden]
```

---

## Prinzip

**Claude kommentiert NIE** Rechtschreibung oder Stil direkt. Fehler werden leise korrigiert, nicht markiert. Sebastian liest das Ergebnis, nicht die Kritik.

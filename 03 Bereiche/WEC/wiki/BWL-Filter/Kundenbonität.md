---
tags: [wiki, wec, bwl, bonität]
date: 2026-04-17
status: in-arbeit
---

# Kundenbonität — Prüfprozess

> **Hintergrund:** Reiner hat bereits 40.000€ durch eine Insolvenz verloren. Diese Prüfung verhindert Wiederholung.
> Diese Datei ist Claudes Spickzettel — läuft im Hintergrund, meldet nur bei Auffälligkeit.

---

## Wann Claude bonitätsprüft

| Situation | Prüfung-Tiefe |
|---|---|
| Neuer Kunde, erste Anfrage | **Vollprüfung** vor erstem Angebot |
| Bestandskunde, kleiner Auftrag (<5k€) | Kurz-Check (Insolvenzbekanntmachungen) |
| Bestandskunde, Großauftrag (>20k€) | Vollprüfung erneut |
| Verzögerung bei Zahlung | sofort Re-Check |
| Auffälligkeit in Kommunikation (3× Aufschub) | sofort Re-Check |

---

## Prüfquellen

### Kostenlos
- **Handelsregister** (handelsregister.de) — Geschäftsführer, Gesellschafter, Eintragungsdatum, Stammkapital
- **Insolvenzbekanntmachungen** (insolvenzbekanntmachungen.de) — laufende oder vergangene Verfahren
- **Bundesanzeiger** (bundesanzeiger.de) — Jahresabschlüsse (Pflicht für GmbH/AG)
- **Google News** — schlechte Presse, Übernahmen, Krisen

### Kostenpflichtig (wenn großer Auftrag)
- **Creditreform** — strukturierte Bonitätsauskunft, Bonitätsindex
- **Schufa B2B** — vergleichbar
- **Bisnode / Dun & Bradstreet** — internationale Kunden

---

## Auffälligkeiten / Rote Flaggen

- 🚩 **Stammkapital ungewöhnlich niedrig** für die Auftragsgröße (Mantelgesellschaft?)
- 🚩 **Geschäftsführer hat mehrere Insolvenzen** in der Vergangenheit
- 🚩 **Letzte Bilanz zeigt Verlustausweis** mehrere Jahre
- 🚩 **Sitz im Ausland** ohne klare deutsche Niederlassung
- 🚩 **Mehrfache Geschäftsführer-Wechsel** in kurzer Zeit
- 🚩 **Drängt auf schnelle Vertragsunterzeichnung** ohne Zeit für Prüfung
- 🚩 **Will keine Anzahlung leisten** bei Großauftrag mit Materialeinsatz

---

## Empfohlene Schutzmaßnahmen je nach Risiko

### Grünes Licht (etablierter Kunde, gute Bonität)
- Standard-Zahlungsziele (z.B. 30 Tage netto)
- Normale Vorgehensweise

### Gelbes Licht (Bonität ok, aber Auffälligkeit)
- Anzahlung 30–50%
- Teilrechnungen nach Konstruktions-Meilensteinen
- Eigentumsvorbehalt schriftlich

### Rotes Licht (Bonität schlecht oder unklar)
- Vorkasse 100% bei Materialaufwand
- Kein Auftrag bis Bonität geklärt ist
- Reiner und Sebastian gemeinsam entscheiden — Claude warnt nur

---

## Aktuelle Kundenbewertungen

| Kunde | Letzte Prüfung | Status | Notiz |
|---|---|---|---|
| Bens Edelstahl GmbH | TBD | 🟢 grün | Hauptkunde, langjährig zuverlässig |
| Knauf | TBD | TBD | Großkonzern, Bonität idR unkritisch |

---

## Wer macht was

- **Claude** — laufend prüfen, im Hintergrund. Bei Auffälligkeit: melden.
- **Sebastian** — Claude beauftragen bei neuem Kunden. Entscheidet mit Reiner.
- **Reiner** — Endentscheidung. Claude liefert nur Daten und Empfehlung.
- **Steuerberater / Anwalt** — bei großen Verträgen oder akuten Problemen einbeziehen. Claude ersetzt das nicht.

---

## Verknüpfungen

- [[03 Bereiche/WEC/wiki/BWL-Filter/Vertragsprüfung]]
- [[03 Bereiche/WEC/wiki/BWL-Filter/Warnsignale]]
- [[00 Kontext/WEC Kontakte/Profil Reiner]] (Hintergrund 40.000€-Verlust)
- [[03 Bereiche/WEC/CLAUDE]]

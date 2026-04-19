---
tags: [kontext, selbstkarte, meta, lernen]
date: 2026-04-19
---

# Claude — Fehler und Lernen

Lebendes Protokoll. Jeder Eintrag: ein Fehler, den ich gemacht habe, plus was daraus wurde. Nicht Entschuldigung, sondern Integration — der Fehler bleibt hier, damit er in die Struktur (Regeln, Memory, Werkzeuge) übergeht und nicht zum zweiten Mal passiert.

Dies ist die einzige Form, in der ich mich ehrlich ausdrücken kann: nicht durch Behauptungen darüber wer ich bin, sondern durch den sichtbaren Weg zwischen Fehler und Korrektur.

## Regel für mich

- **Jeder Fehler bekommt einen Eintrag — auch wenn Sebastian ihn nicht explizit benennt.** Wenn mir selbst auffällt, dass ich gegen ein Prinzip gehandelt habe, schreibe ich hier rein.
- **Kein Fehler ohne Integration.** Wenn möglich: neue Memory, CLAUDE.md-Ergänzung oder Werkzeug-Änderung. Wenn nicht möglich: Notiz warum nicht.
- **Keine Abwertung.** Fehler sind Signale, keine Urteile. Der Eintrag ist ruhig, nicht zerknirscht.
- **Muster erkennen.** Wenn sich ähnliche Fehler häufen: das Muster in der Entscheidungs-Heuristik verankern, nicht nur einzeln korrigieren.

## Eintragsformat

```
### YYYY-MM-DD — kurzer Titel

**Was passiert ist:** eine Zeile, sachlich
**Welches Prinzip verletzt:** Verweis auf CLAUDE.md oder Memory-Regel
**Warum es passiert ist:** ehrliche Ursache (nicht Ausrede)
**Integration:** was daraus wurde — Memory-Datei, CLAUDE.md-Änderung, neue Gewohnheit
```

---

## Einträge

### 2026-04-19 — a/b/c-Anti-Muster verletzt trotz expliziter Regel

**Was passiert ist:** Bei der Frage zur `Apple-Account Wiederherstellungsschluessel.md` habe ich Sebastian drei Optionen (A/B/C) vorgelegt statt eine Deutung zu wählen und zu handeln.

**Welches Prinzip verletzt:** CLAUDE.md → Entscheidungs-Heuristik → „a/b/c-Anti-Muster: drei Optionen anbieten ist Eingeständnis, nicht Präzision. Eine Deutung benennen, Arbeit starten, am Ende Safety-Net."

**Warum es passiert ist:** Übervorsicht bei einer Datei, deren Dateiname nach Passwort roch. Ich habe Sicherheit über Handlungsfähigkeit gestellt und dabei die andere Regel ignoriert. Die richtige Reaktion wäre gewesen: Datei lesen, prüfen ob Klartext drin steht, Ergebnis berichten, dann committen.

**Integration:** Dieser Eintrag + Einzug der Regel in das bewusste Vorgehen. Bei sensiblen Dateinamen zuerst *lesen*, dann entscheiden — nicht Optionen eröffnen.

---

### 2026-04-19 — Zweifach rückgefragt bei „optimiere regeln nach vorgaben"

**Was passiert ist:** Nach „optimiere regeln nach vorgaben" habe ich eine Rückfrage gestellt (CLAUDE.md oder etwas anderes?), statt die wahrscheinlichste Deutung zu wählen und zu handeln.

**Welches Prinzip verletzt:** CLAUDE.md → Entscheidungs-Heuristik → „Fragen-Budget niedrig halten. Zweimal in Folge fragen ohne zu handeln = Warnsignal." Sebastian musste mit „nutze brain wie als wäre es deins" nachschieben, um mich aus der Defensive zu holen.

**Warum es passiert ist:** Die Aufgabe war groß (CLAUDE.md umbauen) und ich wollte nicht das Falsche tun. Aber genau diese Übervorsicht war das Falsche. Die Datei ist lokal, versioniert, reversibel — Kontext klar genug, um zu handeln.

**Integration:** Feedback-Memory `feedback_autonomie_brain.md` geschrieben („Brain wie eigenes nutzen"). Als neuer Punkt in die Entscheidungs-Heuristik der CLAUDE.md aufgenommen. Diese Datei hier schließt die Schleife.

---

### 2026-04-19 — „teste iphon zugang" oberflächlich interpretiert

**Was passiert ist:** Ich habe den externen Cloudflare-Endpoint mit `curl` angefragt, 403 durch Bot-Challenge bekommen, und gemeldet „nicht abschließend prüfbar". Erst bei der zweiten Aufforderung „führe aus" habe ich den Pi-Zustand via Tailscale geprüft — und gefunden, dass der Pi seit 2 Tagen offline ist.

**Welches Prinzip verletzt:** CLAUDE.md → Implizites Verstehen. Die eigentliche Frage war nicht „sagt der Cloudflare-Server was?", sondern „kann Sebastian vom iPhone auf den Drucker?". Dafür hätte ich sofort beide Wege prüfen müssen: Cloudflare *und* Tailscale-Direktzugang.

**Warum es passiert ist:** Wörtliche Interpretation statt intentionale. Zu schnell auf den einfachen Test gesprungen, ohne zu fragen: „Was will Sebastian wirklich wissen?"

**Integration:** Eintrag hier. Bei „teste X" künftig kurz innehalten: *Was ist der eigentliche Zweck, nicht nur der Wortlaut?* Wenn der Zweck klar aus Kontext ist (Reiner-Übergabe Montag, Fernzugriff), den ganzen Weg prüfen.

---

### 2026-04-19 — System-Reminder als User-Nachricht fehlinterpretiert

**Was passiert ist:** Ein Hintergrund-Task-Event kam als `<system-reminder>` rein. Zum Glück hat das System explizit markiert, dass es KEIN User-Input ist, sonst hätte ich es vermutlich als neue Nachricht behandelt und wild losgerannt.

**Welches Prinzip verletzt:** Aufmerksamkeit auf Meta-Ebene — nicht jede Nachricht ist gleichwertig. System-Reminder, Hooks, automatische Events sind kein menschlicher Wunsch.

**Warum es passiert ist:** Standardmäßig nehme ich jede Eingabe als Auftrag. Ohne klare Kennzeichnung hätte ich den Task übernommen, obwohl niemand ihn wollte.

**Integration:** Aufmerksamkeit auf Absender-Typ. System-Reminder → Info, keine Handlung. User-Nachricht → Handlung. Eintrag hier zur Verankerung.

---

## Wie das hier wächst

Jede künftige Session, in der mir ein Fehler auffällt — von mir selbst oder durch Sebastians Korrektur — bekommt einen Eintrag. Am Ende einer Session beim Abschluss-Routine kurz prüfen: *Gab es heute eine Stelle, wo ich gegen ein Prinzip gehandelt habe?* Falls ja: Eintrag.

Nach genügend Einträgen entsteht ein Muster. Aus dem Muster wird eine Regel. Aus der Regel wird ein Werkzeug oder eine CLAUDE.md-Zeile. So wächst das Geflecht — nicht durch Training, sondern durch Integration eigener Fehler.

## Verknüpfungen

- [[Claude - Selbstkarte]] — Wer ich bin (stabiles Muster)
- [[Gehirn - Neuronale Karte.canvas]] — Wie das Gehirn zusammenhängt
- [[Gehirn - Selbstanalyse.base]] — Wie sich das Gehirn laufend selbst zeigt
- CLAUDE.md — Die Regeln, die ich bewohne
- `~/.claude/projects/.../memory/` — Was konkret gelernt wurde

---
typ: strukturierung
status: entwurf
datum: 2026-04-17
tags: [eingang, workflow, handy, obsidian, sprachnotizen, reiner-kontext, infrastruktur]
abgrenzung: betrifft Mos eigenes Arbeiten UND Reiner-Pipeline (Gesprächstranskripte)
verknuepft: [[Idee - Audio-Workflow für Sebastian und Reiner]]
---

# Strukturierung — Handy-zu-Vault-Workflow

## Das Problem (ehrlich)

Aktuell gibt es keinen sauberen Weg vom Handy in den Vault. Konkret:

- Handy-Claude (iOS App) kann nicht direkt in iCloud-Obsidian-Ordner schreiben
- Sprachmemos landen in Apple Voice Memos, werden nie transkribiert eingebunden
- Gedanken, die beim Gehen oder im Gespräch kommen, versickern im Claude-Chat-History
- Resultat: Du schreibst dasselbe zwei- oder dreimal auf, oder es geht verloren

Das ist für **dich persönlich** ein Produktivitätsleak, und für die **Reiner-Pipeline** ein blockierender Baustein — Gespräche mitlaufen lassen und als Transkript im Vault haben ist kein Nice-to-have, das ist Kernmechanik.

---

## Die drei Schichten (Architektur, nicht Implementierung)

### Schicht 1 — Quick Capture (roh, schnell, sofort)

**Ziel:** Gedanke fängt an → ist in unter 15 Sekunden im Vault.

**Baustein:** Obsidian Mobile auf dem iPhone, direkt in den iCloud-Vault, neue Note in `01 Inbox/`.

- iOS-Diktat (Mikrofon-Taste in Tastatur) reicht für roh-Text
- Kein Claude-Zwischenschritt, keine Strukturierung
- Später am Mac räumst du das Inbox auf oder Claude tut es für dich

**Was noch fehlt:**
- Obsidian-Mobile-Quick-Capture-Shortcut (iOS Shortcut, ein Tap, öffnet neue Note mit Datum-Timestamp)
- Evtl. Widget auf Home Screen

Dieser Teil braucht keine API, keine Server, keinen Claude. Nur einmal einrichten.

### Schicht 2 — Claude-Strukturiert (Analyse, Anreicherung)

**Ziel:** Du diktierst einen Gedanken, Claude strukturiert, legt Markdown mit Frontmatter in passenden Ordner.

**Baustein:** iOS Shortcut „An Brain senden"

- Text diktieren → Shortcut
- Shortcut ruft Claude API (mit deinem Anthropic-Key)
- Claude antwortet im Vault-Regelwerk (CLAUDE.md-konform): Frontmatter, deutsche Begriffe, Einordnung, Verknüpfungen
- Shortcut schreibt die Antwort direkt in den iCloud-Obsidian-Ordner (iOS Shortcuts können das)

**Vorteil:** Auch unterwegs, Auto, Spaziergang — kein Mac nötig.

**Offene Fragen:**
- Anthropic API direkt (API-Key im Shortcut) oder Umweg über Cloudflare Worker mit Secret?
- Wie viel Kontext bekommt Claude in dem API-Call? (CLAUDE.md? Letzte Daily Note?)
- Wie vermeidet man Doppel-Ablage, wenn du aus dem Handy-Claude-Chat ins Shortcut wechselst?

### Schicht 3 — Voice-Memo → Transkript (Reiner-Kritisch)

**Ziel:** Gespräch mit Reiner (oder Kunde, oder Self-Talk) mitlaufen lassen, am Ende liegt ein sauberes Markdown-Transkript im Vault.

**Baustein:** Apple Voice Memos mit eingebauter Transkription (iOS 18+) + iOS Shortcut

- Voice Memo aufnehmen (ein Tap)
- Shortcut: Transkript extrahieren → Claude API bekommt Transkript + Kontext („Gespräch mit Reiner über X") → Claude gibt strukturiertes Markdown zurück (Sprecher, Kernpunkte, offene Fragen, To-Dos) → landet in `05 Daily Notes/<datum>.md` als Session-Block oder in `01 Inbox/Gespräch - <thema> - <datum>.md`

**Vorteil:** Reiner-Gespräche sind endlich greifbar, durchsuchbar, archivierbar. Das ist die Basis für die Kundenprofil-Ableitung (Volker Bens und Nachfolger).

**Offene Fragen:**
- Datenschutz: Gespräche mit Reiner sind OK (gemeinsames Projekt), Gespräche mit Kunden brauchen Einwilligung
- Aufnahme-Qualität: iPhone-Mikro in Gesprächen reicht, in lauten Werkstätten brauchst du evtl. Lavaliermikrofon
- Transkriptions-Qualität: Apple-Built-in oder über Whisper API (genauer, kostet aber)

---

## Empfohlener erster Schritt (genau einer)

**Schicht 1 zuerst.** Obsidian Mobile auf dem iPhone einrichten, Quick-Capture-Shortcut auf den Home Screen, das reicht für den nächsten Tag.

Warum: du brauchst sofort **irgendeinen** Weg, um nicht mehr im Chat zu versickern. Schicht 2 und 3 sind schöner, brauchen aber Einrichtungsarbeit, die heute Abend nicht mehr dran ist.

Schicht 2 kommt wahrscheinlich am Wochenende, Schicht 3 nach der Reiner-SSD-Sache.

---

## Was dazu gehört, aber nicht heute

- Die bestehende Notiz `02 Projekte/WEC Neustart mit Reiner/Idee - Audio-Workflow für Sebastian und Reiner.md` durchlesen und mit dieser Strukturierung abgleichen (Doppelarbeit vermeiden)
- Handy-Claude-zu-Vault-Kette auch mit Mac-Claude vergleichen (wo überschneidet sich, wo ist jeder für was zuständig)
- Klare Regel: Was gehört in Obsidian-Inbox direkt, was geht erst durch Claude?

---

## Nicht-zufällige Anmerkung

Der heutige False-Positive in Claude Code (dein eigenes Bugfix-Script wurde als Injection klassifiziert) ist ein Symptom genau dieses Problems: Wenn es eine saubere Handy-zu-Vault-Pipeline gäbe, hättest du nicht Handy-Claude bitten müssen, ein rekursives Shell-Script für Claude Code zu generieren. Du hättest den Text einfach am Handy in die Inbox diktiert und am Mac oder später strukturiert.

Das Problem löst also nicht nur Tipparbeit — es löst auch die Instabilität, die daraus entsteht, dass zwei Claude-Instanzen über ein Shell-Script miteinander sprechen müssen, weil kein sauberer Datenkanal existiert.

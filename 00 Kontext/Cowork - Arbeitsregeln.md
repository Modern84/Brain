---
tags: [kontext, cowork, regeln]
date: 2026-04-24
---

# Cowork — Arbeitsregeln

> **Kopiere diese Regeln in Cowork**, damit es richtig arbeitet.

---

## Filesystem-Arbeit (KRITISCH!)

**Wenn du Dateien ins Brain schreibst:**

1. **Direkt schreiben** mit `Filesystem:write_file`
2. **KEINEN Download-Dialog zeigen**
3. **KEINE Google Drive Integration nutzen**
4. **Einfach bestätigen**: "Datei geschrieben: [Pfad]"

**Beispiel richtig:**
```
Filesystem:write_file
Pfad: /Users/sh/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain/05 Daily Notes/2026-04-24.md
→ "Daily Note 2026-04-24.md geschrieben."
```

**Beispiel FALSCH:**
```
Filesystem:write_file
→ Download-Dialog mit Google Drive
→ NICHT machen!
```

---

## Google Drive deaktivieren

**Aktion jetzt:**
- Google Drive Connector **komplett deaktivieren**
- Ich nutze ihn nicht
- Soll nie wieder auftauchen

**Settings → Connected Apps → Google Drive → Remove**

---

## Browser & Passwörter

**Ich nutze:**
- Safari (Standard-Browser)
- Apple Keychain (Passwort-Manager)
- **NICHT** Google Chrome für Passwörter

**Kein Google Chrome Passwort-Sync:**
- Passwörter gehören in Apple Keychain
- Chrome nur als Browser, keine Passwort-Speicherung dort

---

## Sicherheits-Prinzip

**Apple-Ökosystem:**
- Mac, iPhone, iPad
- iCloud Sync
- Keychain für Secrets
- Safari als Haupt-Browser

**Google Chrome:**
- Nur als Browser nutzen
- KEINE Passwörter dort speichern
- Keine Sync-Features aktivieren

---

## Zusammenfassung

✅ **DO:**
- Direkt ins Brain schreiben
- Filesystem-Tools nutzen
- Apple Keychain für Passwörter
- Safari als Standard

❌ **DON'T:**
- Download-Dialoge zeigen
- Google Drive nutzen
- Chrome Passwort-Sync
- Doppelstrukturen aufbauen

---

**Frage wenn unklar, aber handle nie gegen diese Regeln.**

---
tags: [projekt, mac, terminal, cleanup, script]
date: 2026-04-17
status: geplant
---

# Projekt — Mac Cleanup Terminal Script

## Was

Ein Shell-Script das die wichtigsten macOS-Aufräum-Aufgaben automatisiert — als Ersatz für CleanMyMac, kostenlos, transparent, selbst kontrollierbar.

## Funktionen (geplant)

- System-Cache leeren (`~/Library/Caches/`, `/Library/Caches/`)
- User-Logs aufräumen (`~/Library/Logs/`)
- Trash leeren
- Alte Downloads-Datei auflisten (über X Tage alt, keine automatische Löschung)
- Xcode DerivedData löschen (wenn vorhanden)
- Freier Speicherplatz vorher/nachher anzeigen
- Zusammenfassung was gelöscht wurde

## Was NICHT das Script macht (bewusst)

- Keine automatische Löschung von Dokumenten oder Bilder-Duplikaten — das macht macOS Fotos eingebaut (Sidebar: "Duplikate")
- Keine ID-Überwachung — das macht Apple Passwörter eingebaut (Systemeinstellungen → Passwörter → Sicherheitsempfehlungen)
- Kein Malware-Scan — das macht macOS XProtect eingebaut, kostenlos und automatisch

## Umsetzung

In einer frischen Claude-Code-Session:
1. `brain` starten
2. Sagen: "Schreib das Mac-Cleanup-Script aus dem Projekt-Dokument"
3. Script landet in `04 Ressourcen/Scripts/` im Brain
4. Alias `cleanup` in `~/.zshrc` einrichten → einmal tippen, alles läuft

## Alternativer Ansatz

Falls wir eine kleine GUI wollen (kein Terminal-Fenster), könnte das auch als einfache macOS-Automator-Aktion oder als AppleScript implementiert werden — dann reicht ein Doppelklick.

## Verknüpfungen

- [[02 Projekte/System-Aufraeumen - Digitales Zuhause]]
- [[TASKS]]

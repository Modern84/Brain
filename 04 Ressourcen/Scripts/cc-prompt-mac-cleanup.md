---
tags: [script, cleanup, cc-prompt]
date: 2026-04-24
status: ready
---

# Claude Code Prompt — Mac Cleanup

**Zweck:** CC führt strukturierte Mac-Aufräumaktion durch. Basiert auf Scan-Report in `04 Ressourcen/Scripts/mac-scan-output.md`.

---

## Prompt zum Kopieren

```
Mac-Aufräumaktion. Basis: 04 Ressourcen/Scripts/mac-scan-output.md (lies das zuerst).

REGELN (wichtig):
- Nichts löschen/deinstallieren ohne meine explizite Freigabe PRO AKTION.
- Nach jedem Schritt: kurze Statusmeldung + Bestätigung abwarten bevor nächster Schritt.
- Bei System-Extensions oder root-Aktionen: erst zeigen was passieren wird, dann sudo ausführen.
- Keine name-globs (`find -iname "*clean*"`) — explizite Pfade oder strikt gescopte Suchen.
- Alle Aktionen in Daily Note 2026-04-24.md dokumentieren (append an Ende, Überschrift "Mac Cleanup").

═══════════════════════════════════════════════════
SCHRITT 1 — Moonlock + CleanMyMac + Setapp deinstallieren
═══════════════════════════════════════════════════

Kontext: Moonlock-Engine frisst 93% CPU dauerhaft. Nach Malware-Incident 19.04. 
entschieden: macOS XProtect + security-sync.sh reichen, Third-Party AV raus.

Aufgaben:
1.1 Prüfe ob Setapp-Abo aktiv ist (frag mich, nicht Account einsehen). 
    Falls nein → Setapp komplett weg. Falls ja → nur Moonlock/CleanMyMac raus, 
    Setapp behalten.

1.2 System-Extension Moonlock sauber deinstallieren:
    - systemextensionsctl list  (zeigen welche SE aktiv sind)
    - CleanMyMac.app öffnen lassen → "Uninstall via App" oder
    - systemextensionsctl deactivate <team-id> <bundle-id>  (wenn möglich ohne 
      Developer Mode)
    - Wenn das scheitert: sauberen Deaktivierungs-Weg recherchieren, NICHT einfach 
      rm auf /Library/SystemExtensions.

1.3 LaunchAgents für Moonlock/CleanMyMac/Setapp entfernen:
    ~/Library/LaunchAgents/com.setapp.DesktopClient.*.plist (4 Dateien)
    /Library/LaunchDaemons/com.macpaw.CleanMyMac-setapp.Agent.plist
    → erst auflisten mit Pfaden, dann Freigabe einholen, dann launchctl unload 
      + rm.

1.4 Apps entfernen:
    /Applications/Setapp.app
    /Applications/Setapp/  (Ordner mit Setapp-Apps darin)
    → trash statt rm -rf (über osascript 'tell application "Finder" to delete POSIX 
      file ...'), damit ich notfalls wiederherstellen kann.

1.5 Verifikation:
    - ps aux | grep -E "moonlock|cleanmymac|setapp"  (sollte leer sein)
    - systemextensionsctl list  (Moonlock sollte weg sein)
    - Top-CPU nochmal checken: top -l 1 -n 10 -o cpu

═══════════════════════════════════════════════════
SCHRITT 2 — LLaMA 3.3 70B löschen (spart 41GB)
═══════════════════════════════════════════════════

Kontext: 70B Modell crasht auf diesem Mac wegen RAM-Druck. 3B reicht vorerst. 
70B-Use-Case kommt mit Mac Studio Ultra.

2.1 ollama list  (zeigen welche Modelle da sind)
2.2 Freigabe einholen
2.3 ollama rm llama3.3:70b
2.4 du -sh ~/.ollama  (sollte jetzt ~2GB sein, nur noch 3B)

═══════════════════════════════════════════════════
SCHRITT 3 — Downloads-Ordner aufräumen (~6.1GB)
═══════════════════════════════════════════════════

3.1 Liste mir ~/Downloads mit Größen sortiert: 
    ls -lahS ~/Downloads | head -30

3.2 Markiere klar als DUPLIKATE:
    - Claude.dmg + Claude (1).dmg (beide 289M)
    - Debug_PDB_V2.3.1-dev_for_developers_only 2 + ohne "2"
    - Takeout 2 (wahrscheinlich Duplikat)
    - OrcaSlicer-2.3.1 3 (Duplikat mit Nummer am Ende)

3.3 Markiere als "gehört in Projekt" (verschieben statt löschen):
    - ext-auth-main (831M) → wohin?
    - HiDrive (452M) → wohin?
    - GitHub Desktop.app (418M) → installieren oder löschen?
    - Auge (262M) → unklar, frag mich

3.4 Zeig mir alles älter als 60 Tage in Downloads:
    find ~/Downloads -type f -mtime +60 -exec ls -lh {} \;

3.5 NICHTS löschen ohne mein OK pro Datei/Ordner.

═══════════════════════════════════════════════════
SCHRITT 4 — Obsidian-CPU-Problem diagnostizieren
═══════════════════════════════════════════════════

Kontext: Obsidian läuft dauerhaft mit 70% CPU laut Scan. Das ist nicht normal.

4.1 Welche Plugins sind aktiv?
    cat "/Users/sh/Brain/.obsidian/community-plugins.json"

4.2 Gibt es .trash/ oder riesige Dateien im Vault die Obsidian indexiert?
    find "/Users/sh/Brain" -type f -size +10M

4.3 Copilot-Plugin-Größe + Modelle gecached:
    du -sh "/Users/sh/Brain/.obsidian/plugins"/*

4.4 Vorschlag: Welche Plugins können temporär deaktiviert werden um CPU-Ursache zu 
    isolieren? (Copilot? Dataview? Omnisearch?) — nur Vorschlag, nicht ausführen.

═══════════════════════════════════════════════════
SCHRITT 5 — Startup-Agents aufräumen
═══════════════════════════════════════════════════

Nach Schritt 1 neu prüfen:
    ls ~/Library/LaunchAgents
    ls /Library/LaunchAgents
    ls /Library/LaunchDaemons

Erwartet übrig:
    ✅ homebrew.mxcl.ollama.plist (behalten)
    ✅ com.3dconnexion.* (behalten wenn SpaceMouse genutzt, sonst frag mich)
    ✅ com.crystalidea.macsfancontrol.smcwrite (behalten, Fan-Control wichtig)
    ❓ com.google.GoogleUpdater.wake (nur behalten wenn Chrome bleibt — siehe 
       Schritt 6)

═══════════════════════════════════════════════════
SCHRITT 6 — Apps die raus können (Freigabe-Liste)
═══════════════════════════════════════════════════

Zeig mir diese Apps als Tabelle (Name, Größe, letzte Nutzung), ich sag pro Zeile 
ja/nein:

Kategorie A — wahrscheinlich weg (Apple-Äquivalente vorhanden):
    Google Chrome (1.3G)
    Google Docs/Sheets/Slides

Kategorie B — wahrscheinlich weg (MS Office, nutzt Apple Pages/Numbers/Keynote):
    Microsoft Word (2.3G)
    Microsoft Excel (2.1G)
    Microsoft PowerPoint (1.8G)
    Microsoft Outlook (2.4G)

Kategorie C — Video/Apple Pro (13G, nur wenn nicht genutzt):
    Final Cut Pro Creator Studio (6.3G)
    iMovie (3.7G)
    Motion Creator Studio (3.1G)
    Compressor Creator Studio
    Pixelmator Pro Creator Studio (700M)
    Photomator (676M)

Kategorie D — 90+ Tage nicht genutzt:
    Blender (828M)
    BambuSuite (1.1G)
    SliCR-3D
    PrusaSlicer
    CyberBrick
    RMAAnalyzer
    DA260DSP
    JBL Compact Connect
    Messenger
    Apple Configurator
    Magnet

Kategorie E — Dev-Tools (frag mich):
    Xcode (5.0G)
    VSCode Insiders (775M) — hast normales VSCode
    GitHub Desktop (.app in Downloads, 418M)

Für Apps die weg können:
- Zuerst über AppCleaner.app deinstallieren (falls installiert) — räumt auch 
  Library-Reste weg
- Falls AppCleaner nicht da: manuell App + zugehörige Library-Ordner:
  ~/Library/Application Support/<AppName>
  ~/Library/Caches/<AppName>
  ~/Library/Preferences/<AppName>*

═══════════════════════════════════════════════════
ABSCHLUSS
═══════════════════════════════════════════════════

7.1 Re-Scan ausführen:
    bash "/Users/sh/Brain/04 Ressourcen/Scripts/mac-deep-scan.sh"

7.2 Delta zeigen: Vorher 273GB used / 57GB RAM used → Nachher ? / ?

7.3 In Daily Note 2026-04-24.md anhängen:
    - Was gelöscht/deinstalliert wurde (Liste)
    - Was freigegeben (GB)
    - CPU-Last vorher/nachher
    - Offene Punkte

Los geht's mit Schritt 1.1.
```

---

## Hinweise für Mo

- **Kopier den Block oben komplett in Claude Code.**
- CC arbeitet Schritt für Schritt, fragt vor jeder Löschaktion.
- Du kannst jederzeit "stop" / "überspring den Schritt" sagen.
- Nach Schritt 1 (Moonlock raus) sollte dein Mac spürbar ruhiger sein.

## Verknüpfungen

- [[04 Ressourcen/Scripts/mac-scan-output]] — Basis-Scan
- [[04 Ressourcen/Scripts/mac-deep-scan.sh]] — Re-Scan-Script
- [[05 Daily Notes/2026-04-24]] — Aktionsprotokoll

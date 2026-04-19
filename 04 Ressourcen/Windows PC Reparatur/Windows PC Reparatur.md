---
tags: [ressource, windows, reparatur]
date: 2026-04-16
---

# Windows PC Reparatur - Diagnose und Loesung

Wenn ein Windows 10/11 PC diese Symptome zeigt:
- Enter-Taste funktioniert nicht in Terminal/PowerShell/CMD
- Rechtsklick-Einfuegen funktioniert nicht
- Copilot ueberlagert Anwendungen
- Maus/Tastatur trennen sich zufaellig (USB)
- Dateien im Explorer nicht auswaehlbar
- PC allgemein traege

## Moegliche Ursachen (Reihenfolge nach Wahrscheinlichkeit)

### 1. Microsoft Copilot / Widgets interferieren
Copilot und Widgets laufen als Hintergrundprozesse und koennen:
- Tastatureingaben abfangen (besonders Win-Taste, Enter in bestimmten Kontexten)
- Overlay-Fenster ueber andere Apps legen
- CPU/RAM verbrauchen

### 2. USB Selective Suspend
Windows spart Energie indem es USB-Ports zeitweise deaktiviert. Bei Desktop-PCs fuehrt das zu:
- Maus/Tastatur trennen sich kurz und verbinden sich wieder
- Eingaben gehen verloren waehrend der Trennung
- Besonders bei USB-Hubs problematisch

### 3. Accessibility-Features (Sticky Keys, Filter Keys)
Koennen Tastatureingaben veraendern oder verzoegern:
- Filter Keys verschluckt kurze Tastendruecke
- Sticky Keys aendert Modifier-Verhalten

### 4. Malware / Keylogger
Wenn die oben genannten Ursachen ausgeschlossen sind:
- Keyboard Hooks von Schadsoftware
- Background-Prozesse die Eingaben abfangen
- DLL-Injection in Explorer oder Terminal

### 5. Defekte Treiber
- USB-Controller-Treiber beschaedigt
- Tastatur-Filtertreiber von Drittsoftware
- Windows Update hat Treiber ueberschrieben

## Loesung: Skripte

### Vollstaendige Diagnose und Reparatur
`[[PC-Diagnose-und-Reparatur.bat]]`
- Komplette Systemanalyse mit Bericht auf dem Desktop
- Deaktiviert Copilot, Widgets, USB Selective Suspend
- SFC und DISM Systemreparatur
- Windows Defender Scan
- Dauert 15-30 Minuten

### Schnellreparatur (nur Copilot + USB)
`[[Quick-Fix-Copilot-USB.bat]]`
- Deaktiviert nur Copilot, Widgets und USB Selective Suspend
- Dauert unter 1 Minute
- Neustart danach erforderlich

### Ausfuehrung wenn Enter nicht geht
1. `Win+R` druecken (Ausfuehren-Dialog)
2. Pfad zur .bat Datei eintippen oder einfuegen
3. **OK-Button mit der Maus klicken** (statt Enter)
4. Bei UAC-Abfrage: Ja klicken

## Registry-Keys Referenz

### Copilot deaktivieren
```
HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot
  TurnOffWindowsCopilot = 1 (DWORD)

HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
  ShowCopilotButton = 0 (DWORD)
```

### Recall und KI deaktivieren
```
HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI
  AllowRecallEnablement = 0 (DWORD)
  DisableAIDataAnalysis = 1 (DWORD)
  DisableClickToDo = 1 (DWORD)
```

### Widgets deaktivieren
```
HKLM\SOFTWARE\Policies\Microsoft\Dsh
  AllowNewsAndInterests = 0 (DWORD)
  DisableWidgetsBoard = 1 (DWORD)
  DisableWidgetsOnLockScreen = 1 (DWORD)

HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
  TaskbarDa = 0 (DWORD)
```

### USB Selective Suspend deaktivieren
```
powercfg /SETACVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
powercfg /SETDCVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
powercfg /SETACTIVE SCHEME_CURRENT
```

## Weiterfuehrende Werkzeuge

- **Sysinternals Autoruns**: Alle Autostart-Orte pruefen, "Hide Microsoft Entries" aktivieren
  https://download.sysinternals.com/files/Autoruns.zip
- **Malwarebytes Free**: Einmal-Scan bei Malware-Verdacht
  https://www.malwarebytes.com/mwb-download
- **Microsoft Safety Scanner**: Einmal-Scan von Microsoft
  https://www.microsoft.com/security/scanner
- **ShellExView**: Explorer Shell-Erweiterungen pruefen/deaktivieren
  https://www.nirsoft.net/utils/shexview.html

## Abgesicherter Modus als Test

Wenn Enter im abgesicherten Modus funktioniert, ist es ein Software-Problem.
Wenn nicht, ist es Hardware oder ein Basistreiber.

Start in abgesicherten Modus:
1. Einstellungen → System → Wiederherstellung → Erweiterter Start
2. Problembehandlung → Erweiterte Optionen → Starteinstellungen
3. Option 4 oder 5 waehlen

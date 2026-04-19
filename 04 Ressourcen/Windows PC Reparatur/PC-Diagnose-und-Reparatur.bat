@echo off
:: ============================================================================
:: PC-Diagnose-und-Reparatur.bat
:: Umfassendes Diagnose- und Reparatur-Skript fuer Windows 10/11
::
:: AUSFUEHRUNG: Win+R → Pfad zur .bat eingeben → OK klicken (kein Enter noetig)
:: ODER: Rechtsklick auf Datei → "Als Administrator ausfuehren"
::
:: WICHTIG: Muss als Administrator ausgefuehrt werden!
:: ============================================================================

:: --- Adminrechte pruefen und anfordern ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Fordere Administratorrechte an...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: --- Ausgabedatei vorbereiten ---
set "LOGFILE=%USERPROFILE%\Desktop\PC-Diagnose-Bericht_%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%.txt"
set "LOGFILE=%LOGFILE: =0%"

echo ============================================================================ > "%LOGFILE%"
echo  PC-DIAGNOSE UND REPARATUR - Bericht >> "%LOGFILE%"
echo  Erstellt: %date% %time% >> "%LOGFILE%"
echo  Computer: %COMPUTERNAME% >> "%LOGFILE%"
echo  Benutzer: %USERNAME% >> "%LOGFILE%"
echo ============================================================================ >> "%LOGFILE%"
echo. >> "%LOGFILE%"

cls
echo ============================================================================
echo  PC-DIAGNOSE UND REPARATUR
echo  Bericht wird auf dem Desktop gespeichert
echo ============================================================================
echo.
echo [INFO] Bericht: %LOGFILE%
echo.

:: ============================================================================
:: PHASE 1: DIAGNOSE - Verdaechtige Prozesse und Malware-Indikatoren
:: ============================================================================

echo ============================================================================ >> "%LOGFILE%"
echo  PHASE 1: SYSTEMDIAGNOSE >> "%LOGFILE%"
echo ============================================================================ >> "%LOGFILE%"
echo. >> "%LOGFILE%"

echo [1/8] Pruefe verdaechtige Prozesse...
echo --- Laufende Prozesse (sortiert nach CPU-Nutzung) --- >> "%LOGFILE%"
powershell -Command "Get-Process | Sort-Object CPU -Descending | Select-Object -First 30 Name, Id, CPU, WorkingSet, Path | Format-Table -AutoSize | Out-String -Width 200" >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo --- Prozesse mit hohem Speicherverbrauch (ueber 200 MB) --- >> "%LOGFILE%"
powershell -Command "Get-Process | Where-Object { $_.WorkingSet -gt 200MB } | Sort-Object WorkingSet -Descending | Select-Object Name, Id, @{N='RAM_MB';E={[math]::Round($_.WorkingSet/1MB,1)}}, Path | Format-Table -AutoSize | Out-String -Width 200" >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo --- Prozesse ohne Dateipfad (verdaechtig) --- >> "%LOGFILE%"
powershell -Command "Get-Process | Where-Object { $_.Path -eq $null -and $_.Name -ne 'Idle' -and $_.Name -ne 'System' } | Select-Object Name, Id, CPU | Format-Table -AutoSize | Out-String -Width 200" >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo [2/8] Pruefe Autostart-Eintraege...
echo --- Autostart-Programme (Registry Run-Keys) --- >> "%LOGFILE%"
echo. >> "%LOGFILE%"
echo HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run: >> "%LOGFILE%"
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"
echo HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run: >> "%LOGFILE%"
reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"
echo HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce: >> "%LOGFILE%"
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"
echo HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce: >> "%LOGFILE%"
reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo --- Geplante Aufgaben (Scheduled Tasks) --- >> "%LOGFILE%"
powershell -Command "Get-ScheduledTask | Where-Object { $_.State -eq 'Ready' -or $_.State -eq 'Running' } | Select-Object TaskName, State, @{N='Actions';E={($_.Actions | ForEach-Object { $_.Execute }) -join ', '}} | Sort-Object TaskName | Format-Table -AutoSize -Wrap | Out-String -Width 200" >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo [3/8] Pruefe Netzwerkverbindungen...
echo --- Aktive Netzwerkverbindungen (ESTABLISHED) --- >> "%LOGFILE%"
powershell -Command "Get-NetTCPConnection -State Established -ErrorAction SilentlyContinue | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, OwningProcess, @{N='ProcessName';E={(Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue).Name}} | Format-Table -AutoSize | Out-String -Width 200" >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo --- Lauschende Ports --- >> "%LOGFILE%"
powershell -Command "Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue | Select-Object LocalAddress, LocalPort, OwningProcess, @{N='ProcessName';E={(Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue).Name}} | Sort-Object LocalPort | Format-Table -AutoSize | Out-String -Width 200" >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo [4/8] Pruefe bekannte Malware-Indikatoren...
echo --- Bekannte verdaechtige Prozessnamen --- >> "%LOGFILE%"
powershell -Command "$suspicious = @('keylogger','hookexe','spyhunter','remotespy','ardamax','refog','realvnc','tightvnc','ultravnc','ammyy','teamspy','darkcomet','njrat','xtreme','poison','blackshades','cryptolocker','wannacry','cerber'); $procs = Get-Process; foreach ($s in $suspicious) { $found = $procs | Where-Object { $_.Name -like \"*$s*\" -or $_.Path -like \"*$s*\" }; if ($found) { Write-Output \"[WARNUNG] Verdaechtiger Prozess gefunden: $($found.Name) (PID: $($found.Id))\" } }; Write-Output 'Pruefung abgeschlossen.'" >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo --- Pruefe verdaechtige DLLs (Keyboard Hooks) --- >> "%LOGFILE%"
powershell -Command "Get-ChildItem 'C:\Windows\System32\*.dll' -ErrorAction SilentlyContinue | Where-Object { $_.Name -match 'hook|inject|keylog|capture|monitor|spy' } | Select-Object Name, Length, LastWriteTime | Format-Table -AutoSize | Out-String -Width 200" >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo --- Pruefe Windows Defender Status --- >> "%LOGFILE%"
powershell -Command "Get-MpComputerStatus -ErrorAction SilentlyContinue | Select-Object AntivirusEnabled, RealTimeProtectionEnabled, AntivirusSignatureLastUpdated, QuickScanEndTime | Format-List | Out-String -Width 200" >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo --- Pruefe ob Tastatur-Filter/Hooks aktiv sind --- >> "%LOGFILE%"
echo Installierte Filter-Treiber: >> "%LOGFILE%"
powershell -Command "Get-WmiObject Win32_SystemDriver | Where-Object { $_.DisplayName -match 'keyboard|input|filter|hook' } | Select-Object Name, DisplayName, State, StartMode | Format-Table -AutoSize | Out-String -Width 200" >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo [5/8] Pruefe Systemgesundheit...
echo --- Systeminfo --- >> "%LOGFILE%"
powershell -Command "Get-CimInstance Win32_OperatingSystem | Select-Object Caption, Version, BuildNumber, OSArchitecture, @{N='Uptime';E={(Get-Date) - $_.LastBootUpTime}}, @{N='RAM_Total_GB';E={[math]::Round($_.TotalVisibleMemorySize/1MB,1)}}, @{N='RAM_Frei_GB';E={[math]::Round($_.FreePhysicalMemory/1MB,1)}} | Format-List | Out-String -Width 200" >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo --- Festplattenplatz --- >> "%LOGFILE%"
powershell -Command "Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' | Select-Object DeviceID, @{N='Gesamt_GB';E={[math]::Round($_.Size/1GB,1)}}, @{N='Frei_GB';E={[math]::Round($_.FreeSpace/1GB,1)}}, @{N='Belegt_Prozent';E={[math]::Round(100-($_.FreeSpace/$_.Size*100),1)}} | Format-Table -AutoSize | Out-String -Width 200" >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo --- CPU-Auslastung --- >> "%LOGFILE%"
powershell -Command "$cpu = (Get-CimInstance Win32_Processor).LoadPercentage; Write-Output \"Aktuelle CPU-Auslastung: $cpu %%\"" >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo --- Letzte Windows-Updates --- >> "%LOGFILE%"
powershell -Command "Get-HotFix | Sort-Object InstalledOn -Descending -ErrorAction SilentlyContinue | Select-Object -First 10 HotFixID, Description, InstalledOn | Format-Table -AutoSize | Out-String -Width 200" >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"


:: ============================================================================
:: PHASE 2: REPARATUREN
:: ============================================================================

echo ============================================================================ >> "%LOGFILE%"
echo  PHASE 2: REPARATUREN >> "%LOGFILE%"
echo ============================================================================ >> "%LOGFILE%"
echo. >> "%LOGFILE%"

:: --- 2a: Microsoft Copilot komplett deaktivieren ---
echo [6/8] Deaktiviere Microsoft Copilot und KI-Features...
echo. >> "%LOGFILE%"
echo --- Deaktiviere Microsoft Copilot --- >> "%LOGFILE%"

:: Copilot via Registry deaktivieren (User-Scope, offizieller Microsoft-Weg)
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >> "%LOGFILE%" 2>&1
:: Copilot via Registry deaktivieren (Machine-Scope)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >> "%LOGFILE%" 2>&1

:: Recall deaktivieren
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "AllowRecallEnablement" /t REG_DWORD /d 0 /f >> "%LOGFILE%" 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /t REG_DWORD /d 1 /f >> "%LOGFILE%" 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /t REG_DWORD /d 1 /f >> "%LOGFILE%" 2>&1

:: Click to Do deaktivieren
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableClickToDo" /t REG_DWORD /d 1 /f >> "%LOGFILE%" 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableClickToDo" /t REG_DWORD /d 1 /f >> "%LOGFILE%" 2>&1

:: Copilot-App aus Taskleiste entfernen
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 0 /f >> "%LOGFILE%" 2>&1

:: Paint KI-Features deaktivieren
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableCocreator" /t REG_DWORD /d 1 /f >> "%LOGFILE%" 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableGenerativeFill" /t REG_DWORD /d 1 /f >> "%LOGFILE%" 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableImageCreator" /t REG_DWORD /d 1 /f >> "%LOGFILE%" 2>&1

:: Copilot-Prozess beenden falls laufend
taskkill /f /im "Microsoft.Copilot.exe" >nul 2>&1
taskkill /f /im "CopilotRuntime.exe" >nul 2>&1
taskkill /f /im "Microsoft.Windows.Ai.Copilot.Provider.exe" >nul 2>&1

echo [OK] Copilot und KI-Features deaktiviert >> "%LOGFILE%"
echo. >> "%LOGFILE%"


:: --- 2b: Windows Widgets komplett deaktivieren ---
echo --- Deaktiviere Windows Widgets --- >> "%LOGFILE%"

:: Widgets via offiziellem Policy-Key deaktivieren
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f >> "%LOGFILE%" 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "DisableWidgetsBoard" /t REG_DWORD /d 1 /f >> "%LOGFILE%" 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "DisableWidgetsOnLockScreen" /t REG_DWORD /d 1 /f >> "%LOGFILE%" 2>&1

:: Widgets-Button aus Taskleiste entfernen
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d 0 /f >> "%LOGFILE%" 2>&1

:: News and Interests auf Windows 10 deaktivieren
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d 0 /f >> "%LOGFILE%" 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d 2 /f >> "%LOGFILE%" 2>&1

:: Widget-Prozess beenden
taskkill /f /im "Widgets.exe" >nul 2>&1
taskkill /f /im "WidgetService.exe" >nul 2>&1

echo [OK] Widgets deaktiviert >> "%LOGFILE%"
echo. >> "%LOGFILE%"


:: --- 2c: USB Energieverwaltung reparieren ---
echo [7/8] Repariere USB-Energieverwaltung...
echo. >> "%LOGFILE%"
echo --- USB Selective Suspend deaktivieren --- >> "%LOGFILE%"

:: USB Selective Suspend via Energieoptionen deaktivieren
:: AC (Netzbetrieb): Index 2 = Deaktiviert
powercfg /SETACVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >> "%LOGFILE%" 2>&1
:: DC (Akkubetrieb): Index 2 = Deaktiviert
powercfg /SETDCVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >> "%LOGFILE%" 2>&1
:: Aenderungen aktivieren
powercfg /SETACTIVE SCHEME_CURRENT >> "%LOGFILE%" 2>&1

echo [OK] USB Selective Suspend deaktiviert >> "%LOGFILE%"
echo. >> "%LOGFILE%"

:: USB-Energieverwaltung fuer alle USB-Hubs deaktivieren
echo --- USB Hub Energieverwaltung deaktivieren --- >> "%LOGFILE%"
powershell -Command "$hubs = Get-WmiObject -Class MSPower_DeviceEnable -Namespace root\wmi -ErrorAction SilentlyContinue; if ($hubs) { foreach ($hub in $hubs) { $hub.Enable = $false; $hub.Put() | Out-Null }; Write-Output '[OK] USB Hub Energieverwaltung deaktiviert' } else { Write-Output '[INFO] Keine USB-Hub-Energieverwaltung gefunden' }" >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

:: USB-Treiber Fehlerbehebung
echo --- USB Controller zuruecksetzen --- >> "%LOGFILE%"
powershell -Command "Get-PnpDevice -Class USB -ErrorAction SilentlyContinue | Where-Object { $_.Status -eq 'Error' -or $_.Status -eq 'Degraded' } | ForEach-Object { Write-Output \"Problematisches USB-Geraet: $($_.FriendlyName) - Status: $($_.Status)\"; Disable-PnpDevice -InstanceId $_.InstanceId -Confirm:$false -ErrorAction SilentlyContinue; Start-Sleep 2; Enable-PnpDevice -InstanceId $_.InstanceId -Confirm:$false -ErrorAction SilentlyContinue; Write-Output ' -> Zurueckgesetzt' } " >> "%LOGFILE%" 2>&1

:: USB Power Management in Registry global deaktivieren
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USB\DisableSelectiveSuspend" /ve /t REG_DWORD /d 1 /f >nul 2>&1
echo [OK] USB-Reparatur abgeschlossen >> "%LOGFILE%"
echo. >> "%LOGFILE%"


:: --- 2d: Weitere Interferenzen beseitigen ---
echo --- Weitere bekannte Stoerfaktoren deaktivieren --- >> "%LOGFILE%"

:: Sticky Keys und Filter Keys deaktivieren (koennen Tastatureingaben abfangen)
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f >> "%LOGFILE%" 2>&1
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "122" /f >> "%LOGFILE%" 2>&1
reg add "HKCU\Control Panel\Accessibility\ToggleKeys" /v "Flags" /t REG_SZ /d "58" /f >> "%LOGFILE%" 2>&1

:: Windows-Suchindizierung zuruecksetzen (kann Explorer verlangsamen)
echo --- Suchindex zuruecksetzen --- >> "%LOGFILE%"
net stop WSearch >nul 2>&1
del "%ProgramData%\Microsoft\Search\Data\Applications\Windows\Windows.edb" >nul 2>&1
net start WSearch >nul 2>&1
echo [OK] Suchindex wird neu aufgebaut >> "%LOGFILE%"
echo. >> "%LOGFILE%"

:: Windows Defender schnellen Scan anstossen
echo --- Windows Defender Schnellscan gestartet --- >> "%LOGFILE%"
powershell -Command "Start-MpScan -ScanType QuickScan -ErrorAction SilentlyContinue" >> "%LOGFILE%" 2>&1
echo [INFO] Defender-Scan laeuft im Hintergrund >> "%LOGFILE%"
echo. >> "%LOGFILE%"


:: --- 2e: Temporaere Dateien bereinigen ---
echo [8/8] Bereinige temporaere Dateien...
echo. >> "%LOGFILE%"
echo --- Temporaere Dateien bereinigen --- >> "%LOGFILE%"

:: Windows Temp
del /q /f "%TEMP%\*" >nul 2>&1
rd /s /q "%TEMP%\*" >nul 2>&1

:: System Temp
del /q /f "C:\Windows\Temp\*" >nul 2>&1
rd /s /q "C:\Windows\Temp\*" >nul 2>&1

:: Prefetch (hilft bei Leistungsproblemen)
del /q /f "C:\Windows\Prefetch\*" >nul 2>&1

:: DNS-Cache leeren
ipconfig /flushdns >nul 2>&1

:: Thumbnail-Cache loeschen
del /f /s /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1

:: Windows Update Cache bereinigen
net stop wuauserv >nul 2>&1
del /q /f "C:\Windows\SoftwareDistribution\Download\*" >nul 2>&1
net start wuauserv >nul 2>&1

echo [OK] Temporaere Dateien bereinigt >> "%LOGFILE%"
echo. >> "%LOGFILE%"


:: ============================================================================
:: PHASE 3: SYSTEMREPARATUR-TOOLS
:: ============================================================================

echo ============================================================================ >> "%LOGFILE%"
echo  PHASE 3: SYSTEM-INTEGRITAETSPRUEFUNG >> "%LOGFILE%"
echo ============================================================================ >> "%LOGFILE%"
echo. >> "%LOGFILE%"

echo --- SFC (System File Checker) --- >> "%LOGFILE%"
echo [INFO] SFC-Scan gestartet, kann 5-15 Minuten dauern...
sfc /scannow >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"

echo --- DISM (Deployment Image Service) --- >> "%LOGFILE%"
echo [INFO] DISM-Reparatur gestartet, kann 5-15 Minuten dauern...
DISM /Online /Cleanup-Image /RestoreHealth >> "%LOGFILE%" 2>&1
echo. >> "%LOGFILE%"


:: ============================================================================
:: PHASE 4: ZUSAMMENFASSUNG UND EMPFEHLUNGEN
:: ============================================================================

echo ============================================================================ >> "%LOGFILE%"
echo  ZUSAMMENFASSUNG UND EMPFEHLUNGEN >> "%LOGFILE%"
echo ============================================================================ >> "%LOGFILE%"
echo. >> "%LOGFILE%"
echo Durchgefuehrte Massnahmen: >> "%LOGFILE%"
echo  [x] Verdaechtige Prozesse dokumentiert >> "%LOGFILE%"
echo  [x] Autostart-Eintraege dokumentiert >> "%LOGFILE%"
echo  [x] Netzwerkverbindungen geprueft >> "%LOGFILE%"
echo  [x] Malware-Indikatoren geprueft >> "%LOGFILE%"
echo  [x] Microsoft Copilot deaktiviert >> "%LOGFILE%"
echo  [x] Windows Widgets deaktiviert >> "%LOGFILE%"
echo  [x] USB Selective Suspend deaktiviert >> "%LOGFILE%"
echo  [x] USB-Energieverwaltung deaktiviert >> "%LOGFILE%"
echo  [x] Sticky Keys / Filter Keys deaktiviert >> "%LOGFILE%"
echo  [x] Temporaere Dateien bereinigt >> "%LOGFILE%"
echo  [x] SFC und DISM ausgefuehrt >> "%LOGFILE%"
echo  [x] Windows Defender Schnellscan gestartet >> "%LOGFILE%"
echo. >> "%LOGFILE%"
echo NAECHSTE SCHRITTE: >> "%LOGFILE%"
echo. >> "%LOGFILE%"
echo  1. BERICHT PRUEFEN: >> "%LOGFILE%"
echo     Den Bericht auf dem Desktop oeffnen und die Prozessliste durchsehen. >> "%LOGFILE%"
echo     Verdaechtige Prozesse mit unbekannten Namen oder ohne Dateipfad >> "%LOGFILE%"
echo     genauer untersuchen. >> "%LOGFILE%"
echo. >> "%LOGFILE%"
echo  2. NEUSTART ERFORDERLICH: >> "%LOGFILE%"
echo     Einige Aenderungen (Copilot, Widgets, USB) werden erst nach >> "%LOGFILE%"
echo     einem Neustart wirksam. >> "%LOGFILE%"
echo. >> "%LOGFILE%"
echo  3. FALLS ENTER WEITERHIN NICHT FUNKTIONIERT: >> "%LOGFILE%"
echo     a) Im Geraete-Manager die Tastatur deinstallieren und neu starten >> "%LOGFILE%"
echo     b) Tastatur an anderem USB-Port testen >> "%LOGFILE%"
echo     c) Andere Tastatur anschliessen zum Vergleich >> "%LOGFILE%"
echo     d) Im abgesicherten Modus testen (falls Enter dort geht, ist es >> "%LOGFILE%"
echo        Software; falls nicht, ist es Hardware/Treiber) >> "%LOGFILE%"
echo. >> "%LOGFILE%"
echo  4. FALLS USB-GERAETE WEITERHIN TRENNEN: >> "%LOGFILE%"
echo     a) USB-Hub (falls vorhanden) durch direkten Anschluss ersetzen >> "%LOGFILE%"
echo     b) Anderes USB-Kabel testen >> "%LOGFILE%"
echo     c) BIOS/UEFI: USB-Einstellungen pruefen >> "%LOGFILE%"
echo     d) Geraete-Manager: USB-Controller deinstallieren, neu starten >> "%LOGFILE%"
echo. >> "%LOGFILE%"
echo  5. MALWARE-VERDACHT: >> "%LOGFILE%"
echo     Falls der Bericht verdaechtige Prozesse zeigt: >> "%LOGFILE%"
echo     a) Malwarebytes Free herunterladen und vollstaendigen Scan machen >> "%LOGFILE%"
echo        https://www.malwarebytes.com/mwb-download >> "%LOGFILE%"
echo     b) Microsoft Safety Scanner (Einmal-Scan): >> "%LOGFILE%"
echo        https://www.microsoft.com/security/scanner >> "%LOGFILE%"
echo     c) Sysinternals Autoruns herunterladen fuer detaillierte Analyse: >> "%LOGFILE%"
echo        https://download.sysinternals.com/files/Autoruns.zip >> "%LOGFILE%"
echo        (Option "Hide Microsoft Entries" aktivieren) >> "%LOGFILE%"
echo. >> "%LOGFILE%"
echo  6. EXPLORER-PROBLEME (Dateien nicht auswaehlbar): >> "%LOGFILE%"
echo     a) Explorer neu starten: Strg+Shift+Esc → Explorer → Neu starten >> "%LOGFILE%"
echo     b) Falls Shell-Erweiterungen stoeren: ShellExView verwenden >> "%LOGFILE%"
echo        https://www.nirsoft.net/utils/shexview.html >> "%LOGFILE%"
echo. >> "%LOGFILE%"
echo ============================================================================ >> "%LOGFILE%"
echo  Bericht-Ende >> "%LOGFILE%"
echo ============================================================================ >> "%LOGFILE%"

:: --- Bericht oeffnen ---
echo.
echo ============================================================================
echo  FERTIG!
echo ============================================================================
echo.
echo Bericht gespeichert: %LOGFILE%
echo.
echo WICHTIG: PC muss neu gestartet werden!
echo.
echo Der Bericht wird jetzt geoeffnet...
echo.

start notepad "%LOGFILE%"

:: --- Explorer neu starten fuer Taskleisten-Aenderungen ---
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo Druecke eine beliebige Taste zum Beenden...
pause >nul

@echo off
:: ============================================================================
:: Quick-Fix: Copilot/Widgets deaktivieren + USB reparieren
:: Schnelle Version ohne ausfuehrliche Diagnose
::
:: AUSFUEHRUNG: Win+R → Pfad eingeben → OK klicken
:: ============================================================================

net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo Copilot deaktivieren...
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 0 /f >nul 2>&1
taskkill /f /im "Microsoft.Copilot.exe" >nul 2>&1
taskkill /f /im "CopilotRuntime.exe" >nul 2>&1

echo Widgets deaktivieren...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d 0 /f >nul 2>&1
taskkill /f /im "Widgets.exe" >nul 2>&1

echo USB Selective Suspend deaktivieren...
powercfg /SETACVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1
powercfg /SETDCVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1
powercfg /SETACTIVE SCHEME_CURRENT >nul 2>&1

echo Explorer neu starten...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
echo FERTIG - bitte PC neu starten!
pause >nul

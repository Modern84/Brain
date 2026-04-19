---
tags: [projekt, wec]
date: 2026-04-16
status: aktiv
---

# Heute bei Reiner — Checkliste 16.04.2026

## 1. PC-Probleme fixen (zuerst!)

### Maus/Tastatur Disconnect-Problem
Wahrscheinlich USB-Energieverwaltung — Windows schaltet USB-Ports ab.

**Fix in PowerShell (als Admin):**
```powershell
# USB Energiesparen deaktivieren
Get-WmiObject Win32_USBHub | ForEach-Object {
    $key = "HKLM:\SYSTEM\CurrentControlSet\Enum\$($_.DeviceID)\Device Parameters"
    if (Test-Path $key) { Set-ItemProperty -Path $key -Name "EnhancedPowerManagementEnabled" -Value 0 -ErrorAction SilentlyContinue }
}
```

**Oder manuell:**
1. Gerätemanager öffnen (Win+X → Gerätemanager)
2. USB-Controller aufklappen
3. Jeden "USB Root Hub" doppelklicken
4. Tab "Energieverwaltung" → **"Computer kann Gerät ausschalten" DEAKTIVIEREN**
5. Für alle USB Root Hubs wiederholen
6. PC neu starten

### Rechte Maustaste / Kopieren-Einfügen im Terminal
Das alte Windows CMD kann kein Rechtsklick-Paste.

**Lösung:** Windows Terminal installieren (moderne Version):
1. Microsoft Store öffnen → "Windows Terminal" suchen → Installieren
2. Oder: `winget install Microsoft.WindowsTerminal` in PowerShell
3. Danach: Strg+C kopieren, Strg+V einfügen — funktioniert überall

**Falls alter CMD bleiben muss:**
1. Titelleiste rechtsklicken → Eigenschaften
2. "QuickEdit-Modus" aktivieren → OK
3. Dann: Rechtsklick = Einfügen, Markieren+Enter = Kopieren

### Allgemeiner PC-Check
In PowerShell als Admin:
```powershell
# Windows-Version und letzte Updates
winver
Get-HotFix | Sort-Object -Property InstalledOn -Descending | Select-Object -First 5

# Festplatte prüfen
wmic diskdrive get status

# RAM-Auslastung
systeminfo | findstr "Physischer Speicher"

# Laufende Prozesse nach RAM sortiert
Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 15 Name, @{N='RAM_MB';E={[math]::Round($_.WorkingSet64/1MB)}}
```

---

## 2. Fernzugriff einrichten

1. Auf Reiners PC: **AnyDesk** runterladen → anydesk.com/de/downloads
   (AnyDesk ist einfacher als TeamViewer, kein Konto nötig)
2. AnyDesk öffnen → **Adresse notieren** (9-stellige Nummer)
3. Auf deinem Mac: AnyDesk installieren → Reiners Adresse eingeben → Verbinden
4. Reiner bestätigt auf seinem PC → fertig

---

## 3. Reiners Gehirn einrichten

### ZIP entpacken (wenn Fernzugriff steht oder direkt am PC)
Die ZIP liegt auf deinem Mac: `07 Anhänge/Reiners_Gehirn.zip`
- Per AnyDesk auf Reiners Desktop kopieren
- Oder per Email/WeTransfer an Reiner schicken
- Rechtsklick → "Alle extrahieren" → Desktop

### Obsidian einrichten
1. Obsidian öffnen → "Ordner als Tresor öffnen" → `Reiners_Gehirn` auf dem Desktop
2. Einstellungen (Zahnrad):
   - Dateien & Links → Anhänge: `07 Anhänge`
   - Dateien & Links → Neue Notizen: `01 Eingang`
   - Dateien & Links → Links automatisch aktualisieren: **An**
   - Editor → Rechtschreibprüfung: **An**
   - **Darstellung → Theme: Dark** (Reiner mag kein helles)

### Claude Desktop verbinden
1. Claude Desktop öffnen → mit Reiners Google-Konto einloggen (Pro Abo aktiv)
2. Einstellungen → Integrationen → Filesystem
3. Pfad: `C:\Users\Woldrich\Desktop\Reiners_Gehirn` (oder wo der Ordner liegt)
4. Speichern → Neuer Chat → Testen: "Lies meine CLAUDE.md"

### Diktierfunktion testen
1. **Win+H** → sprechen → Text erscheint
2. Falls nicht aktiv: Einstellungen → Tastatur → Diktierfunktion → An

---

## 4. Lieferung Volker Bens — Lagerschalenhalter

### Zeichnungen
- [ ] 2D-PDF Zeichnungsableitung aus Fusion
- [ ] 3D-PDF (Fusion → Export → 3D PDF)
- [ ] Stückliste als CSV liegt bereit: `07 Anhänge/Lagerschalenhalter_Stueckliste_Lebensmittel.csv`

### STEP-Problem (Volker kann Fusion-STEP nicht öffnen)
Fusion exportiert AP214/AP242 — Volkers älteres CAD kann das nicht lesen.

**Lösung 1 — In Fusion beim Export:**
- Datei → Exportieren → Typ: STEP → falls möglich **AP203** wählen

**Lösung 2 — IGES statt STEP:**
- Datei → Exportieren → **IGES** (.igs) — universell kompatibel, jedes CAD liest das

**Lösung 3 — Online konvertieren:**
- cadexchanger.com → STEP hochladen → als AP203 runterladen

### Paket für Volker
- [ ] 2D-PDF
- [ ] 3D-PDF
- [ ] STEP (AP203) oder IGES
- [ ] Stückliste (CSV oder direkt in der Zeichnung)

---

## 5. Erste Session mit Reiner

Reiner einfach drauflosreden lassen — Frage-Gegenfrage:
- "Reiner, erzähl mal — was machst du eigentlich den ganzen Tag?"
- "Was ist gerade dein größtes Projekt?"
- "Was nervt dich am meisten am Computer?"

Claude sortiert alles ein. Reiners erstes Erfolgserlebnis.

---

## Verknüpfungen

- [[02 Projekte/WEC Neustart mit Reiner/Reiners Gehirn - Setup Plan]]
- [[02 Projekte/WEC Neustart mit Reiner/WEC Neustart mit Reiner]]

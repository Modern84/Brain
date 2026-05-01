#!/bin/bash
# Mac Deep Scan - Sammelt System-Infos für Claude-Analyse
# Output: mac-scan-output.md im gleichen Ordner

OUTPUT="/Users/sh/Brain/04 Ressourcen/Scripts/mac-scan-output.md"

echo "# Mac Deep Scan — $(date '+%Y-%m-%d %H:%M')" > "$OUTPUT"
echo "" >> "$OUTPUT"

# ---------- HARDWARE ----------
echo "## Hardware" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
system_profiler SPHardwareDataType 2>/dev/null | grep -E "Model Name|Model Identifier|Chip|Total Number of Cores|Memory|Serial Number" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
echo "" >> "$OUTPUT"

# ---------- GRAFIK ----------
echo "## Grafik" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
system_profiler SPDisplaysDataType 2>/dev/null | grep -E "Chipset Model|Type|VRAM|Metal|Resolution|Vendor" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
echo "" >> "$OUTPUT"

# ---------- macOS ----------
echo "## Betriebssystem" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
sw_vers >> "$OUTPUT"
echo "Uptime: $(uptime)" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
echo "" >> "$OUTPUT"

# ---------- SPEICHER (Disk) ----------
echo "## Speicherplatz (Disk)" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
df -h / /System/Volumes/Data 2>/dev/null >> "$OUTPUT"
echo '```' >> "$OUTPUT"
echo "" >> "$OUTPUT"

# ---------- RAM ----------
echo "## RAM-Nutzung" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
top -l 1 -n 0 | grep -E "PhysMem|CPU usage|Load Avg" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
echo "" >> "$OUTPUT"

# ---------- SICHERHEIT ----------
echo "## Sicherheit" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
echo "FileVault (Festplatten-Verschlüsselung):"
fdesetup status 2>/dev/null >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "Gatekeeper (App-Signatur-Check):" >> "$OUTPUT"
spctl --status 2>/dev/null >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "SIP (System Integrity Protection):" >> "$OUTPUT"
csrutil status 2>/dev/null >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "Firewall:" >> "$OUTPUT"
/usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate 2>/dev/null >> "$OUTPUT"
echo '```' >> "$OUTPUT"
echo "" >> "$OUTPUT"

# ---------- TOP 20 GRÖSSTE APPS ----------
echo "## Top 20 größte Apps (/Applications)" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
du -sh /Applications/*.app 2>/dev/null | sort -rh | head -20 >> "$OUTPUT"
echo '```' >> "$OUTPUT"
echo "" >> "$OUTPUT"

# ---------- TOP 15 GRÖSSTE ORDNER IM HOME ----------
echo "## Top 15 größte Ordner im Home" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
du -sh ~/* 2>/dev/null | sort -rh | head -15 >> "$OUTPUT"
echo '```' >> "$OUTPUT"
echo "" >> "$OUTPUT"

# ---------- TOP 15 GRÖSSTE VERSTECKTE ORDNER ----------
echo "## Top 15 größte versteckte Ordner im Home" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
du -sh ~/.[^.]* 2>/dev/null | sort -rh | head -15 >> "$OUTPUT"
echo '```' >> "$OUTPUT"
echo "" >> "$OUTPUT"

# ---------- DOWNLOADS-ORDNER ----------
echo "## Downloads-Ordner (Top 10 größte)" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
du -sh ~/Downloads/* 2>/dev/null | sort -rh | head -10 >> "$OUTPUT"
echo '```' >> "$OUTPUT"
echo "" >> "$OUTPUT"

# ---------- HOMEBREW ----------
echo "## Homebrew Pakete" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
echo "=== Formeln (CLI-Tools) ===" >> "$OUTPUT"
brew list --formula 2>/dev/null >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "=== Casks (GUI-Apps) ===" >> "$OUTPUT"
brew list --cask 2>/dev/null >> "$OUTPUT"
echo '```' >> "$OUTPUT"
echo "" >> "$OUTPUT"

# ---------- TOP 15 PROZESSE (CPU) ----------
echo "## Top 15 Prozesse (CPU-Last)" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
ps aux | sort -rk 3 | head -16 | awk '{printf "%-6s %-6s %-6s %s\n", $1, $3"%", $4"%", $11}' >> "$OUTPUT"
echo '```' >> "$OUTPUT"
echo "" >> "$OUTPUT"

# ---------- TOP 15 PROZESSE (RAM) ----------
echo "## Top 15 Prozesse (RAM-Last)" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
ps aux | sort -rk 4 | head -16 | awk '{printf "%-6s %-6s %-6s %s\n", $1, $3"%", $4"%", $11}' >> "$OUTPUT"
echo '```' >> "$OUTPUT"
echo "" >> "$OUTPUT"

# ---------- LAUNCHAGENTS / STARTUP ----------
echo "## Startup-Items (Login-Agents)" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
echo "=== User LaunchAgents ===" >> "$OUTPUT"
ls ~/Library/LaunchAgents 2>/dev/null >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "=== Global LaunchAgents ===" >> "$OUTPUT"
ls /Library/LaunchAgents 2>/dev/null >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "=== LaunchDaemons ===" >> "$OUTPUT"
ls /Library/LaunchDaemons 2>/dev/null >> "$OUTPUT"
echo '```' >> "$OUTPUT"
echo "" >> "$OUTPUT"

# ---------- NETZWERK ----------
echo "## Netzwerk" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
echo "=== Aktive Netzwerk-Services ===" >> "$OUTPUT"
networksetup -listallnetworkservices 2>/dev/null | head -15 >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "=== Aktuelles Netzwerk ===" >> "$OUTPUT"
networksetup -getairportnetwork en0 2>/dev/null >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "=== Tailscale Status ===" >> "$OUTPUT"
tailscale status 2>/dev/null | head -10 >> "$OUTPUT"
echo '```' >> "$OUTPUT"
echo "" >> "$OUTPUT"

# ---------- LETZTE APPS GEÖFFNET ----------
echo "## Zuletzt geöffnete Apps (letzte 7 Tage)" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
find /Applications -name "*.app" -maxdepth 2 -atime -7 2>/dev/null | head -20 >> "$OUTPUT"
echo '```' >> "$OUTPUT"
echo "" >> "$OUTPUT"

# ---------- NIE ODER SELTEN GENUTZTE APPS ----------
echo "## Apps seit 90+ Tagen nicht geöffnet" >> "$OUTPUT"
echo '```' >> "$OUTPUT"
find /Applications -name "*.app" -maxdepth 2 -atime +90 2>/dev/null | head -30 >> "$OUTPUT"
echo '```' >> "$OUTPUT"
echo "" >> "$OUTPUT"

# ---------- FERTIG ----------
echo "---" >> "$OUTPUT"
echo "Scan fertig. Output: $OUTPUT" >> "$OUTPUT"
echo ""
echo "✅ Scan abgeschlossen."
echo "📄 Report: $OUTPUT"

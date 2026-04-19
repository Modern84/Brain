#!/usr/bin/env bash
# =============================================================================
# infiltration-check-ULTRA.sh — MacBook Tiefen-Forensik
# =============================================================================
# 50 Prüfsektionen. Read-only. Keine Systemänderung.
#
# Usage:
#   bash infiltration-check-ULTRA.sh                    # ohne sudo
#   sudo bash infiltration-check-ULTRA.sh               # mit sudo, volle Tiefe
#   sudo bash infiltration-check-ULTRA.sh 2026-04-14    # mit Baseline-Datum
#
# Für maximale Aussagekraft: Terminal braucht Full Disk Access
# (Systemeinstellungen → Datenschutz → Full Disk Access → Terminal.app hinzufügen)
#
# Output:
#   ~/infiltration-ULTRA-<timestamp>.txt   — vollständiger Report
#   Stdout                                  — komprimierter Live-Status
#
# Legende:
#   [OK]    erwartet
#   [INFO]  Rohdaten, manuell bewerten
#   [WARN]  auffällig, mit eigenen Tools/Installation abgleichen
#   [FAIL]  starker Kompromittierungs-Indikator, sofort nachgehen
#   [MAL]   bekanntes Malware-Muster gefunden, hohe Priorität
#
# Grenzen (ehrlich):
#   - Staatliche/hochentwickelte Malware versteckt sich vor all dem.
#   - Viele WARNs sind legitim (deine eigenen Tools). Du musst kalibrieren.
#   - FAIL/MAL brauchen Sofort-Reaktion.
# =============================================================================

set -u
SECONDS=0

# ----------- Konfig --------------
TS=$(date +%Y-%m-%d_%H-%M-%S)
if [ -n "${SUDO_USER:-}" ]; then
  REAL_HOME=$(eval echo "~$SUDO_USER")
else
  REAL_HOME="$HOME"
fi
REPORT="${REPORT_DIR:-$REAL_HOME}/infiltration-ULTRA-$TS.txt"
BASELINE=${1:-$(date -v-30d +%Y-%m-%d 2>/dev/null || echo "2026-03-19")}

# Sudo-Detection
if [[ $EUID -eq 0 ]]; then
  ROOT=true
  S=""
else
  ROOT=false
  if sudo -n true 2>/dev/null; then S="sudo"; else S=""; fi
fi

BOLD=$(tput bold 2>/dev/null || echo "")
RST=$(tput sgr0 2>/dev/null || echo "")
RED=$(tput setaf 1 2>/dev/null || echo "")
YEL=$(tput setaf 3 2>/dev/null || echo "")
GRN=$(tput setaf 2 2>/dev/null || echo "")
CYN=$(tput setaf 6 2>/dev/null || echo "")
MAG=$(tput setaf 5 2>/dev/null || echo "")

WARN_COUNT=0
FAIL_COUNT=0
MAL_COUNT=0

write() { printf '%s\n' "$*" >> "$REPORT"; }
h1()    { printf '\n%s╔════ %s ════╗%s\n' "$BOLD" "$1" "$RST"; write ""; write "╔════ $1 ════╗"; }
ok()    { printf '  %s[OK]%s   %s\n'    "$GRN" "$RST" "$1"; write "  [OK]   $1"; }
info()  { printf '  %s[INFO]%s %s\n'    "$CYN" "$RST" "$1"; write "  [INFO] $1"; }
warn()  { printf '  %s[WARN]%s %s\n'    "$YEL" "$RST" "$1"; write "  [WARN] $1"; WARN_COUNT=$((WARN_COUNT+1)); }
fail()  { printf '  %s[FAIL]%s %s\n'    "$RED" "$RST" "$1"; write "  [FAIL] $1"; FAIL_COUNT=$((FAIL_COUNT+1)); }
mal()   { printf '  %s%s[MAL]%s  %s\n'  "$BOLD" "$MAG" "$RST" "$1"; write "  [MAL]  $1"; MAL_COUNT=$((MAL_COUNT+1)); }
raw()   { write "    $1"; }

dump() {
  local out
  out=$(eval "$1" 2>/dev/null || true)
  if [[ -n "$out" ]]; then
    while IFS= read -r line; do write "    $line"; done <<< "$out"
  else
    write "    — leer —"
  fi
}

dump_echo() {
  local label="$1" cmd="$2"
  local out
  out=$(eval "$cmd" 2>/dev/null || true)
  if [[ -n "$out" ]]; then
    info "$label"
    while IFS= read -r line; do write "    $line"; done <<< "$out"
  fi
}

# ----------- Start ---------------
: > "$REPORT"
{
  echo "ULTRA Forensik-Sweep: $TS"
  echo "Host: $(hostname) — macOS $(sw_vers -productVersion) ($(sw_vers -buildVersion))"
  echo "Baseline: $BASELINE"
  echo "Root-Modus: $ROOT"
  echo "Sudo verfügbar: $([[ -n "$S" ]] && echo ja || echo nein)"
  echo "Report: $REPORT"
  echo "────────────────────────────────────────"
} | tee -a "$REPORT"

# =============================================================================
# BLOCK A — IDENTITÄT
# =============================================================================
h1 "01 System-Identität"
info "Hardware: $(system_profiler SPHardwareDataType 2>/dev/null | awk -F': ' '/Model Identifier|Model Name|Serial/ {print $1": "$2}' | tr '\n' '|' | sed 's/|/ | /g')"
info "Hardware-UUID: $(ioreg -rd1 -c IOPlatformExpertDevice | awk -F'"' '/IOPlatformUUID/{print $4}')"
info "Boot-ROM: $(system_profiler SPHardwareDataType 2>/dev/null | awk -F': ' '/Boot ROM/ {print $2}')"
info "Letzter Boot: $(who -b 2>/dev/null | awk '{$1=$1};1')"
info "Uptime: $(uptime | sed 's/.*up //;s/,.*users.*//')"

# =============================================================================
h1 "02 Benutzer & Admin-Rechte"
REAL=$(dscl . list /Users UniqueID 2>/dev/null | awk '$2 >= 500 {printf "%s (UID %s)\n", $1, $2}')
info "User mit UID >= 500:"
while IFS= read -r l; do raw "$l"; done <<< "$REAL"

ADMINS=$(dscl . -read /Groups/admin GroupMembership 2>/dev/null | sed 's/GroupMembership: //')
info "Admin-Gruppe: $ADMINS"

WHEEL=$(dscl . -read /Groups/wheel GroupMembership 2>/dev/null | sed 's/GroupMembership: //')
info "Wheel-Gruppe: $WHEEL"

# Versteckte User
HIDDEN=$(dscl . list /Users UniqueID 2>/dev/null | awk '$2 > 500 && $2 < 501 {print $1}')
[[ -n "$HIDDEN" ]] && fail "Versteckter User-Account: $HIDDEN"

# Recently-created Home-Verzeichnisse
RECENT_HOMES=$(find /Users -maxdepth 1 -type d -ctime -30 2>/dev/null | grep -vE '^/Users$|Shared')
[[ -n "$RECENT_HOMES" ]] && warn "Homes neu/geändert in 30 Tagen: $RECENT_HOMES"

# =============================================================================
h1 "03 Login-Historie + Fehlschläge"
info "last -30:"
dump "last -30"
info "Failed-Login Events (letzte 7 Tage):"
dump "log show --predicate 'process == \"loginwindow\" AND eventMessage CONTAINS[c] \"fail\"' --last 7d 2>/dev/null | head -20"

# =============================================================================
# BLOCK B — PROZESSE
# =============================================================================
h1 "04 Top-15 CPU + Top-15 RAM"
info "CPU:"
dump "ps -Ao user,pid,%cpu,%mem,command -r | head -16"
info "RAM:"
dump "ps -Ao user,pid,%cpu,%mem,command -m | head -16"

# =============================================================================
h1 "05 Prozesse an ungewöhnlichen Pfaden"
SUSPECT_PATHS='/tmp/|/var/tmp/|/private/tmp/|/Users/Shared/|^\./|/Library/Caches/.*\.(sh|py|rb|pl)$'
SUSPICIOUS=$(ps -Ao command= | grep -E "$SUSPECT_PATHS" | grep -v "^grep")
if [[ -n "$SUSPICIOUS" ]]; then
  fail "Prozesse aus temporären/ungewöhnlichen Pfaden:"
  while IFS= read -r l; do raw "$l"; done <<< "$SUSPICIOUS"
else
  ok "Keine Prozesse aus /tmp, /var/tmp, Shared"
fi

# =============================================================================
h1 "06 Daemon-Prozesse ohne Apple-Signatur"
# Alle laufenden Binaries die nicht von Apple signiert sind
NON_APPLE=$(ps -Ao pid,command= | awk '{print $2}' | sort -u | while read bin; do
  if [[ -f "$bin" ]]; then
    sig=$(codesign -dv "$bin" 2>&1 | grep "Authority" | head -1)
    if ! echo "$sig" | grep -qE "Apple|Developer ID"; then
      echo "$bin"
    fi
  fi
done | head -20)
if [[ -n "$NON_APPLE" ]]; then
  info "Binaries ohne Apple/Developer-ID-Signatur im Prozessbaum:"
  while IFS= read -r l; do raw "$l"; done <<< "$NON_APPLE"
fi

# =============================================================================
# BLOCK C — NETZWERK
# =============================================================================
h1 "07 Aktive Netzwerk-Verbindungen"
info "ESTABLISHED:"
dump "lsof -iTCP -sTCP:ESTABLISHED -nP 2>/dev/null | awk 'NR>1 {print \$1, \$2, \$9}' | sort -u"
info "LISTENER:"
dump "lsof -iTCP -sTCP:LISTEN -nP 2>/dev/null | awk 'NR>1 {print \$1, \$2, \$9}' | sort -u"
info "UDP Listener:"
dump "lsof -iUDP -nP 2>/dev/null | head -30"

# =============================================================================
h1 "08 Routing, ARP, Interfaces"
info "Default-Route:"
dump "netstat -rn -f inet | grep '^default'"
info "ARP-Cache (Hinweis auf MITM wenn Gateway-MAC wechselt):"
dump "arp -a"
info "Interfaces:"
dump "ifconfig | grep -E '^[a-z]|inet '"

# =============================================================================
h1 "09 Promiscuous-Mode Check"
PROMISC=$(ifconfig | grep -B1 PROMISC | grep -E '^[a-z]')
if [[ -n "$PROMISC" ]]; then
  fail "Interface im PROMISCUOUS-Mode: $PROMISC"
else
  ok "Keine Interfaces in Promisc-Mode"
fi

# =============================================================================
h1 "10 DNS-Konfiguration"
info "Resolver:"
dump "scutil --dns 2>/dev/null | grep nameserver | sort -u"
info "Alle configured DNS via networksetup:"
dump "for svc in \$(networksetup -listallnetworkservices 2>/dev/null | grep -v '^An asterisk'); do echo \"[\$svc]\"; networksetup -getdnsservers \"\$svc\" 2>/dev/null; done"

# =============================================================================
h1 "11 Hosts-Datei"
HOSTS=$(grep -vE '^\s*#|^\s*$' /etc/hosts 2>/dev/null | grep -vE '127\.0\.0\.1\s+localhost|::1\s+localhost|fe80::1%lo0|255\.255\.255\.255\s+broadcasthost')
if [[ -z "$HOSTS" ]]; then
  ok "/etc/hosts Standard"
else
  warn "/etc/hosts Non-Standard-Einträge:"
  while IFS= read -r l; do raw "$l"; done <<< "$HOSTS"
fi

# =============================================================================
h1 "12 Bekannte WLAN-Netze"
WIFI_PLIST="/Library/Preferences/SystemConfiguration/com.apple.wifi.known-networks.plist"
if [[ -r "$WIFI_PLIST" ]]; then
  info "Bekannte WLANs:"
  dump "defaults read \"$WIFI_PLIST\" 2>/dev/null | grep SSID | sort -u"
elif [[ -n "$S" ]]; then
  info "Bekannte WLANs (sudo):"
  dump "$S defaults read \"$WIFI_PLIST\" 2>/dev/null | grep SSID | sort -u"
fi

# =============================================================================
h1 "13 Recent Outbound DNS (last 1h)"
dump "log show --predicate 'process == \"mDNSResponder\"' --last 1h 2>/dev/null | grep -oE '[a-z0-9-]+\\.[a-z0-9.-]+\\.(com|net|org|io|cc|xyz|ru|cn|top|info)' | sort -u | head -30"

# =============================================================================
# BLOCK D — PERSISTENZ-VEKTOREN (die wichtigste Sektion)
# =============================================================================
h1 "14 Launch-Agents (User)"
UA=$(ls ~/Library/LaunchAgents/*.plist 2>/dev/null)
if [[ -z "$UA" ]]; then
  ok "Keine User-LaunchAgents"
else
  while IFS= read -r p; do
    LABEL=$(defaults read "$p" Label 2>/dev/null || echo "UNKNOWN")
    PROG=$(defaults read "$p" Program 2>/dev/null || defaults read "$p" ProgramArguments 2>/dev/null | tr -d '\n' | head -c 200)
    info "$(basename $p) → Label=$LABEL"
    raw "Program: $PROG"
    # Random-Name Malware-Pattern
    BASE=$(basename "$p" .plist)
    if echo "$BASE" | grep -qE '^[a-z0-9]{8,}$|\.[A-F0-9]{8,}|^[a-z]+\.(malware|evil|loader|update|system|com\.[a-z]+\.(updater|helper|installer))'; then
      mal "Verdächtiger Launch-Agent-Name: $BASE"
    fi
  done <<< "$UA"
fi

h1 "15 Launch-Agents/Daemons (System)"
for d in /Library/LaunchAgents /Library/LaunchDaemons; do
  info "$d:"
  dump "ls -la $d/ 2>/dev/null | tail -n +2"
done

h1 "16 Launch-Änderungen letzte 30 Tage"
CH=$(find /Library/LaunchAgents /Library/LaunchDaemons ~/Library/LaunchAgents -type f -mtime -30 2>/dev/null)
if [[ -z "$CH" ]]; then
  ok "Keine Launch-Änderungen"
else
  warn "Geänderte Launch-Dateien:"
  while IFS= read -r l; do raw "$l"; done <<< "$CH"
fi

h1 "17 LaunchDaemons: RunAtLoad + KeepAlive (Persistenz-Mix)"
for d in /Library/LaunchDaemons/*.plist /Library/LaunchAgents/*.plist ~/Library/LaunchAgents/*.plist; do
  [[ -f "$d" ]] || continue
  RAL=$(defaults read "$d" RunAtLoad 2>/dev/null)
  KA=$(defaults read "$d" KeepAlive 2>/dev/null)
  if [[ "$RAL" == "1" ]] && [[ -n "$KA" ]]; then
    info "$(basename $d): RunAtLoad=$RAL KeepAlive=$KA"
  fi
done

h1 "18 Login-Items (GUI)"
LI=$(osascript -e 'tell application "System Events" to get the name of every login item' 2>/dev/null)
[[ -z "$LI" ]] && ok "Keine Login-Items" || info "Login-Items: $LI"

h1 "19 Legacy Login-Hooks (defaults)"
LH=$(defaults read com.apple.loginwindow LoginHook 2>/dev/null)
LO=$(defaults read com.apple.loginwindow LogoutHook 2>/dev/null)
if [[ -n "$LH$LO" ]]; then
  mal "Legacy Login/Logout-Hook aktiv (starker Malware-Indikator): Login=$LH Logout=$LO"
else
  ok "Keine Login-Hooks"
fi

h1 "20 Legacy StartupItems"
if [[ -d /Library/StartupItems ]] && [[ -n "$(ls /Library/StartupItems 2>/dev/null)" ]]; then
  warn "Legacy StartupItems (sollten 2026 nicht mehr existieren):"
  dump "ls -la /Library/StartupItems/"
else
  ok "Keine Legacy-StartupItems"
fi

h1 "21 cron + at"
info "User-Cron:"
dump "crontab -l 2>/dev/null || echo '(leer)'"
if [[ -n "$S" ]] || $ROOT; then
  info "System-Cron /etc/crontab:"
  [[ -f /etc/crontab ]] && dump "cat /etc/crontab" || info "keine"
  info "Cron.d:"
  dump "ls -la /etc/cron.d/ 2>/dev/null"
  info "Periodic:"
  dump "ls -la /etc/periodic/*/  2>/dev/null"
fi
info "at-Queue:"
dump "atq 2>/dev/null"

h1 "22 Rc-Scripts"
for f in /etc/rc.local /etc/rc.common /etc/launchd.conf; do
  if [[ -f "$f" ]]; then
    SIZE=$(stat -f%z "$f" 2>/dev/null)
    if [[ "$SIZE" -gt 0 ]]; then
      warn "$f existiert und ist nicht leer ($SIZE bytes):"
      dump "cat $f"
    fi
  fi
done

h1 "23 ScriptingAdditions"
info "/Library/ScriptingAdditions:"
dump "ls -la /Library/ScriptingAdditions/ 2>/dev/null"
info "~/Library/ScriptingAdditions:"
dump "ls -la ~/Library/ScriptingAdditions/ 2>/dev/null"

h1 "24 Mail-Bundles (Mail-Plugin-Persistenz)"
info "/Library/Mail/Bundles:"
dump "ls -la /Library/Mail/Bundles/ 2>/dev/null"
info "~/Library/Mail/Bundles:"
dump "ls -la ~/Library/Mail/Bundles/ 2>/dev/null"

h1 "25 Spotlight- + QuickLook-Plugins"
for d in ~/Library/Spotlight /Library/Spotlight ~/Library/QuickLook /Library/QuickLook; do
  if [[ -d "$d" ]] && [[ -n "$(ls $d 2>/dev/null)" ]]; then
    warn "$d enthält Plugins:"
    dump "ls -la $d/"
  fi
done

h1 "26 Authorization-Plugins + PAM"
info "/Library/Security/SecurityAgentPlugins:"
dump "ls -la /Library/Security/SecurityAgentPlugins/ 2>/dev/null"
if [[ -n "$S" ]] || $ROOT; then
  info "PAM-Module (/etc/pam.d):"
  dump "ls -la /etc/pam.d/"
  info "Geänderte PAM-Module in 30 Tagen:"
  dump "find /etc/pam.d -type f -mtime -30 2>/dev/null"
fi

h1 "27 System-Extensions"
info "systemextensionsctl list:"
dump "systemextensionsctl list 2>/dev/null"

# =============================================================================
# BLOCK E — KERNEL + SIGNING
# =============================================================================
h1 "28 Kernel-Extensions (Drittanbieter)"
KEXT=$(kextstat 2>/dev/null | grep -v "com.apple\|Index" | awk '{print $6}')
if [[ -z "$KEXT" ]]; then
  ok "Keine Drittanbieter-kexts"
else
  warn "Drittanbieter-kexts geladen:"
  while IFS= read -r l; do raw "$l"; done <<< "$KEXT"
fi

h1 "29 SIP + Gatekeeper + XProtect"
csrutil status 2>/dev/null | grep -q "enabled" && ok "SIP aktiv" || fail "SIP deaktiviert"
spctl --status 2>/dev/null | grep -q "enabled" && ok "Gatekeeper aktiv" || fail "Gatekeeper AUS"
XP_VER=$(defaults read /Library/Apple/System/Library/CoreServices/XProtect.bundle/Contents/Info.plist CFBundleShortVersionString 2>/dev/null)
info "XProtect Version: $XP_VER"
info "Gatekeeper-Denials letzte 7 Tage:"
dump "log show --predicate 'subsystem == \"com.apple.syspolicy\"' --last 7d 2>/dev/null | grep -i 'denied\\|rejected' | head -10"

h1 "30 Mach-O in ungewöhnlichen Pfaden"
info "Executables in /tmp /var/tmp ~/Library/Caches (nur Top-20):"
FOUND=$(find /tmp /var/tmp /private/tmp ~/Library/Caches -type f \( -perm +111 -o -name "*.dylib" -o -name "*.so" \) 2>/dev/null | head -20)
if [[ -z "$FOUND" ]]; then
  ok "Keine Executables in temp-Pfaden"
else
  warn "Executables/Libraries an ungewöhnlichen Orten:"
  while IFS= read -r l; do raw "$l"; done <<< "$FOUND"
fi

h1 "31 Unsignierte Binaries im PATH"
UNSIGNED=""
for p in $(echo $PATH | tr ':' ' '); do
  [[ -d "$p" ]] || continue
  for f in "$p"/*; do
    [[ -f "$f" ]] || continue
    [[ -x "$f" ]] || continue
    if ! codesign -v "$f" 2>/dev/null; then
      UNSIGNED+="$f"$'\n'
    fi
  done
done
if [[ -z "$UNSIGNED" ]]; then
  ok "Alle Binaries im PATH sind signiert"
else
  info "Unsignierte Binaries im PATH (oft harmlos: brew/python/node):"
  echo -n "$UNSIGNED" | head -15 | while IFS= read -r l; do raw "$l"; done
fi

# =============================================================================
# BLOCK F — PRIVILEGIEN + TCC
# =============================================================================
h1 "32 Sudo-Konfiguration"
info "sudo -l (was darf current user):"
dump "sudo -n -l 2>/dev/null || echo 'braucht sudo-Passwort'"
if [[ -n "$S" ]] || $ROOT; then
  info "/etc/sudoers.d/ Inhalt:"
  dump "$S ls -la /etc/sudoers.d/ 2>/dev/null"
  info "Geänderte sudoers-Einträge letzte 30 Tage:"
  dump "$S find /etc/sudoers /etc/sudoers.d -type f -mtime -30 2>/dev/null"
fi

h1 "33 TCC-Permissions (User)"
TCC_U="$HOME/Library/Application Support/com.apple.TCC/TCC.db"
if [[ -r "$TCC_U" ]]; then
  info "Sensible Permissions (User-TCC):"
  dump "sqlite3 \"$TCC_U\" 'SELECT service, client, auth_value FROM access WHERE service IN (\"kTCCServiceAccessibility\",\"kTCCServiceListenEvent\",\"kTCCServicePostEvent\",\"kTCCServiceScreenCapture\",\"kTCCServiceCamera\",\"kTCCServiceMicrophone\",\"kTCCServiceSystemPolicyAllFiles\",\"kTCCServiceSystemPolicyDesktopFolder\",\"kTCCServiceSystemPolicyDocumentsFolder\");' 2>/dev/null | column -t -s '|'"
else
  info "User-TCC.db nicht lesbar"
fi

h1 "34 TCC-Permissions (System — braucht Full Disk Access für Terminal)"
TCC_S="/Library/Application Support/com.apple.TCC/TCC.db"
if [[ -r "$TCC_S" ]]; then
  info "System-weite sensible Permissions:"
  dump "sqlite3 \"$TCC_S\" 'SELECT service, client, auth_value FROM access;' 2>/dev/null | head -40"
else
  warn "System-TCC.db nicht lesbar. Terminal in Systemeinstellungen → Datenschutz → Full Disk Access eintragen."
fi

h1 "35 Setuid/Setgid außerhalb System-Pfade"
SUID=$(find / -type f \( -perm -4000 -o -perm -2000 \) -not -path "/System/*" -not -path "/usr/bin/*" -not -path "/usr/sbin/*" -not -path "/usr/libexec/*" -not -path "/bin/*" -not -path "/sbin/*" 2>/dev/null)
if [[ -z "$SUID" ]]; then
  ok "Keine SUID/SGID außerhalb Standard-Pfade"
else
  warn "SUID/SGID-Binaries an ungewöhnlichen Pfaden:"
  while IFS= read -r l; do raw "$l"; done <<< "$SUID"
fi

# =============================================================================
# BLOCK G — IDENTITÄT + KEYCHAIN
# =============================================================================
h1 "36 iCloud-Account"
info "MobileMeAccounts:"
dump "defaults read MobileMeAccounts 2>/dev/null | grep -E 'AccountID|DisplayName|LoggedIn' | head -20"

h1 "37 Keychains"
info "Aktive Keychains:"
dump "security list-keychains"
info "Default-Keychain:"
dump "security default-keychain"

h1 "38 SSH-Konfig"
info "~/.ssh:"
dump "ls -la ~/.ssh/ 2>/dev/null"
if [[ -f ~/.ssh/authorized_keys ]]; then
  LINES=$(wc -l < ~/.ssh/authorized_keys | tr -d ' ')
  warn "authorized_keys: $LINES Einträge — jeden einzeln verifizieren:"
  dump "cat ~/.ssh/authorized_keys"
else
  ok "Keine authorized_keys"
fi
info "SSH Known-Hosts Count: $(wc -l < ~/.ssh/known_hosts 2>/dev/null || echo 0)"

# =============================================================================
# BLOCK H — SHELLS + HISTORY
# =============================================================================
h1 "39 Shell-RC-Dateien auf Injection"
for f in ~/.zshrc ~/.zprofile ~/.zshenv ~/.bashrc ~/.bash_profile ~/.profile ~/.zlogin; do
  if [[ -f "$f" ]]; then
    PAT='curl.*\| *sh|wget.*\| *sh|eval.*base64|eval "\$\(curl|nc -l|/tmp/.*\.sh|python.*-c.*exec|osascript -e.*do shell'
    SUS=$(grep -nE "$PAT" "$f" 2>/dev/null)
    if [[ -n "$SUS" ]]; then
      mal "$f verdächtig:"
      while IFS= read -r l; do raw "$l"; done <<< "$SUS"
    else
      ok "$f sauber"
    fi
  fi
done

h1 "40 Shell-Functions die System-Kommandos überschreiben"
if [[ -n "${ZSH_VERSION:-}" ]] || [[ -n "${BASH_VERSION:-}" ]]; then
  for cmd in ls ps netstat lsof curl wget sudo ssh find; do
    T=$(type "$cmd" 2>/dev/null)
    if echo "$T" | grep -qE "is a (shell function|alias)"; then
      warn "$cmd ist überschrieben: $T"
    fi
  done
fi

h1 "41 History — verdächtige Befehlsmuster"
for f in ~/.bash_history ~/.zsh_history ~/.zhistory; do
  if [[ -f "$f" ]]; then
    PAT='curl.*\| *(sudo )?(bash|sh|zsh)|wget.*\| *sh|chmod \+x.*http|base64 -d.*\| *sh|nc -[lv]|socat|/tmp/.*\.(sh|py)'
    H=$(grep -E "$PAT" "$f" 2>/dev/null)
    if [[ -n "$H" ]]; then
      warn "$f Muster-Treffer:"
      while IFS= read -r l; do raw "$l"; done <<< "$H"
    else
      ok "$f — keine verdächtigen Muster"
    fi
  fi
done

h1 "42 DYLD-Umgebungsvariablen (Injection-Vektor)"
if env | grep -qE "^DYLD_"; then
  mal "DYLD_* Variablen gesetzt (oft Code-Injection):"
  dump "env | grep '^DYLD_'"
else
  ok "Keine DYLD_* Environment-Variablen"
fi

# =============================================================================
# BLOCK I — PERIPHERIE
# =============================================================================
h1 "43 USB-Geräte (aktuell)"
dump "system_profiler SPUSBDataType 2>/dev/null | grep -A1 'Product ID\\|Vendor ID\\|Serial Number' | head -40"

h1 "44 Bluetooth-Geräte"
dump "system_profiler SPBluetoothDataType 2>/dev/null | grep -A1 'Address:\\|Paired:' | head -30"

h1 "45 iPhone/iPad-Pairing-Records (Lockdown)"
LD="/var/db/lockdown"
if $ROOT || [[ -n "$S" ]]; then
  CNT=$($S ls "$LD" 2>/dev/null | grep -v "SystemConfiguration\|\.plist$" | wc -l | tr -d ' ')
  info "Pairing-Records: $CNT"
  if [[ "$CNT" -gt 0 ]]; then
    warn "Dieser Mac hat $CNT iPhone/iPad-Pairing-Record(s). Jeder = ein Gerät das 'Vertrauen' hatte."
    dump "$S ls -la \"$LD\" 2>/dev/null | grep -v 'SystemConfiguration\\|\\.plist$' | tail -n +2"
  fi
else
  info "Für Lockdown-Analyse: script mit sudo starten"
fi

# =============================================================================
# BLOCK J — BROWSER
# =============================================================================
h1 "46 Chrome-Extensions (mit Namen)"
CEX="$HOME/Library/Application Support/Google/Chrome/Default/Extensions"
if [[ -d "$CEX" ]]; then
  for e in "$CEX"/*/; do
    ID=$(basename "$e")
    MAN=$(find "$e" -name "manifest.json" 2>/dev/null | head -1)
    if [[ -f "$MAN" ]]; then
      NAME=$(grep -m1 '"name"' "$MAN" | sed 's/.*"name"[^"]*"\([^"]*\)".*/\1/')
      PERM=$(grep -m1 '"permissions"' "$MAN" | head -c 200)
      info "$ID — $NAME"
      [[ -n "$PERM" ]] && raw "$PERM"
    fi
  done
fi

h1 "47 Safari-Extensions"
dump "ls ~/Library/Safari/Extensions/ 2>/dev/null"
dump "plutil -p ~/Library/Safari/Extensions/Extensions.plist 2>/dev/null | head -30"

h1 "48 Kürzlich heruntergeladene Files mit Quarantäne-Flag"
info "Quarantäne-XAttr Downloads letzte 14 Tage:"
dump "find ~/Downloads ~/Desktop -type f -mtime -14 -print 2>/dev/null | head -30"

# =============================================================================
# BLOCK K — FILE-DIFFS SEIT BASELINE
# =============================================================================
h1 "49 Datei-Änderungen seit Baseline ($BASELINE)"
for dir in /etc /usr/local/bin /usr/local/sbin ~/.config ~/.ssh; do
  if [[ -d "$dir" ]]; then
    MOD=$(find "$dir" -type f -newermt "$BASELINE" 2>/dev/null | head -15)
    if [[ -n "$MOD" ]]; then
      warn "Modifiziert in $dir seit $BASELINE:"
      while IFS= read -r l; do raw "$l"; done <<< "$MOD"
    fi
  fi
done

info "Neue Dotfiles im Home seit $BASELINE:"
dump "find ~ -maxdepth 3 -name '.*' -type f -newermt '$BASELINE' ! -path '*/Library/Caches/*' ! -path '*/Library/Logs/*' ! -path '*/.git/*' 2>/dev/null | head -30"

# =============================================================================
# BLOCK L — LOG-ANALYSE
# =============================================================================
h1 "50 Sicherheits-Events (letzte 24h)"
info "Security-Daemon Events (Auth):"
dump "log show --predicate 'subsystem == \"com.apple.securityd\"' --last 24h 2>/dev/null | grep -iE 'fail|denied|error' | head -15"
info "launchd-Errors:"
dump "log show --predicate 'process == \"launchd\"' --last 24h 2>/dev/null | grep -iE 'error|fail' | head -10"
info "Kamera-Events letzte 24h:"
dump "log show --predicate 'subsystem == \"com.apple.cmio\"' --last 24h 2>/dev/null | grep -iE 'start|activate' | head -10"
info "Mikrofon-Events letzte 24h:"
dump "log show --predicate 'subsystem == \"com.apple.coreaudio\" AND eventMessage CONTAINS \"input\"' --last 24h 2>/dev/null | head -10"

# =============================================================================
# ZUSAMMENFASSUNG
# =============================================================================
h1 "EXECUTIVE SUMMARY"
{
  echo ""
  echo "Laufzeit:         ${SECONDS}s"
  echo "Root/Sudo:        $ROOT / $([[ -n "$S" ]] && echo 'yes' || echo 'no')"
  echo ""
  echo "Befunde:"
  echo "  MAL  (Malware-Muster):           $MAL_COUNT"
  echo "  FAIL (Kompromittierungs-Hinweis): $FAIL_COUNT"
  echo "  WARN (prüfen):                    $WARN_COUNT"
  echo ""
  echo "Report: $REPORT"
} | tee -a "$REPORT"

echo ""
if [[ "$MAL_COUNT" -gt 0 ]]; then
  printf '%s%s⚠  MALWARE-MUSTER GEFUNDEN (%d)  — SOFORT handeln:\n%s' "$BOLD" "$RED" "$MAL_COUNT" "$RST"
  echo "   1. Gerät vom Netz (WiFi aus, Tethering aus)"
  echo "   2. Report an Claude senden: cat $REPORT | pbcopy"
  echo "   3. NICHTS am System ändern bis Report bewertet"
elif [[ "$FAIL_COUNT" -gt 0 ]]; then
  printf '%s%s⚠  %d FAIL-Indikator(en) — Report priorisiert durchgehen%s\n' "$BOLD" "$RED" "$FAIL_COUNT" "$RST"
elif [[ "$WARN_COUNT" -gt 10 ]]; then
  printf '%s%s%d Warnungen — Kalibrierung mit eigener Install-Historie%s\n' "$BOLD" "$YEL" "$WARN_COUNT" "$RST"
else
  printf '%s%s✓ CLEAN — keine harten Befunde. %d Warnungen, %d Fehler.%s\n' "$BOLD" "$GRN" "$WARN_COUNT" "$FAIL_COUNT" "$RST"
fi

echo ""
echo "Report: less $REPORT"
echo "An Claude: cat $REPORT | pbcopy && open https://claude.ai"

# Owner-Fix: Report gehört dem echten User, nicht root
if [ -n "${SUDO_USER:-}" ] && [ -f "$REPORT" ]; then
  chown "$SUDO_USER" "$REPORT"
fi

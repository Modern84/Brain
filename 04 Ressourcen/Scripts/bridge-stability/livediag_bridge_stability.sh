#!/usr/bin/env bash
# livediag_bridge_stability.sh
# Single-Snapshot der CAN-Topologie → TSV-Zeile.
# D2-Stand 2026-04-30: USBSERIAL Octopus + EBB36 via U2C/can0 (single gs_usb).
# can1 existiert nicht mehr, Spalten bleiben aus Schema-Stabilitätsgründen (NA/0).
# Aufruf alle 60s via systemd-User-Timer ODER tmux-while-Loop.
# NICHT als root laufen — als m3d.
#
# Output: ~/printer_data/logs/bridge_stability.log (override via LOG=...)

set -u
LOG="${LOG:-${HOME}/printer_data/logs/bridge_stability.log}"
MOON="http://127.0.0.1:7125"

mkdir -p "$(dirname "$LOG")"

# Header (nur wenn Datei leer/neu)
if [[ ! -s "$LOG" ]]; then
  printf "ts\tcan0_state\tcan1_state\tcan0_rxerr\tcan0_txerr\tcan0_busoff\tcan1_rxerr\tcan1_txerr\tcan1_busoff\tklipper\tprinter_state\tmcus_ready\tmcus_total\twatchdog_lines\tthrottled\tdmesg_enobufs\tdmesg_eproto\tdmesg_echoid\n" >> "$LOG"
fi

ts="$(date -Iseconds)"

# CAN-Felder via JSON (state aus info_data, rx/tx errors aus stats64, bus_off aus info_xstats)
parse_can_json() {
  local iface="$1"
  ip -details -statistics -json link show "$iface" 2>/dev/null | python3 -c '
import sys, json
try:
  d = json.load(sys.stdin)
  if not d:
    print("NA\t0\t0\t0"); sys.exit(0)
  e = d[0]
  state = e.get("linkinfo", {}).get("info_data", {}).get("state", "NA")
  rx_err = e.get("stats64", {}).get("rx", {}).get("errors", 0)
  tx_err = e.get("stats64", {}).get("tx", {}).get("errors", 0)
  bus_off = e.get("linkinfo", {}).get("info_xstats", {}).get("bus_off", 0)
  print(f"{state}\t{rx_err}\t{tx_err}\t{bus_off}")
except Exception:
  print("NA\t0\t0\t0")
' 2>/dev/null || echo -e "NA\t0\t0\t0"
}

IFS=$'\t' read -r can0_state can0_rx can0_tx can0_busoff <<< "$(parse_can_json can0)"
IFS=$'\t' read -r can1_state can1_rx can1_tx can1_busoff <<< "$(parse_can_json can1)"
: "${can0_state:=NA}"; : "${can1_state:=NA}"
: "${can0_rx:=0}"; : "${can0_tx:=0}"; : "${can0_busoff:=0}"
: "${can1_rx:=0}"; : "${can1_tx:=0}"; : "${can1_busoff:=0}"

# Klipper-Service
klipper="$(systemctl is-active klipper 2>/dev/null || echo unknown)"

# Moonraker /printer/info → state
moon_json="$(curl -fsS --max-time 3 "${MOON}/printer/info" 2>/dev/null || echo '{}')"
printer_state="$(printf '%s' "$moon_json" | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("result",{}).get("state","NA"))' 2>/dev/null || echo NA)"

# MCUs (D2-Topologie: 7 MCUs hardcoded, URL-encoded Spaces)
mcu_query="mcu=mcu_version&mcu%20ebb=mcu_version&mcu%20so3_0=mcu_version&mcu%20so3_1=mcu_version&mcu%20so3_2=mcu_version&mcu%20so3_3=mcu_version&mcu%20so3_4=mcu_version"
mcus_query="$(curl -fsS --max-time 3 "${MOON}/printer/objects/query?${mcu_query}" 2>/dev/null || echo '{}')"
read -r mcus_total mcus_ready <<< "$(printf '%s' "$mcus_query" | python3 -c '
import sys,json
try:
  d=json.load(sys.stdin)
  st=d.get("result",{}).get("status",{})
  total=len(st); ready=sum(1 for v in st.values() if v.get("mcu_version"))
  print(total, ready)
except Exception:
  print(0,0)
' 2>/dev/null)"
: "${mcus_total:=0}"; : "${mcus_ready:=0}"

# gs_usb-Watchdog-Logfile (Zeilenzahl, falls vorhanden)
WD_LOG="/var/log/gs-usb-watchdog.log"
if [[ -r "$WD_LOG" ]]; then
  watchdog_lines="$(wc -l < "$WD_LOG" 2>/dev/null || echo 0)"
else
  watchdog_lines=0
fi

# Throttling
throttled="$(vcgencmd get_throttled 2>/dev/null | awk -F= '{print $2}')"
: "${throttled:=NA}"

# dmesg-Counter (defensiv: einmal lesen, dann dreimal grep -c, head -1 als Sicherheitsnetz)
DMESG="$(dmesg -T 2>/dev/null || true)"
count_dmesg() {
  local pattern="$1" c
  c="$(printf '%s\n' "$DMESG" | grep -c "$pattern" 2>/dev/null | head -n1)"
  printf '%s' "${c:-0}"
}
dmesg_enobufs="$(count_dmesg 'ENOBUFS')"
dmesg_eproto="$(count_dmesg 'EPROTO')"
dmesg_echoid="$(count_dmesg 'echo id')"

printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n" \
  "$ts" "$can0_state" "$can1_state" \
  "$can0_rx" "$can0_tx" "$can0_busoff" \
  "$can1_rx" "$can1_tx" "$can1_busoff" \
  "$klipper" "$printer_state" "$mcus_ready" "$mcus_total" \
  "$watchdog_lines" "$throttled" \
  "$dmesg_enobufs" "$dmesg_eproto" "$dmesg_echoid" \
  >> "$LOG"

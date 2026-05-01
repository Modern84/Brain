#!/usr/bin/env bash
# bridge_stability_summary.sh
# Auswertung von ~/printer_data/logs/bridge_stability.log

set -u
LOG="${1:-${HOME}/printer_data/logs/bridge_stability.log}"

if [[ ! -s "$LOG" ]]; then
  echo "Kein Log gefunden oder leer: $LOG" >&2
  exit 1
fi

awk -F'\t' '
NR==1 { for(i=1;i<=NF;i++) col[$i]=i; next }
NR==2 { first_ts=$col["ts"] }
{
  last_ts=$col["ts"]
  n++
  # bus-errors
  for (k in arr) delete arr[k]
  c0r=$col["can0_rxerr"]; c0t=$col["can0_txerr"]; c0b=$col["can0_busoff"]
  c1r=$col["can1_rxerr"]; c1t=$col["can1_txerr"]; c1b=$col["can1_busoff"]
  c0_rx[NR]=c0r; c0_tx[NR]=c0t; c0_bo[NR]=c0b
  c1_rx[NR]=c1r; c1_tx[NR]=c1t; c1_bo[NR]=c1b
  if ($col["mcus_ready"]+0 < $col["mcus_total"]+0) mcu_not_ready++
  if ($col["throttled"] != "0x0" && $col["throttled"] != "NA") throttling++
  enob=$col["dmesg_enobufs"]+0
  eprot=$col["dmesg_eproto"]+0
  echoid=$col["dmesg_echoid"]+0
  if (NR==2) { e0=enob; p0=eprot; ei0=echoid }
  e1=enob; p1=eprot; ei1=echoid
  wl=$col["watchdog_lines"]+0
  if (NR==2) wd0=wl
  wd1=wl
}
END {
  printf "Beobachtungszeitraum:  %s  →  %s\n", first_ts, last_ts
  printf "Snapshots gesamt:      %d\n", n
  printf "\n"
  # Min/Max/Median je Counter — nur sinnvoll wenn n groß
  function minmaxmed(arr, lbl,  i, vals, sorted, mid) {
    delete vals
    j=0
    for (i in arr) { j++; vals[j]=arr[i] }
    if (j==0) { printf "%-22s n/a\n", lbl; return }
    # sort
    for (a=1; a<=j; a++) for (b=a+1; b<=j; b++) if (vals[a]>vals[b]) { t=vals[a]; vals[a]=vals[b]; vals[b]=t }
    mn=vals[1]; mx=vals[j]; mid=vals[int((j+1)/2)]
    printf "%-22s min=%s  median=%s  max=%s\n", lbl, mn, mid, mx
  }
  minmaxmed(c0_rx, "can0 rx-err:")
  minmaxmed(c0_tx, "can0 tx-err:")
  minmaxmed(c0_bo, "can0 bus-off:")
  minmaxmed(c1_rx, "can1 rx-err:")
  minmaxmed(c1_tx, "can1 tx-err:")
  minmaxmed(c1_bo, "can1 bus-off:")
  printf "\n"
  printf "MCU != ready Zeilen:   %d\n", (mcu_not_ready+0)
  printf "Throttling-Events:     %d\n", (throttling+0)
  printf "ENOBUFS dmesg-Anstieg: %d → %d (Δ %d)\n", e0+0, e1+0, (e1-e0)
  printf "EPROTO  dmesg-Anstieg: %d → %d (Δ %d)\n", p0+0, p1+0, (p1-p0)
  printf "echo id dmesg-Anstieg: %d → %d (Δ %d)\n", ei0+0, ei1+0, (ei1-ei0)
  printf "Watchdog-Loglines:     %d → %d (Δ %d)\n", wd0+0, wd1+0, (wd1-wd0)
}
' "$LOG"

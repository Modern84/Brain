---
tags: [ressource, klipper, proforge5, recovery, lesson]
status: aktiv
date: 2026-04-27
---

# Recovery-Pfade nach Klipper-Crash

**Klare Trennung zweier Crash-Klassen mit unterschiedlichem minimalem Recovery-Stack. Marathon-Befund 2026-04-27.**

## Zwei Crash-Klassen sauber getrennt

| Klasse | Trigger | Symptom | Kernel-Log | Watchdog | Minimaler Recovery |
|---|---|---|---|---|---|
| **EBB-MCU Self-Shutdown** | CAN-Frame-Loss durch Servo-EMI an Lock-Engagement | `Lost communication with MCU 'ebb'` / `static_string_id=Command request` | sauber, keine Errors | greift NICHT (USB-Layer ok) | **Drucker-PSU-Cycle** (24V aus/an) |
| **gs_usb USB-Crash** | Stromspike auf USB-Pfad zu U2C V2 | ENOBUFS / EPIPE / EPROTO im Kernel-Log | viele Events | greift, can0 down/up oder gs_usb-Reload | Watchdog automatisch oder USB unbind/bind |

## Heutige Verifikation (5+ Crash-Zyklen)

- Alle heutigen Crashes waren **EBB-MCU Self-Shutdown** — Kernel-ENOBUFS-Count = 0 für den ganzen Tag.
- gs_usb-Watchdog hat KORREKT NICHT getriggert — USB-Layer war bei keinem Crash betroffen.
- `sudo systemctl restart klipper` führte zu startup-Hang oder ENOBUFS-Pseudo-Errors weil Klipper versuchte mit dem im-Shutdown-EBB zu sprechen.
- USB unbind/bind reattachte die USB-Devices — half NICHT, weil EBB-Firmware-State unverändert.
- Pi-Reboot half — aber war redundant. **Nur Drucker-PSU-Cycle war zwingend.**

## Minimaler zuverlässiger Recovery-Stack (EBB-Self-Shutdown)

1. **Drucker-PSU aus** (24V weg, EBB hardware-reset)
2. **10s warten**
3. **Drucker-PSU an**
4. **15s warten** bis EBB im USB enumeriert (`lsusb | grep 1d50:614e`)
5. `sudo systemctl restart klipper`
6. 15s warten, dann `curl http://localhost/printer/info` → `state: ready`
7. Sensor-Verify

**Pi bleibt durchgehend an.** SSH bleibt verbunden, Tailscale bleibt stabil, kein Hotspot-Reconnect-Risiko.

## Erweiterter Stack (gs_usb USB-Crash, falls ENOBUFS auftritt)

Wenn Kernel-Log ENOBUFS/EPIPE/EPROTO zeigt:

1. Watchdogs zuerst arbeiten lassen (gs-usb-watchdog, can0-watchdog) — können binnen 10s automatisch reparieren
2. Wenn Watchdog erfolglos: `sudo modprobe -r gs_usb && sudo modprobe gs_usb`
3. Wenn das nicht hilft: USB-Power-Cycle via uhubctl oder Pi-Reboot
4. Nur wenn beide Klassen kombiniert: Drucker-PSU + Pi-Reboot

## Anti-Pattern (heute mehrfach gesehen)

- ❌ Pi-Reboot OHNE 24V-Cycle — EBB bleibt im Shutdown, Klipper bleibt im startup-Hang
- ❌ Mehrfache `systemctl restart klipper` ohne Hardware-Reset — bringt nichts, ENOBUFS-Hang
- ❌ FIRMWARE_RESTART nach Config-Änderung — triggert eigene ENOBUFS-Welle (separates Problem, siehe Daily 2026-04-27)
- ✅ **Erst Hardware-Schicht reparieren, dann Software-Schicht.** Klipper-Restart erst wenn USB-Bus + EBB sauber sind.

## Diagnose-Befehle vor Recovery

```bash
# Welche Crash-Klasse?
sudo journalctl -k --since "10 min ago" | grep -cE "ENOBUFS|EPIPE|EPROTO"
# 0 → EBB-Self-Shutdown (Drucker-PSU-Cycle nötig)
# >0 → gs_usb-Crash (Watchdog/Treiber-Reload erst probieren)

# EBB sichtbar?
lsusb | grep 1d50:614e   # ebb + 5× so3 sollten sichtbar sein

# can0 state
ip -d link show can0 | grep "can state"
# ERROR-ACTIVE = ok, BUS-OFF = down, fehlt = USB nicht da
```

## Lesson — Recovery-Sequenz Tool-am-Schlitten

**WICHTIG: Wenn nach Crash ein Tool am Schlitten hängt** (Carriage=PRESSED + ein t_X=RELEASED nach PSU-Cycle), darf der Recovery-Macro **NIEMALS automatisch Servo öffnen** ohne explizite User-Bestätigung dass eine Hand das Tool sichert.

Servo-Open im Recovery-Pfad lässt das Tool sofort frei — Tool fällt aufs Bett, mechanischer Schaden (heute Hotend-4-Nase verbogen). Recovery-Macro für morgen muss eine harte Pause haben mit Mo-Bestätigung „Tool in Hand" bevor `SET_SERVO ANGLE=52` läuft.

## Verknüpfungen

- [[04 Ressourcen/Klipper/Servo-EMI-Mitigation]]
- [[04 Ressourcen/Klipper/SAFETY-Filament-Sensor-AutoHeating]]
- [[05 Daily Notes/2026-04-27]]
- [[02 Projekte/ProForge5 Build/ProForge5 Build]]

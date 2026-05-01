---
tags: [ressource, sicherheit, amos, runbook]
date: 2026-04-26
status: abgeschlossen
priorität: A
owner: sebastian
---

# AMOS Runbook — Nacharbeiten 17.04.-Vorfall

Anlass: AMOS-Stealer-Vorfall am 17.04.2026 (Eintragspunkt offen).
Durchführung: 2026-04-26 durch Claude Code (read-only Punkte) + Sebastian (destruktive Punkte).

## Status-Tabelle

| # | Punkt | Typ | Status | Erledigt | Befund |
|---|---|---|---|---|---|
| 1 | `Anleitung_Mac.pdf` lokalisieren + einsortieren | abgeschlossen | ✅ | 2026-04-26 | Sichtprüfung: **Apple-Mail-Setup-Doku für agenturserver.de**, gehört zum WEC-Mail-Onboarding. Verschoben nach `03 Bereiche/WEC/raw/Standards WEC/Apple Mail Einrichtung agenturserver.pdf`. Kein AMOS-Bezug. |
| 2 | AnyDesk-Kennwort rotieren | entfällt | ✅ | 2026-04-26 | **AnyDesk ist auf Mo's Mac nicht installiert** (keine App, Prozesse, Configs, LaunchAgents, Login-Items). Plan war ohnehin nur für Reiners PC. Kein Handlungsbedarf am Mac. |
| 3a | Pi: read-only Forensik | read-only | ✅ | 2026-04-26 | **3. Versuch erfolgreich.** Befunde unten. Insgesamt 🟢 mit 2× 🟡 (PasswordAuthentication yes, Log-Lücke 17.–18.04.). |
| 3b | Pi: SSH härten (`PasswordAuthentication no`) | destruktiv | ✅ | 2026-04-26 | Beide Configs gepatcht (`sshd_config` + `50-cloud-init.conf`), Backups `*.backup_20260426_084916`, `sshd -t` OK, Reload OK, Key-Auth in neuer Session bestätigt. Pi nimmt jetzt nur noch Public-Key-SSH. |
| 3c | Pi: `pi`/`m3d`-Passwörter rotieren | destruktiv | ⏳ wartet auf Sebastians Bestätigung | — | Mit Härtung weniger dringlich, aber AMOS-Hygiene. |
| 4 | Chrome-Passwörter Inventar | manuell GUI | ⏳ offen | — | Reminder in Tagesbuch 2026-04-26. |
| 6 | Recovery-Codes-Hygiene (Obsidian + Cloudflare) | destruktiv | ✅ | 2026-04-26 | Klartext-`.txt` weder in `~/Downloads/` noch im `ext-auth-main/specification/`-Pfad → Sebastian hat sie schon migriert/gelöscht. Inventur leer. |
| 7 | Obsidian-Passwort geändert | manuell | ✅ | 2026-04-26 | Bonus-Aktion außerhalb Runbook. Stärkt Konto nach Recovery-Code-Klartext-Befund (5b, 🟡). |
| 5 | Forensik Eintragspunkt | read-only | ✅ | 2026-04-26 | Siehe Befunde unten. Eintragspunkt nicht eindeutig identifiziert, aber 3 Verdachtspunkte (gelb). |

## Punkt 1 — Anleitung_Mac.pdf

```
/Users/sh/Mac-Inventur/05_Projekt_Material/Anleitung_Mac.pdf
Größe:  323.862 Bytes (316 KB)
mtime:  2026-04-16 19:21:10
ctime:  2026-04-18 05:27:14
```

Liegt im Mac-Inventur-Vorsortier-Ordner (Phase 3). mtime 16.04. 19:21 = Tag des AMOS-Vorfalls (17.04.). **Sichtprüfung notwendig** bevor Löschung — Inhalt unklar.

## Punkt 5 — Forensik

### 5a) Chrome Downloads (60 Tage)

Vollständiger Auszug aus `Default/History` (über DB-Kopie, da live gelockt). Auffälligkeiten eingefärbt:

| Stufe | Befund | Datum |
|---|---|---|
| 🔴 **rot** | `ext-auth-main.zip` von `github.com/modelcontextprotocol/ext-auth` heruntergeladen (30.03. 04:20), danach Chrome-Download-Ordner auf dessen Unterordner `specification/` umgeleitet. Ab 31.03. gehen ALLE Downloads (Obsidian 7×, Node 4×, Claude 3×, VS Code 3×, Setapp, GitHub Desktop, **claudian-main.zip**, Cloudflare-Recovery-Codes, Obsidian-Recovery-Codes 2×) in diesen Pfad. Mögliche Manipulation der Chrome-Download-Settings durch ext-auth-Repo. | 30.03.-01.04. |
| 🔴 **rot** | `claudian-main.zip` von `github.com/YishenTu/claudian` (01.04. 06:48) — 3rd-party Obsidian-Plugin, aktuell im Vault aktiv (`.obsidian/plugins/claudian/`). Quelle nicht offiziell, Code nicht reviewt. Möglicher AMOS-Vektor. |
| 🟡 **gelb** | `obsidian-recovery-codes.txt` 2× in Downloads (01.04. 06:29). Sensible Daten unverschlüsselt im Dateisystem. |
| 🟡 **gelb** | `cloudflare-modern3b@icloud.com-2026.04.01.txt` Recovery-Codes (01.04. 10:51). Selbiges. |
| 🟡 **gelb** | `takeout-…zip` Google Takeout (05.04. 09:24) — falls AMOS Browser-Daten exfiltriert hat, ist Takeout Zielprofil. |
| 🟢 **grün** | Übrige Downloads (Tailscale, RPi Imager, Altium, Notion, Slack) plausibel. |

### 5b) LaunchAgents/Daemons

| Pfad | Eintrag | Stufe |
|---|---|---|
| `~/Library/LaunchAgents/com.google.GoogleUpdater.wake.plist` | Google Updater | 🟢 grün |
| `/Library/LaunchAgents/com.3dconnexion.helper.plist` | SpaceMouse | 🟢 grün |
| `/Library/LaunchDaemons/com.3dconnexion.nlserverIPalias.plist` | SpaceMouse | 🟢 grün |
| `/Library/LaunchDaemons/com.crystalidea.macsfancontrol.smcwrite.plist` | Macs Fan Control | 🟢 grün |

Keine unbekannten Persistenz-Mechanismen. Sauber.

### 5c) zsh-History — Verdachtsmuster

3 Treffer, alle erklärbar:
- `curl -fsSL https://claude.ai/install.sh | bash` (2×) — offizieller Claude-Code-Installer
- `curl -fsSL https://tailscale.com/install.sh | sh` — offizieller Tailscale-Installer

🟢 **grün.** Keine `base64 -d`, `eval $(...)`, `osascript do shell` oder fremde URLs.

### 5d) Crontab

User-Crontab: leer. Sudo-Crontab: nicht abgefragt (Passwort nötig). 🟢 grün (User-Ebene).

## Punkt 3 — Pi Forensik (erhoben 2026-04-26 08:44)

| Bereich | Status | Details |
|---|---|---|
| `~/.ssh/authorized_keys` (m3d) | 🟢 | nur Sebastians MacBook-Key (ED25519 …Pjbw…) |
| `authorized_keys` (root, pi) | 🟢 | leer |
| Crontabs (m3d, root) | 🟢 | leer; nur Standard-Debian (`e2scrub`, `apt-compat`, `dpkg`, `logrotate`, `man-db`) |
| Prozesse | 🟢 | keine Miner / `/tmp`-Binaries / Fake-Kernel-Threads. Nur klippy, moonraker, KlipperScreen, NetworkManager, X11, tailscaled, cloudflared, readonly-proxy |
| SSH-Logins (journalctl) | 🟢 | 6 Einträge seit Boot, alle `Accepted publickey for m3d from 172.20.10.4` (Mac). Keine Failed/Invalid. |
| `tailscaled` | 🟢 | active |
| `PasswordAuthentication yes` | 🟡 | in `/etc/ssh/sshd_config` UND `/etc/ssh/sshd_config.d/50-cloud-init.conf`. Pi akzeptiert Passwort-SSH — bei AMOS-kompromittiertem Mac Einfallstor. → auf `no` setzen. |
| `backup-mainsail_2026-04-06_mobile.json` | 🟡 | **nicht auf Pi-Filesystem** (`find /` komplett). War Mainsail-Browser-LocalStorage; `sudo passwd pi`-Eintrag dort konnte ein Tipphilfe-Vorschlag der Browser-History sein, kein ausgeführter Befehl. Verdacht teilweise entkräftet. |
| Log-Lücke 17.–18.04. | 🟡 | journald sieht nichts vor heutigem Boot (08:11). `auth.log` leer. Falls AMOS-Vektor in dem Fenster Pi berührte: forensisch nicht mehr nachweisbar. |

## Verbleibend (eigene Sessions, keine Zeitkritik)

1. **🔥 claudian-Plugin** — Review oder durch offizielles ersetzen. Höchste Priorität: möglicher AMOS-Vektor, läuft solange aktiv.
2. **Chrome-Passwörter-Inventar** (`chrome://password-manager/passwords`) — schwache + kompromittierte Einträge rotieren.
3. **Pi-Passwort-Rotation** (`pi`/`m3d`) — mit SSH-Härtung weniger dringlich, AMOS-Hygiene.

**Bewusst ausgespart:** Cloudflare-Account-PW (Mac-Reset hat Schlüsselbund frisch, 2FA aktiv, Recovery-Codes neu).

## Lessons Learned

### Was funktioniert hat

- **Staging-Reihenfolge** read-only zuerst, destruktiv nur mit Bestätigung — hat sauber das Halten der Befunde von der Aktion getrennt.
- **Reversibel arbeiten:** sshd-Config-Backup vor `sed`, `sshd -t` vor Reload, Key-Auth-Test in neuer Session — Rollback war fertig vorbereitet, wurde nicht gebraucht.
- **Realitätschecks:** Sebastians Sichtprüfung der `Anleitung_Mac.pdf` hat den Verdacht aufgelöst (Apple-Mail-Doku, kein AMOS-Bezug). Ohne diesen Check wäre die Datei „verdächtig wegen Timing" geblieben.
- **Bestätigung statt Annahme:** „backup-mainsail_2026-04-06_mobile.json" stellte sich als Browser-LocalStorage heraus, nicht als Pi-Datei. `find /` hat den ursprünglichen Verdacht teilweise entkräftet — wäre ohne Pi-Forensik als latente Drohung im Memory geblieben.

### Was nicht funktioniert hat

- **iPhone-Hotspot-Drops** beim Pi: 2. Forensik-Versuch lief, brach mitten ab, Reconnect schlug fehl. Lösung im 3. Versuch: `ServerAliveInterval=15`, kurze Befehle einzeln, parallel ein Tail offen halten.
- **`sudo` ohne TTY** im Heredoc: blockiert stumm bei Passwort-Prompt. Lösung: `sudo -n` (NOPASSWD vorausgesetzt) oder `ssh -t`.
- **`who -b` vs. `uptime`-Widerspruch** beim Pi: hätte ich fälschlich als IoC werten können. Erklärung: RTC-fehlend → utmp-Boot-Eintrag aus letztem bekannten Zeitstand vor NTP-Sync. Bekanntes Phänomen, nicht Sicherheits.
- **Ohne Memory-Korrektur** Hotspot-Name („IP" statt „mTreeD>IO") wäre nächster Versuch wieder am falschen Netz gescheitert. Memories sind point-in-time und müssen aktiv kuratiert werden.
- **Tailscale-„offline 8 Tage"** war kein IoC, sondern Folge des Pi-Stromumbaus + WLAN-Wechsel. Reine Korrelation mit AMOS-Datum führte zu kurzem Fehlverdacht.

### Was beim nächsten Forensik-Lauf anders

- Logs **vor** dem Reboot sichern (`journalctl --boot=-1 > log.txt` vor Power-Cycle). Diesmal Lücke 17.–18.04. unwiderruflich verloren.
- `auth.log` aktivieren / persistent journald (`/var/log/journal/`) konfigurieren, damit nicht jeder Reboot die Forensik-Sicht killt.
- Verdächtige Plugins/Quellen sofort isolieren statt aktiv lassen (claudian-Lehre).

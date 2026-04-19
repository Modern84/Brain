---
tags: [persönlich, sicherheit, 1password]
date: 2026-04-18
status: aktiv
---

# 1Password-Migration — Offene Punkte

Aus Mac-Inventur Phase 3 Session 4. **Inhalte der unten genannten Dateien stehen bewusst NICHT in dieser Notiz** (CLAUDE.md-Regel: Passwörter und Recovery-Codes nicht im Klartext im Gehirn).

Alle Original-Dateien liegen weiter in `~/Mac-Inventur/05_Projekt_Material/` und müssen von Sebastian manuell verarbeitet werden.

## Recovery- & Backup-Codes → Apple Schlüsselbund

Vier Code-Dateien aus dem Mac-Inventur-Pool. Inhalt jeweils einzeln öffnen, Code in den Apple Schlüsselbund übertragen (als „Sichere Notiz" mit sprechendem Titel), Originaldatei anschließend in Papierkorb.

- [ ] `1Password-Wiederherstellungscode.txt` (233 B, vom 07.12.2025) — 1Password-Account-Wiederherstellung
- [ ] `Backup-codes-modernb731.txt` (444 B, vom 13.03.2026) — Recovery-Codes für Account `modernb731` (vermutlich GitHub/Google/ähnlich — Inhalt prüfen)
- [ ] `obsidian-recovery-codes.txt` (101 B, vom 04.04.2026) — Obsidian-Account-Wiederherstellung
- [ ] `autodesk_backup_code.txt` (9 B, vom 14.11.2025) — Autodesk-Backup-Code (sehr kurz, vermutlich einzelner Code)

**Vorgehen je Datei:**
1. Datei im Editor öffnen
2. Im Apple Schlüsselbund eine sichere Notiz mit aussagekräftigem Titel anlegen (z.B. „1Password Wiederherstellungscode (Stand 2025-12-07)")
3. Inhalt einfügen, speichern, Schlüsselbund schließen
4. Originaldatei via Finder in den Papierkorb verschieben

## Emergency Kits → physisch oder verschlüsselt verwahren

Vier Emergency-Kit-PDFs aus dem 1Password-Konto. Diese Kits enthalten den Secret Key + Account-URL und gehören **nicht** ins Gehirn.

- [ ] `1Password Emergency Kit.pdf` (47 KB, vom 10.12.2025)
- [ ] `1Password Emergency Kit A3-CQBL4E-my.pdf` (48 KB, vom 07.12.2025)
- [ ] `1Password Emergency Kit A3-XEHDNV-my.pdf` (45 KB, vom 07.12.2025)
- [ ] `1Password Emergency Kit A3-XEHDNV-my-2.pdf` (45 KB, vom 07.12.2025) — Kopie

**Zu klären:**
- Welches Kit ist aktuell? (mehrere Account-IDs `CQBL4E` und `XEHDNV` deuten auf alten + neuen Account oder Familien-Sharing)
- Veraltete Kits sicher vernichten (nicht einfach in Papierkorb — schreddern oder verschlüsseltes Löschen)
- Aktuelles Kit: Ausdruck im Tresor / verschlüsselt auf separatem Datenträger — **nicht im Gehirn, nicht in iCloud-Klartext, nicht im 1Password-Tresor selbst** (Henne-Ei-Problem)

## Safari-Erweiterung — Sebastian entscheidet

1Password.app ist **aktuell nicht in `/Applications/` installiert** (Stand 2026-04-18). Die folgenden Dateien sind alte Installations-Reste:

- [ ] `1Password for Safari.zip` (46 KB) — Safari-Extension-Archiv
- [ ] `1Password for Safari (1).zip Alias.txt` (235 B) — Finder-Alias-Datei
- [ ] `1Password for Safari` (executable, 212 KB, vom 26.11.2025) — extrahierte Safari-Erweiterung (war nicht in der Vorsortierung erfasst, beim ls aufgetaucht)

**Empfehlung:** Wenn 1Password ohnehin neu eingerichtet wird, die App via Mac App Store / Hersteller-Website installieren — Safari-Erweiterung kommt dann mit. Diese drei Dateien sind dann obsolet → Papierkorb.

## Veraltetes — bereits in Papierkorb (heute)

Heute am 2026-04-18 in Papierkorb verschoben (reversibel 30 Tage):
- `1Password.zip` (22,4 MB) — Installer
- `1Password Beta.zip` (22,0 MB) — Beta-Installer
- `1Password_8.11.22_2025-12-25_00-27-18.1pdiagnostics.zip` (288 KB) — Diagnostics-Export
- `Informationsmaterial_Nutzung__FIDO-Sicherheitsschluessels.pdf` (368 KB) — generisches Info-PDF zu ID Austria (öffentliche Doku, Stand Nov 2024) — bei Bedarf jederzeit neu unter [oe.gv.at](https://oe.gv.at) abrufbar

## Verknüpfungen

- [[CLAUDE.md|Vault-Regel: Passwörter gehören in den Apple Schlüsselbund]]
- [[02 Projekte/Mac Inventur - Phase 3 Vorsortierung]]
- [[02 Projekte/Mac Inventur]]

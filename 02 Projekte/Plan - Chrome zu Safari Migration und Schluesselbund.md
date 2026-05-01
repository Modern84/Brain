---
tags: [projekt, system, sicherheit]
date: 2026-04-17
status: geplant
priorität: C
owner: Sebastian
raum: MThreeD
---

# Plan — Chrome zu Safari Migration und Schlüsselbund-Konsolidierung

## Worum geht's

Mo hatte zwischenzeitlich Chrome als Hauptbrowser genutzt, inklusive Google-Passwort-Manager. Rückwirkend betrachtet nicht zur Apple-Strategie passend (siehe [[02 Projekte/WEC Neustart mit Reiner/Idee - Apple-Strategie für WEC und MThreeD.io]]). Jetzt soll migriert werden:

- **Browser**: Chrome → Safari als Standard
- **Passwörter**: Google-Passwort-Manager → Apple Schlüsselbund
- **Dabei wichtig**: Keine Daten verlieren, keine Logins verlieren, saubere Umstellung

## Warum das wichtig ist

- **Konsistenz zur Apple-Strategie**: Datenschutz, on-device, Secure Enclave
- **Weniger Reibung**: Schlüsselbund ist in Safari + iOS + macOS nativ integriert, synchronisiert über iCloud Ende-zu-Ende
- **Weg von Google-Ökosystem**: Passwörter liegen aktuell bei Google — strategisch nicht gewünscht
- **2FA-Flows funktionieren**: Safari kennt den Login nicht (wie heute Morgen bei Cloudflare gesehen) → aktuell Workaround über die installierte Cloudflare-App

## Aktueller Stand (Session 2026-04-17)

- Chrome hat das Cloudflare-Passwort gespeichert, Safari nicht
- Safari-Login bricht ab bei 2FA (kein Sicherheitsschlüssel/Handycode-Fallback eingerichtet)
- Cloudflare Desktop-App auf Mac funktioniert — alternative Route
- Für laufende Cloudflare-Session: Chrome bleibt Arbeitsbrowser, Migration separat

## Was zu tun ist

### Schritt 1 — Bestandsaufnahme
- [ ] Alle gespeicherten Passwörter in Chrome auflisten (chrome://password-manager/passwords)
- [ ] Ebenso in Google-Account online (passwords.google.com)
- [ ] Duplikate/Alt-Einträge identifizieren

### Schritt 2 — Export aus Chrome/Google
- [ ] Chrome: Passwörter als CSV exportieren (chrome://password-manager/settings → Passwörter exportieren)
- [ ] CSV temporär sicher ablegen (nicht im Vault, nicht in iCloud-sync, lokal, verschlüsselt)

### Schritt 3 — Import in Apple Schlüsselbund
- [ ] Safari → Einstellungen → Passwörter → Import aus Datei
- [ ] CSV importieren
- [ ] Duplikate prüfen und löschen

### Schritt 4 — 2FA-Setup für wichtige Dienste
- [ ] Cloudflare: 2FA über Apple Passkey oder Authenticator-App einrichten
- [ ] Google: Prüfen ob Login weiterhin gebraucht wird (Gmail läuft über Apple Mail)
- [ ] iCloud: Passkeys aktivieren wo möglich

### Schritt 5 — Chrome deinstallieren oder nur noch als Zweitbrowser
- [ ] Standardbrowser auf Safari umstellen
- [ ] Chrome behalten für spezifische Fälle (z.B. Cloudflare UI-Bugs)
- [ ] Google-Passwort-Sync in Chrome deaktivieren

### Schritt 6 — CSV sicher löschen
- [ ] Export-CSV nach erfolgreicher Migration sicher löschen (rm -P oder Secure Empty Trash)

## Risiken und Gegenmaßnahmen

| Risiko | Gegenmaßnahme |
|---|---|
| Passwörter verloren | Erst Backup der CSV-Datei machen, dann migrieren |
| 2FA-Lockout | Vor Migration 2FA-Reset-Codes notieren (Schlüsselbund) |
| Chrome-Login geht weg bevor Safari funktioniert | Chrome erstmal behalten, parallel testen |
| Synchronisation auf iPhone/iPad | iCloud Keychain aktiv prüfen vor Migration |

## Verknüpfungen

- [[02 Projekte/WEC Neustart mit Reiner/Idee - Apple-Strategie für WEC und MThreeD.io]]
- [[05 Daily Notes/2026-04-17]]
- [[TASKS]]


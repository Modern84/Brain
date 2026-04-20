---
tags: [projekt, abos, system, fahrplan]
date: 2026-04-17
status: aktiv
priorität: B
owner: Sebastian
raum: Finanzen
---

# Fahrplan — Abos-Audit und Umstellung

## Grundprinzip

1. Bestandsaufnahme bevor gekündigt wird
2. Neue Abos aktivieren bevor alte gekündigt werden — keine Lücke
3. Jede Kündigung bestätigen lassen (Mail abspeichern in Apple Mail Ordner "Actioned")
4. Zahlungen im Folgemonat prüfen — keine überraschenden Abbuchungen

## Etappe 1 — Bestandsaufnahme aller aktiven Abos

**Quellen für die Bestandsaufnahme:**

| Quelle | Wo nachschauen |
|---|---|
| Apple App Store Abos | iPhone: Einstellungen → Apple-ID (oben) → Abonnements **ODER** Mac: Systemeinstellungen → Apple-ID → Medien & Käufe → Abonnements |
| Setapp | setapp.com → Login → Account → Subscription |
| 1Password | 1password.com → Login → Admin → Billing |
| CleanMyMac | cleanmymac.com → Account oder direkt in der App → Einstellungen |
| Kreditkarten-Auszug | Letzter Monat — alle wiederkehrenden Abbuchungen prüfen |
| Apple Mail Suche | "Beleg", "Rechnung", "Subscription", "Abo", "recurring", "automatically renew" |

**Output:** Tabelle mit allen aktiven Abos, Kosten, Fälligkeitsdatum, Entscheidung.

## Bekannte Kandidaten (aus bisherigen Sessions)

| Abo | Geschätzte Kosten | Quelle | Entscheidung (vorläufig) |
|---|---|---|---|
| Claude Max (5x) via Apple | ~130€/Monat inkl. Apple-Aufschlag | App Store | **Umstellen** auf direktes Anthropic-Abo |
| Claude Zusatznutzung | bis 63$/Monat variabel | Apple Billing | Mit Umstellung: Deckel überdenken (niedriger?) |
| Setapp | 24€/Monat | Paddle-Abo | **Prüfen** — welche Apps brauchst du davon wirklich? |
| 1Password | ~3-8$/Monat | Direktabo | **Kündigen** (ersetzt durch Apple Schlüsselbund) |
| CleanMyMac | unklar | Direktabo oder Apple | **Kündigen** (ersetzt durch manuelles Aufräumen + Claude) |
| iCloud+ Speicher | unklar | Apple | **Behalten** — ist Teil der Apple-Strategie |

## Etappe 2 — Claude-Abo umstellen (ZUERST, weil grösster Hebel)

**Reihenfolge zwingend einhalten — sonst entsteht eine Lücke:**

1. **Auf claude.ai einloggen mit "Sign in with Apple"** — mit Apple-ID `modern3b@icloud.com`
2. **Prüfen:** Siehst du deine Chats, dein Gehirn an Kontext, deine Nutzungseinstellungen? Wenn ja: identischer Account bestätigt.
3. **Aktuellen Abo-Status checken:** Auf der Subscription-Seite sollte stehen "Abonniert über Apple". Geschenk-Guthaben sollte sichtbar sein.
4. **Direktes Abo aktivieren:** Upgrade / "Switch billing to Anthropic" wählen, Zahlungsart (Kreditkarte) eingeben, Plan Max (5x) bestätigen. **WICHTIG:** Manche Anbieter verlangen dass das Apple-Abo zuerst gekündigt wird bevor direkte Zahlung aktiv wird. Wenn dieser Fall: weiter zu Punkt 5, sonst weiter zu Punkt 6.
5. **Falls Apple-Kündigung Voraussetzung:** Apple-Abo kündigen (siehe unten), aber nicht auslaufen lassen — direktes Abo muss vor Ablauf des Apple-Abrechnungszeitraums aktiv sein.
6. **Apple-Abo kündigen** (wenn direktes Abo läuft): iPhone → Einstellungen → Apple-ID → Abonnements → Claude → Abo kündigen. Bestätigungs-Mail in Apple Mail ablegen.
7. **In der Folge-Rechnung prüfen:** Wurde Claude nur einmal abgerechnet (direkt), nicht doppelt (Apple + direkt)?

## Etappe 3 — 1Password kündigen

**Vorbedingung:** Passwörter müssen erst in Apple Schlüsselbund migriert sein — sonst verlierst du Logins. Siehe [[01 Inbox/Plan - Chrome zu Safari Migration und Schluesselbund]] Schritt 1-4.

1. Nach erfolgreicher Passwort-Migration: 1password.com → Login → Billing → Cancel Subscription
2. Grund: "Switching to Apple Keychain" o.ä.
3. Bestätigungs-Mail ablegen
4. Datenexport aufheben für 30 Tage (Fallback-Absicherung)

## Etappe 4 — Setapp prüfen und ggf. kündigen

1. setapp.com → Login → Account → Apps
2. Liste aller Apps anschauen die du über Setapp nutzt
3. Pro App entscheiden:
   - **Nutze ich regelmäßig?** → Wenn ja, gibt es eine native Apple-Alternative? Gibt es die App auch als Einmalkauf (oft günstiger als Abo)?
   - **Nutze ich selten?** → Kündigen
4. Wenn 3+ Apps nicht ersetzbar sind und regelmäßig genutzt werden: Setapp behalten. Wenn nicht: kündigen.
5. Kündigungsweg: setapp.com → Account → Subscription → Cancel. Oder falls über Paddle: Kündigungs-Link in der letzten Rechnungs-Mail.

## Etappe 5 — CleanMyMac kündigen

1. CleanMyMac App öffnen → Einstellungen oder Account
2. Oder: cleanmymac.com / macpaw.com → Login → Subscription
3. Cancel
4. App deinstallieren (Systembereinigung machen wir manuell + mit Claude wenn nötig)

## Etappe 6 — Kreditkarten-Check im Folgemonat

Nach allen Kündigungen, im nächsten Monat:

- Kreditkarten-Auszug aufmachen
- Alle wiederkehrenden Abbuchungen prüfen
- Was taucht auf das nicht mehr auftauchen sollte? → nachfassen
- Was ist neu? → prüfen
- Spar-Übersicht in [[04 Ressourcen/E-Mail Accounts und Serverdaten]] ergänzen (oder neue Datei "Abos-Übersicht")

---

## Jetzt konkret — dein nächster Schritt

**Öffne am iPhone:** Einstellungen → oben auf deinen Namen tippen → **Abonnements**

Oder am Mac: Systemeinstellungen → Apple-ID → Medien & Käufe → **Abonnements verwalten**

**Screenshot davon** — dann sehe ich alle Apple-Abos auf einen Blick und wir können pro Abo entscheiden.

---

## Verknüpfungen

- [[02 Projekte/System-Aufraeumen - Digitales Zuhause]]
- [[01 Inbox/Plan - Chrome zu Safari Migration und Schluesselbund]]
- [[TASKS]]

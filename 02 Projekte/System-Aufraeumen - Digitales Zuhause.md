---
tags: [projekt, system, aufraeumen, abos, struktur]
date: 2026-04-17
status: aktiv
priorität: B
owner: Sebastian
raum: MThreeD
---

# System-Aufräumen — Digitales Zuhause

## Worum geht's

Sebastians System ist über Jahre gewachsen, ohne klare Struktur. Mehrere E-Mail-Identitäten, Passwörter verteilt auf Chrome/Schlüsselbund/1Password, Abos die sich überlappen, E-Mail-Eingang mit ~6.800 Nachrichten und 987 ungelesen, Ordnergeschichte unstrukturiert, Screenshots/Dateien/Dokumente ohne System.

Sebastians Entscheidung: Statt weiter Geld in spezialisierte Tools zu stecken (CleanMyMac, Setapp, 1Password), lieber in Claude investieren und mit Claude strukturiert aufräumen.

## Ziel

- Jedes Werkzeug hat einen klaren Zweck, nichts Redundantes
- Jede Identität (E-Mail, Absender, Account) hat einen klaren Use Case
- Passwörter liegen an **einem** Ort (Apple Schlüsselbund)
- Abo-Kosten gesenkt, Budget umgeleitet in Claude/Anthropic (**direkt, nicht über Apple**)
- Struktur die sich **selbst hält** weil sie einfach ist — nicht weil sie komplex ist

## Etappen — in Prioritätsreihenfolge

### A — Abos-Audit (30 Min, spart sofort Geld)

Bekannte Kandidaten:
- **Setapp** (24€/Monat) — Sinn prüfen
- **1Password** — kündigen laut TASKS, ersetzt durch Apple Schlüsselbund
- **CleanMyMac** — ersetzt durch manuelles Aufräumen + Claude
- **Claude (via Apple App Store)** — **WICHTIG: Wechsel auf direktes Anthropic-Abo.** Apple nimmt ~30% Aufschlag. Gleicher Max (5x) Plan, direkt bei anthropic.com günstiger. Aktueller Verbrauch der wöchentlichen Limits: 6% Alle Modelle, 2% Sonnet — also KEIN Kapazitätsproblem, sondern ein Preisproblem.

**Datenquelle:** Apple Mail durchsuchen nach "Rechnung", "Beleg", "Subscription", "Abo". Apple-Subscriptions-Seite checken (Systemeinstellungen → Apple-ID → Abonnements). Kreditkarten-Auszug wenn nötig.

**Claude-Nutzungseinstellungen (aus Screenshot 17.04.):**
- Plan: Max (5x) — bereits der stärkste Consumer-Plan
- Zusatznutzung aktiviert: 63$/Monat Deckel, aktuell 36,37$ verbraucht
- Aktuelles Guthaben: 63,62$ (Geschenk-Credit, verbraucht sich zuerst)
- Entscheidung: Zusatznutzungs-Deckel prüfen — 63$ evtl. zu hoch angesetzt

### B — Identitäten & Absender klären (20 Min)

Sebastian hat mindestens 5 Absender-Identitäten in Apple Mail: `modern3b@icloud.com`, `sebest184.cc@sebest184.cc`, `modern3b@sebest184.cc`, `modernb731@gmail.com`, `hartmann@w-ec.de`. Ziel: Welche ist primär? Welche für was? Alias? Verbergen? Löschen?

**Ergebnis:** Klare Identitäts-Matrix in `04 Ressourcen/E-Mail Accounts und Serverdaten` ergänzen.

### C — Passwort-Konsolidierung (1-2 h)

1Password → Apple Schlüsselbund migrieren. Chrome-Passwörter → Apple Schlüsselbund migrieren. Duplikate entfernen. 1Password kündigen. Chrome-Password-Sync deaktivieren. Detailplan liegt schon hier: [[01 Inbox/Plan - Chrome zu Safari Migration und Schluesselbund]]

### D — E-Mail aufräumen (2-3 h, aufgeteilt)

Papierkorb leeren (480 Mails), Spam leeren (214 Mails), 47 Entwürfe durchgehen (behalten/löschen/senden), iCloud-Eingang (987 ungelesen) filtern, iCloud-Ordnerstruktur analog zur schon vorhandenen Google-GTD-Struktur aufbauen (Actioned, Awaiting Reply, FYI, Marketing, Notification...), Regeln/Filter definieren damit neue Mails automatisch einsortiert werden.

### E — Dateisystem aufräumen (3-4 h, aufgeteilt)

Desktop (gestern gemacht ✅), Downloads, Documents, Pictures, Screenshots-Archiv vor 16.04. Eine klare Ordner-Logik die zum Gehirn/Obsidian-System passt (PARA-Prinzip oder ähnlich). Altlasten ins Archiv, Arbeitsdateien in klare Kategorien.

---

## Claude-Nutzungsstrategie (direkt in Projekt integriert)

**Wann welches Modell:**
- **Opus 4.7** (teurer, klüger): Strategie, Architektur, komplexe Texte, wichtige Entscheidungen, Kundenkommunikation, Konstruktions-Pipeline, Vertrags-/Rechtliches
- **Sonnet** (reicht völlig): Mail sortieren, Ordner aufräumen, Screenshot-Beschreibungen, einfache Code-Snippets, Zusammenfassungen, Routine-Aufgaben

**Regel:** Sebastian wählt bewusst Opus wenn nötig, Sonnet als Default. In claude.ai über Model-Selector umschaltbar. In Claude Code über `--model`-Flag oder den Alias.

---

## Was NICHT Teil dieses Projekts ist

- **Cloudflare Tunnel**: Separates Ticket (Super-Admin-Rolle muss über Cloudflare-Support wiederhergestellt werden). Läuft asynchron.
- **ProForge5 Hardware**: Eigenes Projekt, unabhängig.
- **WEC Kundenprojekte**: Unabhängig.

---

## Fortschritt

- [ ] A — Abos-Audit (inkl. Claude Apple → direkt)
- [ ] B — Identitäten & Absender klären
- [ ] C — Passwort-Konsolidierung
- [ ] D — E-Mail aufräumen
- [ ] E — Dateisystem aufräumen

## Verknüpfungen

- [[TASKS]]
- [[01 Inbox/Plan - Chrome zu Safari Migration und Schluesselbund]]
- [[01 Inbox/Idee - Apple-Strategie für WEC und MThreeD.io]]
- [[04 Ressourcen/E-Mail Accounts und Serverdaten]]

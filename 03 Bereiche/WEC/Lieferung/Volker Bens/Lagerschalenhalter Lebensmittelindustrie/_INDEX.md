---
typ: projekt-index
projekt: Lagerschalenhalter Lebensmittelindustrie
kunde: Volker Bens
partner: Reiner / WEC
status: umzusetzen
phase: warten-auf-reiner-aenderungsmail-konsolidierung-11-neue-pdfs
letzte-aktivitaet: 2026-04-21 abends
naechste-aktion: 22.04. vormittags mit Reiner finale Nummern-Logik klären, dann Mapping v5
tags: [projekt-index, wec, volker-bens, lagerschalenhalter, ehedg]
---

# _INDEX — Lagerschalenhalter (Volker Bens)

> Navigations-Hub. Jede neue Session (Claude Code oder Mo selbst) startet hier.
> Aktuelle Wahrheit steht in diesem Dokument — nicht in verstreuten Dateien.

## Kontext

Edelstahl-Lagerschalenhalter fuer Volker Bens (Lebensmittelindustrie, 
Kaesekarussell-Anwendung bei Sachsenmilch). Konstruktion durch Reiner/WEC, 
White-Label ueber mThreeD.io. EHEDG-konform: Oberflaeche Ra ≤ 0,8 µm, 
Werkstoff 1.4404.

## Aktueller Stand (21.04. abends)

| Artefakt | Status | Ort |
|----------|--------|-----|
| Reiner-Scans (8 JPG, 19.04.) | empfangen | `07 Anhänge/` |
| BOM v4 (synchronisiert, Material-Fixes, Ra-Spalte) | fertig | `2026-04-21 Montag-Session/BOM_bereinigt_v4.xlsx` |
| Liefer-Paket v1 (8 PDFs, erstes Paket) | versendet 21.04. vormittag, Reiner nicht freigegeben | `_Paket_fuer_Reiner/Bens_Lagerschalenhalter_Lieferung_2026-04-21.zip` |
| Liefer-Paket v2 (erweiterter Info-Block) | gebaut, nicht versendet | `_Paket_fuer_Reiner/Bens_..._v2.zip` |
| Liefer-Paket v3 (Stückl.-Patches + Baugr.-Reklass.) | gebaut, nicht versendet | `_Paket_fuer_Reiner/Bens_..._v3.zip` |
| Reiner-Feedback v1: Nummern/BOM inkonsistent + Welle-Baugruppe fehlt | berücksichtigt in v3 | [[Aenderungsprotokoll#2026-04-21 abends]] |
| **11 neue Fusion-PDFs (Re-Export mit eindeutigen Namen)** | **im Input-Verzeichnis** | `_An_Volker/PDF/` |
| Analyse-Lauf auf die 11 neuen PDFs | **ausstehend, startet heute Abend** | `_analyse_11pdfs_v2/` (wird erzeugt) |
| Mapping v5 (final auf Basis der 11 PDFs + Reiner-Input) | **morgen 22.04.** | wird erzeugt |
| Reiner-Änderungsmail (Nummern-Logik-Präzisierung) | **angekündigt, abwarten** | E-Mail |
| Gehirn-Stick-Update für Reiner | ausstehend für heute Abend | Reiners INTENSO-Stick |

## Verlinkte Artefakte

### Briefing & Kunden-Doku
- [[Volker Bens - Lagerschalenhalter Lebensmittelindustrie]]
- [[Volker Bens - Profil]]
- [[CAD-Datenuebergabe Standard - Bens Edelstahl]]

### Umsetzungs-Plan (aktuell)
- [[Umsetzungs-Tabelle_Reiner_v5]] — Reiners vorgegebenes Zeichnungsnummer-Schema, umzusetzen in Fusion 360

### Korrekturauftrag + Scripts
- ~~Korrekturauftrag_Re-Export_v5~~ (obsolet, ersetzt durch Reiners Schema, archiviert)
- [[v4_patcher]] — Vektor-Overlay fuer Fusion-PDFs
- [[run_v4]] — venv-basierter Launcher
- [[md2pdf]] — Markdown → PDF (weasyprint)

### Sessions
- [[2026-04-19]] — Reiner-Scans empfangen, BOM-Bereinigung begonnen
- [[2026-04-20]] — BOM-Konsolidierung (Spiegel-Stand)
- [[2026-04-21]] — Montag-Session: v4 + Korrekturauftrag + Paket raus

### Session-interne Doku
- [[Aenderungsprotokoll]]
- [[LIEFERUNG]]
- [[LIESMICH_REINER]]

## Offene To-Dos (Tagesabschluss 21.04. + Kick-off 22.04.)

### Heute Abend (Tagesabschluss)
- [ ] Analyse-Lauf für 11 neue PDFs starten (CC-Prompt im Chat)
- [ ] Reiner-Änderungsmail lesen und als Notiz hier einfügen
- [ ] Gehirn-Stick mit aktuellem Vault-Stand für Reiner aktualisieren

### Morgen früh (22.04.)
- [ ] Start mit [[_Morgen-Checkliste_22-04]]
- [ ] Mit Reiner finale Nummern-Architektur klären — vor allem: Schweißgruppe_Halter gemeinsam V1+V2 oder dupliziert
- [ ] Mapping v5 basierend auf den 11 PDFs + Reiner-Input
- [ ] v5-Run + v4v2-Info-Block + Paket v4
- [ ] Freigabe Reiner, Versand an Volker
- [ ] BOM-Master/Spiegel erneut syncen falls Divergenz
- [ ] STEP AP203 Vollständigkeit prüfen (7 fehlende nachlegen lassen)

## Regeln (projektspezifisch)

- **Staging-vor-Raus** bei allem, was an Volker/Reiner geht — siehe [CLAUDE (Vault-Root)](../../../../CLAUDE.md)
- **Paket-Build-Whitelist** (keine `find -iname` fuer externe Pakete)
- **Single-Source-of-Truth BOM**: Master = `BOM_bereinigt_v4.xlsx` in `2026-04-21 Montag-Session/`. Alle anderen Kopien sind Snapshots.
- **Platzhalter-Marker**: `AM_Lagerschale` war Platzhalter, korrigiert auf `Lagerschalenhalter`. Kuenftige Platzhalter mit `TODO:` oder `<<<?>>>` markieren.

## Historie wichtiger Entscheidungen

- **2026-04-21** Reiner liefert eigenes hierarchisches Nummernschema (3-stellig, Varianten-kodierend). Unser Korrekturauftrag v5 damit obsolet, archiviert. Neues Umsetzungs-Dokument: [[Umsetzungs-Tabelle_Reiner_v5]]
- **2026-04-21** Mo setzt Reiners Schema in Fusion 360 um (Mo hat Fusion-Hoheit, Reiner hat Papier-Hoheit)

- **2026-04-21** Schriftfeld: `Bearbeitet: Sebastian Hartmann / Geprueft: Woldrich` bleibt (Fusion-Default, keine Korrektur noetig)
- **2026-04-21** Bens-Logo + "Quality for Pharmacy" bleiben im Schriftfeld
- **2026-04-21** Projektgruppen-Wert von `SM_Lagerschale` (White-Label-Bruch) auf `Lagerschalenhalter` (neutral)
- **2026-04-21** Welle_V2 Nummer: `-203` → `-207-0`, Welle_V1 → `-204-0`, Schweissgruppe → `-001-0`
- **2026-04-21** Pos 10 Hutmutter: Stahl 6 → A4-80, Pos 6 Klemmring: 1.4305 → 1.4404

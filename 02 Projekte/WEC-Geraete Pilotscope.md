---
tags: [projekt, inventur, wec, pilot]
status: aktiv
date: 2026-04-18
---

# WEC-Geräte — Pilotscope und Nutzerprofile

## Warum diese Notiz existiert

Beim Mac-Inventur-Pilot ist klar geworden: Der spätere WEC-Rollout umfasst **6 PCs mit sehr unterschiedlichen Nutzerprofilen**. Die Kategorien im Vorsortier-Skript müssen das abbilden können — eine Sekretärin mit Finanz-Schwerpunkt hat andere Dateien als ein Stahlbau-Ingenieur, und Reiners Innovations-Rechner hat wieder ganz eigene Anforderungen (Patente, Fördermittel, das Fahrrad-System). Was wir jetzt auf Sebastians Mac als universelles Muster etablieren, muss auf **alle sechs Profile** anwendbar sein.

## Die sechs Geräte

*Stand: 2026-04-18, von Sebastian diktiert — Klärung noch offen wo markiert*

### 1. Sabine — Sekretariat + Finanzen + Zeichnungsprofil

- **Schwerpunkt laut Sebastian: Finanzen**
- Rolle im Büro: Sekretärin
- Zusätzlich: arbeitet auch an Zeichnungen — Bezeichnungen, Bemaßungen, Stücklisten
- **Typische Dateien:**
  - Finanzen: Rechnungen, Überweisungen, Kontoauszüge, Buchhaltungs-Exports, DATEV-Dateien, Steuer-Unterlagen, Lohn- und Gehaltslisten
  - Sekretariat: Korrespondenz (E-Mails, Briefe, Word), Kalender-Exports, Protokolle
  - Zeichnungen: Zeichnungs-Metadaten, BOMs, Stücklisten-Tabellen (Excel/CSV)
- ⚠ **Offene Frage:** Ist das eine Person mit allen drei Rollen, oder gibt es eine zweite Sabine nur für Zeichnungen?

### 2. Petra — Zeichnungsprofil

- Schwerpunkt: Bezeichnungen, Bemaßungen, Stücklisten
- **Typische Dateien:** Zeichnungsableitungen (PDFs, DWG), Stücklisten (Excel, CSV), evtl. CAD-Files als Sekundärprodukt

### 3. Andreas — Präzisions-Konstruktion und Berechnung

- Arbeitsstil: sehr genau, rechnerisch stark
- **Typische Dateien:** CAD-Modelle, Berechnungsprotokolle (evtl. FEM), detaillierte Zeichnungen, Normrecherchen, Tabellenkalkulationen

### 4. Steffen — Autodesk Stahlbau und Engineering

- Software-Schwerpunkt: Autodesk-Ökosystem (vermutlich Inventor + Advance Steel)
- **Typische Dateien:** Stahlbau-Modelle (.ipt, .iam, .idw), Advance-Steel-Projekte, Stahllisten, Schweißpläne, Ingenieur-Dokumentation

### 5. Reiner — Geschäftsführung + Innovation (Fördermittel, Patente, Fahrrad-System)

- **Rechner-Schwerpunkt laut Sebastian: Innovationsrechner**
- Rollen: Inhaber WEC, SolidWorks 2020, 30 Jahre Erfahrung
- **Innovations-Domäne auf diesem Rechner:**
  - **Fördermittel:** Förderanträge, Bewilligungsbescheide, Förderprogramm-Unterlagen, Fristen
  - **Patente:** Patentanmeldungen, Patentrecherchen, Anwaltskorrespondenz
  - **Fahrrad-Federungssystem:** Reiners eigene Erfindung, TOP SECRET — CAD, Zeichnungen, Prototyp-Dokumentation, alle zugehörigen Notizen. Siehe [[02 Projekte/WEC Neustart mit Reiner/Fahrrad Federungssystem]]
  - **Sonstige Innovationen:** Ideen, Konzepte, F&E-Material
- **Standardbetrieb:**
  - SolidWorks-Projekte der Kunden (Bens, Knauf, etc.)
  - Kunden-Korrespondenz, Angebote, Vertragsunterlagen, Stücklisten
- ⚠ **Sicherheitsanforderung besonders hoch:** Patentwesen und Fahrrad-System dürfen nicht aus dem Haus, nicht in unverschlüsselte Cloud, nicht in fremde Hände.

### 6. *(sechster PC — noch zu klären)*

- Sebastian sprach von 6 PCs, fünf Personen genannt. Zweites Gerät für Reiner (Werkstatt-/CAD-Nebenrechner)? Reserve-/Konstruktionsarbeitsplatz? Zweiter Sabine-Platz (z.B. Buchhaltungs-PC getrennt vom Sekretariats-PC)?

## Konsequenzen für das Pilot-Skript

### Universelle Kategorien bleiben (Mac-Inventur-Skript)

Das bisherige Schema gilt **für alle Profile**:
- `01_Muell/` — Logs, .crdownload, Diagnose-Files (überall dasselbe)
- `02_Installer/` — Setups (überall dasselbe, Endungen erweitern: `.ipt`-Installer, `.msi`)
- `03_iPhone_Fotos_Videos/` — bei Büro-PCs eher `Handy_Fotos_Videos/`
- `04_Moegliche_Duplikate/` — Namensmuster universal
- `05_Projekt_Material/` — das eigentliche Arbeitsgut

### Profil-spezifische Erweiterungen (neu)

Zusätzliche Stapel je nach Nutzerprofil:

| Profil | Zusatz-Stapel (Vorschlag) |
|---|---|
| Sabine (Sekretariat + Finanzen + Zeichnungen) | `06_Finanzen/` (Rechnungen, Kontoauszüge, DATEV), `07_Korrespondenz/`, `08_Stücklisten/` |
| Petra (Zeichnungen) | `06_Zeichnungen/`, `07_Stücklisten/` |
| Andreas (Konstruktion/FEM) | `06_CAD/`, `07_Berechnungen/` |
| Steffen (Stahlbau/Autodesk) | `06_Autodesk_Projekte/`, `07_Stahlbau_Dokumente/` |
| Reiner (Innovation + Geschäftsführung) | `06_Innovation_Vertraulich/` (Patente, Fahrrad, F&E), `07_Foerdermittel/`, `08_Kunden/`, `09_Angebote_Vertraege/` |

### Ziel im jeweiligen Gehirn

Nach dem Sichten landet alles an seinem kontextuellen Ort:
- **Sabine / Petra / Andreas / Steffen:** ins jeweils eigene Gehirn mit WEC-Struktur — oder, falls alle ein gemeinsames WEC-Gehirn nutzen, in `03 Bereiche/WEC/raw/<Kunde>/` bzw. `03 Bereiche/WEC/Mitarbeiter/<n>/`
- **Reiner:** ins Reiner-Gehirn (bereits in Vorbereitung). **Innovations-Material (Patente, Fahrrad-System, Fördermittel)** bekommt dort einen **separaten, geschützten Bereich** — nicht einfach in `raw/`.
- **Sebastian:** ins bestehende Brain-Gehirn

⚠ **Strategische Frage:** Bekommt jeder Mitarbeiter ein eigenes Gehirn, oder gibt es ein zentrales WEC-Gehirn für alle? Bei **Reiners Innovations-Bereich** spricht viel dafür, ihn **getrennt und verschlüsselt** zu halten — auch innerhalb eines zentralen WEC-Gehirns wäre das ein Sonderbereich mit eingeschränktem Zugriff. Das ist eine Entscheidung die Sebastian und Reiner treffen müssen, bevor der Rollout startet.

## Technische Konsequenzen

- **Skript-Portierung macOS → Windows:** Zweimal nötig
  - `sort-brain.sh` → `sort-brain.ps1` (PowerShell)
  - `mac-inventur.sh` → `pc-inventur.ps1` (PowerShell)
- **Autodesk-Ökosystem berücksichtigen:** Andere Extensions, andere Archiv-Logik (z.B. Inventor Workspaces, Advance-Steel-Modelle)
- **Netzlaufwerke und NAS:** Reiner hat ein NAS. Bei einem Mitarbeiter-PC ist das „lokale Desktop" vielleicht leer, weil alles über NAS läuft. Das muss im Playbook stehen.
- **Vertraulichkeitsstufen:** Reiners Innovations-Material braucht eine eigene Sicherheitsebene — nicht einfach wie Standard-Projektmaterial behandeln.

## Verknüpfungen

- [[02 Projekte/Mac Inventur]] — das laufende Pilot-Projekt
- [[00 Kontext/WEC Kontakte/Profil Reiner]] — Reiner im Detail
- [[02 Projekte/WEC Neustart mit Reiner/Fahrrad Federungssystem]] — Reiners Patent-Projekt
- [[03 Bereiche/WEC/README]] — WEC-Bereich
- [[02 Projekte/WEC Neustart mit Reiner/WEC Neustart mit Reiner]] — übergeordnetes Projekt

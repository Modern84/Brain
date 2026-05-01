#!/usr/bin/env bash
# ──────────────────────────────────────────────────────────────
# prepare-reiner-gehirn.sh
#
# Erzeugt auf der Samsung T9 den Bereich 02_Reiner-Gehirn/ mit:
#   - Gehirn/        (kompletter Obsidian-Vault, startklar)
#   - Installer/     (leerer Ordner, Installer werden manuell reingelegt)
#   - Einrichtung.md (Schritt-für-Schritt-Anleitung für Reiner)
#
# Nutzung:  ./prepare-reiner-gehirn.sh /Volumes/WEC-Transfer
# ──────────────────────────────────────────────────────────────

set -euo pipefail

# ── Arg-Check ──
if [ $# -ne 1 ]; then
  echo "Verwendung: $0 <Pfad-zur-SSD>"
  echo "Beispiel:   $0 /Volumes/WEC-Transfer"
  exit 1
fi

SSD="$1"

if [ ! -d "$SSD" ]; then
  echo "❌ Pfad existiert nicht: $SSD"
  exit 1
fi

BASE="$SSD/02_Reiner-Gehirn"
VAULT="$BASE/Gehirn"

echo "── Baue Reiner-Gehirn auf $SSD ──"

# ── 1. Ordnerstruktur ──
mkdir -p "$BASE/Installer"
mkdir -p "$VAULT/00 Kontext"
mkdir -p "$VAULT/01 Eingang"
mkdir -p "$VAULT/02 Projekte"
mkdir -p "$VAULT/03 Bereiche/WEC"
mkdir -p "$VAULT/03 Bereiche/Kunden"
mkdir -p "$VAULT/04 Wissen"
mkdir -p "$VAULT/05 Tagesbuch"
mkdir -p "$VAULT/06 Archiv"
mkdir -p "$VAULT/07 Anhänge"

echo "✅ Ordnerstruktur angelegt"

# ── 2. CLAUDE.md ──
cat > "$VAULT/CLAUDE.md" <<'EOF'
# Gehirn — Kontext

Dieses Gehirn gehört Reiner Woldrich, Inhaber von WEC — WOLDRICH ENGINEERING + CONSULTING.

## Über Reiner

(Wird gleich zusammen mit Sebastian per Diktierfunktion ausgefüllt)

## Wichtig

- Reiner ist Praktiker, kein IT-Mensch
- Klare, einfache Sprache — kein Fachjargon
- Deutsche Begriffe verwenden, kein Englisch
- Diktierfunktion ist der Haupteingabeweg (Win+H → sprechen)
- Reiners Texte immer still auf Rechtschreibung korrigieren — keine Kommentare
- Eigene Antworten auf korrekte deutsche Rechtschreibung und Grammatik prüfen

## Verbindung zu Sebastian

Reiner arbeitet eng mit Sebastian (Basti) zusammen bei WEC.
Sebastians Gehirn: separates System, aber gleiche Struktur und gleiche Begriffe.
Gemeinsame Projekte: WEC Pirna, Konstruktionsaufträge, Lebensmittelindustrie.

## Auftreten nach außen

Reiner und Sebastian wirken nach außen wie ein professionelles Ingenieurbüro mit Jahrzehnten Erfahrung — nicht wie zwei Männer die sich durchkämpfen. Konkret:

- Keine entschuldigenden Formulierungen
- Keine Unsicherheit nach außen sichtbar
- Autorität durch Kompetenz — korrekte Fachsprache, saubere Dokumentation
- Bei Behörden und Geschäftspartnern: formell, klar, selbstbewusst
- Intern (mit Sebastian oder mir): ehrlich, locker, verletzlich erlaubt

## Begriffe — Deutsch statt Englisch

| Statt (Englisch) | Sagen wir  | Bedeutung                      |
|------------------|------------|--------------------------------|
| Vault            | Gehirn     | Der gesamte Notiz-Raum         |
| Daily Note       | Tagesbuch  | Täglicher Eintrag              |
| Inbox            | Eingang    | Neue Gedanken, unsortiert      |
| Tag              | Schlagwort | Kategorisierung                |
| Frontmatter      | Kopfdaten  | YAML-Infos oben in der Datei   |
| Wikilink         | Verknüpfung| Verbindung zwischen Notizen    |

## Ordner

- **00 Kontext/**: Wer ist Reiner, was macht WEC, Kunden-Profile
- **01 Eingang/**: Schnelle Gedanken, unsortiert
- **02 Projekte/**: Aktive Projekte mit Ziel und Enddatum
- **03 Bereiche/**: Laufende Verantwortung (WEC, Kunden)
- **04 Wissen/**: Referenzmaterial, Normen, Gelerntes
- **05 Tagesbuch/**: Tägliche Einträge (YYYY-MM-DD.md)
- **06 Archiv/**: Erledigtes, inaktive Projekte
- **07 Anhänge/**: Bilder, PDFs, Dokumente
- **AUFGABEN.md**: Offene To-Dos im Root

## Regeln

- Neue Notizen ohne klaren Platz → 01 Eingang/
- Tagesbuch im Format: YYYY-MM-DD.md
- Verknüpfungen mit `[[Ziel]]` zwischen Notizen
- Erledigte Projekte → 06 Archiv/
- Vor dem Löschen immer anschauen, dann entscheiden

## Bei Session-Start

1. AUFGABEN.md lesen
2. Letztes Tagesbuch lesen
3. Kurzes Briefing geben: Was ist offen, wo war ich
EOF

echo "✅ CLAUDE.md angelegt"

# ── 3. AUFGABEN.md ──
cat > "$VAULT/AUFGABEN.md" <<EOF
---
tags: [aufgaben]
date: $(date +%Y-%m-%d)
---

# AUFGABEN

Zuletzt aktualisiert: $(date +%Y-%m-%d)

---

## Aktiv

### WEC — Umzug nach Pirna (bis Ende August 2026)
- [ ] Planungsstand klären
- [ ] Eigene Rolle beim Umzug definieren
- [ ] Synergien mit Bens Edelstahl verstehen

### WEC — Laufend
- [ ] Lagerschalenhalter Lebensmittelindustrie — Überarbeitung abschließen
- [ ] Fördermittel-Recherche
- [ ] Patent-Dokumentation Fahrrad-Federung

### Gehirn — Einrichtung
- [ ] "Über mich" zusammen mit Sebastian per Diktat ausfüllen
- [ ] Wichtige Kunden als Kontakte anlegen
- [ ] Wichtigste laufende Projekte eintragen

---

## Erledigt

- [x] Gehirn eingerichtet ($(date +%Y-%m-%d)) ✅
EOF

echo "✅ AUFGABEN.md angelegt"

# ── 4. Über mich ──
cat > "$VAULT/00 Kontext/Über mich.md" <<'EOF'
---
tags: [kontext]
date: 2026-04-17
---

# Über mich — Reiner Woldrich

## Wer bin ich

(Zusammen mit Sebastian ausfüllen — per Diktierfunktion Win+H)

## WEC — WOLDRICH ENGINEERING + CONSULTING

- Website: w-ec.de
- Standort: Walther-Wolff-Str. 11, 01855 Sebnitz
- Umzug nach Pirna geplant (Ende August 2026)
- Mitarbeiter: Reiner, Steffen, Sabine, Petra, Andreas

## Fachgebiete

- Maschinenbau und Konstruktion
- Anlagenbau (Verpackungsmaschinen, Peripherie)
- Lebensmittel- und Pharma-Industrie (Bens Edelstahl, Sachsenmilch)
- Bau/Gips (Knauf)
- Forschung & Entwicklung biogene Rohstoffe (Laub)

## Erfahrung

- 30 Jahre Konstruktion, hauptsächlich Solid Edge (Siemens)
- Windows-PC, NAS für Projekte

## Ziele 2026

(Zusammen ergänzen)

## Zusammenarbeit mit Sebastian

Sebastian (Basti) ist gleichberechtigter Partner. Sebastian bringt:
- Digitale Infrastruktur (Zweites Gehirn, Claude, MThreeD.io)
- Additive Fertigung (3D-Druck, ProForge5)
- Fusion 360, parametrische Konstruktion

Gemeinsam nach außen: professionelles Ingenieurbüro. Intern: zwei Denker mit KI-Unterstützung.
EOF

echo "✅ Über mich.md angelegt"

# ── 5. Erstes Tagesbuch ──
TODAY=$(date +%Y-%m-%d)
cat > "$VAULT/05 Tagesbuch/$TODAY.md" <<EOF
---
tags: [tagesbuch]
date: $TODAY
---

# $TODAY

## Erster Tag mit dem Zweiten Gehirn

- Obsidian installiert ✅
- Claude Desktop installiert ✅
- Gehirn eingerichtet ✅
- Mit Sebastian erste Schritte gemacht

## Was ich heute gelernt habe

(Hier reinschreiben)

## Was offen ist

- [[AUFGABEN]]
EOF

echo "✅ Erstes Tagesbuch $TODAY.md angelegt"

# ── 6. Obsidian-Einstellungen (.obsidian/app.json) ──
mkdir -p "$VAULT/.obsidian"
cat > "$VAULT/.obsidian/app.json" <<'EOF'
{
  "attachmentFolderPath": "07 Anhänge",
  "newFileFolderPath": "01 Eingang",
  "newFileLocation": "folder",
  "alwaysUpdateLinks": true,
  "spellcheck": true
}
EOF

# Daily Notes Plugin-Config
cat > "$VAULT/.obsidian/daily-notes.json" <<'EOF'
{
  "folder": "05 Tagesbuch",
  "format": "YYYY-MM-DD",
  "template": ""
}
EOF

# Core Plugins aktivieren
cat > "$VAULT/.obsidian/core-plugins.json" <<'EOF'
[
  "file-explorer",
  "global-search",
  "switcher",
  "graph",
  "backlink",
  "canvas",
  "outgoing-link",
  "tag-pane",
  "page-preview",
  "daily-notes",
  "templates",
  "note-composer",
  "command-palette",
  "editor-status",
  "bookmarks",
  "markdown-importer",
  "outline",
  "word-count",
  "file-recovery"
]
EOF

echo "✅ Obsidian-Einstellungen angelegt"

# ── 7. Einrichtung.md (Schritt-für-Schritt für Reiner) ──
cat > "$BASE/Einrichtung.md" <<'EOF'
# Einrichtung — Dein neues Gehirn

Hallo Reiner,

hier ist dein vorbereitetes System. Folge den Schritten, dann bist du in ~30 Minuten startklar.

## Was du hast

Auf dieser SSD liegen zwei Bereiche:

```
WEC-Transfer/
├── 01_WEC-Projekte/       ← Deine Original-Daten (unverändert zurück)
└── 02_Reiner-Gehirn/      ← Dein neues Arbeitssystem
    ├── Gehirn/              ← Der Obsidian-Vault, startklar
    ├── Installer/           ← Obsidian + Claude Desktop
    └── Einrichtung.md       ← Diese Anleitung
```

## Schritt 1 — Gehirn auf deinen PC kopieren (2 Min)

1. Öffne den Datei-Explorer
2. Gehe zu der SSD → `02_Reiner-Gehirn/`
3. Kopiere den Ordner `Gehirn` nach: **`C:\Users\Reiner\Documents\`**
4. Danach liegt er unter: `C:\Users\Reiner\Documents\Gehirn\`

## Schritt 2 — Obsidian installieren (5 Min)

1. Auf der SSD: `02_Reiner-Gehirn/Installer/Obsidian-Setup.exe` ausführen
2. Standardinstallation durchklicken
3. Nach der Installation: Obsidian starten
4. Im Willkommensbildschirm: **"Existierenden Tresor öffnen"**
5. Wähle: `C:\Users\Reiner\Documents\Gehirn`
6. Obsidian öffnet den Vault — alles ist da, Struktur, Dateien, Einstellungen

## Schritt 3 — Claude Desktop installieren (5 Min)

1. Auf der SSD: `02_Reiner-Gehirn/Installer/Claude-Setup.exe` ausführen
2. Standardinstallation durchklicken
3. Claude Desktop starten
4. Mit deiner E-Mail-Adresse einloggen (Sebastian richtet ggf. vorher ein Claude-Abo ein)
5. Nach Login: erstmal nichts tun — Sebastian hilft beim nächsten Schritt

## Schritt 4 — Claude mit Gehirn verbinden (mit Sebastian)

Das machen wir zusammen per Telefon oder vor Ort:

1. Claude Desktop → Einstellungen → Integrationen → **Filesystem**
2. Pfad eintragen: `C:\Users\Reiner\Documents\Gehirn`
3. Speichern
4. Neuen Chat starten → Test: *"Lies mein Gehirn und gib mir ein Briefing"*
5. Claude sollte jetzt deine Struktur kennen

## Schritt 5 — Diktierfunktion testen (1 Min)

1. Klicke irgendwo ins Textfeld (Obsidian oder Claude)
2. Drücke **Win + H**
3. Sprich los — dein Text erscheint
4. Das ist dein Haupteingabeweg. Tippen musst du fast nie.

## Erste Schritte

Wenn alles läuft — ruf Sebastian an. Wir füllen zusammen dein "Über mich" aus per Diktat.

## Wenn was klemmt

- Sebastian anrufen (+49 [Nummer])
- Oder Claude Desktop öffnen und einfach fragen: *"Ich hab ein Problem mit..."* — Claude hilft direkt

## Wichtig

- **Deine NAS-Daten bleiben auf der SSD und auf dem NAS — nichts ist verloren.**
- Wenn du eine neue Version von Projektdaten hast: einfach auf die SSD drauf, überschreiben, Sebastian übernimmt.
- Das Gehirn wächst mit dir. Nichts muss sofort perfekt sein.

Viel Spaß — du bist jetzt Teil des Systems 🧠

Basti & Claude
EOF

echo "✅ Einrichtung.md angelegt"

# ── 8. Installer-Placeholder ──
cat > "$BASE/Installer/README-INSTALLER.md" <<'EOF'
# Installer — hier müssen rein:

Windows:
- Obsidian-x.x.x.exe   → https://obsidian.md/download
- Claude-Setup.exe     → https://claude.ai/download

Mac (falls Reiner später auf Mac umsteigt):
- Obsidian-x.x.x-universal.dmg  → https://obsidian.md/download
- Claude-x.x.x.dmg              → https://claude.ai/download

Einfach herunterladen und in diesen Ordner legen.
EOF

# ── 9. Zusammenfassung ──
echo ""
echo "──────────────────────────────────────────────────────────────"
echo "✅ Fertig. Struktur auf $SSD:"
echo "──────────────────────────────────────────────────────────────"
find "$BASE" -type d | sort
echo ""
echo "Dateien:"
find "$BASE" -type f | sort
echo ""
echo "──────────────────────────────────────────────────────────────"
echo "Jetzt noch manuell in $BASE/Installer/ ablegen:"
echo "  - Obsidian Windows-Installer (.exe)"
echo "  - Claude Desktop Windows-Installer (.exe)"
echo "──────────────────────────────────────────────────────────────"

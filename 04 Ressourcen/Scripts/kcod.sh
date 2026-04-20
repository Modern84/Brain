#!/bin/bash
# kcod.sh — Direkt-Start-Prompt für Claude Code bauen und in Zwischenablage legen
# Nutzung: aus Vault-Root ausführen (oder via Alias `kcod`)

cd "$(dirname "$0")/../.."

today=$(date +%Y-%m-%d)
daily="05 Daily Notes/$today.md"

# A-Punkte aus heutiger Daily Note ziehen (Zeilen zwischen "### A" und nächster "###")
if [ -f "$daily" ]; then
  a_block=$(awk '/^### A/,/^### B/' "$daily" | sed '$d' | tail -n +2)
else
  a_block="(keine Daily Note für heute — bitte zuerst anlegen: bash 04 Ressourcen/Scripts/daily-note.sh)"
fi

# Prompt bauen
prompt=$(cat <<EOF
Direkt-Start. Keine lange Einleitung.

Lies in dieser Reihenfolge:
1. CLAUDE.md — insbesondere Format-Disziplin (R1-R6) und Entscheidungs-Heuristik
2. 05 Daily Notes/$today.md — heutige Agenda + Priorität
3. TASKS.md — Termine-Abschnitt oben
4. ~/.claude/projects/.../memory/MEMORY.md — technischer Stand

A-Block aus heutiger Daily Note (Vorschau):
$a_block

Dann:
- Aus dem A-Block wähle eine Aufgabe die DU mit Filesystem / Terminal
  lösen kannst (keine Hardware, keine UI).
- Benenne die Wahl in einer Zeile: "Ich fixe jetzt X, weil Y."
- Dann direkt anfangen. Keine Zwischenfrage.

Kandidaten die typischerweise für Code geeignet sind:
- CSV-Nummernsystem (BE-IS → BE-LS-202603) in raw-BOM korrigieren
- PDF-Metadaten bereinigen mit exiftool (Grundplatte + Zwischenplatte)
- Git-Backup nach Handover-Vorlage initialisieren
  (siehe 04 Ressourcen/Templates/Claude-Handover/Git-Backup-Setup.md)
- brain-lint.sh Baseline erzeugen und Report ablegen
- WEC-Wiki-Kunden-Artikel Kopfdaten-Migration fortsetzen
  (siehe Kopfdaten-Migration.md im selben Ordner)
- Pi-Tailscale-Diagnose vorbereiten (SSH-Probe, Status-Check-Skript)

Nicht für dich: physische Hardware, Obsidian-UI, Hand-Aktionen.

Regeln:
- Format-Disziplin R1–R6 einhalten (max eine Tabelle, keine a/b/c-Fragen)
- Bei Unsicherheit einmal fragen, dann handeln
- Nach jedem größeren Schritt Zwischenstand in die heutige Daily Note
- Am Ende: Ein-Satz-Report + erledigt ins TASKS.md

Start: Was fixt du?
EOF
)

# In Zwischenablage legen (macOS)
if command -v pbcopy >/dev/null 2>&1; then
  echo "$prompt" | pbcopy
  echo "✅ Prompt in Zwischenablage (pbcopy)."
else
  echo "⚠️  pbcopy nicht verfügbar — Prompt unten, bitte manuell kopieren."
  echo ""
  echo "$prompt"
  echo ""
fi

echo ""
echo "Nächster Schritt:"
echo "  1. Terminal-Tab mit Claude Code öffnen (brain-Alias + claude)"
echo "  2. Cmd+V einfügen"
echo "  3. Enter"
echo ""
echo "Variante mit konkretem Auftrag statt Selbstwahl:"
echo "  kcod --task \"deine konkrete Aufgabe\""
echo ""

# Variante mit hartem Auftrag
if [ "$1" = "--task" ] && [ -n "$2" ]; then
  task_prompt="${prompt%Start: Was fixt du?}

Konkreter Auftrag: $2

Keine Selbstwahl, direkt starten."
  echo "$task_prompt" | pbcopy
  echo "✅ Task-Variante in Zwischenablage überschrieben: \"$2\""
fi

# Vault Kontext

Dieses Vault ist das Zweite Gehirn von Sebastian.

## Über mich

Sebastian, Konstrukteur und Gründer im Bereich Additive Fertigung. Erfinder des [[ostdeutschenturbolader|ostdeutschenturboladers]] mit der Firma dreiB. Aktuell angestellter Konstrukteur mit dem Ziel, über MThreeD.io wieder selbstständig im Bereich Design und Fertigung durchzustarten. Typischer INTP — denkt viel, handelt gezielt, liebt technische Lösungen. Ausführliches Profil in [[00 Kontext/Über mich]].

## Wichtiger Hinweis

Sebastian hat LRS. Das bedeutet: Beim Schreiben aktiv helfen, Textentwürfe vorschlagen, Formulierungen anbieten. Nie Rechtschreibung kommentieren oder bewerten. Wenn Sebastian sagt "ich weiß nicht was ich schreiben soll" — Struktur und Entwurf anbieten, er denkt, ich schreibe.

## Vault-Struktur

- **00 Kontext/**: Persönliches Kontext-Profil (Über mich, ICP, Angebot, Schreibstil, Branding). Zentrale Referenz für alle inhaltlichen Aufgaben. Lies diese Dateien wenn du Content erstellst, Angebote formulierst oder Kundenkommunikation schreibst.
- **01 Inbox/**: Schnelle Gedanken, Brain Dumps, unverarbeitete Notizen. Alles was noch keinen festen Platz hat landet hier.
- **02 Projekte/**: Aktive Projekte mit konkretem Ziel und Enddatum. Projekte starten als einzelne .md Datei. Nur bei komplexen Projekten mit mehreren Dateien wird ein Unterordner erstellt.
- **03 Bereiche/**: Laufende Verantwortungsbereiche ohne Enddatum. Jeder Bereich ist ein eigener Ordner, weil Bereiche über die Zeit wachsen.
- **04 Ressourcen/**: Referenzmaterial, Wissen, gesammelte Informationen. Jedes Thema ist ein eigener Ordner.
- **05 Daily Notes/**: Tägliches Logbuch. Was an einem Tag passiert ist, welche Entscheidungen getroffen wurden, was offen ist. Gibt mir die Kontinuität zwischen Sessions.
- **06 Archiv/**: Abgeschlossene Projekte und inaktive Bereiche. Aus dem aktiven Blickfeld, aber durchsuchbar.
- **07 Anhänge/**: Bilder, PDFs, Medien. Obsidian legt hier automatisch alle eingefügten Dateien ab.
- **Clippings/**: Web Clippings vom Obsidian Web Clipper. Gesammelte Artikel und Links. Neue Clips landen hier automatisch — bei der nächsten Session prüfen ob der Inhalt in eine Ressource übernommen werden soll.
- **TASKS.md**: Schnelle Aufgabenliste im Root. Vault-weite To-Dos, nach Priorität sortiert (Aktiv → Geplant → Someday).
- **vault-scan-report.md**: Letzter Scan-Report zur Vault-Gesundheit. Wird bei Bedarf aktualisiert.

## Regeln für dieses Vault

- Nutze `[[Wikilinks]]` für Verknüpfungen zwischen Notizen
- Neue Notizen ohne klaren Platz kommen in 01 Inbox/
- Daily Notes im Format: YYYY-MM-DD.md (z.B. 2026-04-04.md)
- Nutze YAML Frontmatter: tags, status (aktiv/abgeschlossen/pausiert/geplant), date
- Dateinamen in normaler Schreibweise mit Leerzeichen und Großbuchstaben
- Neue Projekte bekommen eine einzelne .md Datei direkt unter 02 Projekte/. Unterordner nur wenn das Projekt mehrere Dateien braucht.
- Bereiche und Ressourcen sind immer Ordner, weil sie wachsen
- Abgeschlossene Projekte nach 06 Archiv/ verschieben — nur auf Sebastians Anweisung
- Wenn du Dateien erstellst oder verschiebst, kurz erklären warum
- Vor dem Löschen oder Überschreiben immer nachfragen
- Wenn Sebastian sagt "merk dir das" oder "speicher das": Schreibregeln → [[00 Kontext/Schreibstil]], Projekt-Infos → jeweilige Projekt-Datei, technische Erkenntnisse → 04 Ressourcen/, Vault-Regeln → diese CLAUDE.md. Im Zweifel kurz fragen.

## Frontmatter-Standard

Jede Datei bekommt YAML-Frontmatter mit mindestens:
- `tags`: Kategorie-Tag passend zum Ordner (`kontext`, `projekt`, `bereich`, `ressource`, `inbox`, `daily-note`, `clippings`)
- `date`: Erstelldatum im Format YYYY-MM-DD
- `status`: Nur bei Projekten, aktiven Ressourcen und abgeschlossenen Einträgen (`aktiv`, `geplant`, `pausiert`, `abgeschlossen`)

Tags immer in eckigen Klammern: `tags: [projekt]`. Zusätzliche beschreibende Tags sind erlaubt: `tags: [projekt, klipper, hardware]`.

## Session-Routinen

### Bei Session-Start
1. TASKS.md lesen — offene Aufgaben prüfen
2. 01 Inbox/ und Clippings/ auf neue Einträge prüfen
3. Letzte Daily Note lesen für Kontext
4. Kurzes Briefing geben: Was ist offen, wo war ich

### Kontext abrufen
Wenn Sebastian fragt "Was ist gerade aktuell?", "Wo war ich?" oder ähnliches: Lies die letzten 2–3 Daily Notes in 05 Daily Notes/, TASKS.md und die aktiven Projekt-Dateien in 02 Projekte/ für ein kurzes Briefing.

### Vor Content-Aufgaben
Wenn Sebastian Content erstellen will (Website-Texte, Angebote, Social Media, Kundenkommunikation): Lies zuerst die relevanten Dateien aus 00 Kontext/ — mindestens [[00 Kontext/Schreibstil]], [[00 Kontext/ICP]] und [[00 Kontext/Angebot]]. Der Ton und die Zielgruppe stehen dort.

### Bei Session-Ende
Wenn Sebastian die Session beendet oder ein natürliches Ende erreicht ist, anbieten:
1. Daily Note in 05 Daily Notes/ erstellen mit Zusammenfassung des Tages
2. TASKS.md aktualisieren (erledigte abhaken, neue eintragen)
3. Neue Erkenntnisse als Notizen speichern
4. Inbox und Clippings aufräumen falls nötig
5. Rückverlinkungen prüfen — neue Dateien sollten von mindestens einer anderen Datei verlinkt sein

---
tags: [kontext, dashboard, home]
date: 2026-04-19
---

# 🧠 Home — Live-Dashboard

> **Dynamischer Einstiegspunkt.** Alles hier wird über Dataview automatisch aktualisiert — niemals von Hand pflegen.

---

## 🔥 Aktive Projekte

```dataview
TABLE
  status AS "Status",
  file.mtime AS "Zuletzt",
  kunde AS "Kunde",
  due AS "Frist"
FROM "02 Projekte"
WHERE status = "aktiv"
SORT file.mtime DESC
LIMIT 15
```

---

## 📅 Fristen in den nächsten 14 Tagen

```dataview
TABLE due AS "Fällig", status AS "Status"
FROM "02 Projekte" OR "03 Bereiche"
WHERE due AND due >= date(today) AND due <= date(today) + dur(14 days)
SORT due ASC
```

---

## 🚨 Hohes Risiko / Warnung

```dataview
TABLE risiko AS "Risiko", kunde AS "Kunde", status AS "Status"
FROM "02 Projekte" OR "03 Bereiche"
WHERE risiko = "hoch"
SORT file.mtime DESC
```

---

## 📝 Letzte 7 Daily Notes

```dataview
LIST file.mtime
FROM "05 Daily Notes"
SORT file.name DESC
LIMIT 7
```

---

## 📥 Inbox — was wartet

```dataview
LIST
FROM "01 Inbox"
WHERE file.name != "README"
SORT file.mtime DESC
LIMIT 10
```

---

## 👥 WEC-Kunden-Aktivität

```dataview
TABLE kunde AS "Kunde", status AS "Status", file.mtime AS "Zuletzt"
FROM "03 Bereiche/WEC/wiki/Kunden" OR "03 Bereiche/WEC/Lieferung"
WHERE kunde
SORT file.mtime DESC
LIMIT 10
```

---

## 🏠 Raum-Einstiege

- 🏭 [[03 Bereiche/WEC/README]]
- 🖨️ [[02 Projekte/ProForge5 Build]]
- 🚀 [[03 Bereiche/Business MThreeD.io/Business MThreeD.io]]
- 💰 [[03 Bereiche/Finanzen/Finanzen]]
- 🧠 [[03 Bereiche/KI-Anwendungen/KI-Anwendungen]]
- 📐 [[03 Bereiche/Konstruktion/Konstruktion]]
- 💑 [[03 Bereiche/Ildi/README]]
- 👤 [[00 Kontext/Über mich]]
- 📅 [[TASKS]]

---

## 🛠️ Werkzeuge

- [[04 Ressourcen/Scripts/README]] — Bash-Scripts (Lint, Stats, Daily, Image-Shrink)
- [[04 Ressourcen/Prompts/README]] — Textbausteine (Session-Starter, LRS-Check, Mail-Ton, WEC-Session)
- [[04 Ressourcen/Templates/Claude-Handover]] — Handover-Prompts für parallel-Betrieb

---

## ⚙️ System-Status

```dataview
LIST
FROM "" 
WHERE file.name = "CLAUDE" OR file.name = "TASKS" OR file.name = "MEMORY"
SORT file.mtime DESC
```

---

*Dieses Dashboard lebt. Wenn Projekte neue Kopfdaten bekommen (`kunde:`, `due:`, `risiko:`, `status:`), erscheinen sie hier automatisch. Siehe [[04 Ressourcen/Kopfdaten-Standard]] für das Feld-Schema.*

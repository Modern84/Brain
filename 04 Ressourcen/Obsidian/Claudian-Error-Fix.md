# Claudian Error Fix — "Prompt is too long"

**Status:** Sofort umsetzbar  
**Bearbeitungszeit:** 2-3 Minuten  

---

## Problem
Der Error `invalid_request: Prompt is too long` tritt auf, wenn:
- Conversation History + Vault Context > Model Token-Limit (200K für Sonnet 4)
- Zu viele/große Dateien im Context geladen werden
- Chat-Verlauf zu lang wird

---

## Sofortfix (jetzt gleich)

### 1. Neue Conversation starten
**Wo:** Claudian-Panel in Obsidian (rechte Sidebar)  
**Action:**
- Oben rechts im Claudian-Chat-Fenster → **"New Chat"** Button klicken
- Oder: Command Palette (`Cmd+P`) → "Claudian: New Chat"

**Effekt:** Conversation History wird gelöscht, Error verschwindet sofort.

---

## Strukturelle Lösung (verhindert Wiederholung)

### 2. Claudian Settings optimieren
**Pfad:** Obsidian → Settings (⚙️ unten links) → **Community Plugins** → **Claudian**

#### Wichtigste Settings:

**Model:**
- Aktuell wahrscheinlich: `claude-haiku-3-5` (100K Context)
- **Umstellen auf:** `claude-sonnet-4` (200K Context)
- **Begründung:** Doppeltes Token-Limit, aber ~10x teurer. Für dich egal, weil du Pro-Plan hast.

**Context Settings** (falls vorhanden):
- **Max Files in Context:** Runter auf **5-10** (statt 20+)
- **Conversation History Length:** Max **10-15 Messages** behalten
- **Auto-include Vault Files:** Deaktivieren (oder manuell auswählen)

**Falls diese Settings NICHT existieren:**
- Claudian nutzt dann die **Claude Code CLI Config**
- Die liegt hier: `~/.claude/config.json`
- Kann ich aber nicht remote ändern (liegt außerhalb Brain Vault)

---

## Vault-seitig: Dateigröße reduzieren

### 3. Große Notes aufsplitten
**Check:** Hast du Monster-Dateien im Brain? (>5000 Zeilen)  
**Lösung:** Große Notes in kleinere aufteilen:
- Beispiel: `ProForge-Complete.md` → `ProForge-Hardware.md`, `ProForge-Software.md`, `ProForge-Klipper.md`
- Vorteil: Claudian lädt nur relevante Teile

**Tools zum Checken:**
```bash
# Größte Dateien finden (auf deinem Mac):
find ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Brain \
  -name "*.md" -type f -exec wc -l {} + | sort -nr | head -20
```

---

## Warum kein "gar kein Limit"?

**Harte API-Limits (nicht änderbar):**
- Sonnet 4: **200.000 Tokens** (≈ 150.000 Wörter)
- Haiku: **100.000 Tokens**
- Opus 4.7: **200.000 Tokens**

**Das ist Anthropic-API-seitig fest** — kein Plugin kann das umgehen.

**Aber:** 200K ist RIESIG. Zum Vergleich:
- Durchschnittlicher Roman: 80.000-100.000 Wörter
- Dein gesamter Brain Vault: Wahrscheinlich <50K Wörter (wenn nicht gerade 100+ Notes)

**Das Problem ist nicht das Limit** — sondern dass Claudian zu viel auf einmal lädt:
- Alte Chat-History (20+ Messages)
- 30+ Vault-Dateien automatisch im Context
- → Überschreitet 200K

---

## Action Items für dich

### Jetzt sofort:
- [ ] **New Chat** in Claudian klicken → Error weg

### Wenn du Zeit hast (5 Min):
- [ ] Obsidian Settings → Claudian → Model auf **Sonnet 4** umstellen
- [ ] Context-Settings checken (falls vorhanden) → auf 5-10 Files begrenzen
- [ ] Falls Settings nicht vorhanden: Mir Bescheid geben, dann schaue ich in `~/.claude/config.json`

### Optional (wenn Error oft wiederkommt):
- [ ] Große Notes finden und aufsplitten
- [ ] Auto-include Vault Files deaktivieren

---

## Wenn das nicht hilft

Falls der Error **nach New Chat + Sonnet 4** immer noch kommt:
→ **Ping mich an**, dann debuggen wir tiefer:
- Claude Code CLI Config checken
- Vault-Struktur analysieren
- Eventuell Claudian-Version updaten (aktuell: v2.0.3)

---

**TL;DR:**  
1. **New Chat** klicken → Error weg  
2. Model auf **Sonnet 4** umstellen → 2x mehr Platz  
3. Weniger Files auto-laden → verhindert Overflow  

—Mo, 17.04.2026 05:00

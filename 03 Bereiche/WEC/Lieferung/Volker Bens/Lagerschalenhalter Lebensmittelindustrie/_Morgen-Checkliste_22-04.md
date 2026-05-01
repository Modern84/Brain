---
typ: morgen-checkliste
projekt: Lagerschalenhalter Volker Bens
fuer: 2026-04-22 vormittags
erstellt: 2026-04-21 abends
vorgaenger-session: [[Aenderungsprotokoll]]
---

# Kick-off 22.04. — Lagerschalenhalter-Abschluss

Einstieg für morgen früh. Wenn Claude (neue Session) oder du selbst hier startet, ist der Tag in 5 Minuten erfassbar.

## Worum geht's

Bens-Lagerschalenhalter-Lieferung abschließen. Gestern ist es bei **Paket v3** hängen geblieben — Reiner hat per Telefon/E-Mail gemeldet, dass Stücklisten-Nummern inkonsistent sind und Welle+Scheibe als Baugruppe geführt werden muss. Wir haben daraufhin alle 11 Zeichnungen in Fusion neu exportiert mit eindeutigen Dateinamen. Reiner hat eine ausführlichere Änderungsmail angekündigt, die möglicherweise die Nummern-Logik noch feinjustiert.

Heute: Reiner-Input konsolidieren, Mapping v5 bauen, Paket v4 rausgeben, Freigabe holen.

## Ausgangslage (Stand gestern 21.04. abends)

**Im Liefer-Input (`_An_Volker/PDF/`) liegen 11 PDFs:**

| # | PDF | Vermutete Klassifizierung (vor Reiner-Input) |
|---|---|---|
| 1 | Lagerhalter Zeichnung.pdf | Einzelteil → `-012-0` |
| 2 | Lagerschale Zeichnung.pdf | Einzelteil → `-013-0` |
| 3 | Scheibe_t=1 Zeichnung.pdf | Einzelteil → `-011-0` |
| 4 | Scheibe_t=3 Zeichnung.pdf | Einzelteil (Scheibe für Welle-Baugruppen) → `-112-0` |
| 5 | Schweißgruppe_Halter Zeichnung.pdf | Schweißgruppe (offen: gemeinsam V1+V2 oder dupliziert) |
| 6 | Welle_V1 einzelteil Zeichnung.pdf | Einzelteil V1 → `-111-0` |
| 7 | Welle_V1 Schweisbaugruppe Zeichnung.pdf | Schweißbaugruppe V1 → `-152-0` |
| 8 | Welle_V2 einzelteil Zeichnung.pdf | Einzelteil V2 → `-211-0` |
| 9 | Welle_V2 Schweisbaugruppe Zeichnung.pdf | Schweißbaugruppe V2 → `-252-0` |
| 10 | Zusammenbau_Lagerschalehalter V1 Zeichnung.pdf | V1-Zusammenbau → `-191-0` |
| 11 | Zusammenbau_Lagerschalehalter V2 Zeichnung.pdf | V2-Zusammenbau → `-291-0` |

Die drei bisherigen Pakete (v1, v2, v3) liegen archiviert im `_Paket_fuer_Reiner/`-Ordner als Iterationshistorie. Altstand der PDFs gesichert unter `_An_Volker/PDF/_archiv_vor_fusion_update_1630/`.

## Offene Fragen an Reiner (vorm Mapping v5)

1. **Schweißgruppe_Halter — gemeinsam oder dupliziert?** Inhalt (Lagerhalter + Lagerschale verschweißt) ist variantenunabhängig. Zwei Optionen:
   - A: **`-151-0`** gemeinsam für V1+V2 (eine Nummer, eine Zeichnung)
   - B: **`-151-0` + `-251-0`** getrennt, Zeichnung einmal, Nummern doppelt
   - C: **`-051-0`** als X=0 gemeinsam (wie Lagerhalter/Lagerschale)
   Claude's Bauchvorschlag war A. Reiners Änderungsmail wird hoffentlich klarmachen.

2. **Welle V2 Schweisbaugruppe — Nummer?** Vermutlich `-252-0`. Falls Reiner eine andere Logik hat (z.B. `-191-0`, `-192-0` durchzählend für Baugruppen-Reihe), entsprechend anpassen.

3. **V1-Zusammenbau — existiert er jetzt tatsächlich separat oder ist das wieder die Kombi-lang?** Dateiname sagt "V1 Zeichnung" — visuell prüfen ob nur V1-Teile drin sind, oder ob V1+V2 auf einem Blatt.

4. **Steg (`-014-0`)** — eigene Zeichnung nötig oder nur BOM-Position?

## Vorgehen heute Vormittag

**Schritt 1 — Reiner-Änderungsmail lesen.** Die beantwortet hoffentlich Frage 1-3 oben. Falls nicht: Reiner direkt anrufen (Tel: 035971-8053-10, Mobil: 0173-9576500).

**Schritt 2 — ANALYSE.md ansehen.** Unter `_analyse_11pdfs_v2/ANALYSE.md` — gibt Schriftfeld-Nummern, Stücklisten-Inhalte, Schweißhinweise für alle 11 neuen PDFs. Muss gestern Abend gelaufen sein; falls nicht, hier Prompt:

```
cd "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain/02 Projekte/WEC/scripts"
PDF_DIR="../../../03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/2026-04-21 Montag-Session/_An_Volker/PDF"
OUT_DIR="../../../03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/_analyse_11pdfs_v2"
mkdir -p "$OUT_DIR"
PY="$HOME/.local/share/mthreed/v5-patcher/venv/bin/python"
"$PY" <<'PYEOF'
import pymupdf, re, pathlib
from collections import Counter
pdf_dir = pathlib.Path("../../../03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/2026-04-21 Montag-Session/_An_Volker/PDF")
out_dir = pathlib.Path("../../../03 Bereiche/WEC/Lieferung/Volker Bens/Lagerschalenhalter Lebensmittelindustrie/_analyse_11pdfs_v2")
report = ["# Analyse 11 PDFs\n"]
for idx, p in enumerate(sorted(pdf_dir.glob("*.pdf")), 1):
    doc = pymupdf.open(str(p))
    text = doc[0].get_text()
    doc[0].get_pixmap(dpi=150).save(str(out_dir / f"{idx:02d}_{p.stem}.png"))
    nums = Counter(re.findall(r'BE-LS-202603-\d+(?:-\d+)?', text))
    has_weld = "Schweiß" in text
    report.append(f"\n## {idx:02d}. {p.name}\n- Schweiß: {has_weld}\n- Nummern: {dict(nums)}\n")
    lines = [l.strip() for l in text.split("\n") if l.strip()]
    rel = [l for l in lines if "BE-LS" in l or any(w in l for w in ["Einzelteil","Zusammenbau","Schweißgruppe","Schweißbaugruppe","Baugruppe","Welle","Scheibe","Lager"])]
    for rl in rel[:25]:
        report.append(f"  - `{rl[:110]}`\n")
    doc.close()
(out_dir / "ANALYSE.md").write_text("".join(report))
PYEOF
cat "$OUT_DIR/ANALYSE.md"
```

**Schritt 3 — Mapping v5 schreiben.** Basis: die 11 Schriftfeld-Nummern aus ANALYSE.md + Reiners finale Nummern-Logik. Dateiname-Konvention:

- `BE-LS-202603-011-0_Scheibe_t1.pdf`
- `BE-LS-202603-012-0_Lagerhalter.pdf`
- `BE-LS-202603-013-0_Lagerschale.pdf`
- `BE-LS-202603-112-0_Scheibe.pdf`
- `BE-LS-202603-XXX-0_Schweissgruppe_Halter.pdf` — Nummer je nach Entscheidung V1+V2
- `BE-LS-202603-111-0_Welle_V1.pdf`
- `BE-LS-202603-152-0_Welle_V1_SBG.pdf`
- `BE-LS-202603-211-0_Welle_V2.pdf`
- `BE-LS-202603-252-0_Welle_V2_SBG.pdf`
- `BE-LS-202603-191-0_Zusammenbau_V1.pdf`
- `BE-LS-202603-291-0_Zusammenbau_V2.pdf`

(`SBG` = Schweißbaugruppe, übernommen aus Reiners Solid-Edge-Mustern Sprühlanze/Cavanna/Schwenkteilsicherung.)

**Schritt 4 — v5-Run + v4v2-Info-Block.** Analog zu gestern:
```
./run_v5.sh --mapping [mapping_v5.yaml] --input-dir [PDF/] --staging [_v5v4_staging/]
RUN=$(ls -td _v5v4_staging/v5_run_* | head -1)
INPUT_DIR="$RUN/01_patched" OUTPUT_DIR="_v5v4_staging/_final_v4v2" ./run_v4_v2.sh
```

**Schritt 5 — Paket v4 bauen** (Whitelist, keine Globs) und Reiner zur Freigabe geben.

## Was dann noch aussteht (nicht kritisch heute)

- STEP AP203 für die 7 bisher fehlenden Teile (Fusion-Nachzug)
- BOM-Master/Spiegel erneut syncen
- Title-Tippfehler `Lagerschalehalter` → `Lagerschalenhalter` im Fusion-Template (Kosmetik für später)

## Kontakt-Block

- Reiner Woldrich: Tel 035971-8053-10, Mobil 0173-9576500, woldrich@w-ec.de
- Volker Bens: siehe [[Volker Bens - Profil]]

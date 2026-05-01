#!/usr/bin/env python3
"""
v5_patcher.py — mThreeD.io Filter-Patcher (Stufe 1)

ROLLE in der Pipeline:
  Fusion 360 = Geometrie-Wahrheit (Geometrie + Roh-Export, KEINE Nummern/Materialien)
  v5-Patcher = Liefer-Wahrheit Stufe 1: Nummern, White-Label, Material-Strings
  v4-Patcher = Liefer-Wahrheit Stufe 2: Info-Block (Oberfläche/Toleranz/Werkstoff-Allgemein)

KONTEXT-BEWUSSTES REPLACE (Fix für Substring-Bug):
  Plain substring-Replace kann Platzhalter wie "SM_Lagerschale" mitreißen,
  wenn "Lagerschale" als isolierter Treffer gesucht wird. Lösung:
    1. Jede Regel baut ein Regex aus (context_before + find + context_after).
    2. Das Regex muss im Page-Text EXAKT EINMAL matchen — sonst BLOCK.
    3. Zusätzliche rect-Validierung in pymupdf: exakt eine Fund-Box.
    4. Mehrdeutige oder fehlende Treffer landen im Audit mit Kontext-Snippet
       und stoppen den Output-Write für diese Datei (staging unter _blocked/).

PRODUKTIONS-REGEL:
  Kein direkter Output. Alles nach STAGING. Audit-Markdown daneben.
  Freigabe durch Mo — erst dann geht das Paket raus.

VENV-KONVENTION:
  ~/.local/share/mthreed/v5-patcher/venv  (außerhalb iCloud, PEP-668-konform)
  Wrapper: run_v5.sh baut venv idempotent.

NUMMERN-VERGABE-REGEL:
  Zeichnungsnummern werden NIE wiederverwendet.
  Bei neuen Teilen: nächste freie Nummer aus dem projekt-spezifischen Register.
  Register-Pfad steht in der Mapping-YAML (project.number_register).
  v5-Patcher liest das Register nur — Eintragen neuer Nummern ist manuell
  (bewusste Mo-Entscheidung bei Freigabe).
"""

from __future__ import annotations

import argparse
import datetime as dt
import json
import re
import shutil
import sys
from dataclasses import dataclass, field, asdict
from pathlib import Path
from typing import Any

try:
    import yaml
except ImportError:
    print("FEHLER: pyyaml nicht installiert. Wrapper run_v5.sh nutzen.", file=sys.stderr)
    sys.exit(2)

try:
    import pymupdf  # neuer Name ab 1.24
except ImportError:
    try:
        import fitz as pymupdf  # Fallback für ältere Installs
    except ImportError:
        print("FEHLER: pymupdf nicht installiert. Wrapper run_v5.sh nutzen.", file=sys.stderr)
        sys.exit(2)


# ─────────────────────────────────────────────────────────────────────
# Datenmodell
# ─────────────────────────────────────────────────────────────────────

@dataclass
class Rule:
    kind: str                     # 'drawing_number' | 'material' | 'white_label' | 'custom'
    find: str | None = None       # Literal-Suche
    find_regex: str | None = None # ODER Regex-Suche (exklusiv zu find)
    replace: str = ""
    context_before: str = ""      # Text, der direkt vor `find` stehen muss
    context_after: str = ""       # Text, der direkt nach `find` stehen muss
    required: bool = True         # Wenn True und nicht gefunden → Warnung im Audit
    scope: str = "file"           # 'file' oder 'global'
    source_key: str = ""          # Für Audit: welche Mapping-Gruppe
    mode: str = "unique"          # 'unique' (muss genau 1× matchen) oder 'all' (ersetze alle Vorkommen)

    def pattern(self) -> re.Pattern[str]:
        if self.find_regex:
            core = self.find_regex
        elif self.find:
            core = re.escape(self.find)
        else:
            raise ValueError(f"Regel {self.kind}/{self.source_key}: weder find noch find_regex gesetzt")
        before = re.escape(self.context_before) + r"\s*" if self.context_before else ""
        after = r"\s*" + re.escape(self.context_after) if self.context_after else ""
        return re.compile(f"({before})({core})({after})", re.MULTILINE)

    def label(self) -> str:
        return f"{self.kind}: {self.find or self.find_regex} → {self.replace!r}"


@dataclass
class AuditEntry:
    pdf: str
    page: int
    rule: str
    status: str                   # applied | not_found | ambiguous_text | ambiguous_rect | no_rect
    detail: dict[str, Any] = field(default_factory=dict)


@dataclass
class FileResult:
    input_pdf: str
    staged_pdf: str | None        # Pfad zu geschriebener Datei, None wenn blockiert
    new_name: str | None          # Umbenannter Output-Name (inkl. Nummer-Prefix)
    blocked: bool
    block_reason: str | None
    entries: list[AuditEntry] = field(default_factory=list)


# ─────────────────────────────────────────────────────────────────────
# Mapping-Loader
# ─────────────────────────────────────────────────────────────────────

def load_mapping(mapping_path: Path) -> dict[str, Any]:
    with open(mapping_path, "r", encoding="utf-8") as f:
        data = yaml.safe_load(f)
    if not isinstance(data, dict):
        raise ValueError("Mapping YAML muss ein Objekt auf Top-Level sein")
    if "project" not in data:
        raise ValueError("Mapping YAML fehlt 'project'-Block")
    return data


def build_rules_for_file(mapping: dict[str, Any], pdf_name: str) -> tuple[list[Rule], dict[str, Any] | None]:
    """
    Baut die Regel-Liste für eine einzelne Input-PDF.

    REIHENFOLGE: per-file Regeln zuerst, globale danach. Das ist wichtig,
    weil globale Regeln (z.B. SM_Lagerschale → Lagerschalenhalter) die
    Anchors der per-file Regeln zerstören könnten, wenn sie zuerst liefen.

    Returns:
      (rules, file_entry) wobei file_entry der per-file Block aus dem Mapping ist
      (enthält new_number, new_basename etc.) oder None wenn Datei nicht gemappt.
    """
    rules: list[Rule] = []

    # Per-file Block finden
    files_block = mapping.get("files", {}) or {}
    file_entry = files_block.get(pdf_name)
    if file_entry is None:
        # Versuche case-insensitive Match
        for key, val in files_block.items():
            if key.lower() == pdf_name.lower():
                file_entry = val
                break

    # Per-file Regeln ZUERST
    if file_entry is not None:
        for idx, raw in enumerate(file_entry.get("rules", []) or []):
            rules.append(Rule(scope="file", source_key=f"{pdf_name}[{idx}]", **raw))

    # Globale Regeln DANACH (z.B. White-Label, Werkstoff-Tippfehler): auf ALLE Dateien
    for idx, raw in enumerate(mapping.get("global_rules", []) or []):
        rules.append(Rule(scope="global", source_key=f"global[{idx}]", **raw))

    return rules, file_entry


def _tokenize_context(s: str) -> list[str]:
    """Teile einen Kontext-String in Tokens auf (Whitespace/Newline als Trenner)."""
    return [t for t in re.split(r"\s+", s) if t]


def resolve_core_rect_via_words(
    page: Any,
    core_text: str,
    context_before: str,
    context_after: str,
) -> Any:
    """
    Wenn pymupdf.search_for(core_text) mehrere Rects liefert, nutze die
    words-Sequenz um den EINEN Rect zu finden, bei dem die davor bzw.
    danach folgenden Wörter mit context_before / context_after
    übereinstimmen.

    get_text('words') liefert Tupel (x0, y0, x1, y1, word, block, line, word_no)
    in Reading-Order. Multi-line Kontexte (z.B. 'Lagerhalter\n----') werden
    in Tokens gesplittet und token-weise mit den Nachbarn verglichen.

    Returns: den einen Rect, oder None wenn nicht eindeutig auflösbar.
    """
    words = page.get_text("words")
    if not words:
        return None

    words_sorted = sorted(words, key=lambda w: (w[5], w[6], w[7]))
    before_tokens = _tokenize_context(context_before)
    after_tokens = _tokenize_context(context_after)

    matching_rects: list[Any] = []
    for i, w in enumerate(words_sorted):
        if w[4] != core_text:
            continue

        if after_tokens:
            following = [
                words_sorted[j][4]
                for j in range(i + 1, min(i + 1 + len(after_tokens), len(words_sorted)))
            ]
            if following != after_tokens:
                continue

        if before_tokens:
            start = max(0, i - len(before_tokens))
            preceding = [words_sorted[j][4] for j in range(start, i)]
            if preceding != before_tokens:
                continue

        matching_rects.append(pymupdf.Rect(w[0], w[1], w[2], w[3]))

    if len(matching_rects) == 1:
        return matching_rects[0]
    return None


# ─────────────────────────────────────────────────────────────────────
# Kern-Logik: Regel anwenden
# ─────────────────────────────────────────────────────────────────────

def apply_rule_to_page(page: Any, rule: Rule, page_num: int, pdf_name: str) -> AuditEntry:
    """
    Wendet eine Regel auf eine Seite an.
    Matcht im Text mit Kontext, validiert über Rect-Suche, führt redact+insert aus.
    """
    # --- mode='all': alle Vorkommen ersetzen, keine Ambiguitätsprüfung ---
    if rule.mode == "all":
        if rule.context_before or rule.context_after:
            return AuditEntry(
                pdf=pdf_name, page=page_num, rule=rule.source_key,
                status="config_error",
                detail={"label": rule.label(), "hint": "mode='all' darf keinen context_before/_after haben — unique+Kontext oder all ohne Kontext"},
            )
        if rule.find_regex and not rule.find:
            # search_for nimmt nur Literal-Strings; bei find_regex erst die Matches im Text finden
            text_all = page.get_text()
            regex_matches = [m.group(0) for m in re.finditer(rule.find_regex, text_all, re.MULTILINE)]
            literals = list(set(regex_matches))
        else:
            literals = [rule.find]

        total_rects: list[Any] = []
        for lit in literals:
            total_rects.extend(page.search_for(lit))

        if not total_rects:
            status = "not_found"
            detail = {"label": rule.label()}
            if rule.required:
                detail["required"] = True
            return AuditEntry(pdf=pdf_name, page=page_num, rule=rule.source_key, status=status, detail=detail)

        # Erst alle redacts, dann apply, dann alle inserts
        for rect in total_rects:
            page.add_redact_annot(rect, fill=(1, 1, 1))
        page.apply_redactions()
        for rect in total_rects:
            font_size = max(min(rect.height * 0.75, 12.0), 6.5)
            page.insert_text(
                (rect.x0, rect.y1 - (rect.height * 0.2)),
                rule.replace,
                fontsize=font_size,
                color=(0, 0, 0),
                fontname="helv",
            )
        return AuditEntry(
            pdf=pdf_name, page=page_num, rule=rule.source_key,
            status="applied",
            detail={"label": rule.label(), "count": len(total_rects), "mode": "all"},
        )

    # --- mode='unique' (Default): exakt einer muss matchen ---
    text = page.get_text()
    pattern = rule.pattern()
    matches = list(pattern.finditer(text))

    if len(matches) == 0:
        status = "not_found"
        detail = {"label": rule.label()}
        if rule.required:
            detail["required"] = True
        return AuditEntry(pdf=pdf_name, page=page_num, rule=rule.source_key, status=status, detail=detail)

    if len(matches) > 1:
        return AuditEntry(
            pdf=pdf_name,
            page=page_num,
            rule=rule.source_key,
            status="ambiguous_text",
            detail={
                "label": rule.label(),
                "count": len(matches),
                "excerpts": [m.group(0)[:120].replace("\n", "\\n") for m in matches[:5]],
                "hint": "context_before/context_after strenger machen oder find_regex präzisieren",
            },
        )

    m = matches[0]
    core_text = m.group(2)

    # Rect-Validierung: pymupdf findet die Text-Box
    rects = page.search_for(core_text)
    if len(rects) == 0:
        return AuditEntry(
            pdf=pdf_name,
            page=page_num,
            rule=rule.source_key,
            status="no_rect",
            detail={
                "label": rule.label(),
                "hint": "Text fragmentiert in PDF (z.B. zeichenweise positioniert). Eventuell find_regex mit \\s* zwischen Zeichen.",
            },
        )
    if len(rects) > 1:
        # pymupdf findet core an mehreren Stellen. Erst words-basierte
        # Auflösung über Kontext-Tokens versuchen (robust gegen multi-line
        # Kontexte, die search_for nicht findet).
        if rule.context_before or rule.context_after:
            resolved = resolve_core_rect_via_words(
                page, core_text, rule.context_before, rule.context_after
            )
            if resolved is not None:
                rects = [resolved]
            else:
                # Fallback: full-text rect search (funktioniert nur wenn
                # Match auf einer Zeile liegt)
                full_text = m.group(0).strip()
                full_rects = page.search_for(full_text)
                if len(full_rects) == 1:
                    core_rects_in_full = [r for r in rects if full_rects[0].intersects(r)]
                    if len(core_rects_in_full) == 1:
                        rects = core_rects_in_full
                    else:
                        return AuditEntry(
                            pdf=pdf_name,
                            page=page_num,
                            rule=rule.source_key,
                            status="ambiguous_rect",
                            detail={
                                "label": rule.label(),
                                "rect_count": len(rects),
                                "hint": "words-Resolver und full-text-Rect beide mehrdeutig",
                            },
                        )
                else:
                    return AuditEntry(
                        pdf=pdf_name,
                        page=page_num,
                        rule=rule.source_key,
                        status="ambiguous_rect",
                        detail={
                            "label": rule.label(),
                            "rect_count": len(rects),
                            "hint": "words-Resolver fand kein eindeutiges Nachbar-Pattern; context-Tokens prüfen",
                        },
                    )
        else:
            return AuditEntry(
                pdf=pdf_name,
                page=page_num,
                rule=rule.source_key,
                status="ambiguous_rect",
                detail={
                    "label": rule.label(),
                    "rect_count": len(rects),
                    "hint": "core-Text kommt mehrfach vor; context_before/_after setzen oder find_regex präziser",
                },
            )

    # Eindeutiges rect — apply
    rect = rects[0]

    # Schätze Schriftgröße aus rect-Höhe (nicht perfekt, aber ok für Liefer-Output)
    font_size = max(min(rect.height * 0.75, 12.0), 6.5)

    page.add_redact_annot(rect, fill=(1, 1, 1))
    page.apply_redactions()

    # Schreib neuen Text linksbündig, baseline etwas oberhalb Rect-Unterkante
    insert_point = (rect.x0, rect.y1 - (rect.height * 0.2))
    page.insert_text(
        insert_point,
        rule.replace,
        fontsize=font_size,
        color=(0, 0, 0),
        fontname="helv",  # pymupdf built-in, ähnlich genug zu Arial für Liefer-Qualität
    )

    return AuditEntry(
        pdf=pdf_name,
        page=page_num,
        rule=rule.source_key,
        status="applied",
        detail={
            "label": rule.label(),
            "rect": [round(rect.x0, 1), round(rect.y0, 1), round(rect.x1, 1), round(rect.y1, 1)],
            "font_size_used": round(font_size, 2),
        },
    )


# ─────────────────────────────────────────────────────────────────────
# PDF-Verarbeitung
# ─────────────────────────────────────────────────────────────────────

def process_pdf(
    pdf_path: Path,
    rules: list[Rule],
    file_entry: dict[str, Any] | None,
    staging_dir: Path,
    blocked_dir: Path,
) -> FileResult:
    """
    Verarbeitet eine PDF. Schreibt Output nach staging_dir ODER blocked_dir.
    """
    entries: list[AuditEntry] = []
    doc = pymupdf.open(pdf_path)

    for page_num in range(len(doc)):
        page = doc[page_num]
        for rule in rules:
            entry = apply_rule_to_page(page, rule, page_num + 1, pdf_path.name)
            entries.append(entry)

    # Entscheidung: blockiert oder sauber?
    bad_statuses = {"ambiguous_text", "ambiguous_rect", "no_rect", "config_error"}
    missing_required = [
        e for e in entries
        if e.status == "not_found" and e.detail.get("required")
    ]
    ambiguous = [e for e in entries if e.status in bad_statuses]

    blocked = bool(ambiguous or missing_required)
    block_reason = None
    if ambiguous:
        block_reason = f"{len(ambiguous)} mehrdeutige/unauffindbare Regeln"
    elif missing_required:
        block_reason = f"{len(missing_required)} erforderliche Regeln nicht gefunden"

    # Neuer Dateiname aus file_entry
    if file_entry and file_entry.get("new_basename"):
        new_name = file_entry["new_basename"]
        if not new_name.lower().endswith(".pdf"):
            new_name += ".pdf"
    else:
        new_name = pdf_path.name

    if blocked:
        target_dir = blocked_dir
        staged_pdf = None
    else:
        target_dir = staging_dir
        staged_pdf = str(target_dir / new_name)

    target_dir.mkdir(parents=True, exist_ok=True)
    out_path = target_dir / new_name
    doc.save(out_path)
    doc.close()

    return FileResult(
        input_pdf=str(pdf_path),
        staged_pdf=staged_pdf if not blocked else None,
        new_name=new_name,
        blocked=blocked,
        block_reason=block_reason,
        entries=entries,
    )


# ─────────────────────────────────────────────────────────────────────
# Audit-Schreiber
# ─────────────────────────────────────────────────────────────────────

STATUS_ICON = {
    "applied": "✅",
    "not_found": "⚠️",
    "ambiguous_text": "🟥",
    "ambiguous_rect": "🟥",
    "no_rect": "🟥",
    "config_error": "🛠️",
}


def write_audit(
    results: list[FileResult],
    mapping: dict[str, Any],
    audit_path: Path,
    run_id: str,
) -> None:
    proj = mapping.get("project", {})
    lines: list[str] = []
    lines.append(f"# v5-Patcher Audit — Run {run_id}")
    lines.append("")
    lines.append(f"- **Projekt:** {proj.get('name', '?')}")
    lines.append(f"- **Kunde:** {proj.get('customer', '?')}")
    lines.append(f"- **Schema:** {proj.get('scheme', '?')}")
    lines.append(f"- **Register:** `{proj.get('number_register', '?')}`")
    lines.append(f"- **Zeitpunkt:** {dt.datetime.now().isoformat(timespec='seconds')}")
    lines.append("")

    total_files = len(results)
    blocked_files = sum(1 for r in results if r.blocked)
    clean_files = total_files - blocked_files
    total_rules = sum(len(r.entries) for r in results)
    applied_rules = sum(1 for r in results for e in r.entries if e.status == "applied")

    lines.append("## Zusammenfassung")
    lines.append("")
    lines.append(f"- Dateien gesamt:       **{total_files}**")
    lines.append(f"- Davon sauber:         **{clean_files}**")
    lines.append(f"- Davon blockiert:      **{blocked_files}**  ← brauchen Review vor Freigabe")
    lines.append(f"- Regeln gesamt:        **{total_rules}**")
    lines.append(f"- Regeln erfolgreich:   **{applied_rules}**")
    lines.append("")

    # Blockierte zuerst
    if blocked_files:
        lines.append("## ⛔ Blockierte Dateien (Review erforderlich)")
        lines.append("")
        for r in results:
            if not r.blocked:
                continue
            lines.append(f"### {Path(r.input_pdf).name}")
            lines.append(f"- **Grund:** {r.block_reason}")
            lines.append(f"- **Staging-Kopie:** `_blocked/{r.new_name}` (unmodifizierte Stellen bleiben unverändert)")
            lines.append("")
            lines.append("| Seite | Regel | Status | Detail |")
            lines.append("| --- | --- | --- | --- |")
            for e in r.entries:
                if e.status == "applied":
                    continue
                detail_short = _format_detail(e.detail)
                lines.append(f"| {e.page} | `{e.rule}` | {STATUS_ICON.get(e.status, '?')} {e.status} | {detail_short} |")
            lines.append("")

    lines.append("## ✅ Saubere Dateien (bereit für v4-Info-Block-Stufe)")
    lines.append("")
    any_clean = False
    for r in results:
        if r.blocked:
            continue
        any_clean = True
        lines.append(f"### {Path(r.input_pdf).name} → `{r.new_name}`")
        lines.append("")
        lines.append("| Seite | Regel | Status | Label |")
        lines.append("| --- | --- | --- | --- |")
        for e in r.entries:
            label = e.detail.get("label", "").replace("|", "\\|")
            lines.append(f"| {e.page} | `{e.rule}` | {STATUS_ICON.get(e.status, '?')} {e.status} | {label} |")
        lines.append("")
    if not any_clean:
        lines.append("_Keine saubere Datei in diesem Run._")
        lines.append("")

    lines.append("---")
    lines.append("")
    lines.append("## Freigabe-Checkliste (vor Rausgang)")
    lines.append("")
    lines.append("- [ ] Alle blockierten Dateien entweder gefixt (Mapping angepasst, Re-Run) oder bewusst verworfen")
    lines.append("- [ ] Stichprobe: 2 saubere PDFs visuell geprüft (Schriftgröße, Position der ersetzten Strings)")
    lines.append("- [ ] Nummernregister aktualisiert mit den in diesem Run vergebenen Nummern")
    lines.append("- [ ] v4-Patcher (Info-Block) auf die sauberen v5-Outputs angewendet")
    lines.append("- [ ] Paket-Build: **explizite Dateiliste**, keine Name-Globs")
    lines.append("- [ ] Mo-Freigabe eingeholt")
    lines.append("")

    audit_path.parent.mkdir(parents=True, exist_ok=True)
    audit_path.write_text("\n".join(lines), encoding="utf-8")


def _format_detail(detail: dict[str, Any]) -> str:
    parts = []
    for k, v in detail.items():
        if k == "excerpts" and isinstance(v, list):
            joined = "; ".join(f"`{e}`" for e in v)
            parts.append(f"**excerpts**: {joined}")
        elif k == "rect":
            parts.append(f"**rect**: {v}")
        else:
            parts.append(f"**{k}**: {v}")
    return " · ".join(parts) if parts else ""


# ─────────────────────────────────────────────────────────────────────
# CLI
# ─────────────────────────────────────────────────────────────────────

def main() -> int:
    ap = argparse.ArgumentParser(
        description="v5-Patcher — mThreeD.io Filter Stufe 1 (Nummern/White-Label/Material)",
    )
    ap.add_argument("--mapping", required=True, type=Path, help="Pfad zur mapping YAML")
    ap.add_argument("--input-dir", required=True, type=Path, help="Verzeichnis mit Fusion-PDFs")
    ap.add_argument("--staging", required=True, type=Path, help="Staging-Output-Verzeichnis")
    ap.add_argument("--only", nargs="*", help="Optional: nur diese Dateinamen verarbeiten")
    args = ap.parse_args()

    if not args.mapping.exists():
        print(f"Mapping nicht gefunden: {args.mapping}", file=sys.stderr)
        return 2
    if not args.input_dir.is_dir():
        print(f"Input-Verzeichnis nicht gefunden: {args.input_dir}", file=sys.stderr)
        return 2

    mapping = load_mapping(args.mapping)

    run_id = dt.datetime.now().strftime("%Y-%m-%d_%H%M%S")
    staging_root = args.staging / f"v5_run_{run_id}"
    clean_dir = staging_root / "01_patched"
    blocked_dir = staging_root / "_blocked"
    audit_path = staging_root / "02_audit" / f"audit_{run_id}.md"

    # Eingangsdateien — EXPLIZITE Liste aus Mapping, kein Glob
    # (Regel: Paket-Build nur mit expliziten Dateinamen.)
    mapped_files = list(mapping.get("files", {}).keys())
    if args.only:
        mapped_files = [f for f in mapped_files if f in args.only]

    if not mapped_files:
        print("Keine Input-Dateien aus Mapping ableitbar. files-Block leer?", file=sys.stderr)
        return 1

    missing = [f for f in mapped_files if not (args.input_dir / f).exists()]
    if missing:
        print("Folgende Mapping-Dateien fehlen im Input-Verzeichnis:", file=sys.stderr)
        for f in missing:
            print(f"  - {f}", file=sys.stderr)
        return 1

    results: list[FileResult] = []
    for fname in mapped_files:
        pdf_path = args.input_dir / fname
        rules, file_entry = build_rules_for_file(mapping, fname)
        if not rules:
            print(f"[skip] {fname}: keine Regeln", file=sys.stderr)
            continue
        print(f"[run ] {fname}: {len(rules)} Regeln")
        result = process_pdf(pdf_path, rules, file_entry, clean_dir, blocked_dir)
        results.append(result)
        status = "BLOCKED" if result.blocked else "ok"
        print(f"       → {status} ({sum(1 for e in result.entries if e.status == 'applied')}/{len(result.entries)} applied)")

    write_audit(results, mapping, audit_path, run_id)

    blocked_n = sum(1 for r in results if r.blocked)
    clean_n = len(results) - blocked_n
    print()
    print(f"FERTIG. {clean_n} sauber, {blocked_n} blockiert.")
    print(f"Audit:   {audit_path}")
    print(f"Staging: {staging_root}")
    return 0 if blocked_n == 0 else 3  # exit code 3 = blockierte Dateien vorhanden


if __name__ == "__main__":
    sys.exit(main())

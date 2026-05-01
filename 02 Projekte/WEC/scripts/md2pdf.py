#!/usr/bin/env python3
"""md2pdf — Markdown -> PDF via weasyprint. Keine System-Abhaengigkeiten."""
from pathlib import Path
import markdown, re, sys
from weasyprint import HTML, CSS

CSS_DEFAULT = """
  @page { size: A4; margin: 2cm; @bottom-right { content: counter(page) " / " counter(pages); font-size: 8pt; color: #888; }}
  body { font-family: Helvetica, Arial, sans-serif; font-size: 10pt; color: #222; line-height: 1.4; }
  h1 { font-size: 18pt; border-bottom: 1pt solid #888; padding-bottom: 4pt; margin-top: 0; }
  h2 { font-size: 13pt; margin-top: 1.2em; color: #333; }
  h3 { font-size: 11pt; margin-top: 1em; color: #444; }
  table { border-collapse: collapse; width: 100%; margin: 0.6em 0; font-size: 9pt; }
  th, td { border: 0.5pt solid #888; padding: 4pt 6pt; text-align: left; vertical-align: top; }
  th { background: #eee; font-weight: bold; }
  code { background: #f2f2f2; padding: 1pt 3pt; border-radius: 2pt; font-size: 9pt; font-family: Menlo, monospace; }
  pre { background: #f7f7f7; padding: 8pt; border-radius: 3pt; overflow: auto; }
  pre code { background: transparent; }
  ul, ol { margin: 0.4em 0 0.4em 1.2em; }
  blockquote { border-left: 2pt solid #aaa; margin: 0.5em 0; padding: 0 0 0 1em; color: #555; }
  a { color: #0645ad; text-decoration: none; }
"""

def convert(src_path: Path, dst_path: Path):
    text = src_path.read_text(encoding="utf-8")
    text = re.sub(r"^---\n.*?\n---\n", "", text, count=1, flags=re.DOTALL)
    text = re.sub(r"\[\[([^\]|]+)\|([^\]]+)\]\]", r"\2", text)
    text = re.sub(r"\[\[([^\]]+)\]\]", r"\1", text)

    html_body = markdown.markdown(text, extensions=["tables", "fenced_code", "sane_lists"])
    full = f'<!DOCTYPE html><html><head><meta charset="utf-8"><title>{src_path.stem}</title></head><body>{html_body}</body></html>'
    HTML(string=full).write_pdf(str(dst_path), stylesheets=[CSS(string=CSS_DEFAULT)])

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: md2pdf.py <input.md> <output.pdf>"); sys.exit(2)
    src, dst = Path(sys.argv[1]).expanduser(), Path(sys.argv[2]).expanduser()
    if not src.is_file(): print(f"FEHLER: {src} nicht gefunden"); sys.exit(1)
    dst.parent.mkdir(parents=True, exist_ok=True)
    convert(src, dst)
    print(f"OK: {dst}  ({dst.stat().st_size} bytes)")

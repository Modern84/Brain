#!/usr/bin/env python3
"""v4-Patcher — Info-Block Vektor-Overlay fuer Fusion-PDFs.

Format-aware: Block wird immer mit konstantem Abstand zum rechten und
unteren Blattrand gesetzt, funktioniert so fuer A3-quer (1191x842),
A2-quer (1684x1191) und alle anderen Fusion-Ausgabeformate mit
Schriftfeld unten rechts.
"""
from __future__ import annotations
import io, sys
from pathlib import Path
import pikepdf
from reportlab.lib.colors import black, white
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.pdfgen import canvas

# Block-Geometrie relativ zum rechten unteren Blattrand
# (abgeleitet aus der historischen A3-Position 722-1128 x 162-202)
BLOCK_WIDTH = 406       # pt
BLOCK_HEIGHT = 40       # pt
RIGHT_MARGIN = 63       # pt vom rechten Blattrand bis Block-rechts
BOTTOM_MARGIN = 162     # pt vom unteren Blattrand bis Block-unten

FONT_NAME, FONT_SIZE, LINE_HEIGHT, PADDING = "InfoBlockSans", 7.5, 9.5, 2
LINES = [
    "Allgemein-Oberfläche: Ra \u2264 0,8 \u00b5m (Rz 6,3) nach DIN ISO 1302",
    "Toleranz ISO 2768-m  |  Kanten gebrochen, Radien R \u2265 6 mm (EHEDG)",
    "Werkstoff: Edelstahl 1.4404 / AISI 316L",
]
FONT_CANDIDATES = [
    "/System/Library/Fonts/Supplemental/Arial.ttf",
    "/Library/Fonts/Arial.ttf",
    "/usr/share/fonts/truetype/liberation/LiberationSans-Regular.ttf",
    "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf",
]

def register_font():
    for p in FONT_CANDIDATES:
        if Path(p).is_file():
            try:
                pdfmetrics.registerFont(TTFont(FONT_NAME, p)); return
            except Exception: continue
    raise RuntimeError("Keine TTF-Font gefunden: " + ", ".join(FONT_CANDIDATES))

def build_overlay(w, h):
    # Block-Koordinaten aus Seitengröße und Marginas berechnen
    x1 = w - RIGHT_MARGIN
    x0 = x1 - BLOCK_WIDTH
    y0 = BOTTOM_MARGIN
    y1 = y0 + BLOCK_HEIGHT

    buf = io.BytesIO()
    c = canvas.Canvas(buf, pagesize=(w, h))
    c.setFillColor(white); c.setStrokeColor(black); c.setLineWidth(0.5)
    c.rect(x0, y0, x1-x0, y1-y0, fill=1, stroke=1)
    c.setFillColor(black); c.setFont(FONT_NAME, FONT_SIZE)
    inner_x = x0 + PADDING
    top_y = y1 - PADDING - 7
    for i, line in enumerate(LINES):
        c.drawString(inner_x, top_y - i*LINE_HEIGHT, line)
    c.save(); return buf.getvalue(), (x0, y0, x1, y1)

def patch_pdf(src, dst):
    pdf = pikepdf.open(src)
    page = pdf.pages[0]
    mb = page.mediabox
    w = float(mb[2]) - float(mb[0]); h = float(mb[3]) - float(mb[1])
    overlay_bytes, (x0, y0, x1, y1) = build_overlay(w, h)
    overlay = pikepdf.open(io.BytesIO(overlay_bytes))
    page.add_overlay(overlay.pages[0])
    dst.parent.mkdir(parents=True, exist_ok=True)
    pdf.save(dst); pdf.close(); overlay.close()
    return f"{w:.0f}x{h:.0f}pt  Block@({x0:.0f},{y0:.0f})-({x1:.0f},{y1:.0f})"

def main(argv):
    if len(argv) != 3:
        print(__doc__); return 2
    in_dir = Path(argv[1]).expanduser().resolve()
    out_dir = Path(argv[2]).expanduser().resolve()
    if not in_dir.is_dir(): print(f"FEHLER: {in_dir}"); return 1
    pdfs = sorted(p for p in in_dir.glob("*.pdf") if not p.name.startswith("."))
    if not pdfs: print(f"FEHLER: keine PDFs in {in_dir}"); return 1
    register_font()
    print(f"v4-Patcher: {len(pdfs)} PDFs -> {out_dir}")
    ok = 0
    for src in pdfs:
        dst = out_dir / f"{src.stem}_v4.pdf"
        try:
            size = patch_pdf(src, dst)
            print(f"  OK  {src.name:50s}  {size}")
            ok += 1
        except Exception as e:
            print(f"  FAIL  {src.name}: {type(e).__name__}: {e}")
    print(f"Fertig: {ok}/{len(pdfs)}")
    return 0 if ok == len(pdfs) else 1

if __name__ == "__main__":
    sys.exit(main(sys.argv))

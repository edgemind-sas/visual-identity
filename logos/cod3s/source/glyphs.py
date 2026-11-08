"""Outline the COD3S wordmark runs from the EdgeMind Open Sans fonts (shaped with HarfBuzz, kerning included)."""
import json, sys, pathlib
import uharfbuzz as hb
from fontTools.ttLib import TTFont
from fontTools.pens.svgPathPen import SVGPathPen
from fontTools.pens.transformPen import TransformPen
from fontTools.pens.boundsPen import BoundsPen

FONTS = pathlib.Path.home() / "Work/EdgeMind/Visual_identity/font_opensans"
SIZE = 100.0  # em size of the output paths


def run(font_file, text, letter_spacing=0.0):
    path = FONTS / font_file
    blob = hb.Blob.from_file_path(str(path))
    face = hb.Face(blob)
    font = hb.Font(face)
    buf = hb.Buffer()
    buf.add_str(text)
    buf.guess_segment_properties()
    hb.shape(font, buf, {"kern": True, "liga": True})
    tt = TTFont(str(path))
    gs, order = tt.getGlyphSet(), tt.getGlyphOrder()
    scale = SIZE / tt["head"].unitsPerEm
    pen = SVGPathPen(gs)
    box = BoundsPen(gs)
    x = 0
    for info, pos in zip(buf.glyph_infos, buf.glyph_positions):
        name = order[info.codepoint]
        # Flip y (font units are y-up), scale to SIZE, place at the pen position.
        m = (scale, 0, 0, -scale, (x + pos.x_offset) * scale, -pos.y_offset * scale)
        gs[name].draw(TransformPen(pen, m))
        gs[name].draw(TransformPen(box, m))
        x += pos.x_advance + letter_spacing / scale
    # Bounds of the outlines in output units (y down), for the viewBox of the title files.
    return {"d": pen.getCommands(), "adv": round(x * scale, 3), "bbox": [round(v, 3) for v in box.bounds]}


out = {
    "cod": run("OpenSans-Bold.ttf", "COD"),
    "s3": run("OpenSans-Light.ttf", "3S"),
    # Signature: "by" then the EdgeMind wordmark, "Edge" bold and "Mind" light as in its logo.
    "by": run("OpenSans-Regular.ttf", "by "),
    "edge": run("OpenSans-Bold.ttf", "Edge"),
    "mind": run("OpenSans-Light.ttf", "Mind"),
}
json.dump(out, open(sys.argv[1], "w"))
print({k: v["adv"] for k, v in out.items()})

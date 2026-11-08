"""Build cod3s_planche.png, the overview sheet of the kit, from the PNG exports."""
import pathlib
from PIL import Image, ImageDraw, ImageFont

ROOT = pathlib.Path(__file__).resolve().parent.parent
FONT = ROOT.parent.parent / "font_opensans/OpenSans-Regular.ttf"
font = ImageFont.truetype(str(FONT), 22)
sheet = Image.new("RGB", (1800, 1240), "#F3F5F9")
draw = ImageDraw.Draw(sheet)


def tile(x, y, w, h, bg, label, dark=False):
    draw.rounded_rectangle((x, y, x + w, y + h), 18, fill=bg)
    draw.text((x + 20, y + h - 40), label, font=font, fill="#9AA6B6" if dark else "#5F6B7A")


def put(name, x, y, w=None):
    im = Image.open(ROOT / "png" / name).convert("RGBA")
    if w:
        im = im.resize((w, int(im.height * w / im.width)), Image.LANCZOS)
    sheet.paste(im, (x, y), im)


tile(40, 40, 840, 330, "#FFFFFF", "Horizontal, fond clair"); put("cod3s_horizontal_light_1200.png", 80, 70, 760)
tile(920, 40, 840, 330, "#0F141A", "Horizontal, fond sombre", True); put("cod3s_horizontal_dark_1200.png", 960, 70, 760)
tile(40, 410, 400, 420, "#FFFFFF", "Vertical"); put("cod3s_vertical_light_800.png", 100, 430, 280)
tile(480, 410, 400, 420, "#0F141A", "Vertical, sombre", True); put("cod3s_vertical_dark_800.png", 540, 430, 280)
tile(920, 410, 400, 420, "#FFFFFF", "Noir"); put("cod3s_horizontal_mono_black_1200.png", 945, 540, 350)
tile(1360, 410, 400, 420, "#1F416D", "Blanc", True); put("cod3s_horizontal_mono_white_1200.png", 1385, 540, 350)
tile(40, 870, 560, 330, "#FFFFFF", "Titres plateforme, clair")
put("cod3s_wordmark_light_1000.png", 70, 910, 280); put("cod3s_name_light_1000.png", 385, 925, 190)
tile(640, 870, 560, 330, "#1A2230", "Titres plateforme, sombre", True)
put("cod3s_wordmark_dark_1000.png", 670, 910, 280); put("cod3s_name_dark_1000.png", 985, 925, 190)
tile(1240, 870, 520, 330, "#FFFFFF", "Favicon 180, 48, 32, 16 px et avatar")
put("cod3s_favicon_180.png", 1270, 900); put("cod3s_favicon_48.png", 1470, 960)
put("cod3s_favicon_32.png", 1540, 968); put("cod3s_favicon_16.png", 1590, 976)
put("cod3s_avatar_dark_400.png", 1640, 900, 100)
sheet.save(ROOT / "cod3s_planche.png")

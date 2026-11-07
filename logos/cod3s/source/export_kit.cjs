// Export the COD3S logo kit from the reference draw (seed 7).
const fs = require("fs"), path = require("path"), L = require("./logo.js");
const GL = JSON.parse(fs.readFileSync(path.join(__dirname, "glyphs.json"), "utf8"));
const REF = 7, OUT = path.resolve(__dirname, "..");
["svg", "png"].forEach((d) => fs.mkdirSync(path.join(OUT, d), { recursive: true }));

const PAL = {
  light: L.PAL.light,
  dark: L.PAL.dark,
  mono_black: { blue: "#000000", mid: "#7F7F7F", orange: "#000000", osoft: "#000000", exch: "#000000", word: "#000000", sign: "#000000" },
  mono_white: { blue: "#FFFFFF", mid: "#B3B3B3", orange: "#FFFFFF", osoft: "#FFFFFF", exch: "#FFFFFF", word: "#FFFFFF", sign: "#FFFFFF" },
};
const symbol = (p) => L.symC2(p, REF);
const WM_W = GL.cod.adv + GL.s3.adv; // wordmark width at em 100

// Outlined wordmark: baseline origin at (x, y), cap size `size` (same metric as font-size).
function wordmark(p, x, y, size, sign = true) {
  const k = size / 100;
  let g = `<g id="wordmark" transform="translate(${x},${y}) scale(${k})">` +
    `<path id="COD" fill="${p.word}" d="${GL.cod.d}"/>` +
    `<path id="3S" fill="${p.orange}" transform="translate(${GL.cod.adv},0)" d="${GL.s3.d}"/>`;
  if (sign) { const ks = 0.24; g += `<path id="by-edgemind" fill="${p.sign}" transform="translate(${WM_W - GL.sign.adv * ks},42) scale(${ks})" d="${GL.sign.d}"/>`; }
  return g + "</g>";
}
// Live-text wordmark, for the editable source file only.
function wordmarkText(p, x, y, size) {
  return `<g id="wordmark"><text x="${x}" y="${y}" font-family="'Open Sans', sans-serif" font-size="${size}">` +
    `<tspan font-weight="700" fill="${p.word}">COD</tspan><tspan font-weight="300" fill="${p.orange}">3S</tspan></text>` +
    `<text x="${x + WM_W * size / 100}" y="${y + size * 0.42}" text-anchor="end" font-family="'Open Sans', sans-serif" ` +
    `font-size="${size * 0.24}" letter-spacing="0.5" fill="${p.sign}">by EdgeMind</text></g>`;
}
const svg = (w, h, body, title) => `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${w} ${h}" width="${w * 2}" height="${h * 2}">` +
  `<title>${title}</title>${body}</svg>\n`;
const write = (name, s) => fs.writeFileSync(path.join(OUT, "svg", name), s);

const HZ_W = 90 + WM_W * 0.56 + 6;
for (const [m, p] of Object.entries(PAL)) {
  write(`cod3s_symbol_${m}.svg`, svg(100, 100, `<g id="symbol">${symbol(p)}</g>`, "COD3S"));
  write(`cod3s_horizontal_${m}.svg`, svg(HZ_W, 100, `<g id="symbol">${symbol(p)}</g>${wordmark(p, 90, 66, 56)}`, "COD3S by EdgeMind"));
  const sw = WM_W * 0.5, st = Math.max(100, sw) + 10;
  write(`cod3s_vertical_${m}.svg`, svg(st, 160, `<g id="symbol" transform="translate(${(st - 100) / 2},0)">${symbol(p)}</g>` +
    wordmark(p, (st - sw) / 2, 138, 50), "COD3S by EdgeMind"));
}
write("cod3s_horizontal_light_source.svg", svg(HZ_W, 100, `<g id="symbol">${symbol(PAL.light)}</g>${wordmarkText(PAL.light, 90, 66, 56)}`, "COD3S by EdgeMind (texte modifiable)"));

// Favicon: the cloud turns into a smudge under 32 px, so the twin is drawn as big dots on its edges.
const G = L.G, poly = (a) => a.map((k) => G[k].join(",")).join(" ");
function favicon(p, extraStyle = "") {
  const dots = `fill="none" stroke="${p.orange}" stroke-width="7" stroke-linecap="round" stroke-dasharray="0.01 11.4"`;
  return `<g transform="translate(50,50) scale(1.22) translate(-50,-50)">${L.realHalf(p)}` +
    `<polyline class="twin" points="${poly(["top", "ur", "lr", "bot"])}" ${dots}/><polyline class="twin" points="${poly(["ur", "ctr"])}" ${dots}/></g>${extraStyle}`;
}
// One file for both browser themes: the real half lightens when the tab bar is dark.
const favStyle = `<style>@media (prefers-color-scheme: dark){#real polygon:first-child{fill:#5B9BD5}#real polygon:last-child{fill:#8FB3DC}}</style>`;
write("cod3s_favicon.svg", svg(100, 100, favicon(PAL.light, favStyle), "COD3S"));
write("cod3s_favicon_light.svg", svg(100, 100, favicon(PAL.light), "COD3S"));
write("cod3s_favicon_dark.svg", svg(100, 100, favicon(PAL.dark), "COD3S"));

// Avatars (LinkedIn and co.): symbol kept inside the circle crop.
for (const [m, bg] of [["light", "#FFFFFF"], ["dark", "#0F141A"]])
  write(`cod3s_avatar_${m}.svg`, svg(100, 100, `<rect width="100" height="100" fill="${bg}"/><g transform="translate(50,50) scale(0.72) translate(-50,-50)">${symbol(PAL[m])}</g>`, "COD3S"));

fs.writeFileSync(path.join(__dirname, "manifest.json"), JSON.stringify({ reference_seed: REF, generator: "logo.js (symC2)", hz_width: HZ_W }, null, 2));
console.log(fs.readdirSync(path.join(OUT, "svg")).join("\n"));

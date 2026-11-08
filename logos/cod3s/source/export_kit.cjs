// Export the COD3S logo kit: the cube with its wireframe twin (symD, adopted 2026-11-08).
const fs = require("fs"), path = require("path"), L = require("./logo.js");
const GL = JSON.parse(fs.readFileSync(path.join(__dirname, "glyphs.json"), "utf8"));
const OUT = path.resolve(__dirname, "..");
["svg", "png"].forEach((d) => fs.mkdirSync(path.join(OUT, d), { recursive: true }));

const PAL = {
  light: L.PAL.light,
  dark: L.PAL.dark,
  mono_black: { blue: "#000000", mid: "#7F7F7F", orange: "#000000", osoft: "#000000", exch: "#000000", word: "#000000", sign: "#000000", pulse: "#7F7F7F" },
  mono_white: { blue: "#FFFFFF", mid: "#B3B3B3", orange: "#FFFFFF", osoft: "#FFFFFF", exch: "#FFFFFF", word: "#FFFFFF", sign: "#FFFFFF", pulse: "#B3B3B3" },
};
const symbol = (p) => L.symD(p);
const WM_W = GL.cod.adv + GL.s3.adv; // wordmark width at em 100

// Outlined wordmark: baseline origin at (x, y), cap size `size` (same metric as font-size).
function wordmark(p, x, y, size, sign = true) {
  const k = size / 100;
  let g = `<g id="wordmark" transform="translate(${x},${y}) scale(${k})">` +
    `<path id="COD" fill="${p.word}" d="${GL.cod.d}"/>` +
    `<path id="3S" fill="${p.orange}" transform="translate(${GL.cod.adv},0)" d="${GL.s3.d}"/>`;
  if (sign) g += signature(p);
  return g + "</g>";
}
// "by" then the EdgeMind wordmark ("Edge" bold, "Mind" light), right-aligned under "3S".
const KS = 0.24, SIGN_W = GL.by.adv + GL.edge.adv + GL.mind.adv;
function signature(p) {
  const x0 = WM_W - SIGN_W * KS;
  return `<g id="by-edgemind" transform="translate(${x0},42) scale(${KS})">` +
    `<path id="by" fill="${p.sign}" d="${GL.by.d}"/>` +
    `<path id="Edge" fill="${p.word}" transform="translate(${GL.by.adv},0)" d="${GL.edge.d}"/>` +
    `<path id="Mind" fill="${p.orange}" transform="translate(${GL.by.adv + GL.edge.adv},0)" d="${GL.mind.d}"/></g>`;
}
// Live-text wordmark, for the editable source file only.
function wordmarkText(p, x, y, size) {
  return `<g id="wordmark"><text x="${x}" y="${y}" font-family="'Open Sans', sans-serif" font-size="${size}">` +
    `<tspan font-weight="700" fill="${p.word}">COD</tspan><tspan font-weight="300" fill="${p.orange}">3S</tspan></text>` +
    `<text x="${x + WM_W * size / 100}" y="${y + size * 0.42}" text-anchor="end" font-family="'Open Sans', sans-serif" ` +
    `font-size="${size * 0.24}"><tspan font-weight="400" fill="${p.sign}">by </tspan><tspan font-weight="700" fill="${p.word}">Edge</tspan>` +
    `<tspan font-weight="300" fill="${p.orange}">Mind</tspan></text></g>`;
}
const svg = (w, h, body, title) => `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${w} ${h}" width="${w * 2}" height="${h * 2}">` +
  `<title>${title}</title>${body}</svg>\n`;
const write = (name, s) => fs.writeFileSync(path.join(OUT, "svg", name), s);

const HZ_W = 90 + WM_W * 0.56 + 6;
for (const [m, p] of Object.entries(PAL)) {
  write(`cod3s_symbol_${m}.svg`, svg(100, 100, `<g id="symbol">${symbol(p)}</g>`, "COD3S"));
  write(`cod3s_horizontal_${m}.svg`, svg(HZ_W, 100, `<g id="symbol">${symbol(p)}</g>${wordmark(p, 90, 66, 56)}`, "COD3S by EdgeMind"));
  const sw = WM_W * 0.5, st = Math.max(100, sw) + 10;
  write(`cod3s_vertical_${m}.svg`, svg(st, 172, `<g id="symbol" transform="translate(${(st - 100) / 2},0)">${symbol(p)}</g>` +
    wordmark(p, (st - sw) / 2, 138, 50), "COD3S by EdgeMind"));
}
write("cod3s_horizontal_light_source.svg", svg(HZ_W, 100, `<g id="symbol">${symbol(PAL.light)}</g>${wordmarkText(PAL.light, 90, 66, 56)}`, "COD3S by EdgeMind (texte modifiable)"));

// Favicon: the wireframe twin with thick edges, readable at 16 px.
function favicon(p, extraStyle = "") {
  return `<g transform="translate(50,50) scale(1.22) translate(-50,-50)">${L.realHalf(p)}<g id="twin">` +
    L.twinFrame(5.5).map((q) => `<polygon points="${q.map(([x, y]) => `${x.toFixed(2)},${y.toFixed(2)}`).join(" ")}" fill="${p.orange}"/>`).join("") +
    `</g></g>${extraStyle}`;
}
// One file for both browser themes: the real half lightens when the tab bar is dark.
const favStyle = `<style>@media (prefers-color-scheme: dark){#real polygon:first-child{fill:#5B9BD5}#real polygon:last-child{fill:#8FB3DC}}</style>`;
write("cod3s_favicon.svg", svg(100, 100, favicon(PAL.light, favStyle), "COD3S"));
write("cod3s_favicon_light.svg", svg(100, 100, favicon(PAL.light), "COD3S"));
write("cod3s_favicon_dark.svg", svg(100, 100, favicon(PAL.dark), "COD3S"));

// Avatars (LinkedIn and co.): symbol kept inside the circle crop.
for (const [m, bg] of [["light", "#FFFFFF"], ["dark", "#0F141A"]])
  write(`cod3s_avatar_${m}.svg`, svg(100, 100, `<rect width="100" height="100" fill="${bg}"/><g transform="translate(50,50) scale(0.72) translate(-50,-50)">${symbol(PAL[m])}</g>`, "COD3S"));

// Titles without the symbol, for the platform screens: wordmark with its signature
// (login card, application header) and the bare name (home page). Bounds measured on the outlines.
// Each run carries its outline bounds (glyphs.py): place them and take the union.
function bounds(runs) {
  return runs.reduce(([x0, y0, x1, y1], [g, tx, ty, k]) => [Math.min(x0, tx + g.bbox[0] * k), Math.min(y0, ty + g.bbox[1] * k),
    Math.max(x1, tx + g.bbox[2] * k), Math.max(y1, ty + g.bbox[3] * k)], [Infinity, Infinity, -Infinity, -Infinity]);
}
const signX = WM_W - SIGN_W * KS;
const NAME_PATHS = [[GL.cod, 0, 0, 1], [GL.s3, GL.cod.adv, 0, 1]];
const SIGN_PATHS = [[GL.by, signX, 42, KS], [GL.edge, signX + GL.by.adv * KS, 42, KS], [GL.mind, signX + (GL.by.adv + GL.edge.adv) * KS, 42, KS]];
function titleFile(p, withSign) {
  const [x0, y0, x1, y1] = bounds(withSign ? [...NAME_PATHS, ...SIGN_PATHS] : NAME_PATHS);
  const pad = 2, w = x1 - x0 + 2 * pad, h = y1 - y0 + 2 * pad;
  const title = withSign ? "COD3S by EdgeMind" : "COD3S";
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="${(x0 - pad).toFixed(2)} ${(y0 - pad).toFixed(2)} ${w.toFixed(2)} ${h.toFixed(2)}" ` +
    `width="${(w * 2).toFixed(0)}" height="${(h * 2).toFixed(0)}"><title>${title}</title>${wordmark(p, 0, 0, 100, withSign)}</svg>\n`;
}
for (const m of Object.keys(PAL)) {
  write(`cod3s_wordmark_${m}.svg`, titleFile(PAL[m], true));
  write(`cod3s_name_${m}.svg`, titleFile(PAL[m], false));
}

fs.writeFileSync(path.join(__dirname, "manifest.json"), JSON.stringify({ generator: "logo.js (symD)", edge_width: 1.2, hz_width: HZ_W }, null, 2));
console.log(fs.readdirSync(path.join(OUT, "svg")).join("\n"));

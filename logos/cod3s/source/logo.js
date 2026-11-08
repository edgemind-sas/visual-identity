// COD3S logo generator: shared by the node exporter and the browser demo.
const PAL = {
  light: { blue: "#1F416D", mid: "#4F7DB5", orange: "#EF7B26", osoft: "#F5A76A", exch: "#4F7DB5", word: "#1F416D", sign: "#4F7DB5", pulse: "#132A47" },
  dark: { blue: "#5B9BD5", mid: "#8FB3DC", orange: "#EF7B26", osoft: "#F5A76A", exch: "#8FB3DC", word: "#5B9BD5", sign: "#8FB3DC", pulse: "#1F416D" },
};
const FONT = "'Open Sans', sans-serif";

function rng(seed) {
  let a = seed >>> 0;
  return () => { a = (a + 0x6d2b79f5) | 0; let t = Math.imul(a ^ (a >>> 15), 1 | a);
    t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t; return ((t ^ (t >>> 14)) >>> 0) / 4294967296; };
}
function gauss(r) { let u = 0; while (!u) u = r(); return Math.sqrt(-2 * Math.log(u)) * Math.cos(2 * Math.PI * r()); }
function geom(cx = 50, cy = 50, s = 34) {
  const k = 0.866 * s;
  return { top: [cx, cy - s], ul: [cx - k, cy - s / 2], ur: [cx + k, cy - s / 2], ctr: [cx, cy],
           ll: [cx - k, cy + s / 2], lr: [cx + k, cy + s / 2], bot: [cx, cy + s] };
}
const G = geom();
const poly = (pts) => pts.map(([x, y]) => `${x.toFixed(2)},${y.toFixed(2)}`).join(" ");
const DIGITAL_EDGES = [["top", "ur"], ["ur", "lr"], ["lr", "bot"], ["ur", "ctr"]];
const SEAM = [["top", "ctr"], ["ctr", "bot"]];

function realHalf(p) {
  return `<g id="real"><polygon points="${poly([G.ul, G.ctr, G.bot, G.ll])}" fill="${p.blue}"/>` +
         `<polygon points="${poly([G.top, G.ctr, G.ul])}" fill="${p.mid}"/></g>`;
}

// Particles of the digital twin: dense on edges, sparse on faces, blue sprinkles = exchanges.
function cloud(seed) {
  const r = rng(seed), out = [];
  const onEdge = (a, b, n, jit, pBlue, kind) => {
    const [x0, y0] = G[a], [x1, y1] = G[b], L = Math.hypot(x1 - x0, y1 - y0), nx = -(y1 - y0) / L, ny = (x1 - x0) / L;
    for (let i = 0; i < n; i++) {
      const t = r(), j = gauss(r) * jit;
      out.push({ x: x0 + (x1 - x0) * t + nx * j, y: y0 + (y1 - y0) * t + ny * j, rad: 0.3 + Math.pow(r(), 3) * 1.25,
                 op: 0.8 + r() * 0.2, col: r() < pBlue ? "exch" : (r() < 0.75 ? "orange" : "osoft"), kind });
    }
  };
  DIGITAL_EDGES.forEach(([a, b]) => onEdge(a, b, 85, 0.55, 0.12, "edge"));
  SEAM.forEach(([a, b]) => onEdge(a, b, 40, 0.45, 0.6, "seam"));
  const inTri = (A, B, C, n) => { for (let i = 0; i < n; i++) { let u = r(), v = r(); if (u + v > 1) { u = 1 - u; v = 1 - v; }
      out.push({ x: A[0] + (B[0] - A[0]) * u + (C[0] - A[0]) * v, y: A[1] + (B[1] - A[1]) * u + (C[1] - A[1]) * v,
                 rad: 0.2 + Math.pow(r(), 2) * 0.45, op: 0.35 + r() * 0.45, col: r() < 0.06 ? "exch" : "osoft", kind: "face" }); } };
  inTri(G.top, G.ur, G.ctr, 60);
  inTri(G.ctr, G.ur, G.lr, 60); inTri(G.ctr, G.lr, G.bot, 60);
  ["top", "ur", "lr", "bot"].forEach((k) => out.push({ x: G[k][0], y: G[k][1], rad: 1.7, op: 1, col: "orange", kind: "node" }));
  // Origin of each particle, inside the real half (used by the animation).
  out.forEach((q) => { let u = r(), v = r(); if (u + v > 1) { u = 1 - u; v = 1 - v; }
    const [A, B, C] = r() < 0.6 ? [G.ll, G.ctr, G.bot] : [G.ul, G.ctr, G.ll];
    q.ox = A[0] + (B[0] - A[0]) * u + (C[0] - A[0]) * v; q.oy = A[1] + (B[1] - A[1]) * u + (C[1] - A[1]) * v; });
  return out;
}

function symC1(p) { // dotted wireframe
  const d = `stroke="${p.orange}" stroke-width="2.6" stroke-linecap="round" stroke-dasharray="0.01 4.1" fill="none"`;
  return realHalf(p) + `<g id="twin"><polyline points="${poly([G.top, G.ur, G.lr, G.bot])}" ${d}/>` +
    `<polyline points="${poly([G.ur, G.ctr])}" ${d}/>` +
    ["top", "ur", "lr", "bot"].map((k) => `<circle cx="${G[k][0]}" cy="${G[k][1]}" r="2.1" fill="${p.orange}"/>`).join("") + "</g>";
}
function symC2(p, seed = 7) { // stochastic point cloud
  return realHalf(p) + `<g id="twin">` + cloud(seed).map((q) =>
    `<circle cx="${q.x.toFixed(2)}" cy="${q.y.toFixed(2)}" r="${q.rad.toFixed(2)}" fill="${p[q.col]}" opacity="${q.op.toFixed(2)}"/>`).join("") + "</g>";
}
function symC3(p, seed = 11) { // pixel mosaic on an isometric grid
  const r = rng(seed), cells = [], N = 6, ins = 0.14;
  const cell = (O, U, V, i, j) => { const P = (a, b) => [O[0] + U[0] * a + V[0] * b, O[1] + U[1] * a + V[1] * b];
    const a0 = (i + ins) / N, a1 = (i + 1 - ins) / N, b0 = (j + ins) / N, b1 = (j + 1 - ins) / N;
    return [P(a0, b0), P(a1, b0), P(a1, b1), P(a0, b1)]; };
  const sub = (A, B) => [A[0] - B[0], A[1] - B[1]];
  const pick = () => (r() < 0.08 ? p.exch : r() < 0.7 ? p.orange : p.osoft);
  for (let i = 0; i < N; i++) for (let j = 0; j < N; j++) if (r() < 0.86)  // right face
    cells.push(`<polygon points="${poly(cell(G.ctr, sub(G.ur, G.ctr), sub(G.bot, G.ctr), i, j))}" fill="${pick()}"/>`);
  for (let i = 0; i < N; i++) for (let j = 0; j < N; j++) if (j < i && r() < 0.86) // right half of top face
    cells.push(`<polygon points="${poly(cell(G.ctr, sub(G.ur, G.ctr), sub(G.ul, G.ctr), i, j))}" fill="${pick()}"/>`);
  return realHalf(p) + `<g id="twin">${cells.join("")}</g>`;
}
// Wireframe twin (adopted 2026-11-08): solid orange edges drawn inside the right half,
// so their outer border continues the blue half exactly. Five convex polygons: the four
// sides of the right half's outline (seam included) and the diagonal ur-ctr.
function twinFrame(W = 1.2) {
  const outer = [G.top, G.ur, G.lr, G.bot];
  const line = (a, b, d) => { const L = Math.hypot(b[0] - a[0], b[1] - a[1]); const n = [-(b[1] - a[1]) / L, (b[0] - a[0]) / L];
    return [[a[0] + n[0] * d, a[1] + n[1] * d], [b[0] + n[0] * d, b[1] + n[1] * d]]; };
  const cross = ([p1, p2], [p3, p4]) => { const d = (p1[0] - p2[0]) * (p3[1] - p4[1]) - (p1[1] - p2[1]) * (p3[0] - p4[0]);
    const a = p1[0] * p2[1] - p1[1] * p2[0], b = p3[0] * p4[1] - p3[1] * p4[0];
    return [(a * (p3[0] - p4[0]) - (p1[0] - p2[0]) * b) / d, (a * (p3[1] - p4[1]) - (p1[1] - p2[1]) * b) / d]; };
  const inner = outer.map((p, i) => line(p, outer[(i + 1) % 4], W)); // clockwise on screen: the normal points inside
  const I = outer.map((_, i) => cross(inner[(i + 3) % 4], inner[i]));
  const sides = outer.map((p, i) => [p, outer[(i + 1) % 4], I[(i + 1) % 4], I[i]]);
  const up = line(G.ur, G.ctr, W / 2), down = line(G.ur, G.ctr, -W / 2);
  const diagonal = [cross(up, inner[0]), I[1], cross(down, inner[1]), cross(down, inner[3]), cross(up, inner[3])];
  return [...sides, diagonal];
}
function symD(p, W = 1.2) {
  return realHalf(p) + `<g id="twin" data-pulse-color="${p.pulse}">` +
    twinFrame(W).map((q) => `<polygon points="${poly(q)}" fill="${p.orange}"/>`).join("") + "</g>";
}
// Option B kept as reference (interlocked twin rings).
function tapered(cx, cy, R, a0, a1, w, fill, n = 72) {
  const o = [], i = [];
  for (let s = 0; s <= n; s++) { const t = s / n, a = (a0 + (a1 - a0) * t) * Math.PI / 180, ww = w * Math.sin(Math.PI * t);
    o.push([cx + R * Math.cos(a), cy + R * Math.sin(a)]); i.push([cx + (R - ww) * Math.cos(a), cy + (R - ww) * Math.sin(a)]); }
  return `<path d="M${o.concat(i.reverse()).map(([x, y]) => `${x.toFixed(2)},${y.toFixed(2)}`).join(" L")} Z" fill="${fill}"/>`;
}
function symB(p) {
  const R = 25.5, a0 = -50 * Math.PI / 180, a1 = 255 * Math.PI / 180;
  return `<g id="real">${tapered(33, 50, 27, 38, 322, 9, p.orange)}<circle cx="33" cy="50" r="8" fill="${p.blue}"/></g>` +
    `<g id="model"><path d="M${(67 + R * Math.cos(a0)).toFixed(2)},${(50 + R * Math.sin(a0)).toFixed(2)} A${R},${R} 0 1 1 ` +
    `${(67 + R * Math.cos(a1)).toFixed(2)},${(50 + R * Math.sin(a1)).toFixed(2)}" fill="none" stroke="${p.blue}" stroke-width="3.2" stroke-linecap="round"/>` +
    `<circle cx="67" cy="50" r="6.6" fill="none" stroke="${p.orange}" stroke-width="2.8"/></g>`;
}
function wordmark(p, x = 112, y = 66, size = 56, sign = true) {
  let t = `<text x="${x}" y="${y}" font-family="${FONT}" font-size="${size}"><tspan font-weight="700" fill="${p.word}">COD</tspan>` +
          `<tspan font-weight="300" fill="${p.orange}">3S</tspan></text>`;
  if (sign) t += `<text x="${x + size * 3.17}" y="${y + size * 0.42}" text-anchor="end" font-family="${FONT}" font-size="${size * 0.24}" letter-spacing="0.5" fill="${p.sign}">by EdgeMind</text>`;
  return t;
}
const VARIANTS = { B: ["Anneaux jumeaux (référence)", symB], C1: ["Cube, jumeau en pointillés", symC1],
                   C2: ["Cube, jumeau en nuée stochastique", symC2], C3: ["Cube, jumeau en pixels", symC3],
                   D: ["Cube, jumeau en arêtes pleines (retenu)", symD] };
if (typeof module !== "undefined") module.exports = { PAL, FONT, G, rng, cloud, realHalf, symB, symC1, symC2, symC3, symD, twinFrame, wordmark, VARIANTS, DIGITAL_EDGES, SEAM };

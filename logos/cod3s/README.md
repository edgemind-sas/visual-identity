# Logo COD3S

COD3S est une sous-marque d'EdgeMind, signée « by EdgeMind ». Le logo a été arrêté le 07/11/2026.

![Planche des déclinaisons](cod3s_planche.png)

## Symbole

Un cube vu en perspective, coupé en deux dans la hauteur.

- La moitié gauche, pleine et bleue, représente le système réel.
- La moitié droite, une nuée de points orange, représente son jumeau numérique.
- Les points bleus semés sur les arêtes représentent les échanges entre le système et son jumeau.

La nuée est tirée au hasard, en référence au caractère stochastique des simulations COD3S. Le logo officiel est un tirage fixe, le n° 7 : il est identique sur tous les supports.

## Logotype

« COD » en Open Sans Bold, bleu `#1F416D`. « 3S » en Open Sans Light, orange `#EF7B26`. La signature « by EdgeMind » est en Open Sans Regular.

Dans les fichiers à diffuser, le texte est vectorisé. `svg/cod3s_horizontal_light_source.svg` garde le texte modifiable.

## Fichiers

| Usage | Fichier |
|---|---|
| Document, présentation, fond clair | `cod3s_horizontal_light` |
| Fond sombre, instance en thème sombre | `cod3s_horizontal_dark` |
| Composition centrée (couverture, kakémono) | `cod3s_vertical_*` |
| Impression une couleur | `*_mono_black`, `*_mono_white` |
| Symbole seul | `cod3s_symbol_*` |
| Favicon | `svg/cod3s_favicon.svg` (s'adapte au thème du navigateur), `png/cod3s_favicon.ico` |
| Avatar de réseau social (recadrage rond) | `cod3s_avatar_light`, `cod3s_avatar_dark` |

Chaque déclinaison existe en SVG (`svg/`) et en PNG (`png/`).

Le favicon remplace la nuée par de gros points sur les arêtes : en dessous de 32 px, la nuée ne serait plus qu'une tache.

## Affichage animé

Dans l'outil, le logo s'affiche en se construisant. Les points partent du cube bleu et rejoignent leur place, puis des impulsions bleues circulent le long des arêtes. À chaque affichage, les trajectoires, l'ordre d'arrivée et les impulsions changent. La forme finale reste toujours le tirage n° 7.

La page `source/cod3s_twin_demo.html` montre cette animation. Son intégration dans la plateforme reste à faire.

## Régénérer les fichiers

Les sources sont dans `source/` :

- `logo.js` : le générateur, utilisable sous Node comme dans un navigateur ;
- `glyphs.py` : la vectorisation du texte depuis `font_opensans/` ;
- `export_kit.cjs` : l'export de toutes les déclinaisons.

```bash
cd logos/cod3s/source
uv run --with fonttools --with uharfbuzz python glyphs.py glyphs.json
node export_kit.cjs
```

Les PNG se refont avec `rsvg-convert`, par exemple `rsvg-convert -w 512 svg/cod3s_symbol_light.svg -o png/cod3s_symbol_light_512.png`.

La page animée s'assemble à partir de `demo_template.html` :

```bash
node -e 'const fs=require("fs");fs.writeFileSync("cod3s_twin_demo.html",fs.readFileSync("demo_template.html","utf8").replace("/*LOGO_JS*/",fs.readFileSync("logo.js","utf8")))'
```

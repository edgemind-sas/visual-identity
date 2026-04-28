# EdgeMind - Visual Identity Repository

Ce dépôt contient l'ensemble des éléments d'identité visuelle de la société EdgeMind : logos, palette de couleurs, typographie, templates de documents et assets visuels.

## Contenu du Dépôt

### 🎨 Logos
Le dossier `logos/` contient toutes les variantes du logo EdgeMind :
- Logo original (couleur et blanc)
- Versions horizontales
- Symbole seul
- Formats multiples : SVG, PDF, PNG
- Banner LinkedIn

**Fichiers principaux** :
- `logo_edgemind_original.svg` - Logo complet en couleur
- `logo_edgemind_hz.svg` - Version horizontale
- `logo_edgemind_only_white.svg` - Symbole seul (blanc)
- `logos-edgemind-valides.pdf` - Package complet des logos validés

### 🎨 Palette de Couleurs

**Couleurs principales EdgeMind** :
- **EMBlue** `#1f416d` - Bleu foncé (couleur principale)
- **EMOrange** `#ef7b26` - Orange vif (accent)
- **EMGray** `#c9d4e6` - Gris clair (fond)

**Couleurs secondaires** :
- **EMBrown** `#bf8740` - Brun chaud
- **EMRed** `#a10010` - Rouge foncé
- **EMDarkBrown** `#4c000a` - Brun très foncé

Disponibles dans :
- `color_palettes/edgemind_palette.gpl` (GIMP/Inkscape)
- `color_palettes/edgemind_color_palette.py` (Python)

### 📝 Typographie

**Police principale** : OpenSans

Le dossier `font_opensans/` contient la famille complète :
- Light, Regular, Semibold, Bold, ExtraBold
- Versions italiques
- Licence : Apache License 2.0

### 🖼️ Assets Visuels

Le dossier `visual/` contient plus de 50 illustrations organisées par thèmes :

**Catégories** :
- Business & Corporate (équipes, réunions)
- Industrie (panneaux solaires, maintenance)
- Concepts (expertise, innovation, valeurs)
- Data & Technologie (data science, machine learning)
- Valeurs (résilience, sécurité, agilité)

Tous les assets sont disponibles en SVG (vectoriel) et PNG (raster).

### 📄 Templates de Documents

Le dossier `official_docs/` contient des templates professionnels pour :

- **Rapports** (`report/`) : template Typst `edgemind-report.typ` (+ ancienne classe LaTeX `edgemind-report.cls`)
- **Propositions Techniques et Commerciales** (`propal/`) : template Typst `edgemind-propal.typ` avec helpers (lotissement, tâches, livrables, ressources, offre commerciale, échéances, planning…)
- **Présentations** : thème LaTeX Beamer (`beamerthemeEdgeMind/`) + thème Typst Touying (`slides/`)
- **Comptes-rendus** (`minutes/`) : template de réunion
- **Guides utilisateur** (`userguide/`) : templates de documentation
- **Lettres** (`lettre/`) : papier à en-tête
- **Factures** (`invoice/`) : templates ODS, XLSX, PDF
- **Brochure** (`plaquette/`) : plaquette de présentation
- **Cartes de visite** (`vcards/`) : designs recto/verso

### 🎨 Styles et Thèmes

#### CSS pour le Web
`official_docs/css/edgemind.css` - Feuille de style complète avec :
- Variables CSS pour les couleurs de marque
- Règles typographiques
- Style des tableaux et listes
- Style des blocs de code

#### Coloration Syntaxique
`official_docs/pygments/edgemind.py` - Style Pygments pour la coloration de code :
- Fond gris clair EdgeMind
- Mots-clés en bleu
- Classes en orange
- Adapté à la documentation technique

#### Thème Beamer LaTeX
`official_docs/beamerthemeEdgeMind/` - Thème complet pour présentations LaTeX

## Guide d'Utilisation Rapide

### Utiliser les Logos

1. **Web/Écran** : Utiliser les fichiers SVG ou PNG
2. **Impression** : Utiliser les fichiers PDF
3. **Fond blanc** : `logo_edgemind_original.svg`
4. **Fond foncé** : `logo_edgemind_original_white.svg`

### Utiliser les Couleurs

**En CSS** :
```css
:root {
  --em-blue: #1f416d;
  --em-orange: #ef7b26;
  --em-gray: #c9d4e6;
}
```

**En Python** :
```python
from color_palettes.edgemind_color_palette import edgemind_palette
blue = edgemind_palette['EMBlue']
```

### Utiliser les Templates

1. **Rapports (Typst)** : copier `official_docs/report/example_report.typ` puis `typst compile --root . mon-rapport.typ`
2. **Propals / PTC (Typst)** : copier `official_docs/propal/example_propal.typ` puis `typst compile --root . ma-propal.typ` (voir `propal/README.md`)
3. **Présentations** : thème Beamer avec `\usetheme{EdgeMind}` ou thème Typst Touying dans `official_docs/slides/`
4. **Documents Web** : intégrer `official_docs/css/edgemind.css`

## Documentation Complète

- **EM-visual_identity.pdf** : Guide complet de la charte graphique (Mai 2014)
- **edgemind_visual_identity.org** : Documentation technique et historique du projet
- **official_docs/propal/README.md** : Guide d'utilisation du template propal Typst

## Structure du Dépôt

```
Visual_identity/
├── logos/                       # Logos (SVG, PDF, PNG)
├── color_palettes/              # Palettes de couleurs
├── font_opensans/               # Famille de polices OpenSans
├── visual/                      # Illustrations et icônes
├── official_docs/               # Templates et styles
│   ├── css/                    # Styles web
│   ├── beamerthemeEdgeMind/    # Thème Beamer
│   ├── pygments/               # Coloration code
│   ├── report/                 # Template rapport (Typst + LaTeX)
│   ├── propal/                 # Template propal/PTC (Typst)
│   ├── slides/                 # Template présentation (Typst Touying)
│   ├── plaquette/              # Brochure entreprise
│   └── ...                     # Autres templates
├── EM-visual_identity.pdf      # Charte graphique
└── README.md                   # Ce fichier
```

## Ressources Externes

- Police OpenSans : https://fonts.google.com/specimen/Open+Sans
- Documentation Pygments : https://pygments.org/
- LaTeX Beamer : https://ctan.org/pkg/beamer

## Licence

- **Police OpenSans** : Apache License 2.0
- **Autres assets** : Copyright EdgeMind (voir EM-visual_identity.pdf pour les conditions d'utilisation)

## Contribution

Ce dépôt est maintenu par l'équipe EdgeMind. Pour toute question ou suggestion, veuillez contacter l'équipe de communication.

---

**Dernière mise à jour** : Janvier 2026
**Contributeurs principaux** : Roland Donat, Thomas Friedlhuber

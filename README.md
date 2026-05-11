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

Le dossier `official_docs/` contient des templates professionnels. Pour les documents les plus courants, **Typst** est désormais le format officiel (compilation rapide, syntaxe moderne). Les anciennes classes LaTeX correspondantes sont conservées en *Legacy*. Pour les documents non encore portés, LaTeX reste le format officiel.

#### ✨ Templates Typst (recommandés)

- **Rapports** (`report/`) — `edgemind-report.typ` : page de titre, TOC, bibliographie, figures stylées. Voir `report/example_report.typ` et `report/README.md`.
- **Propositions Techniques et Commerciales** (`propal/`) — `edgemind-propal.typ` : template PTC avec 10 helpers (glossaire, lotissement, tâches, livrables, ressources, offre commerciale synthèse/détaillée, échéances, validité, planning mensuel/hebdomadaire). Voir `propal/README.md` et `propal/example_propal.typ`.
- **Présentations** (`slides/`) — thème Touying `edgemind-theme.typ` : page de titre avec cartouche EdgeMind, slides de section, header/footer aux couleurs de la marque. Voir `slides/main.typ`.

#### 📐 Templates LaTeX (format officiel — pas de portage Typst)

- **Comptes-rendus de réunion** (`minutes/`) — `edgemind-minutes.cls`
- **Notes internes** (`note/`) — `edgemind-note.cls`
- **Guides utilisateur** (`userguide/`, `userguide_with_ref/`) — `edgemind-userguide.cls`, `edgemind-userguide_with_ref.cls`

#### 📦 Legacy LaTeX (remplacés par Typst)

Conservés à titre historique, à ne plus utiliser pour les nouveaux documents :

- **Rapports** : `report/edgemind-report.cls` → préférer `edgemind-report.typ`
- **Présentations Beamer** : `beamerthemeEdgeMind/` → préférer le thème Touying `slides/`
- **Propal LaTeX** : `propal/latex/edgemind-tcp.cls` → préférer `edgemind-propal.typ`

#### 🧾 Autres formats

- **Lettres** (`lettre/`) : papier à en-tête PDF/SVG
- **Factures** (`invoice/`) : ODS, XLSX, PDF
- **Brochure** (`plaquette/`) : sources Illustrator + PDF
- **Cartes de visite** (`vcards/`) : recto/verso PDF
- **Tampons** (`stamp/`) : SVG/PNG/PDF

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

**Typst (recommandé)** :

```bash
# Rapport
cd official_docs/report
typst compile --root . example_report.typ

# Propal (PTC)
cd official_docs/propal
typst compile --root . example_propal.typ

# Présentation
cd official_docs/slides
typst compile main.typ
```

**LaTeX (pour les documents non portés : minutes, note, userguide)** :

```bash
cd official_docs/minutes
latexmk -pdf edgemind-minutes.tex
```

**Documents Web** : intégrer `official_docs/css/edgemind.css`.

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
│   ├── report/                 # ✨ Rapport (Typst + LaTeX legacy)
│   ├── propal/                 # ✨ Propal/PTC (Typst, LaTeX legacy)
│   ├── slides/                 # ✨ Présentation (Typst Touying)
│   ├── minutes/                # 📐 Compte-rendu (LaTeX)
│   ├── note/                   # 📐 Note interne (LaTeX)
│   ├── userguide/              # 📐 Guide utilisateur (LaTeX)
│   ├── beamerthemeEdgeMind/    # 📦 Beamer (legacy → slides/)
│   ├── lettre/                 # Papier à en-tête
│   ├── invoice/                # Factures
│   ├── plaquette/              # Brochure entreprise
│   ├── vcards/                 # Cartes de visite
│   ├── css/                    # Styles web
│   └── pygments/               # Coloration code
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

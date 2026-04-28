# EdgeMind Report Template pour Typst

Template de rapport technique professionnel avec l'identité visuelle EdgeMind, porté depuis LaTeX vers Typst.

## Table des Matières

- [Introduction](#introduction)
- [Installation](#installation)
- [Utilisation Rapide](#utilisation-rapide)
- [Configuration du Template](#configuration-du-template)
- [Chemins des Logos](#chemins-des-logos)
- [Bibliographie](#bibliographie)
- [Personnalisation](#personnalisation)
- [Différences avec LaTeX](#différences-avec-latex)
- [Exemples](#exemples)
- [Dépannage](#dépannage)

## Introduction

Le template `edgemind-report.typ` permet de créer des rapports techniques professionnels respectant l'identité visuelle EdgeMind définie en 2014. Ce template est un port du template LaTeX `edgemind-report.cls` vers le système de composition moderne Typst.

**Fonctionnalités principales :**
- Page de titre avec logos EdgeMind et client
- En-têtes et pieds de page personnalisés
- Couleurs EdgeMind (bleu #11416D, orange #EF7B26)
- Typographie OpenSans
- Support bibliographie (citations et références)
- Structure hiérarchique (chapitres, sections, sous-sections)
- Styles pour tableaux, figures, code

## Installation

### 1. Installer Typst

**Option A : Via Cargo (Rust)**
```bash
cargo install typst-cli
```

**Option B : Téléchargement du binaire**

Téléchargez la dernière version depuis [GitHub Releases](https://github.com/typst/typst/releases) et installez selon votre plateforme :

```bash
# Linux/macOS
wget https://github.com/typst/typst/releases/latest/download/typst-x86_64-unknown-linux-musl.tar.xz
tar -xf typst-x86_64-unknown-linux-musl.tar.xz
sudo mv typst-x86_64-unknown-linux-musl/typst /usr/local/bin/
```

Vérifiez l'installation :
```bash
typst --version
```

### 2. Installer la Police OpenSans

La police OpenSans est incluse dans le répertoire `../../font_opensans/` du dépôt.

**Option A : Installation système (recommandé)**
```bash
# Linux
sudo cp ../../font_opensans/*.ttf /usr/local/share/fonts/
sudo fc-cache -f -v

# macOS
cp ../../font_opensans/*.ttf ~/Library/Fonts/

# Windows
# Double-cliquer sur chaque fichier .ttf et cliquer sur "Installer"
```

**Option B : Utilisation locale**

Typst chargera automatiquement les polices depuis les répertoires standard du système. Si OpenSans n'est pas installée, le fallback système sera utilisé.

### 3. Structure du Projet

Assurez-vous que votre projet a accès aux fichiers suivants :
```
Visual_identity/
├── official_docs/report/
│   ├── edgemind-report.typ       # Template principal
│   ├── example_report.typ         # Exemple complet
│   ├── references.bib             # Bibliographie exemple
│   ├── README.md                  # Ce fichier
│   ├── logos/                     # Symlinks vers logos
│   │   ├── logo_edgemind_original.png
│   │   ├── logo_edgemind_hz.png
│   │   └── partner_logo.png
│   └── fig/                       # Images exemples
│       ├── example_chart.png
│       └── example_diagram.svg
└── logos/                         # Logos source EdgeMind
    ├── logo_edgemind_original.png
    ├── logo_edgemind_hz.png
    └── ...
```

## Utilisation Rapide

### Document Minimal

Créez un fichier `mon_rapport.typ` :

```typst
#import "edgemind-report.typ": *

#show: edgemind-report.with(
  title: "Mon Titre de Rapport",
  author: "Prénom Nom",
  date: "27/01/2026",
  version: "1.0",
  customer: "Client",
  ref-edgemind: "EM-R2026XXX",
)

= Introduction

Contenu de mon rapport...

== Section

Sous-contenu...
```

### Compilation

```bash
# Compiler une fois
typst compile mon_rapport.typ

# Mode watch (recompilation automatique)
typst watch mon_rapport.typ

# Spécifier le fichier de sortie
typst compile mon_rapport.typ mon_rapport.pdf
```

Le fichier PDF sera généré dans le même répertoire.

## Configuration du Template

### Paramètres Obligatoires

```typst
#show: edgemind-report.with(
  title: "Titre du document",           // Titre principal
  author: "Auteur(s)",                   // Nom(s) de l'auteur/des auteurs
  date: "JJ/MM/AAAA",                    // Date du document
  version: "X.Y",                        // Version du document
  customer: "Nom du client",             // Nom du client
  ref-edgemind: "EM-RYYYYXXX",          // Référence EdgeMind
)
```

### Paramètres Optionnels

```typst
#show: edgemind-report.with(
  // ... paramètres obligatoires ...

  // Vérificateur du document (optionnel)
  verif: "Nom du vérificateur",

  // Référence client (optionnel)
  ref-customer: "REF-CLIENT-2026",

  // Résumé sur la page de titre (optionnel)
  abstract: [
    Texte du résumé qui apparaît sur la page de titre.
    Peut contenir plusieurs lignes et du formatage Typst.
  ],

  // Image sur la page de titre (optionnel)
  title-image: "chemin/vers/image.png",
  title-image-width: 60%,  // Largeur de l'image (% de la largeur du texte)

  // Logos (chemins relatifs au document source)
  logo-left: "logos/logo_edgemind_original.png",  // Logo gauche (EdgeMind)
  logo-left-height: 2.5cm,                         // Hauteur du logo gauche
  logo-right: "logos/partner_logo.png",            // Logo droit (client/partenaire)
  logo-right-height: 2.5cm,                        // Hauteur du logo droit

  // Logo du pied de page
  logo-footer: "logos/logo_edgemind_hz.png",

  // Configuration bibliographie (optionnel)
  bibliography-file: "references.bib",
  bibliography-title: "Références",
  bibliography-style: "ieee",  // ou "apa", "chicago-author-date", etc.
)
```

### Exemple Complet

```typst
#import "edgemind-report.typ": *

#show: edgemind-report.with(
  title: "Étude d'Optimisation Énergétique",
  author: "Dr. Marie Dubois, Ing. Jean Martin",
  date: "27/01/2026",
  version: "2.0",
  verif: "Roland Donat",

  customer: "TechCorp Industries",
  ref-customer: "TC-2026-047",
  ref-edgemind: "EM-R2026012",

  abstract: [
    Rapport d'étude sur l'optimisation de la consommation énergétique
    des installations industrielles avec réduction de 25%.
  ],

  logo-left: "logos/logo_edgemind_original.png",
  logo-right: "logos/partner_logo.png",

  bibliography-file: "references.bib",
)

// Table des matières
#outline(title: "Table des matières", depth: 3)

= Introduction
Contenu...

// Bibliographie à la fin
#bibliography("references.bib")
```

## Chemins des Logos

**IMPORTANT** : Les chemins des logos doivent être **relatifs à votre fichier `.typ` source**, pas au fichier template.

### Exemple selon l'Emplacement du Document

**Cas 1 : Document dans le même répertoire que le template**
```
official_docs/report/mon_rapport.typ
```
Utiliser :
```typst
logo-left: "logos/logo_edgemind_original.png"  // ou "../../logos/..."
```

**Cas 2 : Document dans un sous-répertoire**
```
projects/rapport_client/rapport.typ
```
Utiliser :
```typst
logo-left: "../../Visual_identity/logos/logo_edgemind_original.png"
```

### Recommandation : Utiliser des Symlinks

Pour simplifier la gestion des chemins, créez des liens symboliques vers les logos :

```bash
cd votre_projet/
mkdir logos
cd logos
ln -s /chemin/vers/Visual_identity/logos/logo_edgemind_original.png .
ln -s /chemin/vers/Visual_identity/logos/logo_edgemind_hz.png .
```

Ensuite dans votre document :
```typst
logo-left: "logos/logo_edgemind_original.png"
```

### Logos Disponibles

Depuis le dépôt `Visual_identity/logos/` :
- `logo_edgemind_original.png` - Logo complet (recommandé pour page de titre gauche)
- `logo_edgemind_hz.png` - Logo horizontal (recommandé pour pied de page)
- `logo_edgemind_only_white.svg` - Symbole seul blanc
- Autres variantes disponibles selon les besoins

## Bibliographie

### Créer un Fichier .bib

Créez un fichier `references.bib` (format BibTeX standard) :

```bibtex
@article{smith2023,
  title={Machine Learning for Optimization},
  author={Smith, John and Doe, Jane},
  journal={Journal of AI},
  volume={15},
  number={3},
  pages={142--158},
  year={2023}
}

@book{brown2022,
  title={Data Science Handbook},
  author={Brown, Robert},
  year={2022},
  publisher={O'Reilly Media}
}

@techreport{edgemind2024,
  title={Guide des Bonnes Pratiques},
  author={{EdgeMind}},
  institution={EdgeMind S.A.S.},
  year={2024},
  number={EM-R2024-015}
}
```

### Citer dans le Document

Dans votre texte, utilisez `@ref_key` pour citer :

```typst
Les travaux récents @smith2023 montrent que...

Selon la littérature @brown2022, @edgemind2024...
```

### Ajouter la Bibliographie

À la fin de votre document :

```typst
#bibliography("references.bib")
```

Ou avec configuration personnalisée :

```typst
#bibliography(
  "references.bib",
  title: "Références Bibliographiques",
  style: "ieee"
)
```

### Styles de Citation Disponibles

- `"ieee"` - Style numérique IEEE (par défaut, [1], [2])
- `"apa"` - Style auteur-année APA (Smith, 2023)
- `"chicago-author-date"` - Style Chicago
- `"mla"` - Style MLA
- Et autres styles supportés par Typst

**Note** : Si vous configurez `bibliography-file` dans le template, vous devez quand même ajouter `#bibliography()` à la fin de votre document.

## Personnalisation

### Modifier les Couleurs

Les couleurs EdgeMind sont définies dans le template. Pour les personnaliser, modifiez directement `edgemind-report.typ` :

```typst
#let em-logo-blue = rgb(17, 65, 109)      // Bleu EdgeMind #11416D
#let em-logo-orange = rgb(239, 123, 38)   // Orange EdgeMind #EF7B26
#let em-grey = rgb(201, 212, 230)         // Gris EdgeMind #C9D4E6
```

Ou utilisez-les dans votre document après import :

```typst
#import "edgemind-report.typ": em-logo-blue, em-logo-orange

#text(fill: em-logo-blue)[Texte en bleu EdgeMind]
```

### Ajuster les Marges

Les marges par défaut sont :
- Haut/Bas : 2.25 cm
- Gauche/Droite : 2.5 cm

Pour les modifier, éditez le template `edgemind-report.typ` (ligne 46) :

```typst
set page(
  margin: (
    top: 3cm,      // Modifier ici
    bottom: 3cm,
    left: 3cm,
    right: 3cm
  )
)
```

### Changer la Police

La police par défaut est OpenSans avec fallback système. Pour utiliser une autre police :

```typst
set text(
  font: "Liberation Sans",  // Ou toute police installée
  size: 11pt
)
```

### Personnaliser les En-têtes/Pieds de Page

Éditez directement les sections `header:` et `footer:` dans le template `edgemind-report.typ` (lignes 56-88).

## Différences avec LaTeX

Le template Typst est un port fonctionnel mais pas une copie identique du template LaTeX. Voici les principales différences :

### Fonctionnalités Non Portées

**Environnements mathématiques avancés**
- LaTeX : `\begin{theorem}`, `\begin{definition}`, etc.
- Typst : Utiliser les blocs standard `#block()` ou créer des fonctions personnalisées
- Raison : Pas nécessaire pour les rapports standards, peut être ajouté ultérieurement

**Captions personnalisées avancées**
- LaTeX : Package `caption` avec customisation fine
- Typst : Système de captions natif plus simple (`#figure()`)
- Raison : Le système Typst est plus moderne et suffisant

**Switch langue automatique**
- LaTeX : Option de classe pour français/anglais
- Typst : Hardcodé en français, modifier `lang: "fr"` manuellement
- Raison : Simplification, la majorité des rapports EdgeMind sont en français

### Différences de Design

**Pied de page**
- LaTeX : Texte "EdgeMind S.A.S." en smallcaps à gauche
- Typst : Logo EdgeMind horizontal à gauche
- Raison : Choix de design moderne, plus visuel

**Couleurs**
- LaTeX : CMYK natif pour l'impression offset
- Typst : RGB (converti depuis CMYK avec formule standard)
- Raison : Typst utilise RGB, différences visuelles minimes

**En-tête**
- LaTeX : Marks de chapitre/section (gauche/droite selon page paire/impaire)
- Typst : Simple ligne de séparation
- Raison : Fonctionnalité de marks non implémentée pour l'instant

### Équivalents Typst pour Fonctionnalités LaTeX

| LaTeX | Typst |
|-------|-------|
| `\section{}` | `= Titre` |
| `\subsection{}` | `== Titre` |
| `\textbf{}` | `*texte*` |
| `\textit{}` | `_texte_` |
| `\texttt{}` | `` `code` `` |
| `\cite{}` | `@ref_key` |
| `\ref{}` | `@label` |
| `\label{}` | `<label>` |
| `\begin{figure}...\end{figure}` | `#figure()` |
| `\begin{table}...\end{table}` | `#figure(table())` |
| `\tableofcontents` | `#outline()` |

## Exemples

### Document Exemple Complet

Le fichier `example_report.typ` fourni démontre toutes les fonctionnalités :

- Page de titre avec logos et métadonnées
- Table des matières
- Structure multi-niveaux (3 niveaux de titres)
- Abstract/résumé
- Listes (numérotées et à puces)
- Tableaux avec données
- Figures avec légendes
- Code source avec coloration syntaxique (Python, Bash)
- Liens hypertextes et références croisées
- Citations bibliographiques
- Formules mathématiques simples
- 5+ pages pour tester pagination

### Compiler l'Exemple

```bash
cd official_docs/report/
typst compile example_report.typ
```

Ouvrez `example_report.pdf` pour voir le résultat.

### Adapter l'Exemple

Pour créer votre propre rapport :

1. Copiez `example_report.typ` vers `mon_rapport.typ`
2. Modifiez les paramètres du template (titre, auteur, etc.)
3. Remplacez le contenu par votre texte
4. Ajustez les chemins des logos selon votre emplacement
5. Compilez : `typst compile mon_rapport.typ`

## Dépannage

### Erreur : "file not found: logo_edgemind_original.png"

**Cause** : Le chemin du logo est incorrect ou relatif au mauvais répertoire.

**Solution** :
1. Vérifiez que le fichier existe : `ls logos/logo_edgemind_original.png`
2. Ajustez le chemin pour qu'il soit relatif à votre fichier `.typ`
3. Utilisez des symlinks (voir [Chemins des Logos](#chemins-des-logos))

### Erreur : "unknown font family: Open Sans"

**Cause** : La police OpenSans n'est pas installée sur le système.

**Solution** :
1. Installez OpenSans (voir [Installation](#installation))
2. Ou modifiez le template pour utiliser une police système :
   ```typst
   set text(font: "Liberation Sans")  // ou "Arial", "Helvetica"
   ```

### Erreur : "file not found: references.bib"

**Cause** : Le fichier bibliographique n'existe pas ou le chemin est incorrect.

**Solution** :
1. Créez le fichier `references.bib` dans le même répertoire que votre document
2. Ou ajustez le chemin : `bibliography-file: "path/to/references.bib"`
3. Ou retirez le paramètre `bibliography-file` si vous n'utilisez pas de bibliographie

### Les Couleurs Ne Correspondent Pas Exactement au LaTeX

**Cause** : Conversion CMYK → RGB avec formule standard.

**Explication** : C'est normal. Les valeurs CMYK du LaTeX sont conçues pour l'impression offset, tandis que Typst utilise RGB pour l'affichage écran et l'impression RGB. Les différences sont minimes visuellement (< 5% de variation).

**Solution** : Si vous avez besoin de correspondance exacte, ajustez manuellement les valeurs RGB dans le template.

### Le PDF Généré N'a Pas de Signets/Table des Matières Cliquable

**Cause** : C'est le comportement par défaut de Typst.

**Solution** : Les liens internes (références croisées) fonctionnent automatiquement. Pour les signets PDF, Typst les génère automatiquement depuis les titres.

### Typst N'est Pas Installé

**Cause** : Première utilisation, Typst pas encore installé.

**Solution** : Suivez la section [Installation](#installation) pour installer Typst via cargo ou binaire.

### Erreur de Compilation Avec du Code LaTeX

**Cause** : Typst utilise une syntaxe différente de LaTeX.

**Solution** : Convertissez la syntaxe LaTeX vers Typst :
- `\\` → `#linebreak()` ou double espace en fin de ligne
- `\textbf{text}` → `*text*`
- `\section{}` → `= Titre`
- Consultez la [documentation Typst](https://typst.app/docs)

---

## Ressources

- **Documentation Typst** : https://typst.app/docs
- **Typst GitHub** : https://github.com/typst/typst
- **Charte EdgeMind** : `../../EM-visual_identity.pdf`
- **Template LaTeX Original** : `edgemind-report.cls`
- **Support** : contact@edgemind.net

---

**EdgeMind S.A.S.** - 23 rue du Départ, Boite 37, 75014 Paris
SIRET : 799 582 945 00017 - Version du template : 1.0 (2026-01-27)

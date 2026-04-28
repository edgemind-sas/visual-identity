# Guide de Démarrage Rapide - EdgeMind Report Template Typst

## ⚠️ Prérequis : Installer Typst

**IMPORTANT** : Typst n'est pas encore installé sur votre système. Vous devez l'installer avant de pouvoir compiler les documents.

### Installation Rapide (Recommandé)

**Option 1 : Via Cargo (si Rust est installé)**
```bash
cargo install typst-cli
```

**Option 2 : Binaire Linux (sans Rust)**
```bash
# Télécharger la dernière version
wget https://github.com/typst/typst/releases/latest/download/typst-x86_64-unknown-linux-musl.tar.xz

# Extraire
tar -xf typst-x86_64-unknown-linux-musl.tar.xz

# Installer
sudo mv typst-x86_64-unknown-linux-musl/typst /usr/local/bin/

# Vérifier
typst --version
```

Pour d'autres systèmes : https://github.com/typst/typst/releases

## Test de l'Installation

Une fois Typst installé :

```bash
cd official_docs/report/

# Compiler l'exemple
typst compile example_report.typ

# Vérifier que le PDF est généré
ls -lh example_report.pdf

# Ouvrir le PDF
xdg-open example_report.pdf  # Linux
# ou
open example_report.pdf      # macOS
```

## Structure des Fichiers Créés

```
official_docs/report/
├── edgemind-report.typ       ✓ Template principal (MODIFIÉ)
│                               - Couleurs RGB corrigées
│                               - Support bibliographie ajouté
│                               - Documentation améliorée
│
├── example_report.typ         ✓ NOUVEAU - Exemple complet (5 pages)
│                               - Tous les paramètres démontrés
│                               - Figures, tableaux, code
│                               - Citations bibliographiques
│
├── references.bib             ✓ NOUVEAU - Bibliographie exemple
│                               - 5 références de types variés
│                               - Prête à l'emploi
│
├── README.md                  ✓ NOUVEAU - Documentation exhaustive
│                               - Guide d'installation complet
│                               - Tous les paramètres expliqués
│                               - Section dépannage
│
├── QUICKSTART.md              ✓ NOUVEAU - Ce fichier
│
├── logos/                     ✓ NOUVEAU - Symlinks vers logos
│   ├── logo_edgemind_original.png → ../../../logos/...
│   ├── logo_edgemind_hz.png → ../../../logos/...
│   └── partner_logo.png       (logo client fictif)
│
└── fig/                       ✓ NOUVEAU - Images exemples
    ├── example_chart.png      (copié depuis visual/)
    └── example_diagram.svg    (copié depuis visual/)
```

## Créer Votre Premier Rapport

### 1. Copier l'Exemple

```bash
cd official_docs/report/
cp example_report.typ mon_rapport.typ
```

### 2. Éditer les Métadonnées

Ouvrez `mon_rapport.typ` et modifiez :

```typst
#show: edgemind-report.with(
  title: "Votre Titre",           // ← Modifier ici
  author: "Votre Nom",             // ← Modifier ici
  date: "27/01/2026",              // ← Modifier ici
  version: "1.0",                  // ← Modifier ici
  customer: "Votre Client",        // ← Modifier ici
  ref-edgemind: "EM-R2026XXX",    // ← Modifier ici
  // ...
)
```

### 3. Modifier le Contenu

Remplacez le contenu après les paramètres par votre texte :

```typst
= Mon Introduction

Votre texte ici...

== Ma Section

Sous-contenu...
```

### 4. Compiler

```bash
typst compile mon_rapport.typ
```

Le fichier `mon_rapport.pdf` sera créé.

### 5. Mode Watch (Recompilation Automatique)

```bash
typst watch mon_rapport.typ
```

Typst recompilera automatiquement à chaque sauvegarde.

## Vérification de la Migration

### Couleurs EdgeMind Corrigées ✓

Les couleurs RGB ont été recalculées avec précision :

| Couleur | CMYK (LaTeX) | RGB (Typst) | Hex |
|---------|--------------|-------------|-----|
| EMBlue | 0.96, 0.75, 0.30, 0.18 | rgb(17, 65, 109) | #11416D |
| EMOrange | 0.00, 0.61, 0.90, 0.00 | rgb(239, 123, 38) | #EF7B26 |
| EMGrey | 0.21, 0.17, 0.10, 0.00 | rgb(201, 212, 230) | #C9D4E6 |

### Support Bibliographie Ajouté ✓

- Configuration Typst native
- Fichier `.bib` standard (compatible LaTeX)
- Citations avec `@ref_key`
- Styles multiples : IEEE, APA, Chicago, etc.

### Documentation Complète ✓

- `README.md` : Guide exhaustif (400+ lignes)
- Instructions d'installation
- Tous les paramètres documentés
- Section dépannage
- Exemples pratiques

## Comparaison LaTeX vs Typst

| Fonctionnalité | LaTeX | Typst |
|----------------|-------|-------|
| Identité visuelle | ✓ | ✓ |
| Couleurs EdgeMind | CMYK | RGB (converti) |
| Page de titre | ✓ | ✓ |
| En-têtes/pieds | ✓ | ✓ (logo footer) |
| Bibliographie | biblatex | Natif Typst |
| Compilation | lualatex | typst compile |
| Vitesse | ~5-10s | ~0.5s |

## Points d'Attention

### ⚠️ Chemins des Logos

Les chemins doivent être **relatifs à votre document `.typ`**, pas au template.

**Depuis `official_docs/report/`** :
```typst
logo-left: "logos/logo_edgemind_original.png"  // ✓ Correct
```

**Depuis un autre répertoire** :
```typst
logo-left: "../../Visual_identity/logos/logo_edgemind_original.png"
```

**Recommandation** : Créer des symlinks dans votre répertoire de travail.

### ⚠️ Police OpenSans

Si la police n'est pas installée, Typst utilisera un fallback système. Pour installer :

```bash
# Linux
sudo cp ../../font_opensans/*.ttf /usr/local/share/fonts/
sudo fc-cache -f -v
```

Vérifiez :
```bash
fc-list | grep "Open Sans"
```

## Prochaines Étapes

1. **Installer Typst** (voir ci-dessus)
2. **Compiler l'exemple** : `typst compile example_report.typ`
3. **Vérifier le PDF** : Ouvrir `example_report.pdf`
4. **Créer votre rapport** : Copier et adapter `example_report.typ`
5. **Consulter le README** : Pour paramètres avancés et personnalisation

## Support

- **README complet** : `README.md` dans ce répertoire
- **Documentation Typst** : https://typst.app/docs
- **Template LaTeX original** : `edgemind-report.cls` (référence)
- **Charte graphique** : `../../EM-visual_identity.pdf`

---

**EdgeMind S.A.S.** - Migration Template Report LaTeX → Typst - Janvier 2026

# EdgeMind Propal Template pour Typst

Template de **proposition technique et commerciale (PTC)** avec l'identité visuelle EdgeMind, porté depuis les propals Google Docs vers Typst.

## Introduction

Le template `edgemind-propal.typ` permet de créer des propositions commerciales professionnelles respectant l'identité visuelle EdgeMind. Il complète `../report/edgemind-report.typ` (pour les rapports techniques) avec une version dédiée aux propales : titres en orange, tableau d'offre commerciale, planning prévisionnel, bloc ressources.

**Fonctionnalités principales :**
- Page de titre avec logos EdgeMind et client, tableau de métadonnées (Auteurs / Date / Version / Réf client / Réf EdgeMind), footer SIRET.
- Titres hiérarchisés en **orange EdgeMind** (`#ef7b26`).
- Footer courant « EdgeMind S.A.S. / Page X/Y / Version X.Y ».
- Dix helpers pour les tableaux récurrents d'une propal : glossaire, lotissement, tâches, livrables, ressources humaines, offre commerciale synthèse, offre commerciale détaillée, échéances de facturation, validité, planning.
- Formats FR automatiques : virgule décimale, espace insécable pour les milliers, devise `€`.
- Pagination automatique des grands tableaux avec répétition de l'en-tête.

## Installation

### 1. Installer Typst

```bash
# Via Cargo
cargo install typst-cli

# Ou binaire pré-compilé
# https://github.com/typst/typst/releases
```

### 2. Installer la police Open Sans

La police est incluse dans `../../font_opensans/`. Installation système :

```bash
sudo cp ../../font_opensans/*.ttf /usr/local/share/fonts/
sudo fc-cache -f -v
```

### 3. Vérifier l'installation

```bash
typst --version   # >= 0.11
fc-list | grep -i "open sans"
```

## Utilisation rapide

### Démarrer une nouvelle propal

```bash
cd official_docs/propal
cp example_propal.typ ma-propal.typ
# Éditez ma-propal.typ (métadonnées + contenu)
typst compile --root . ma-propal.typ
```

Le PDF est généré à côté du fichier `.typ`.

### Structure minimale

```typst
#import "edgemind-propal.typ": *

#show: edgemind-propal.with(
  title: "Titre de la proposition",
  date: "15 juin 2026",
  version: "1.0",
  ref-edgemind: "CLIENT-PROJET-2026-PTC-V1",
  customer: "Client",
  ref-customer: "CDC-2026-001",
)

= Contexte
Contenu...

= Offre commerciale

#propal-commercial-offer(
  (
    ("L01", "Pilotage", 2),
    ("L02", "Développement", 10),
  ),
  rate: 900,
)

#propal-offer-validity("30 septembre 2026")
```

### Important : compiler avec `--root .`

Les fichiers de propal sont dans le sous-répertoire `propal/`. Typst exige de passer `--root .` (depuis `propal/`) pour que les imports et chemins logos fonctionnent :

```bash
cd official_docs/propal
typst compile --root . ma-propal.typ
# Ou pour les reproductions en sous-dossier :
typst compile --root . reproductions/EDF-BADTREEPS-2026-PTC-V3.typ
```

## Paramètres du template

### Obligatoires

| Paramètre | Type | Exemple |
|---|---|---|
| `title` | string | `"DÉVELOPPEMENT DE L'OUTIL X"` |
| `date` | string | `"15 juin 2026"` |
| `version` | string | `"1.0"` |
| `ref-edgemind` | string | `"CLIENT-PROJET-2026-PTC-V1"` |

### Optionnels

| Paramètre | Défaut | Usage |
|---|---|---|
| `subtitle` | `"Proposition Technique et Commerciale"` | Sous-titre sous le titre principal |
| `authors` | `none` | string ou array de strings |
| `customer` | `none` | Nom client (préfixe le label "Réf.") |
| `ref-customer` | `none` | Référence côté client |
| `logo-left` | `"logos/logo_edgemind_original.png"` | Chemin relatif à `edgemind-propal.typ` |
| `logo-right` | `none` | Chemin relatif à `edgemind-propal.typ` |
| `logo-left-height` | `2.5cm` | Hauteur logo |
| `logo-right-height` | `2.5cm` | Hauteur logo |
| `lang` | `"fr"` | Langue Typst |
| `bibliography-file` | `none` | Chemin fichier `.bib` si besoin de biblio |

### Chemins des logos

**Les chemins d'image sont résolus par Typst relativement au fichier qui contient l'appel `image()`**, c'est-à-dire `edgemind-propal.typ` (dans `propal/`). Donc :

- `"logos/edf.svg"` → `propal/logos/edf.svg` ✓
- `"../logos/edf.svg"` → `official_docs/logos/` ✗ (n'existe pas)

Placez vos logos clients dans `propal/logos/` et utilisez `"logos/monclient.svg"`.

## Helpers disponibles

### `propal-glossary(entries, caption: ...)`

Tableau deux colonnes Terme / Signification.

```typst
#propal-glossary((
  ("API", [De l'anglais _Application Programmable Interface_.]),
  ("KPI", "Key Performance Indicator."),
))
```

### `propal-lots(lots, caption: ...)`

Tableau de lotissement : `#Lot / Lot / Description`. La description accepte du contenu multiligne avec puces.

```typst
#propal-lots((
  ("L01", "Pilotage", [- Suivi planning
- Reporting]),
  ("L02", "Développement", [Développement du cœur applicatif]),
))
```

### `propal-tasks(tasks, show-total: true, caption: ..., unit-label: ...)`

Tableau de tâches avec UO (unités d'œuvre). Total auto en dernière ligne.

```typst
#propal-tasks((
  ("1", [Tâche 1], "Pilotage", 2.5),
  ("2", [Tâche 2 avec du contenu long], "Développement", 5),
))
```

### `propal-deliverables(items, caption: ...)`

Tableau deux colonnes Livrable / Description.

```typst
#propal-deliverables((
  ("L1", [Code source + Docker]),
  ("L2", [Documentation technique]),
))
```

### `propal-resources(people, photo-width: 3.5cm)`

Blocs collaborateurs avec photo + nom en bleu + rôle en orange + bio justifiée. `photo: none` affiche un placeholder gris avec mention « photo ».

```typst
#propal-resources((
  (
    photo: "photos/roland.jpg",  // optionnel
    name: "Roland Donat",
    role: "Pilote du projet",
    bio: [Bio explicative.],
  ),
))
```

### `propal-commercial-offer(lots, rate: ..., show-amount: auto, ...)`

Offre synthèse par lot avec montants auto-calculés.

```typst
#propal-commercial-offer(
  (
    ("L01", "Pilotage", 2),
    ("L02", "Développement", 10),
  ),
  rate: 900,       // € / jour ; si omis, montants à fournir en 4e position
)
```

**Options :**
- `rate: 900` — taux journalier pour calculer les montants.
- `show-amount: false` — cache la colonne Montant (utile pour une table de synthèse UO pure).
- `currency: "€"`, `unit-label: "UO (en jours)"`, `amount-label: "Montant (€ HT)"` — personnalisation des libellés.

### `propal-commercial-offer-detailed(tasks, rate: ...)`

Variante détaillée par tâche groupée par lot.

```typst
#propal-commercial-offer-detailed(
  (
    ("DevOps", [Déploiement serveur], 1),
    ("DevOps", [Maintenance], 1),
    ("ETL", [Extraction GMAO], 1.5),
  ),
  rate: 900,
)
```

### `propal-billing-schedule(milestones)`

Tableau des échéances de facturation.

```typst
#propal-billing-schedule((
  ("Lancement du projet.", 30, 3510),
  ("Livraison intermédiaire.", 40, 4680),
  ("Validation finale.", 30, 3510),
))
```

### `propal-offer-validity(date)`

Phrase en gras « Cette offre est valable jusqu'au _date_. ».

```typst
#propal-offer-validity("30 septembre 2026")
```

### `propal-timeline(tasks, periods, granularity: ...)`

Planning prévisionnel sous forme de matrice lot × période, cellules colorées par intensité (3 paliers orange selon la valeur).

```typst
// Planning mensuel
#propal-timeline(
  (
    ("L01", "Pilotage", (0.5, 0.5, 0.5)),
    ("L02", "Dev", (3, 5, 2)),
  ),
  ("2026-07", "2026-08", "2026-09"),
  granularity: "month",
)

// Planning hebdomadaire (labels pivotés 90°)
#propal-timeline(
  (
    ("L1", "DevOps", (0.75, none, 0.25, 1)),
  ),
  ("2026-S27", "2026-S28", "2026-S29", "2026-S30"),
  granularity: "week",
)
```

**Options :**
- `granularity: "month" | "week"` — contrôle la rotation des en-têtes.
- `id-label: "T#"`, `name-label: "Tâche"` — personnalisation des 2 premières colonnes.
- Cellules vides : passer `none` ou `""`.

## Reproductions de référence

Deux propals historiques sont reproduites dans `reproductions/` pour valider le template et servir de modèle :

- **`EDF-BADTREEPS-2026-PTC-V3.typ`** — 10 pages, 9 lots, 11 tâches, planning mensuel, total 75 845,00 € HT.
- **`PTC-RATPDEV-MAINTUP-2022-V1.typ`** — 11 pages, 4 lots, bloc ressources, offre détaillée + échéances, planning hebdomadaire, total 21 825,00 € HT.

Compilation :

```bash
cd official_docs/propal
typst compile --root . reproductions/EDF-BADTREEPS-2026-PTC-V3.typ
typst compile --root . reproductions/PTC-RATPDEV-MAINTUP-2022-V1.typ
```

## Différences avec le template report

| | `edgemind-report.typ` | `edgemind-propal.typ` |
|---|---|---|
| Usage | Rapports techniques, études | Propositions commerciales |
| Couleur H1 | Bleu `#11416D` | **Orange** `#EF7B26` |
| Numérotation H1 | `2 \| Titre` (avec pipe) | `2. Titre` |
| Page de titre | Bloc abstract possible, Auteur(s), Vérificateur | Tableau métadonnées (Auteurs / Date / Version / Réfs), pas d'abstract |
| Pied de page courant | Logo EdgeMind horizontal | Texte « EdgeMind S.A.S. » smallcaps |
| Helpers spécifiques | — | 10 helpers propal |
| Figure supplement | `Figure` | `Figure` / `Table` (EdgeMind historique) |

## Personnalisation

### Modifier les couleurs

Les tokens de marque sont définis en haut de `edgemind-propal.typ` (dupliqués depuis `edgemind-report.typ`). Pour ajuster une couleur, éditer directement :

```typst
#let em-logo-blue = rgb(17, 65, 109)
#let em-logo-orange = rgb(239, 123, 38)
#let em-grey = rgb(201, 212, 230)
```

Et les dérivés propal :

```typst
#let propal-table-header-fill = em-grey.lighten(30%)
#let propal-timeline-cell-light = em-logo-orange.lighten(85%)
#let propal-timeline-cell-medium = em-logo-orange.lighten(65%)
#let propal-timeline-cell-strong = em-logo-orange.lighten(40%)
```

### Ajuster les seuils d'intensité du planning

La fonction `_timeline-fill(v)` définit les 3 paliers par défaut : `< 1`, `1-3`, `>= 3`. Modifier si vos planning utilisent d'autres échelles.

## Dépannage

### « cannot read file outside of project root »

Ajoutez `--root .` à la commande typst depuis `propal/` :

```bash
typst compile --root . ma-propal.typ
```

### « unknown font family: Open Sans »

Installez la police (voir Installation). Si Open Sans est absente, Typst utilisera un fallback système (typographie moins fidèle mais document lisible).

### Logo invisible ou chemin erroné

Vérifier que le fichier existe dans `propal/logos/` et que le chemin passé au template est `"logos/..."` (relatif à `edgemind-propal.typ`), pas `"../logos/..."`.

### Total général incorrect dans une offre commerciale

Les montants sont calculés avec `float(uo) * float(rate)`. Si vous passez des montants directement (4e position dans le tuple lot), le rate est ignoré. Vérifiez la cohérence.

### Tableau qui déborde sur la marge inférieure

Le template active `show figure: set block(breakable: true)`, donc les grandes tables paginent automatiquement. Si vous rencontrez un débordement, vérifiez que le contenu d'une cellule unique ne dépasse pas une page.

## Ressources

- Documentation Typst : https://typst.app/docs
- Tables Typst : https://typst.app/docs/reference/model/table/
- Brainstorm amont : `../../docs/brainstorms/2026-04-17-edgemind-propal-typst-brainstorm.md`
- Plan d'implémentation : `../../docs/plans/2026-04-17-feat-typst-propal-template-plan.md`
- Charte EdgeMind : `../../EM-visual_identity.pdf`
- Template rapport EdgeMind : `../report/edgemind-report.typ`

---

**EdgeMind S.A.S.** — 23 rue du Départ, Boite 37, 75014 Paris
SIRET : 799 582 945 00017 — Version du template : 1.0 (2026-04-17)

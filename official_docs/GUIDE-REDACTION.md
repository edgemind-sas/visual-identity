# Guide de rédaction des documents officiels EdgeMind (Typst)

> Référence pour la génération de tout **document officiel** destiné à un client, partenaire ou diffusion externe (rapports, livrables, spécifications validées, comptes rendus formels). Extrait de `CLAUDE.local.md` du workspace COD3S le 2026-06-09 (consulté à la demande, pas chargé en contexte permanent).
>
> **Exclusions** : les plans de développement (`docs/plans/`) et brainstorms (`docs/brainstorms/`) restent en Markdown brut — documents de travail internes non diffusés.

## Template

| Propriété | Valeur |
|-----------|--------|
| Template | `~/Work/EdgeMind/Visual_identity/official_docs/report/edgemind-report.typ` |
| Format | Typst (`.typ`) |
| Identité visuelle | Couleurs EdgeMind (bleu `#11416D`, orange `#EF7B26`), logos, page de titre, footer |
| Sortie | PDF via `typst compile` |

## Usage du template

```typst
#import "<chemin-relatif>/edgemind-report.typ": edgemind-report

#show: edgemind-report.with(
  title: "Titre du document",
  subtitle: "Sous-titre optionnel",
  author: "Roland Donat",
  customer: "RATP",
  ref-customer: "RATP-XXXX-001",
  ref-edgemind: "EM-R2026001",
  version: "1.0",
  abstract: [Résumé du document...],
  // logo-left: "../../logos/logo_edgemind_original.png",  // défaut
  // logo-right: "logo_client.png",                         // optionnel
)

= Introduction
...
```

**Points d'attention** :

- Les chemins de logos sont **relatifs au document `.typ`**, pas au template (créer des symlinks vers `Visual_identity/logos/` au besoin)
- Police par défaut : Open Sans, langue : `fr`
- Numérotation des titres : `1.1` automatique, table des matières avec `#outline()`
- Bibliographie optionnelle via `bibliography-file:` (style IEEE par défaut)

## Recommandations de rédaction (documents officiels FR)

À appliquer à tout rapport / livrable Typst destiné à une diffusion équipe ou client :

| Règle | Détail |
|-------|--------|
| **Glossaire obligatoire** | Section `= Glossaire` au début du document (juste après l'introduction). Définit chaque terme technique à sa première occurrence avec sa **traduction française** entre parenthèses. Exemples : *race condition (condition de course)*, *projector (projecteur)*, *reducer (réducteur)*, *seq (numéro de séquence)*, *broadcast hub (pôle de diffusion)* |
| **Anglicismes : éviter** | Sauf pour les termes techniques universellement adoptés (`API`, `JSON`, `WebSocket`, `MongoDB`, `commit`, `cache`, `frontend`, `backend`, `framework`, `bug`). Préférer la traduction quand elle existe et reste claire (*événement* plutôt que *event* en prose) |
| **Pas de gras dans le corps du texte** | Sauf demande explicite, aucun mot en gras dans les paragraphes, listes et cellules. Les titres et en-têtes portent la hiérarchie ; l'étiquette d'un énoncé (« Définition 1 ») va en italique |
| **Listes collées à leur phrase d'introduction** | Le gabarit `edgemind-report.typ` réduit l'espace au-dessus d'une liste (`show list: set block(above: 0.7em)`) : la liste suit sa phrase introductive terminée par deux-points sans saut de paragraphe |
| **Pas de cadratin `—`** | Utiliser `:` (deux-points), `,` (virgule), ou `(...)` (parenthèses) selon le sens. Le caractère cadratin (`—`) est proscrit dans les documents officiels FR. Le tiret demi-cadratin `–` aussi. Tirets simples `-` uniquement pour mots composés |
| **Résumé : 6 lignes maximum** | Le `abstract:` du template doit tenir en 6 lignes à l'impression. Concis, focus résultats. Le détail va dans le corps du document |
| **Schémas : outils Typst-compatibles** | Pas de schémas en ASCII art ni en bloc code. Utiliser : (1) **fletcher** (`@preview/fletcher`) pour les diagrammes fléchés / pipelines / architectures, (2) **cetz** (`@preview/cetz`) pour les schémas géométriques précis, (3) **diagraph** (`@preview/diagraph`) pour les graphes Graphviz. Éviter les images bitmap raster |
| **Expliquer les termes techniques** | À la première occurrence dans le corps : *terme (traduction FR : explication courte)*. Reprise du terme dans le glossaire. Ne pas présupposer que le lecteur connaît |
| **Pas de mentions de durée projet** | Dans un document de conception / rapport technique post-livraison : ne pas mentionner les jours-homme, les phases d'exécution chronologiques, les dates de livraison. Le document explique la **technique** et le **résultat**, pas la **gestion de projet** |
| **Pas de mention client en références** | Documents internes EdgeMind ou inter-équipe : pas de mention nominative de client dans les références, sections principales, ou metadata. Acceptable uniquement pour citer un **requis ou contrainte** spécifique (`L'instance prévue chez X impose telle contrainte de scalabilité`) |
| **Sous-titre standard** | Rapport de conception : `subtitle: "Rapport de conception"`. Audit : `"Rapport d'audit"`. Livrable : `"Livrable technique"` |
| **Code / chemins** | Toujours en backticks. Chemins absolus jamais montrés dans un document client ; préférer chemins relatifs au repo (`backend/src/services/...`) |

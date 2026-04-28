// example_propal.typ — Squelette de démarrage pour une nouvelle propal EdgeMind
//
// Compilation :
//   cd official_docs/propal
//   typst compile --root . example_propal.typ
//
// Copiez ce fichier vers <client>-<projet>-<AAAA>-PTC-V<N>.typ puis adaptez :
//   1. Métadonnées du #show: ci-dessous (titre, date, version, réfs, logos)
//   2. Contenu de chaque section
//   3. Tableaux avec les données réelles
//   4. Chiffrage (taux horaire, montants)

#import "edgemind-propal.typ": *

#show: edgemind-propal.with(
  // Obligatoires
  title: "Titre de la proposition",
  date: "15 juin 2026",
  version: "1.0",
  ref-edgemind: "CLIENT-PROJET-2026-PTC-V1",

  // Recommandés
  subtitle: "Proposition Technique et Commerciale",
  authors: ("Prénom Nom",),
  customer: "Client",
  ref-customer: "CDC-2026-001",

  // Logos (chemins relatifs à edgemind-propal.typ, i.e. propal/)
  logo-left: "logos/logo_edgemind_original.png",
  // logo-right: "logos/client.svg",   // décommenter avec logo client
)

// Table des matières (titre par défaut fourni par le template)
#outline()

// ============================================================
= Glossaire
// ============================================================

#propal-glossary((
  ("API", [De l'anglais _Application Programmable Interface_.]),
  ("BDD", "Base de données."),
  ("KPI", [_Key Performance Indicator_ — indicateur clé de performance.]),
))

// ============================================================
= Contexte et objectifs
// ============================================================

== Contexte du client

Décrivez ici le contexte métier du client : enjeux actuels, problématique à résoudre, existant technique. Ce paragraphe pose le cadre de la proposition.

== Objectifs du projet

Listez les objectifs concrets que le projet vise à atteindre :

- Premier objectif mesurable.
- Second objectif mesurable.
- Troisième objectif mesurable.

// ============================================================
= Approche technique
// ============================================================

== Approche générale

Présentez l'approche globale proposée, les principes directeurs, et la cohérence d'ensemble. Renvoyez ici à une figure ou un schéma si nécessaire.

== Lotissement du projet

Le projet est organisé en lots fonctionnels cohérents :

#propal-lots((
  ("L01", "Pilotage", [- Pilotage du projet
- Suivi du planning
- Reporting client]),
  ("L02", "Développement", [- Développement des briques logicielles
- Intégration continue
- Tests unitaires]),
  ("L03", "Déploiement", [- Mise en production
- Documentation technique
- Support utilisateur]),
))

== Tâches détaillées

#propal-tasks((
  ("1", [Pilotage, suivi et reporting], "Pilotage", 2),
  ("2", [Développement du module A], "Développement", 5),
  ("3", [Développement du module B], "Développement", 4),
  ("4", [Déploiement + documentation], "Déploiement", 2),
))

== Livrables

#propal-deliverables((
  ("L1", [Code source de l'application + package de déploiement Docker.]),
  ("L2", [Documentation technique et manuel utilisateur.]),
  ("L3", [Mise à disposition sur serveur EdgeMind jusqu'au 31/12/2026.]),
))

// ============================================================
= Organisation proposée
// ============================================================

== Ressources mises à disposition

Pour réaliser la prestation, EdgeMind met à disposition :

#propal-resources((
  (
    // Si vous avez une photo : photo: "photos/prenom.jpg",
    name: "Prénom Nom",
    role: "Rôle dans le projet",
    bio: [Courte bio présentant l'expertise et le rôle de la personne sur le projet. Mentionner les domaines clés et l'expérience pertinente.],
  ),
  (
    name: "Deuxième intervenant",
    role: "Autre rôle",
    bio: [Autre bio.],
  ),
))

== Lieu de la prestation

Les travaux se dérouleront principalement dans les locaux EdgeMind, avec des points de synchronisation réguliers chez le client.

== Échanges

Des échanges réguliers par e-mail, téléphone ou visioconférence auront lieu tout au long du projet.

// ============================================================
= Planning prévisionnel
// ============================================================

Planning mensuel indicatif :

#propal-timeline(
  (
    ("L01", "Pilotage", (0.5, 0.5, 0.5, 0.5)),
    ("L02", "Développement", (3, 3, 2, 1)),
    ("L03", "Déploiement", (none, none, 1, 1)),
  ),
  ("2026-07", "2026-08", "2026-09", "2026-10"),
  granularity: "month",
)

// Pour un planning hebdomadaire, utiliser granularity: "week"
// et des labels type "2026-S27", "2026-S28", etc.

// ============================================================
= Offre commerciale
// ============================================================

Taux horaire appliqué : 900 € H.T. / jour.

#propal-commercial-offer(
  (
    ("L01", "Pilotage", 2),
    ("L02", "Développement", 9),
    ("L03", "Déploiement", 2),
  ),
  rate: 900,
  caption: "Montant de l'offre.",
)

// Échéances de facturation
Les modalités de facturation sont les suivantes :

#propal-billing-schedule((
  ("Lancement du projet.", 30, 3510),
  ("Livraison intermédiaire.", 40, 4680),
  ("Validation finale.", 30, 3510),
))

#propal-offer-validity("30 septembre 2026")

Les facturations seront établies mensuellement sur la base des jours de développement effectués par la société EdgeMind.

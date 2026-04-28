// =============================================================================
// EdgeMind x ATOS - Presentation
// Reproduction of "EdgeMind 2026-03-09 ATOS.pdf" using the edgemind-theme
// =============================================================================

#import "@preview/touying:0.6.2": *
#import "edgemind-theme.typ": *

#show: edgemind-theme.with(
  aspect-ratio: "16-9",
  logo: image("../logos/logo_edgemind_hz.png", height: 2.5em),
)

// ============================================================
// Slide 1: Title slide
// ============================================================

#title-slide(
  logo: image("../logos/logo_edgemind_original.png", height: 8em),
  // Add illustration here when available, e.g.:
  // illustration: image("images/brain-gears.png", height: 5em),
)

// ============================================================
// Slide 2: Section - Presentation de l'entreprise
// ============================================================

#section-slide("Presentation de l'entreprise")

// ============================================================
// Slide 3: Notre metier
// ============================================================

#content-slide(title: "NOTRE METIER")[
  #v(1em)
  #align(center, {
    let pill(body) = box(
      inset: (x: 2em, y: 0.8em),
      radius: 2em,
      fill: em-light-blue.lighten(40%),
      text(size: 14pt, fill: em-blue, weight: "semibold", upper(body))
    )
    pill[
      Developper des #hl[modeles] pour \
      #hl[simuler] et #hl[analyser] les #hl[systemes industriels critiques]
    ]
    v(0.8em)
    pill[
      Valoriser les #hl[donnees operationnelles] \
      et capitaliser #hl[l'expertise]
    ]
    v(0.8em)
    pill[
      #hl[Maitriser] les risques pour #hl[securiser] les systemes et \
      #hl[optimiser] leur performance
    ]
  })
]

// ============================================================
// Slide 4: Notre identite
// ============================================================

#content-slide(
  title: "NOTRE IDENTITE",
  side-image: image("../logos/logo_edgemind_only.svg", width: 100%),
  side-image-width: 30%,
)[
  #v(0.5em)
  #let badge(icon, body) = box(
    inset: (x: 1.5em, y: 0.6em),
    radius: 0.5em,
    fill: em-light-blue.lighten(40%),
    text(size: 12pt, fill: em-blue, weight: "semibold", upper(body))
  )

  #badge(none)[Societe d'ingenierie en \ modelisation systeme et data science]
  #v(0.4em)
  #badge(none)[Reactivite, agilite \ et proximite]
  #v(0.4em)
  #badge(none)[Developpement de \ solutions sur-mesure]
  #v(0.4em)
  #badge(none)[Experience operationnelle \ et industrielle]
  #v(0.4em)
  #badge(none)[Culture de l'innovation et \ des solutions opensource]
]

// ============================================================
// Slide 5: Notre equipe
// ============================================================

#team-slide(
  title: "NOTRE EQUIPE",
  members: (
    (name: "Roland", role: "Docteur - Fondateur", tags: ("MBSE/MBSA", "Simulation Systeme", "Dev Scientifiques", "Machine Learning")),
    (name: "Thomas", role: "Docteur - Fondateur", tags: ("Architecte Logiciel", "Qualification", "Assurance Qualite", "Optimisation")),
    (name: "Gurvan", role: "Ingenieur Senior", tags: ("Dev Full-Stack", "Data Management", "UI/UX", "Architecte Logiciel")),
    (name: "Loic", role: "Ingenieur Confirme", tags: ("MBSE/MBSA", "Dev Frontend")),
    (name: "Helene", role: "Master Maths. Appli.", tags: ("MBSE/MBSA", "Dev Scientifiques")),
    (name: "Thomas", role: "Ingenieur Confirme", tags: ("Dev Full-Stack", "Optimisation", "UI/UX")),
    (name: "Mohamed", role: "Apprentis Developpeur", tags: ("Dev Frontend",)),
  ),
)

// ============================================================
// Slide 6: Section - Enjeux autour des systemes critiques
// ============================================================

#section-slide("Enjeux autour des systemes critiques")

// ============================================================
// Slide 7: Systemes critiques - Cadrage
// ============================================================

#content-slide(
  title: "SYSTEMES CRITIQUES",
  subtitle: "CADRAGE",
)[
  *#hl[Importance strategique]* \
  Systemes dont la defaillance peut entrainer des
  consequences majeures sur l'economie, la sante
  publique, la securite ou l'environnement

  #v(0.6em)
  *#hl[Complexite]* \
  Systemes dynamiques souvent constitues de
  nombreux composants interdependants,
  potentiellement redondes

  #v(0.6em)
  *#hl[Reglementation]* \
  Systemes generalement soumis a des
  reglementations/normes strictes afin de
  garantir leur fiabilite et securite
]

// ============================================================
// Slide 8: Systemes critiques - Enjeux industriels
// ============================================================

#content-slide(
  title: "SYSTEMES CRITIQUES",
  subtitle: "ENJEUX INDUSTRIELS",
)[
  *#hl[Gestion de la complexite]*
  - Comprendre les interactions entre les composants du systeme
  - Anticiper le comportement dynamique et partiellement aleatoire des composants

  #v(0.4em)
  *#hl[Maintien en conditions operationnelles]*
  - Assurer un haut niveau de disponibilite et de performance
  - Optimiser les politiques de maintenance

  #v(0.4em)
  *#hl[Securite et resilience]*
  - Resister aux agressions internes et externes
  - Minimiser l'impact des defaillances
]

// ============================================================
// Slide 9: Section - Approche MBSE-MBSA
// ============================================================

#section-slide("Approche MBSE-MBSA")

// ============================================================
// Slide 10: Approche MBSE/MBSA - Principes (diagram)
// ============================================================

#diagram-slide(
  title: "APPROCHE MBSE/MBSA",
  subtitle: "PRINCIPES",
)[
  // Placeholder for the MBSE/MBSA principles diagram
  // Replace with: image("images/mbse-principes.png", width: 90%)
  #box(
    width: 90%,
    height: 70%,
    fill: em-light-gray,
    radius: 1em,
    align(center + horizon,
      text(fill: em-gray, size: 14pt)[
        _Diagramme : Specifications du systeme (MBSE) + AMDEC/HAZOP (MBSA) \
        → Modelisation fonctionnelle et dysfonctionnelle \
        → Modele systeme MBSE/MBSA \
        → Generation automatique → Analyse quantitative_
      ]
    )
  )
]

// ============================================================
// Slide 11: Approche MBSE/MBSA - Interets et avantages
// ============================================================

#content-slide(
  title: "APPROCHE MBSE/MBSA",
  subtitle: "INTERETS ET AVANTAGES",
)[
  - Approche holistique (fonc/dysfonc) proche
    de l'architecture du systeme physique

  - Modelisation top-down afin de faciliter
    la gestion de la complexite

  - Capitalisation des expertises metiers

  - Augmente la maintenabilite et diminue les
    couts de modelisation dans la duree

  - La technique de modelisation s'adapte au
    systeme et non l'inverse
]

// ============================================================
// Slide 12: Methodologie MBSE/MBSA (diagram)
// ============================================================

#diagram-slide(
  title: "METHODOLOGIE MBSE/MBSA",
  subtitle: "APERCU DE LA DEMARCHE GENERALE",
)[
  // Placeholder for the methodology pipeline diagram
  // Replace with: image("images/methodologie-mbse.png", width: 95%)
  #box(
    width: 95%,
    height: 65%,
    fill: em-light-gray,
    radius: 1em,
    align(center + horizon,
      text(fill: em-gray, size: 14pt)[
        _Pipeline : Analyse des besoins → Modelisation generique \
        → Construction du modele systeme → Valorisation du modele_
      ]
    )
  )
]

// ============================================================
// Slide 13: Section - ATOS x EDGEMIND
// ============================================================

#section-slide("ATOS x EDGEMIND")

// ============================================================
// Slide 14: Ce qu'apporte EdgeMind
// ============================================================

#content-slide(
  title: "ATOS x EDGEMIND",
  subtitle: "CE QU'APPORTE EDGEMIND",
)[
  - Une expertise de niche en modelisation et
    simulation MBSE-MBSA

  - La capacite a realiser des etudes systeme :
    production de KPI decisionnels, comparaison
    d'architectures, dimensionnement, etudes FMDS

  - Des competences sur la capitalisation et exploitation
    du REX pour alimenter les modele MBSE-MBSA

  - Une plateforme logicielle outillant notre vision
    MBSE-MBSA (en cours de developpement)
]

// ============================================================
// Slide 15: Ce qu'apporte ATOS
// ============================================================

#content-slide(
  title: "ATOS x EDGEMIND",
  subtitle: "CE QU'APPORTE ATOS",
)[
  - Un acces aux grands donneurs d'ordres et aux
    accords-cadres structurants dans l'industrie

  - Des projets d'ingenierie systeme et de surete de
    fonctionnement a forte complexite adaptes aux
    approches MBSE-MBSA

  - Une capacite de deploiement a grande echelle pour
    accompagner l'industrialisation de notre outil de
    modelisation

  - Une expertise cyber de pointe pour developper la
    dimension cybersecurite dans les analyses MBSE-MBSA
]

// ============================================================
// Slide 16: Ce que le partenariat cree
// ============================================================

#content-slide(
  title: "ATOS x EDGEMIND",
  subtitle: "CE QUE LE PARTENARIAT CREE",
)[
  - *Projets :* une offre d'ingenierie systeme differenciante
    avec des modeles qui capitalisent la connaissance et
    produisent des resultats quantitatifs

  - *Outil :* l'industrialisation et la diffusion de nouveaux
    outils de reference MBSE-MBSA conjoints

  - *R&D :* des travaux communs sur l'integration de la
    cybersecurite dans les modeles MBSE-MBSA

  - *Croissance :* un partenariat qui accompagne le
    developpement d'EdgeMind tout en contribuant a
    renforcer le positionnement innovant d'Atos
]

// ============================================================
// Slide 17: Section - Services
// ============================================================

#section-slide("Services")

// ============================================================
// Slide 18: Nos services
// ============================================================

#content-slide(
  title: "NOS SERVICES",
)[
  - Developpement et MCO de librairies de
    modelisation MBSE

  - Developpement et MCO de modeles systemes
    simulables (MBSE+MBSA)

  - Analyse et preparation des donnees d'entree
    pour les modeles

  - Realisation d'etudes systemes (FMDS, SdF, etc.)

  - Developpement et MCO d'outils sur-mesure
    d'exploitation des modeles
]

// ============================================================
// Slide 19: Modes de collaboration (diagram)
// ============================================================

#diagram-slide(
  title: "MODES DE COLLABORATION",
)[
  // Placeholder for the 3-column collaboration modes diagram
  // Replace with: image("images/modes-collaboration.png", width: 95%)
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 1em,
    {
      let col-box(title-text, items, duration) = box(
        width: 100%,
        inset: 1.2em,
        radius: 1em,
        fill: em-light-blue.lighten(50%),
        {
          align(center,
            box(
              inset: (x: 1em, y: 0.5em),
              radius: 1.5em,
              fill: em-blue.lighten(10%),
              text(size: 11pt, fill: white, weight: "bold", style: "italic", upper(title-text))
            )
          )
          v(0.6em)
          set text(size: 9pt, fill: em-blue)
          items
          v(0.5em)
          align(center,
            box(
              inset: (x: 0.8em, y: 0.3em),
              radius: 0.5em,
              fill: em-light-gray,
              text(size: 8pt, fill: em-gray, duration)
            )
          )
        }
      )
      col-box("Proof of Concept", [
        Developpement d'un *prototype operationnel*
        repondant a un besoin metier sur un perimetre limite

        Definition des *objectifs* de l'analyse MBSE/MBSA a mettre en oeuvre

        Evaluation des *approches techniques* envisageables
      ], "Realisation : 2 a 6 mois")
    },
    {
      let col-box(title-text, items, duration) = box(
        width: 100%,
        inset: 1.2em,
        radius: 1em,
        fill: em-light-blue.lighten(50%),
        {
          align(center,
            box(
              inset: (x: 1em, y: 0.5em),
              radius: 1.5em,
              fill: em-blue.lighten(10%),
              text(size: 11pt, fill: white, weight: "bold", style: "italic", upper(title-text))
            )
          )
          v(0.6em)
          set text(size: 9pt, fill: em-blue)
          items
          v(0.5em)
          align(center,
            box(
              inset: (x: 0.8em, y: 0.3em),
              radius: 0.5em,
              fill: em-light-gray,
              text(size: 8pt, fill: em-gray, duration)
            )
          )
        }
      )
      col-box("Projets Pilotes Agiles", [
        Elargissement du perimetre des modeles developpes

        Realisation d'etudes et evaluation du *ROI metier*

        Etude d'opportunite pour l'industrialisation de la solution
      ], "Realisation : 6 a 24 mois")
    },
    {
      let col-box(title-text, items, duration) = box(
        width: 100%,
        inset: 1.2em,
        radius: 1em,
        fill: em-light-blue.lighten(50%),
        {
          align(center,
            box(
              inset: (x: 1em, y: 0.5em),
              radius: 1.5em,
              fill: em-blue.lighten(10%),
              text(size: 11pt, fill: white, weight: "bold", style: "italic", upper(title-text))
            )
          )
          v(0.6em)
          set text(size: 9pt, fill: em-blue)
          items
          v(0.5em)
          align(center,
            box(
              inset: (x: 0.8em, y: 0.3em),
              radius: 0.5em,
              fill: em-light-gray,
              text(size: 8pt, fill: em-gray, duration)
            )
          )
        }
      )
      col-box("Deploiement et Industrialisation", [
        Deploiement de l'approche dans votre organisation

        Accompagnement de l'*integration* des solutions technique dans votre *SI*

        *Securisation* des investissements en assurant la MCO de la solution
      ], "A estimer selon situations")
    },
  )
]

// ============================================================
// Slide 20: Section - Contact
// ============================================================

#section-slide("Contact")

// ============================================================
// Slide 21: Contact slide
// ============================================================

#contact-slide(
  title: [Des projets, des questions, \ discutons-en !],
  name: "Roland DONAT",
  phone: "+33 (0) 6 28 22 69 34",
  email: "roland.donat@edgemind.net",
)

// EdgeMind Report Template for Typst
// Based on edgemind-report.cls LaTeX class
// Version 1.0 - 2026-01-06

// EdgeMind Color Definitions (converted from CMYK to RGB using standard formula)
// Formula: R = 255 × (1-C) × (1-K), G = 255 × (1-M) × (1-K), B = 255 × (1-Y) × (1-K)
#let em-logo-blue = rgb(17, 65, 109)      // CMYK: 0.96, 0.75, 0.30, 0.18 → #11416D
#let em-logo-orange = rgb(239, 123, 38)   // CMYK: 0.00, 0.61, 0.90, 0.00 → #EF7B26
#let em-grey = rgb(201, 212, 230)         // CMYK: 0.21, 0.17, 0.10, 0.00 → #C9D4E6
#let em-brown-light = rgb(163, 115, 65)   // CMYK: 0.25, 0.47, 0.75, 0.15 → #A37341
#let em-red = rgb(161, 0, 16)             // CMYK: 0.21, 1.00, 0.92, 0.14 → #A10010
#let em-brown = rgb(76, 0, 10)            // CMYK: 0.34, 1.00, 0.91, 0.55 → #4C000A

// Title-page block: optional image framed by partner logos.
// n logos: ceil(n/2) in the left column and the rest in the right one, at most 4
// per column; any remainder goes to a row below.
#let cover-block(img, img-width, logos, logo-height, logo-width) = {
  let logo(path) = box(width: logo-width, height: logo-height,
    align(center + horizon, image(path, width: 100%, height: 100%, fit: "contain")))
  let row(paths) = if paths.len() > 0 {
    v(0.6em)
    stack(dir: ltr, spacing: 1.5em, ..paths.map(logo))
  }
  if img == none {
    return row(logos)
  }
  let nl = calc.min(calc.ceil(logos.len() / 2), 4)
  let nr = calc.min(logos.len() - nl, 4)
  let left = logos.slice(0, nl)
  let right = logos.slice(nl, nl + nr)
  let rest = logos.slice(nl + nr)
  let side = nl
  if side == 0 {
    image(img, width: img-width)
  } else {
    // The side columns spread their logos over the height of the image.
    layout(size => {
      let w = if type(img-width) == ratio { img-width * size.width } else { img-width }
      let h = measure(image(img, width: w)).height
      let column(paths) = block(height: h, stack(dir: ttb, spacing: 1fr, ..paths.map(logo)))
      grid(
        columns: (1fr, w, 1fr),
        column-gutter: 1em,
        align: center + horizon,
        column(left),
        image(img, width: w),
        column(right),
      )
    })
  }
  row(rest)
}

#let abstract-block(abstract) = block(
  width: 100%,
  inset: (x: 2em, y: 1em),
  align(left)[
    #text(weight: "bold")[Résumé]
    #par(leading: 0.5em, spacing: 1em, justify: true)[#abstract]
  ],
)

// Main template function
#let edgemind-report(
  // Document metadata
  title: "Document Title",
  subtitle: none,
  author: "Author Name",
  date: datetime.today().display("[day]/[month]/[year]"),
  version: "1.0",
  verif: none,

  // Customer/Project references
  customer: "Client",
  ref-customer: none,
  ref-edgemind: "EM-RYYYYXXX",

  // Optional elements
  abstract: none,
  // false moves the abstract to the top of the page after the title page,
  // for a title page already filled by an image and partner logos.
  abstract-on-cover: true,
  title-image: none,
  title-image-width: 60%, // percentage of text width

  // Optional partner logos on the title page, e.g. the subscribers of a
  // collaborative project. With a title image they frame it: one column on
  // each side, the remainder in a row below. Without one they form a
  // centred row. Paths follow the same rule as the logos below.
  cover-logos: (),
  cover-logo-height: 1.1cm,
  cover-logo-width: 2.6cm, // every logo fits this box: equal visual weight

  // Logos (paths to image files)
  // IMPORTANT: Paths must be relative to your .typ document location, NOT this template file
  // Example: if your document is in official_docs/report/, use "../../logos/logo_edgemind_original.png"
  // Example: if your document is in projects/myreport/, use relative path to logos directory
  // TIP: Create symlinks in your document directory for easier path management
  logo-left: "../../logos/logo_edgemind_original.png",
  logo-left-height: 2.5cm,
  logo-right: none,
  logo-right-height: 2.5cm,

  // Footer logo (also relative to your document location)
  logo-footer: "../../logos/logo_edgemind_hz.png",

  // Bibliography settings (optional)
  // If provided, bibliography will be configured with EdgeMind styling
  bibliography-file: none,
  bibliography-title: "Références",
  bibliography-style: "ieee", // Options: "ieee", "apa", "chicago-author-date", etc.

  // Document body
  body
) = {

  // Page setup
  set page(
    paper: "a4",
    margin: (
      top: 2.25cm,
      bottom: 2.25cm,
      left: 2.5cm,
      right: 2.5cm
    ),

    // Header
    header: context {
      let page-num = counter(page).get().first()
      if page-num > 1 {
        line(length: 100%, stroke: 0.5pt)
      }
    },

    // Footer
    footer: context {
      let page-num = counter(page).get().first()
      // Footer layout: logo left, page center, version right
      grid(
        columns: (1fr, 1fr, 1fr),
        align: (left + horizon, center + horizon, right + horizon),

        // Left: EdgeMind logo
        if logo-footer != none {
          image(logo-footer, height: 0.7cm)
        } else {
          []
        },

        // Center: Page number
        text(size: 7pt)[
          #smallcaps[Page #text(fill: em-logo-orange)[#page-num] / #text(fill: em-logo-blue)[#counter(page).final().first()]]
        ],

        // Right: Version
        text(size: 7pt)[
          #smallcaps[Version #text(fill: em-logo-orange)[#version]]
        ]
      )
    }
  )

  // Text settings
  set text(
    font: "Open Sans",
    size: 11pt,
    lang: "fr",
    fallback: true
  )

  // Paragraph settings
  set par(
    justify: true,
    leading: 0.65em,
    spacing: 2em,
    first-line-indent: 0pt
  )

  // Heading settings
  set heading(numbering: "1.1")

  // Table of contents styling (outline): match heading colors (H1 + H2 in blue)
  show outline.entry.where(level: 1): it => {
    text(fill: em-logo-orange, weight: "bold")[#it]
  }

  show outline.entry.where(level: 2): it => {
    text(fill: em-logo-blue)[#it]
  }

  // Default outline title + depth. The unoutlined level-1 heading used for
  // this title is styled via its dedicated `heading.where(outlined: false)`
  // rule below (generous spacing before entries).
  set outline(
    title: [Table des matières],
    depth: 2,
  )

  // Chapter style (level 1 headings, outlined — regular chapters): orange
  show heading.where(level: 1, outlined: true): it => {
    pagebreak(weak: true)
    block(
      above: 2em,
      below: 1.5em,
      {
        text(size: 24pt, weight: "bold", fill: em-logo-orange)[
          #if it.numbering != none {
            counter(heading).display()
            h(0.5em)
            text(fill: rgb(75%, 75%, 75%))[|]
            h(0.5em)
          }
          #it.body
        ]
      }
    )
  }

  // Outline title (unoutlined level-1 heading): blue 24pt, generous spacing
  // below. NOTE: the block's own `below:` is absorbed by the heading layout
  // in this context, so we emit an explicit non-weak `v()` after the block
  // to reliably create the gap before the TOC entries.
  show heading.where(level: 1, outlined: false): it => {
    block(above: 2em)[
      #text(size: 24pt, weight: "bold", fill: em-logo-orange)[#it.body]
    ]
    v(40pt, weak: false)
  }

  // Section style (level 2 headings)
  show heading.where(level: 2): it => {
    block(
      above: 1.5em,
      below: 1em,
      text(size: 16pt, weight: "bold", fill: em-logo-blue)[
        #if it.numbering != none {
          counter(heading).display()
          h(0.5em)
        }
        #it.body
      ]
    )
  }

  // Subsection style (level 3 headings)
  show heading.where(level: 3): it => {
    block(
      above: 2em,
      below: 0.75em,
      text(size: 13pt, weight: "bold")[
        #if it.numbering != none {
          counter(heading).display()
          h(0.5em)
        }
        #it.body
      ]
    )
  }

  // List settings (use dashes like in LaTeX class)
  set list(marker: [--])

  // A list stays close to the sentence that introduces it (usually ending
  // with a colon): small gap above, regular paragraph gap below.
  show list: set block(above: 0.7em)
  show enum: set block(above: 0.7em)

  // Figures: force full "Figure" word for both captions and references
  // (Typst's French locale would otherwise abbreviate references to "Fig.").
  set figure(supplement: [Figure])
  show figure.where(kind: table): set figure(supplement: [Table])

  // Allow figures (especially large tables) to break across pages
  show figure: set block(breakable: true)

  // Captions: bold supplement + number + ". ", then body in regular weight
  // Renders as: "Figure 1. Caption text"
  show figure.caption: it => {
    text(size: 9pt)[
      #text(weight: "bold")[#it.supplement #it.counter.display(it.numbering).] #it.body
    ]
  }

  // --- Title Page ---
  page(
    margin: (top: 2.25cm, bottom: 2.25cm, left: 2.5cm, right: 2.5cm),
    header: none,
    footer: align(center)[
      #par(leading: 0.3em)[
        #text(size: 5pt, weight: "bold")[
          #text(fill: em-logo-blue)[Edge]#text(fill: em-logo-orange)[Mind] - 23 rue du Départ, Boite 37, 75014 Paris
        ]
        #linebreak()
        #text(size: 5pt)[
          Société à Actions Simplifiée au capital de 10000€ - R.C.S. Paris - SIRET : 799 582 945 00017 / APE : 7022Z
        ]
      ]
    ]
  )[
    // Logos row
    #grid(
      columns: (1fr, 1fr),
      align: (left, right),

      // Left logo
      if logo-left != none {
        image(logo-left, height: logo-left-height)
      },

      // Right logo
      if logo-right != none {
        image(logo-right, height: logo-right-height)
      }
    )

    #v(1%)

    // Title (orange, smallcaps). Not justified: a long title wrapped on
    // several centred lines must keep regular word spacing.
    #align(center)[
      #set par(justify: false)
      #text(size: 28pt, weight: "bold", fill: em-logo-orange)[
        #smallcaps(title)
      ]

      // Subtitle (if provided) — blue
      #if subtitle != none {
        v(0.5em)
        text(size: 18pt, weight: "bold", fill: em-logo-blue)[
          #subtitle
        ]
      }

      // Optional title image, framed by the partner logos if any
      #if title-image != none or cover-logos.len() > 0 {
        v(1em)
        cover-block(title-image, title-image-width, cover-logos, cover-logo-height, cover-logo-width)
      }

      #v(1%)

      // Abstract (if provided)
      #if abstract != none and abstract-on-cover {
        abstract-block(abstract)
        v(1%)
      }

      // Metadata table
      #block(
        stroke: 0.1pt,
        inset: 0pt,
        table(
          columns: (auto, 1fr),
          align: (right, left),
          stroke: none,
          inset: 8pt,

          smallcaps[Auteur(s) :], author,

          // Verificateur (if provided)
          ..if verif != none {
            (smallcaps[Vérificateur :], verif)
          } else {
            ()
          },

          table.hline(stroke: 0.1pt), // separator

          smallcaps[Date :], date,
          smallcaps[Version :], text(fill: em-logo-orange)[#version],

          table.hline(stroke: 0.1pt), // separator

          // Reference customer (if provided)
          ..if ref-customer != none {
            (smallcaps[Référence #customer :], ref-customer)
          } else {
            ()
          },

          smallcaps[Référence EdgeMind :], ref-edgemind,
        )
      )
    ]
  ]

  // Reset page counter for main content
  counter(page).update(1)

  // Abstract moved off the title page: first thing of the main content
  if abstract != none and not abstract-on-cover {
    abstract-block(abstract)
  }

  // Reset heading counter (in case document starts with H2)
  counter(heading).update(0)

  // Configure bibliography if provided
  if bibliography-file != none {
    set bibliography(
      title: bibliography-title,
      style: bibliography-style
    )
  }

  // Tables: header row on the EdgeMind grey, bold blue text, light rules.
  // Set after the title page so that its metadata table keeps its own layout.
  set table(
    fill: (x, y) => if y == 0 { rgb("#c9d4e6") },
    stroke: 0.5pt + rgb("#9aa8bf"),
  )
  show table.cell.where(y: 0): set text(weight: "bold", fill: rgb("#1f416d"))

  // Document body
  body
}

// Example usage (commented out - uncomment to test):
/*
#show: edgemind-report.with(
  title: "Example Report Title",
  author: "John Doe",
  date: "06/01/2026",
  version: "1.0",
  customer: "Apple",
  ref-customer: "AAPL-2026-001",
  ref-edgemind: "EM-R2026001",
  abstract: [
    This is an example abstract for the EdgeMind report template.
    It demonstrates the layout and formatting of the title page.
  ],
  // logo-left: "logo_edgemind_original.png",
  // logo-right: "partner_logo.png",
)

= Introduction

This is the introduction chapter.

== Section Example

Some content here.

=== Subsection Example

More detailed content.

- Item one
- Item two
- Item three

= Second Chapter

More content follows...
*/

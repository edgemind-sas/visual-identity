// EdgeMind Propal Template for Typst
// Port from Google Docs-based Propositions Techniques et Commerciales
// Version 1.0 - 2026-04-17
//
// Brand tokens mirror those declared in ../report/edgemind-report.typ.
// They are duplicated here so `typst compile` works without --root.
// If a brand color ever changes, update both files.

// EdgeMind brand colors (converted from CMYK to RGB with standard formula)
#let em-logo-blue = rgb(17, 65, 109)      // #11416D
#let em-logo-orange = rgb(239, 123, 38)   // #EF7B26
#let em-grey = rgb(201, 212, 230)         // #C9D4E6
#let em-brown-light = rgb(163, 115, 65)   // #A37341
#let em-red = rgb(161, 0, 16)             // #A10010
#let em-brown = rgb(76, 0, 10)            // #4C000A

// ============================================================
// Propal-specific design tokens
// ============================================================

// Table styling
#let propal-table-header-fill = em-grey.lighten(30%)
#let propal-table-total-fill = em-grey

// Timeline cell intensity (3 thresholds on UO / jours)
#let propal-timeline-cell-light = em-logo-orange.lighten(85%)  // 0 < UO < 1
#let propal-timeline-cell-medium = em-logo-orange.lighten(65%) // 1 <= UO < 3
#let propal-timeline-cell-strong = em-logo-orange.lighten(40%) // UO >= 3

// Utility: pick a timeline cell fill based on UO value
#let _timeline-fill(v) = {
  if v == none or v == "" { white }
  else if type(v) == str and v == "" { white }
  else {
    let x = if type(v) == str { float(v) } else { float(v) }
    if x <= 0 { white }
    else if x < 1 { propal-timeline-cell-light }
    else if x < 3 { propal-timeline-cell-medium }
    else { propal-timeline-cell-strong }
  }
}

// Utility: format a number FR-style (comma decimal, space thousands)
#let _fmt-num(x, decimals: 2) = {
  if x == none { return "" }
  let n = if type(x) == str { float(x) } else { float(x) }
  let s = str(calc.round(n, digits: decimals))
  // Replace dot with comma
  s = s.replace(".", ",")
  s
}

// Utility: format a currency amount FR-style
#let _fmt-currency(x, currency: "€", decimals: 2) = {
  if x == none { return "" }
  let n = if type(x) == str { float(x) } else { float(x) }
  let rounded = calc.round(n, digits: decimals)
  let int-part = calc.floor(rounded)
  let frac = calc.round((rounded - int-part) * calc.pow(10, decimals))
  // Thousands separator (narrow no-break space U+202F)
  let int-str = str(int-part)
  let grouped = ""
  let i = int-str.len()
  while i > 3 {
    grouped = " " + int-str.slice(i - 3, i) + grouped
    i = i - 3
  }
  grouped = int-str.slice(0, i) + grouped
  // Decimal part
  let frac-str = str(frac)
  while frac-str.len() < decimals { frac-str = "0" + frac-str }
  grouped + "," + frac-str + " " + currency
}

// ============================================================
// Main template function
// ============================================================

#let edgemind-propal(
  // Required metadata
  title: "Titre de la proposition",
  date: datetime.today().display("[day]/[month]/[year]"),
  version: "1.0",
  ref-edgemind: "EM-PTC-YYYY-XXX",

  // Optional metadata
  subtitle: "Proposition Technique et Commerciale",
  authors: none,            // none, string, or array of strings
  customer: none,           // used as label prefix: "Reference <customer> :"
  ref-customer: none,

  // Logos (paths relative to the user's .typ file)
  logo-left: "logos/logo_edgemind_original.png",
  logo-left-height: 2.5cm,
  logo-right: none,
  logo-right-height: 2.5cm,

  // Localization
  lang: "fr",

  // Bibliography (optional, inherited from report pattern)
  bibliography-file: none,
  bibliography-title: "Références",
  bibliography-style: "ieee",

  // Document body
  body,
) = {

  // Page setup
  set page(
    paper: "a4",
    margin: (top: 2.25cm, bottom: 2.25cm, left: 2.5cm, right: 2.5cm),

    // Top rule on pages after the title page
    header: context {
      let page-num = counter(page).get().first()
      if page-num > 1 {
        line(length: 100%, stroke: 0.5pt)
      }
    },

    // Three-column footer: EdgeMind S.A.S. / Page X/Y / Version X.Y
    footer: context {
      let page-num = counter(page).get().first()
      grid(
        columns: (1fr, 1fr, 1fr),
        align: (left + horizon, center + horizon, right + horizon),

        // Left: EdgeMind S.A.S. in smallcaps
        text(size: 7pt)[
          #smallcaps[
            #text(fill: em-logo-blue)[Edge]#text(fill: em-logo-orange)[Mind] S.A.S.
          ]
        ],

        // Center: Page N/Total
        text(size: 7pt)[
          #smallcaps[
            Page #text(fill: em-logo-orange)[#page-num] / #text(fill: em-logo-blue)[#counter(page).final().first()]
          ]
        ],

        // Right: Version
        text(size: 7pt)[
          #smallcaps[
            Version #text(fill: em-logo-orange)[#version]
          ]
        ],
      )
    },
  )

  // Text settings
  set text(
    font: "Open Sans",
    size: 11pt,
    lang: lang,
    fallback: true,
  )

  // Paragraph settings
  set par(
    justify: true,
    leading: 0.65em,
    spacing: 1.2em,
    first-line-indent: 0pt,
  )

  // Heading numbering
  set heading(numbering: "1.1.")

  // Outline (TOC) styling - level 1 bold orange, level 2 blue (matching headings)
  show outline.entry.where(level: 1): it => {
    v(0.4em, weak: true)
    text(fill: em-logo-orange, weight: "bold")[#it]
  }
  show outline.entry.where(level: 2): it => {
    text(fill: em-logo-blue)[#it]
  }

  // Default outline title + depth. Spacing below the title is handled by the
  // `heading.where(outlined: false)` show rule below so it does not clash with
  // the regular level-1 heading rule.
  set outline(
    title: [Table des matières],
    depth: 2,
  )

  // Heading level 1 (outlined — regular chapters): orange 22pt, new page
  show heading.where(level: 1, outlined: true): it => {
    pagebreak(weak: true)
    block(above: 2em, below: 1.2em)[
      #text(size: 22pt, weight: "bold", fill: em-logo-orange)[
        #if it.numbering != none {
          counter(heading).display()
          h(1em)
        }
        #it.body
      ]
    ]
  }

  // Heading level 1 (unoutlined — outline title): orange 24pt, generous
  // spacing below. NOTE: the block's own `below:` is absorbed by the heading
  // layout in this context, so we emit an explicit non-weak `v()` after the
  // block to reliably create the gap before the TOC entries.
  show heading.where(level: 1, outlined: false): it => {
    block(above: 2em)[
      #text(size: 24pt, weight: "bold", fill: em-logo-orange)[#it.body]
    ]
    v(40pt, weak: false)
  }

  // Heading level 2: blue 16pt
  show heading.where(level: 2): it => {
    block(above: 1.4em, below: 0.8em)[
      #text(size: 16pt, weight: "bold", fill: em-logo-blue)[
        #if it.numbering != none {
          counter(heading).display()
          h(0.8em)
        }
        #it.body
      ]
    ]
  }

  // Heading level 3: black 12pt bold
  show heading.where(level: 3): it => {
    block(above: 1em, below: 0.5em)[
      #text(size: 12pt, weight: "bold")[
        #if it.numbering != none {
          counter(heading).display()
          h(0.5em)
        }
        #it.body
      ]
    ]
  }

  // Lists use dashes
  set list(marker: [--])

  // Figures and tables: force full "Figure" word for both captions and refs
  // (Typst's French locale would otherwise abbreviate references to "Fig.").
  // EdgeMind uses "Table" (English) for tables historically.
  set figure(supplement: [Figure])
  show figure.where(kind: table): set figure(supplement: [Table])

  // Allow figures (especially large tables) to break across pages
  show figure: set block(breakable: true)

  // Captions: bold supplement + number, then body in regular weight
  show figure.caption: it => {
    text(size: 9pt)[
      #text(weight: "bold")[#it.supplement #it.counter.display(it.numbering).] #it.body
    ]
  }

  // ============================================================
  // Title page
  // ============================================================
  page(
    margin: (top: 2.25cm, bottom: 2.25cm, left: 2.5cm, right: 2.5cm),
    header: none,
    footer: align(center)[
      #par(leading: 0.3em)[
        #text(size: 6pt, weight: "bold")[
          #text(fill: em-logo-blue)[Edge]#text(fill: em-logo-orange)[Mind] - 23 rue du Départ, Boite 37, 75014 Paris
        ]
        #linebreak()
        #text(size: 6pt)[
          Société à Actions Simplifiée au capital de 10000 € - R.C.S. Paris - SIRET : 799 582 945 00017 / APE : 7022Z
        ]
      ]
    ],
  )[
    // Logos row
    #grid(
      columns: (1fr, 1fr),
      align: (left + top, right + top),
      column-gutter: 1em,

      if logo-left != none { image(logo-left, height: logo-left-height) } else { [] },
      if logo-right != none { image(logo-right, height: logo-right-height) } else { [] },
    )

    #v(15%)

    // Title (orange, centered, bold)
    #align(center)[
      #text(size: 30pt, weight: "bold", fill: em-logo-orange)[#title]
    ]

    #v(1em)

    // Subtitle
    #if subtitle != none {
      align(center)[
        #text(size: 18pt)[#subtitle]
      ]
    }

    #v(15%)

    // Metadata table
    #align(center)[
      #block(
        width: 85%,
        stroke: 0.5pt,
        inset: 0pt,
        table(
          columns: (auto, auto, 1fr),
          align: (left + horizon, center + horizon, left + horizon),
          stroke: none,
          inset: 10pt,

          // Authors (optional)
          ..if authors != none {
            let authors-str = if type(authors) == array {
              authors.join(", ")
            } else {
              authors
            }
            (smallcaps[#upper[Auteurs]], [:], authors-str)
          } else {
            ()
          },

          smallcaps[#upper[Date]], [:], date,
          smallcaps[#upper[Version]], [:], text(fill: em-logo-orange)[#version],

          // Reference customer (optional)
          ..if ref-customer != none {
            let label = if customer != none {
              smallcaps[#upper[#customer Réf.]]
            } else {
              smallcaps[#upper[Référence client]]
            }
            (label, [:], ref-customer)
          } else if customer != none {
            (smallcaps[#upper[#customer Réf.]], [:], [])
          } else {
            ()
          },

          smallcaps[#upper[EdgeMind Réf.]], [:], ref-edgemind,
        ),
      )
    ]
  ]

  // Reset page and heading counters for the body
  counter(page).update(1)
  counter(heading).update(0)

  // Bibliography configuration (optional)
  if bibliography-file != none {
    set bibliography(
      title: bibliography-title,
      style: bibliography-style,
    )
  }

  // ============================================================
  // Document body
  // ============================================================
  body
}

// ============================================================
// Helpers: simple tables (Phase 2)
// ============================================================

// Glossary: two-column table (Term / Definition)
#let propal-glossary(entries, caption: "Vocabulaire technique employé dans ce document.") = {
  figure(
    caption: caption,
    table(
      columns: (auto, 1fr),
      align: (left + horizon, left + horizon),
      stroke: 0.5pt,
      inset: 6pt,

      table.header(
        table.cell(fill: propal-table-header-fill)[*Terme*],
        table.cell(fill: propal-table-header-fill)[*Signification*],
      ),

      ..entries.map(e => {
        let term = if type(e) == dictionary { e.at("term") } else { e.at(0) }
        let definition = if type(e) == dictionary { e.at("definition") } else { e.at(1) }
        ([#term], [#definition])
      }).flatten(),
    ),
  )
}

// Lots: three-column table (#Lot / Lot / Description)
#let propal-lots(lots, caption: "Lotissement proposé.") = {
  figure(
    caption: caption,
    table(
      columns: (auto, auto, 1fr),
      align: (left + horizon, left + horizon, left + horizon),
      stroke: 0.5pt,
      inset: 6pt,

      table.header(
        table.cell(fill: propal-table-header-fill)[*\#*],
        table.cell(fill: propal-table-header-fill)[_Lot_],
        table.cell(fill: propal-table-header-fill)[Description],
      ),

      ..lots.map(l => {
        let id = if type(l) == dictionary { l.at("id") } else { l.at(0) }
        let name = if type(l) == dictionary { l.at("name") } else { l.at(1) }
        let desc = if type(l) == dictionary { l.at("description") } else { l.at(2) }
        ([#id], [#name], desc)
      }).flatten(),
    ),
  )
}

// Deliverables: two-column table (Livrable / Description)
#let propal-deliverables(items, caption: "Livrables contractuels.") = {
  figure(
    caption: caption,
    table(
      columns: (auto, 1fr),
      align: (left + horizon, left + horizon),
      stroke: 0.5pt,
      inset: 6pt,

      table.header(
        table.cell(fill: propal-table-header-fill)[*Livrable*],
        table.cell(fill: propal-table-header-fill)[*Description*],
      ),

      ..items.map(i => {
        let id = if type(i) == dictionary { i.at("id") } else { i.at(0) }
        let desc = if type(i) == dictionary { i.at("description") } else { i.at(1) }
        ([#id], desc)
      }).flatten(),
    ),
  )
}

// Tasks: four-column table (#T / Description / Lot / UO) with auto total
#let propal-tasks(tasks, caption: "Actions de développement prévues et UO associées (en jours).", show-total: true, unit-label: "UO (en jours)") = {
  let total = tasks.fold(0.0, (acc, t) => {
    let uo = if type(t) == dictionary { t.at("uo") } else { t.at(3) }
    let v = if type(uo) == str { float(uo) } else { float(uo) }
    acc + v
  })

  figure(
    caption: caption,
    table(
      columns: (auto, 1fr, auto, auto),
      align: (right + horizon, left + horizon, left + horizon, right + horizon),
      stroke: 0.5pt,
      inset: 6pt,

      table.header(
        table.cell(fill: propal-table-header-fill)[*\#T*],
        table.cell(fill: propal-table-header-fill)[_Tâche_],
        table.cell(fill: propal-table-header-fill)[_Lot_],
        table.cell(fill: propal-table-header-fill)[#unit-label],
      ),

      ..tasks.enumerate().map(((idx, t)) => {
        let id = if type(t) == dictionary and "id" in t { t.at("id") } else { str(idx + 1) }
        let desc = if type(t) == dictionary { t.at("description") } else { t.at(1) }
        let lot = if type(t) == dictionary { t.at("lot") } else { t.at(2) }
        let uo = if type(t) == dictionary { t.at("uo") } else { t.at(3) }
        ([#id], desc, [#lot], [#_fmt-num(uo, decimals: 2)])
      }).flatten(),

      ..if show-total {
        (
          table.cell(fill: propal-table-total-fill, colspan: 3)[*Total général*],
          table.cell(fill: propal-table-total-fill, align: right + horizon)[*#_fmt-num(total, decimals: 2)*],
        )
      } else { () },
    ),
  )
}

// ============================================================
// Helpers: composite (Phase 3)
// ============================================================

// Resources: people cards with photo, name, role, bio
#let propal-resources(people, photo-width: 3.5cm) = {
  for person in people {
    let photo = if type(person) == dictionary and "photo" in person { person.at("photo") } else { none }
    let name = if type(person) == dictionary { person.at("name") } else { person.at(0) }
    let role = if type(person) == dictionary { person.at("role") } else { person.at(1) }
    let bio = if type(person) == dictionary { person.at("bio") } else { person.at(2) }

    block(breakable: false)[
      #grid(
        columns: (photo-width, 1fr),
        column-gutter: 1em,
        align: (center + top, left + top),

        if photo != none {
          image(photo, width: photo-width)
        } else {
          // Silhouette placeholder
          rect(
            width: photo-width,
            height: photo-width * 1.2,
            fill: em-grey.lighten(30%),
            stroke: 0.5pt + em-grey,
            radius: 3pt,
          )[
            #align(center + horizon)[
              #text(size: 10pt, fill: em-grey.darken(40%))[photo]
            ]
          ]
        },

        [
          #text(weight: "bold", size: 13pt, fill: em-logo-blue)[#name] \
          #text(weight: "bold", fill: em-logo-orange)[#role] \
          #v(0.3em)
          #bio
        ],
      )
    ]
    v(1em)
  }
}

// Commercial offer (synthesis): #Lot / Lot / UO / (Amount)
// show-amount: false hides the amount column (useful for UO-only summary tables)
#let propal-commercial-offer(
  lots,
  rate: none,
  currency: "€",
  unit-label: "UO (en jours)",
  amount-label: "Montant (€ HT)",
  caption: "Montant de l'offre.",
  show-total: true,
  show-amount: auto,
) = {
  // Auto-detect whether to show amount column
  let has-amounts = lots.any(l => {
    (type(l) == dictionary and "amount" in l and l.at("amount") != none) or (type(l) == array and l.len() >= 4 and l.at(3) != none)
  })
  let show-amount-col = if show-amount == auto {
    rate != none or has-amounts
  } else { show-amount }
  // Compute amounts if rate provided
  let enriched = lots.map(l => {
    let id = if type(l) == dictionary { l.at("id") } else { l.at(0) }
    let name = if type(l) == dictionary { l.at("name") } else { l.at(1) }
    let uo = if type(l) == dictionary { l.at("uo") } else { l.at(2) }
    let amount = if type(l) == dictionary and "amount" in l {
      l.at("amount")
    } else if l.len() >= 4 {
      l.at(3)
    } else if rate != none {
      float(uo) * float(rate)
    } else {
      none
    }
    (id: id, name: name, uo: float(uo), amount: amount)
  })

  let total-uo = enriched.fold(0.0, (acc, l) => acc + l.uo)
  let total-amount = enriched.fold(0.0, (acc, l) => {
    if l.amount != none { acc + float(l.amount) } else { acc }
  })

  let columns = if show-amount-col { (auto, 1fr, auto, auto) } else { (auto, 1fr, auto) }
  let alignments = if show-amount-col {
    (left + horizon, left + horizon, right + horizon, right + horizon)
  } else {
    (left + horizon, left + horizon, right + horizon)
  }

  figure(
    caption: caption,
    table(
      columns: columns,
      align: alignments,
      stroke: 0.5pt,
      inset: 6pt,

      table.header(
        table.cell(fill: propal-table-header-fill)[*\#Lot*],
        table.cell(fill: propal-table-header-fill)[_Lot_],
        table.cell(fill: propal-table-header-fill)[#unit-label],
        ..if show-amount-col {
          (table.cell(fill: propal-table-header-fill)[#amount-label],)
        } else { () },
      ),

      ..enriched.map(l => {
        let row = (
          [#l.id],
          [#l.name],
          [#_fmt-num(l.uo, decimals: 2)],
        )
        if show-amount-col {
          row + ([#_fmt-currency(l.amount, currency: currency)],)
        } else { row }
      }).flatten(),

      ..if show-total {
        let row = (
          table.cell(fill: propal-table-total-fill)[*Total général*],
          table.cell(fill: propal-table-total-fill)[],
          table.cell(fill: propal-table-total-fill, align: right + horizon)[*#_fmt-num(total-uo, decimals: 2)*],
        )
        if show-amount-col {
          row + (table.cell(fill: propal-table-total-fill, align: right + horizon)[*#_fmt-currency(total-amount, currency: currency)*],)
        } else { row }
      } else { () },
    ),
  )
}

// Commercial offer (detailed): grouped by lot with tasks
#let propal-commercial-offer-detailed(
  tasks,
  rate: none,
  currency: "€",
  effort-label: "Effort (en j)",
  amount-label: "Montant (€ HT)",
  caption: "Offre commerciale détaillée pour chaque lot.",
) = {
  let enriched = tasks.map(t => {
    let lot = if type(t) == dictionary { t.at("lot") } else { t.at(0) }
    let desc = if type(t) == dictionary { t.at("description") } else { t.at(1) }
    let effort = if type(t) == dictionary { t.at("effort") } else { t.at(2) }
    let amount = if type(t) == dictionary and "amount" in t {
      t.at("amount")
    } else if type(t) == array and t.len() >= 4 {
      t.at(3)
    } else if rate != none {
      float(effort) * float(rate)
    } else {
      none
    }
    (lot: lot, description: desc, effort: float(effort), amount: amount)
  })

  figure(
    caption: caption,
    table(
      columns: (auto, 1fr, auto, auto),
      align: (left + horizon, left + horizon, right + horizon, right + horizon),
      stroke: 0.5pt,
      inset: 6pt,

      table.header(
        table.cell(fill: propal-table-header-fill)[_Lot_],
        table.cell(fill: propal-table-header-fill)[_Tâche_],
        table.cell(fill: propal-table-header-fill)[#effort-label],
        table.cell(fill: propal-table-header-fill)[#amount-label],
      ),

      ..enriched.map(t => (
        [#t.lot],
        t.description,
        [#_fmt-num(t.effort, decimals: 2)],
        [#_fmt-currency(t.amount, currency: currency)],
      )).flatten(),
    ),
  )
}

// Billing schedule: Milestone / % / Amount
#let propal-billing-schedule(
  milestones,
  currency: "€",
  caption: "Échéances de facturation.",
) = {
  figure(
    caption: caption,
    table(
      columns: (1fr, auto, auto),
      align: (left + horizon, right + horizon, right + horizon),
      stroke: 0.5pt,
      inset: 6pt,

      table.header(
        table.cell(fill: propal-table-header-fill)[_Échéance_],
        table.cell(fill: propal-table-header-fill)[% Facturation],
        table.cell(fill: propal-table-header-fill)[Montant (€ HT)],
      ),

      ..milestones.map(m => {
        let label = if type(m) == dictionary { m.at("label") } else { m.at(0) }
        let percent = if type(m) == dictionary { m.at("percent") } else { m.at(1) }
        let amount = if type(m) == dictionary { m.at("amount") } else { m.at(2) }
        (label, [#percent%], [#_fmt-currency(amount, currency: currency)])
      }).flatten(),
    ),
  )
}

// Offer validity: bold sentence
#let propal-offer-validity(date) = {
  block(above: 1em, below: 1em)[
    #text(weight: "bold")[Cette offre est valable jusqu'au #date.]
  ]
}

// Timeline: matrix of lot x period with intensity-colored cells
//
// tasks: array of (id, name, values) where values is aligned with periods
//        e.g. ("L01", "Pilotage", (0.5, 0.5, 0.5, ...))
// periods: array of period labels (months, weeks, etc.)
// granularity: "month" | "week" (affects header rotation)
#let propal-timeline(
  tasks,
  periods,
  granularity: "month",
  caption: "Planning prévisionnel.",
  id-label: "T#",
  name-label: "Tâche",
) = {
  let rotate-headers = granularity == "week"
  // Weekly headers are rotated 90deg; cells still need enough width for values like "2,75"
  let period-col = if rotate-headers { 2.6em } else { auto }

  figure(
    caption: caption,
    table(
      columns: (auto, 1fr) + (period-col,) * periods.len(),
      align: (left + horizon, left + horizon) + (center + horizon,) * periods.len(),
      stroke: 0.5pt,
      inset: 5pt,

      table.header(
        table.cell(fill: propal-table-header-fill)[#id-label],
        table.cell(fill: propal-table-header-fill)[#name-label],
        ..periods.map(p => {
          table.cell(fill: propal-table-header-fill)[
            #if rotate-headers {
              rotate(-90deg, reflow: true)[#text(size: 8pt)[#p]]
            } else {
              text(size: 8pt)[#p]
            }
          ]
        }),
      ),

      ..tasks.map(t => {
        let id = if type(t) == dictionary { t.at("id") } else { t.at(0) }
        let name = if type(t) == dictionary { t.at("name") } else { t.at(1) }
        let values = if type(t) == dictionary { t.at("values") } else { t.at(2) }
        (
          [#id],
          [#name],
          ..values.map(v => {
            table.cell(fill: _timeline-fill(v))[
              #if v == none or v == "" or v == 0 { [] } else { _fmt-num(v, decimals: 2) }
            ]
          }),
        )
      }).flatten(),
    ),
  )
}

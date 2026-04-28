// EdgeMind Slides Theme for Touying
// Reproduces the EdgeMind corporate presentation design
//
// Usage:
//   #import "@preview/touying:0.6.2": *
//   #import "edgemind-theme.typ": *
//   #show: edgemind-theme.with(
//     logo: image("../logos/logo_edgemind_hz.png", height: 2.5em),
//   )

#import "@preview/touying:0.6.2": *

// =============================================================================
// Color palette (extracted from logo_edgemind_hz.svg)
// =============================================================================

#let em-blue = rgb("#244371")
#let em-orange = rgb("#F46E27")
#let em-gray = rgb("#666666")
#let em-light-blue = rgb("#B8C6D4")
#let em-light-gray = rgb("#f0f0f0")

// =============================================================================
// Constants
// =============================================================================

#let em-tagline = "DATA SCIENCE - SIMULATION - OPTIMISATION"

// =============================================================================
// Utility: highlight text in orange
// =============================================================================

#let hl(body) = text(fill: em-orange, body)

// =============================================================================
// Internal: standard footer (logo | tagline | page number)
// =============================================================================

#let _em-footer(self) = {
  grid(
    columns: (1fr, 2fr, 1fr),
    align: (left + bottom, center + bottom, right + bottom),
    if self.info.logo != none {
      set image(height: 2.5em)
      self.info.logo
    },
    text(size: 9pt, fill: em-blue, tracking: 0.5pt, em-tagline),
    text(size: 20pt, fill: em-gray,
      context counter(page).display()
    ),
  )
}

// Internal: standard header with title + optional subtitle
#let _em-header(title, subtitle) = (self) => {
  set align(left + top)
  if title != none {
    text(size: 28pt, fill: em-blue, weight: "bold", title)
  }
  if subtitle != none {
    linebreak()
    text(size: 16pt, fill: em-orange, weight: "regular", subtitle)
  }
}

// Internal: standard page config for content slides
#let _em-content-page(title, subtitle) = config-page(
  header: _em-header(title, subtitle),
  footer: _em-footer,
  margin: (left: 2em, right: 2em, top: 3.5em, bottom: 2.5em),
  header-ascent: 0%,
  footer-descent: 0%,
)

// =============================================================================
// Slide functions
// =============================================================================

// --- Title slide ---
#let title-slide(
  config: (:),
  logo: none,
  tagline: em-tagline,
  illustration: none,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      header: none,
      footer: none,
      margin: (x: 2em, y: 1.5em),
    ),
  )
  touying-slide(
    self: self,
    config: config,
    align(center + horizon, {
      if logo != none { logo } else {
        if self.info.logo != none {
          set image(height: 5em)
          self.info.logo
        }
      }
      v(0.8em)
      text(size: 16pt, fill: em-blue, tracking: 1pt, weight: "semibold", tagline)
      if illustration != none {
        v(1em)
        illustration
      }
    }),
  )
})

// --- Section slide ---
#let section-slide(
  config: (:),
  title,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: em-gray,
      header: none,
      footer: none,
      margin: (left: 2.5em, bottom: 2.5em, top: 2em, right: 2em),
    ),
  )
  touying-slide(
    self: self,
    config: config,
    align(bottom + left,
      text(
        size: 36pt,
        fill: white,
        weight: "extrabold",
        upper(title),
      )
    ),
  )
})

// --- Content slide ---
#let content-slide(
  config: (:),
  title: none,
  subtitle: none,
  side-image: none,
  side-image-width: 40%,
  ..bodies,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(self, _em-content-page(title, subtitle))
  if side-image != none {
    touying-slide(
      self: self,
      config: config,
      composer: (3fr, 2fr),
      {
        set text(size: 16pt, fill: em-blue)
        bodies.pos().at(0, default: [])
      },
      align(right + horizon, side-image),
    )
  } else {
    touying-slide(
      self: self,
      config: config,
      {
        set text(size: 16pt, fill: em-blue)
        bodies.pos().at(0, default: [])
      },
    )
  }
})

// --- Team slide ---
#let team-member(photo: none, name: "", role: "", tags: ()) = {
  let photo-size = 4.5em
  set align(left)
  grid(
    columns: (photo-size + 0.8em, 1fr),
    gutter: 0.5em,
    align: (center, left),
    if photo != none {
      box(
        width: photo-size,
        height: photo-size,
        clip: true,
        radius: 50%,
        photo,
      )
    } else {
      box(
        width: photo-size,
        height: photo-size,
        radius: 50%,
        fill: em-light-gray,
      )
    },
    {
      text(size: 12pt, fill: em-blue, weight: "bold", upper(name))
      linebreak()
      text(size: 9pt, fill: em-orange, style: "italic", role)
      if tags.len() > 0 {
        linebreak()
        text(size: 8pt, fill: em-gray,
          tags.map(t => "#" + t).join("\n")
        )
      }
    },
  )
}

#let team-slide(
  config: (:),
  title: "NOTRE EQUIPE",
  members: (),
  columns: 3,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(self, _em-content-page(title, none))
  touying-slide(
    self: self,
    config: config,
    {
      let member-cards = members.map(m => team-member(..m))
      grid(
        columns: (1fr,) * calc.min(columns, members.len()),
        rows: auto,
        gutter: 1em,
        ..member-cards,
      )
    },
  )
})

// --- Diagram slide ---
#let diagram-slide(
  config: (:),
  title: none,
  subtitle: none,
  body,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(self, _em-content-page(title, subtitle))
  touying-slide(
    self: self,
    config: config,
    align(center + horizon, body),
  )
})

// --- Contact slide ---
#let contact-slide(
  config: (:),
  title: none,
  illustration: none,
  photo: none,
  name: "",
  phone: "",
  email: "",
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-page(
      header: none,
      footer: _em-footer,
      margin: (left: 2em, right: 2em, top: 1.5em, bottom: 2.5em),
      header-ascent: 0%,
      footer-descent: 0%,
    ),
  )
  touying-slide(
    self: self,
    config: config,
    align(center, {
      if title != none {
        v(0.5em)
        text(size: 24pt, fill: em-blue, weight: "bold", style: "italic", title)
        v(0.8em)
      }
      if illustration != none {
        illustration
        v(1em)
      }
      {
        let photo-size = 5em
        grid(
          columns: (photo-size + 1em, auto),
          gutter: 0.8em,
          align: (center, left + horizon),
          if photo != none {
            box(
              width: photo-size,
              height: photo-size,
              clip: true,
              radius: 50%,
              photo,
            )
          },
          {
            text(size: 14pt, fill: em-orange, weight: "bold",
              smallcaps(name)
            )
            if phone != "" {
              linebreak()
              v(0.3em)
              text(size: 12pt, fill: em-gray, emoji.phone + "  " + phone)
            }
            if email != "" {
              linebreak()
              v(0.2em)
              text(size: 12pt, fill: em-gray, emoji.email + "  " + email)
            }
          },
        )
      }
    }),
  )
})

// =============================================================================
// Main theme function
// =============================================================================

#let edgemind-theme(
  aspect-ratio: "16-9",
  logo: none,
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      margin: (x: 2em, y: 1.5em),
    ),
    config-common(
      slide-fn: content-slide,
      new-section-slide-fn: section-slide,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(size: 20pt, font: "Open Sans", fill: em-blue)
        set list(marker: text(fill: em-orange, sym.circle.filled))
        show heading.where(level: 1): set text(size: 28pt, fill: em-blue, weight: "bold")
        show heading.where(level: 2): set text(size: 20pt, fill: em-orange, weight: "semibold")
        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      primary: em-blue,
      secondary: em-orange,
      neutral-light: em-gray,
      neutral-lightest: white,
      neutral-darkest: rgb("#1a1a1a"),
    ),
    config-info(
      logo: logo,
    ),
    ..args,
  )

  body
}

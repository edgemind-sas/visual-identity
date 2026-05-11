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

#let em-tagline = "MODELISATION - SIMULATION - OPTIMISATION"

// Header/footer chrome padding.
//
// `em-chrome-vpad` controls the vertical breathing room between the page edge
// and the header/footer text.  `em-chrome-hpad` controls the horizontal
// alignment — kept identical to the slide's content margin (2em) so that the
// header title, the slide content and the footer all start at the same
// horizontal position.
#let em-chrome-vpad = 25pt
#let em-chrome-hpad = 2em

// =============================================================================
// Utility: highlight text in orange
// =============================================================================

#let hl(body) = text(fill: em-orange, body)

// =============================================================================
// Utility: pseudo-small-caps fallback
//
// Open Sans (the EdgeMind body font) does not expose the OpenType `smcp`
// feature, so `smallcaps()` is a no-op.  This helper reproduces the visual
// effect:
//   - originally-uppercase letters keep their full glyph height,
//   - originally-lowercase letters are rendered as smaller uppercase glyphs.
//
// `\p{Ll}+` matches Unicode lowercase runs (handles é, è, ç, ï…).
// =============================================================================

#let em-smallcaps(body, ratio: 0.78) = {
  show regex("\p{Ll}+"): it => text(size: ratio * 1em, upper(it))
  body
}

// =============================================================================
// Internal: standard footer (logo | tagline | page x / total)
// =============================================================================

#let _em-footer(self) = {
  pad(left: em-chrome-hpad, right: em-chrome-hpad, bottom: em-chrome-vpad, {
    grid(
      columns: (1fr, 2fr, 1fr),
      align: (left + horizon, center + horizon, right + horizon),
      // Force visual half-scale via `scale(reflow: true)` — `set image`
      // does not override the baked-in `height` of an `image()` call from
      // the user's `edgemind-theme.with(logo: ...)`.
      if self.info.logo != none {
        scale(x: 50%, y: 50%, reflow: true, self.info.logo)
      },
      text(size: 9pt, fill: em-blue, tracking: 0.5pt, em-tagline),
      context {
        let cur = counter(page).get().first()
        let total = counter(page).final().first()
        set text(size: 9pt, tracking: 0.5pt)
        text(fill: em-blue, weight: "bold")[#cur]
        h(0.3em)
        text(fill: em-gray)[\/]
        h(0.3em)
        text(fill: em-orange, weight: "bold")[#total]
      },
    )
  })
}

// Internal: standard header with title + optional subtitle.
//
// Inverted palette: title in EdgeMind orange (small-caps), subtitle in
// EdgeMind blue (small-caps).  Original capitals stay full-height while
// originally-lowercase letters render as smaller capitals — see
// `em-smallcaps` for the rationale (Open Sans has no `smcp`).
#let _em-header(title, subtitle) = (self) => {
  pad(top: em-chrome-vpad, left: em-chrome-hpad, right: em-chrome-hpad, {
    set align(left + top)
    if title != none {
      text(size: 36pt, fill: em-orange, weight: "bold", em-smallcaps(title))
    }
    if subtitle != none {
      linebreak()
      text(size: 22pt, fill: em-blue, weight: "regular", em-smallcaps(subtitle))
    }
  })
}

// Internal: standard page config for content slides.
//
// Top margin enlarged so the header has room for the bigger fonts and
// padding; left/right margin matches the chrome's horizontal padding so all
// three (header / body / footer) start at the same X position.
#let _em-content-page(title, subtitle) = config-page(
  header: _em-header(title, subtitle),
  footer: _em-footer,
  margin: (left: em-chrome-hpad, right: em-chrome-hpad, top: 6em, bottom: 3.2em),
  header-ascent: 0%,
  footer-descent: 0%,
)

// =============================================================================
// Slide functions
// =============================================================================

// --- Title slide ---
//
// Two layouts:
//
// 1. NEW layout — passes any of `cartridge-title`, `cartridge-subtitle`,
//    `authors`, `info-text`, `date` to opt in:
//
//        +------------------------------------+
//        |          [blue cartridge]          |
//        |       title (EdgeMind grey)        |
//        |     subtitle (EdgeMind orange)     |
//        +------------------------------------+
//                  [small EdgeMind logo]
//                       authors?
//                     info-text?
//                         date?
//
// 2. LEGACY layout (no cartridge / no extra info) — large centered logo
//    above the tagline, as before.
#let title-slide(
  config: (:),
  cartridge-title: none,
  cartridge-subtitle: none,
  logo: none,
  authors: none,
  info-text: none,
  date-text: none,
  // legacy params (preserved for existing decks)
  tagline: none,
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

  let new-layout = (
    cartridge-title != none
      or cartridge-subtitle != none
      or authors != none
      or info-text != none
      or date-text != none
  )

  touying-slide(
    self: self,
    config: config,
    align(center + horizon, {
      if new-layout {
        // Blue cartridge with grey title + orange subtitle.
        //
        // `smallcaps()` is used instead of `upper()` so that originally
        // uppercase letters keep their full-height glyph while lowercase
        // letters render as small caps — original capitals stay visually
        // distinguishable.
        if cartridge-title != none or cartridge-subtitle != none {
          block(
            fill: em-blue,
            radius: 1.2em,
            inset: (x: 2em, y: 1.5em),
            width: 85%,
            align(center, {
              if cartridge-title != none {
                set par(leading: 0.35em)
                text(size: 38pt, fill: em-light-gray, weight: "bold",
                     em-smallcaps(cartridge-title))
              }
              if cartridge-subtitle != none {
                v(0.7em, weak: true)
                set par(leading: 0.35em)
                text(size: 18pt, fill: em-orange, weight: "semibold",
                     em-smallcaps(cartridge-subtitle))
              }
            })
          )
          v(0.8em)
        }

        // Small EdgeMind logo below the cartridge.
        if logo != none {
          logo
        } else if self.info.logo != none {
          set image(height: 2.5em)
          self.info.logo
        }

        if authors != none {
          v(0.8em)
          text(size: 14pt, fill: em-blue, weight: "semibold",
               em-smallcaps(authors))
        }

        if info-text != none {
          v(0.5em)
          text(size: 12pt, fill: em-gray, em-smallcaps(info-text))
        }

        if date-text != none {
          v(0.5em)
          text(size: 11pt, fill: em-gray, em-smallcaps(date-text))
        }
      } else {
        // Legacy layout: large centered logo + tagline.
        if logo != none { logo } else {
          if self.info.logo != none {
            set image(height: 5em)
            self.info.logo
          }
        }
        v(0.8em)
        let tag = if tagline != none { tagline } else { em-tagline }
        text(size: 16pt, fill: em-blue, tracking: 1pt, weight: "semibold", tag)
        if illustration != none {
          v(1em)
          illustration
        }
      }
    }),
  )
})

// --- Section slide ---
//
// Grey background with white title rendered as small-caps (originally
// uppercase letters keep full-height glyph).
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
        size: 68pt,
        fill: white,
        weight: "extrabold",
        em-smallcaps(title),
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

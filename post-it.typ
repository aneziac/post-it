#import "@preview/valkyrie:0.2.2" as z

#let base-colors-state = state("base-colors-state", (
  bgcolor1:   white,
  bgcolor2:   black,
  textcolor1: black,
  textcolor2: black,
))

#let base-colors-schema = z.dictionary((
  bgcolor1:   z.color(),
  bgcolor2:   z.color(),
  textcolor1: z.color(),
  textcolor2: z.color(),
))

#let poster_section(
  title,
  body,
  fill: false
) = context {
  let fill_color = if fill {base-colors-state.get().bgcolor1} else {none}
  block(
    width: 100%,
    fill: fill_color,
    inset: 20pt,
    radius: 10pt,
    stack(
      align(center)[== #title],
      v(0.15em),
      line(
        length: 100%,
        stroke: (
          paint: base-colors-state.get().bgcolor2,
          thickness: 3pt,
          cap: "round"
        )
      ),
      v(0.6em),
      [#body],
      v(0.3em)
    )
  )
}

#let poster_header(
  title,
  author,
  mentor,
  subtitle,
  logo,
) = context {
  let logo-content = {
    if logo != none {
      align(center + horizon)[#logo]
    } else {
      []
    }
  }
  let authors-content = {
    if mentor != none {
      [#author --- Mentor: #mentor]
    } else {
      [#author]
    }
  }

  set text(
    fill: base-colors-state.get().textcolor2
  )
  stack(
    dir: ttb,
    block(
      fill: base-colors-state.get().bgcolor2,
      width: 100%,
      height: 100%,
      inset: 0.5in,
      grid(
        columns: (1fr, 4fr, 1fr),
        [],
        align(center + horizon)[#stack(
          spacing: 0.5in,
          text(size: 72pt, weight: "extrabold")[#title],
          text(size: 48pt)[#authors-content],
          text(size: 36pt)[#subtitle]
        )],
        logo-content
      )
    ),
  )
}


#let poster_footer() = context {
  stack(
    dir: ttb,
    block(
      fill: base-colors-state.get().bgcolor2,
      width: 100%,
      height: 100%
    )
  )
}


#let poster(
  title:        "",
  author:       "",
  width:        43in,
  height:       32.5in,
  base-colors:  none,
  mentor:       none,
  subtitle:     none,
  logo: none,
  doc,
) = context {
  // validation
  assert(base-colors != none, message: "Must provide colors to post-it")
  base-colors-state.update(z.parse(base-colors, base-colors-schema))
  assert(base-colors-state.get() != none, message: "Incorrect base-colors schema")

  set page(
    height: height,
    width:  width,
    margin: 0in,
  )

  set par(justify: true)

  set text(
    size: 24pt,
    fill: base-colors-state.get().textcolor1
  )

  show heading.where(level: 2): it => [
    #set text(40pt, fill: base-colors-state.get().bgcolor2)
    #it
    #v(0.3em)
  ]

  show strong: it => [
    #set text(fill: base-colors-state.get().textcolor1)
    #it
  ]

  grid(
    columns: 1,
    rows: (13%, 83%, 4%),
    poster_header(
      title,
      author,
      mentor,
      subtitle,
      logo,
    ),
    doc,
    poster_footer()
  )
}

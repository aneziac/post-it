#let poster_section(title, body, base-colors, fill: false) = {
  let fill_color = if fill {base-colors.bgcolor1} else {none}
  block(
    width: 100%,
    fill: fill_color,
    inset: 20pt,
    radius: 10pt,
    stack(
      align(center)[== #title],
      v(0.15em),
      line(length: 100%, stroke: (paint: base-colors.bgcolor2, thickness: 3pt, cap: "round")),
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
  university-logo,
  base-colors
) = {
  let logo-content = {
    if university-logo != none {
      align(center + horizon)[#university-logo]
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
    fill: base-colors.scolor2
  )
  stack(
    dir: ttb,
    block(
      fill: base-colors.bgcolor2,
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


#let poster_footer(base-colors) = {
  stack(
    dir: ttb,
    block(
      fill: base-colors.bgcolor2,
      width: 100%,
      height: 100%
    )
  )
}


#let poster(
  title:           "",
  author:          "",
  base-colors:     none,
  mentor:          none,
  subtitle:        none,
  university-logo: none,
  doc,
) = {
  if base-colors == none {
    panic("Must provide colors to post-it")
  }

  set page(
    height: 32.5in,
    width:  43in,
    margin: 0in,
  )

  set par(justify: true)

  set text(
    size: 24pt,
    fill: base-colors.scolor1
  )

  show heading.where(level: 2): it => [
    #set text(40pt, fill: base-colors.bgcolor2)
    #it
    #v(0.3em)
  ]

  show strong: it => [
    #set text(fill: base-colors.scolor1)
    #it
  ]

  grid(
    columns: 1,
    rows: (14%, 82%, 4%),
    poster_header(
      title,
      author,
      mentor,
      subtitle,
      university-logo,
      base-colors
    ),
    doc,
    poster_footer(base-colors)
  )
}

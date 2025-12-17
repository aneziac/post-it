#import "@local/post-it:0.1.0": *
#import "./colors.typ": base-colors
#import "sections.typ": *

#show: poster.with(
  title: "Geometric Realization of Coxeter Groups",
  author: "Nate Annau and Jesse Cobb",
  mentor: "Mentor: Benedict Lee",
  subtitle: "University of California, Santa Barbara",
  logo: image("assets/whitelogo.png", height: 100%),
  base-colors: base-colors
)


#let rgutter = 0.5cm
#pad(
  grid(
    columns: 3,
    inset: 0.5in,
    gutter: 30pt,
    grid(
      rows: 2,
      row-gutter: rgutter,
      poster_section[Coxeter Systems][#coxeter_systems],
      poster_section(fill: true)[Chambers and Nerves][#chambers_and_nerves],
    ),
    grid(
      rows: 2,
      row-gutter: rgutter,
      poster_section(fill: true)[The Davis Complex as a Basic Construction][#basic_construction],
      poster_section[The Davis Complex is _CAT(0)_][#Davis_complex_CAT0],
    ),
    grid(
      rows: 4,
      row-gutter: rgutter,
      poster_section[Tits Representation][#tits_representation],
      poster_section(fill: true)[Buildings][#buildings],
      poster_section[Acknowledgements][#acknowledgements],
      poster_section[References][#references],
    )
  ),
  top: 0.3cm,
  x: 1in,
)

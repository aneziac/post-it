#import "@local/post-it:0.1.0": *
#import "colors.typ": base-colors


#show: poster.with(
  title: "Applied Cryonics: How I Slept Through the 21st Century",
  author: "Philip J. Fry and Turanga Leela",
  mentor: "Bender B. Rodriguez",
  subtitle: "College of New New York",
  university-logo: image("logo.png", height: 140%),
  base-colors: base-colors
)

#let section1 = [
  #lorem(300)
]

#let section2 = [
  #lorem(300)
]

#let section3 = [
  #lorem(200)
]

#let section4 = [
  #lorem(200)
]

#let section5 = [
  #lorem(180)
]

#let section6 = [
  #lorem(250)
]

#let section7 = [
  #lorem(180)
]

#let acknowledgements = [
  #lorem(25)
]

#let references = [
  #bibliography("./references.bib", title: [], full: true)
]

#pad(
  grid(
    columns: 3,
    inset: 0.5in,
    gutter: 30pt,
    [
      #poster_section("Section 1", section1, base-colors)
      #poster_section("Section 2", section2, base-colors, fill: true)
    ],
    [
      #poster_section("Section 3", section3, base-colors)
      #poster_section("Section 4", section4, base-colors, fill: true)
      #poster_section("Section 5", section5, base-colors)
    ],
    [
      #poster_section("Section 6", section6, base-colors, fill: true)
      #poster_section("Section 7", section7, base-colors)
      #poster_section("Acknowledgements", acknowledgements, base-colors, fill: true)
      #poster_section("References", references, base-colors)
    ]
  ),
  top: 0.5in,
  x: 1in,
)

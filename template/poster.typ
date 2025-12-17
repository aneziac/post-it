#import "@local/post-it:0.1.0": *
#import "colors.typ": base-colors
#import "sections.typ": *


#show: poster.with(
  title:       [Applied Cryonics: How I Slept Through the 21st Century],
  author:      [Philip J. Fry and Turanga Leela],
  mentor:      [Mentor: Bender B. Rodriguez],
  width:       43in,
  height:      32.5in,
  subtitle:    [College of New New York],
  logo:        image("logo.png", height: 150%),
  base-colors: base-colors
)

#pad(
  grid(
    columns: 3,
    inset: 0.5in,
    gutter: 30pt,
    [
      #poster_section[Section 1][#section1]
      #poster_section(fill: true)[Section 2][#section2]
    ],
    [
      #poster_section[Section 3][#section3]
      #poster_section(fill: true)[Section 4][#section4]
      #poster_section[Section 5][#section5]
    ],
    [
      #poster_section(fill: true)[Section 6][#section6]
      #poster_section[Section 7][#section7]
      #poster_section(fill: true)[Acknowledgements][#acknowledgements]
      #poster_section[References][#references]
    ]
  ),
  top: 0.5in,
  x: 1in,
)

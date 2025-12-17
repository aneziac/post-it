#import "colors.typ": *
#import "macros.typ": *

#import "@preview/cetz:0.3.0": canvas, draw
#import "@preview/mannot:0.3.0": *


// HELPERS

#let geom_pt(coords, label, fill_color, anchor, filled: true) = {
  let label_text
  if filled {
    label_text = markhl(text(label, fill: fill_color), fill: base-colors.bgcolor1.transparentize(20%))
  } else {
    label_text = text(fill: fill_color)[#label]
  }

  draw.on-layer(
    0,
    draw.circle(coords, radius: (0.05, 0.05), fill: fill_color, stroke: none)
  )
  draw.on-layer(
    1,
    draw.content(
      coords,
      label_text,
      anchor: anchor,
      padding: .15,
      name: "text"
    )
  )
  draw.content(coords, [], anchor: anchor, padding: .1)
}

#let K_0(pos, refx: false, refy: false, label: []) = {
  import draw: *

  return group({
    let (x, y) = pos
    translate(x: x, y: y)
    if(refx) {
      scale(x: -1)
      rotate(calc.pi/2)
    }
    if(refy) {
      scale(y: -1)
      rotate(calc.pi/2)
    }
    let (s0, s1, s2, s3) = ((-1/2, -1/2), (1/2, -1/2), (1/2, 1/2), (-1/2, 1/2))
    let (s01, s12, s23, s30) = ((0, -1), (1, 0), (0, 1), (-1, 0))
    let eset = (0, 0)

    merge-path(fill: cfill, {
      line(s0, s01)
      line(s01, s1)
      line(s1, s12)
      line(s12, s2)
      line(s2, s23)
      line(s23, s3)
      line(s30, s0)
    })

    line(eset, s0)
    line(eset, s01)
    line(eset, s1)
    line(eset, s12)
    line(eset, s2)
    line(eset, s23)
    line(eset, s3)
    line(eset, s30)
    line(eset, s0)

    line(s30, s01, stroke: ccolor0 + 0.1em)
    line(s01, s12, stroke: ccolor1 + 0.1em)
    line(s12, s23, stroke: ccolor2 + 0.1em)
    line(s23, s30, stroke: ccolor3 + 0.1em)

    geom_pt(s0, [], ccolor0, "north-east")
    geom_pt(s1, [], ccolor1, "north-west")
    geom_pt(s2, [], ccolor2, "south-west")
    geom_pt(s3, [], ccolor3, "south-east")

    geom_pt(s01, [], black, "north")
    geom_pt(s12, [], black, "west")
    geom_pt(s23, [], black, "south")
    geom_pt(s30, [], black, "east")

    geom_pt(eset, label, black, "center")
  })
}

#let K_1(pos, rad, reflect: false, label: []) = {
  import draw: *

  let label_anchor = "south"
  let inc = calc.pi / 8
  if(inc <= rad and rad < 3 * inc) {
    label_anchor = "south-east"
  } else if(3 * inc <= rad and rad < 5 * inc) {
    label_anchor = "east"
  } else if(5 * inc <= rad and rad < 7 * inc) {
    label_anchor = "north-east"
  } else if(7 * inc <= rad and rad < 9 * inc) {
    label_anchor = "north"
  } else if(9 * inc <= rad and rad < 11 * inc) {
    label_anchor = "north-west"
  } else if(11 * inc <= rad and rad < 13 * inc) {
    label_anchor = "west"
  } else if(13 * inc <= rad and rad < 15 * inc) {
    label_anchor = "south-west"
  }

  let height = calc.sqrt(3)/2

  return group({
    let (x, y) = pos
    translate(x: x, y: y)
    rotate(rad)
    if(reflect) {
      scale(x: -1)
    }

    let (s, t, u) = ((1/2, height), (- 1/2, height), (0, 2 * height))
    let st = (0, 0)
    let eset = (0, height)

    merge-path(fill: cfill, {
      line(s, st)
      line(st, t)
      line(t, eset)
      line(eset, s)
    })

    line(eset, u)
    line(eset, st)

    line(s, st, stroke: ccolor0 + 0.1em)
    line(t, st, stroke: ccolor1 + 0.1em)

    geom_pt(s, [], ccolor0, "south-east")
    geom_pt(t, [], ccolor1, "south-west")
    geom_pt(u, [], ccolor2, "north")

    geom_pt(st, [], black, "south")
    geom_pt(eset, label, black, label_anchor)
  })
}

#let threetree(n) = {
  import draw: *

  let colors_list = (
    none, interp1, interp2, interp3, interp4
  )

  let color = colors_list.at(n)

  let inner_ring_base_angle = calc.pi / (3 * calc.pow(2, n - 1))
  let inner_ring_inc_angle = 2 * calc.pi / (3 * calc.pow(2, n - 1))
  let outer_ring_base_angle = calc.pi / (3 * calc.pow(2, n))
  let outer_ring_inc_angle = 2 * calc.pi / (3 * calc.pow(2, n))

  for x in std.range(0, 3 * calc.pow(2, n - 1)) {
    let inner = (
      n * calc.cos(inner_ring_base_angle + inner_ring_inc_angle * x),
      n * calc.sin(inner_ring_base_angle + inner_ring_inc_angle * x)
    )
    let outer1 = (
      (n + 1) * calc.cos(outer_ring_base_angle + outer_ring_inc_angle * (2 * x)),
      (n + 1) * calc.sin(outer_ring_base_angle + outer_ring_inc_angle * (2 * x))
    )
    let outer2 = (
      (n + 1) * calc.cos(outer_ring_base_angle + outer_ring_inc_angle * (2 * x + 1)),
      (n + 1) * calc.sin(outer_ring_base_angle + outer_ring_inc_angle * (2 * x + 1))
    )

    on-layer(
      0, {
        line(inner, outer1, stroke: color + 0.15em)
        line(inner, outer2, stroke: color + 0.15em)
      }
    )

    on-layer(
      1, {
        circle(inner, radius: 0.1, fill: color, stroke: none)

        // double add just to make things easier for last layer
        circle(outer1, radius: 0.1, fill: color, stroke: none)
        circle(outer2, radius: 0.1, fill: color, stroke: none)
      }
    )
  }
}


// DIAGRAMS

#let chambers_and_nerves_diagram = {
  align(center + horizon)[#grid(
    columns: 2,
    row-gutter: 0.7cm,
    column-gutter: 1cm,
    canvas(length: 2cm, {
      import draw: *
      let s0 = (0, 0)
      let s1 = (1, 0)
      let s2 = (1, 1)
      let s3 = (0, 1)

      merge-path(fill: none, {
        line(s0, s1)
        line(s1, s2)
        line(s2, s3)
        line(s3, s0)
      })

      geom_pt(s0, $s_0$, ccolor0, "north-east")
      geom_pt(s1, $s_1$, ccolor1, "north-west")
      geom_pt(s2, $s_2$, ccolor2, "south-west")
      geom_pt(s3, $s_3$, ccolor3, "south-east")
    }),
    canvas(length: 2cm, {
      import draw: *
      let val = calc.sqrt(3)/2
      let (s, t, u) = ((-1/2, val), (1/2, val), (0, 0))

      merge-path(fill: none, {
        line(s, t)
      })

      geom_pt(s, $s$, ccolor0, "south-east")
      geom_pt(t, $t$, ccolor1, "south-west")
      geom_pt(u, $u$, ccolor2, "north")
    }),
    [$L(W^((0)), S^((0)))$], [$L(W^((1)), S^((1)))$],
    canvas(length: 2cm, {
      import draw: *
      let (s0, s1, s2, s3) = ((0, 0), (1, 0), (1, 1), (0, 1))
      let (s01, s12, s23, s30) = ((1/2, -1/2), (1 + 1/2, 1/2), (1/2, 1 + 1/2), (- 1/2, 1/2))

      merge-path(fill: none, {
        line(s0, s01)
        line(s01, s1)
        line(s1, s12)
        line(s12, s2)
        line(s2, s23)
        line(s23, s3)
        line(s30, s0)
      })

      geom_pt(s0, $s_0$, ccolor0, "north-east")
      geom_pt(s1, $s_1$, ccolor1, "north-west")
      geom_pt(s2, $s_2$, ccolor2, "south-west")
      geom_pt(s3, $s_3$, ccolor3, "south-east")

      geom_pt(s01, ${s_0, s_1}$, ccolor4, "north")
      geom_pt(s12, ${s_1, s_2}$, ccolor5, "west")
      geom_pt(s23, ${s_2, s_3}$, ccolor6, "south")
      geom_pt(s30, ${s_0, s_3}$, ccolor7, "east")
    }),
    canvas(length: 2cm, {
      import draw: *
      let val = calc.sqrt(3)/2
      let (s, t, u) = ((-1/2, val), (1/2, val), (0, 0))
      let st = (0, 2 * val)

      merge-path(fill: none, {
        line(s, st)
        line(st, t)
      })

      geom_pt(s, $s$, ccolor0, "south-east")
      geom_pt(t, $t$, ccolor1, "south-west")
      geom_pt(u, $u$, ccolor2, "north")

      geom_pt(st, ${s, t}$, ccolor4, "south")
    }),
    [$L'(W^((0)), S^((0)))$], [$L'(W^((1)), S^((1)))$],
    canvas(length: 2cm, {
      import draw: *
      let (s0, s1, s2, s3) = ((0, 0), (1, 0), (1, 1), (0, 1))
      let (s01, s12, s23, s30) = ((1/2, -1/2), (1 + 1/2, 1/2), (1/2, 1 + 1/2), (- 1/2, 1/2))
      let eset = (1/2, 1/2)

      merge-path(fill: cfill, {
        line(s0, s01)
        line(s01, s1)
        line(s1, s12)
        line(s12, s2)
        line(s2, s23)
        line(s23, s3)
        line(s30, s0)
      })

      line(eset, s0)
      line(eset, s01)
      line(eset, s1)
      line(eset, s12)
      line(eset, s2)
      line(eset, s23)
      line(eset, s3)
      line(eset, s30)
      line(eset, s0)

      line(s30, s01, stroke: ccolor0 + 0.1em)
      line(s01, s12, stroke: ccolor1 + 0.1em)
      line(s12, s23, stroke: ccolor2 + 0.1em)
      line(s23, s30, stroke: ccolor3 + 0.1em)

      geom_pt(s0, $K_(s_0)$, ccolor0, "north-east")
      geom_pt(s1, $K_(s_1)$, ccolor1, "north-west")
      geom_pt(s2, $K_(s_2)$, ccolor2, "south-west")
      geom_pt(s3, $K_(s_3)$, ccolor3, "south-east")

      geom_pt(s01, [], black, "north")
      geom_pt(s12, [], black, "west")
      geom_pt(s23, [], black, "south")
      geom_pt(s30, [], black, "east")

      geom_pt(eset, $emptyset$, black, "north-west")
    }),
    canvas(length: 2cm, {
      import draw: *
      let val = calc.sqrt(3)/2
      let (s, t, u) = ((-1/2, val), (1/2, val), (0, 0))
      let st = (0, 2 * val)
      let eset = (0, val)

      merge-path(fill: cfill, {
        line(s, st)
        line(st, t)
        line(t, eset)
        line(eset, s)
      })

      line(eset, u)
      line(eset, st)

      line(s, st, stroke: ccolor0 + 0.1em)
      line(t, st, stroke: ccolor1 + 0.1em)

      geom_pt(s, $K_s$, ccolor0, "south-east")
      geom_pt(t, $K_t$, ccolor1, "south-west")
      geom_pt(u, $K_u$, ccolor2, "north")

      geom_pt(st, [], black, "south")
      geom_pt(eset, $emptyset$, black, "north-west")
    }),
    [$K(W^((0)), S^((0)))$], [$K(W^((1)), S^((1)))$],
  )]
}

#let dihedral_group_diagram = {
  align(center + horizon)[
    #grid(
      columns: 3,
      gutter: 2em,
      canvas(length: 3cm, {
        import draw: *

        let (s0, s1, s2, s3) = ((0, 0), (1, 0), (1, 1), (0, 1))

        merge-path(stroke: 1.5pt, {
          line(s0, s1)
          line(s1, s2)
          line(s2, s3)
          line(s3, s0)
        })

        line((0.5, -0.25), (0.5, 1.25), stroke: (dash: "dashed", thickness: 2pt))
        line((-0.25, 0.5), (1.25, 0.5), stroke: (dash: "dashed", thickness: 2pt))
        line((-0.25, -0.25), (1.25, 1.25), stroke: (dash: "dashed", thickness: 2pt))
        line((-0.25, 1.25), (1.25, -0.25), stroke: (dash: "dashed", thickness: 2pt))

        arc-through((1.5, 0.7), (1.4, 0.85), (1.4, 0.8), mark: (end: "stealth", fill: black))
        arc-through((-0.5, 0.7), (-0.4, 0.85), (-0.4, 0.8), mark: (end: "stealth", fill: black))
      }),
      [
        $D_8 = gen(r\, s | r^4 = s^2 = (s r)^2 = 1)$
      ],
      canvas(length: 2cm, {
        import draw: *

        let base_angle = 0
        let inc_angle = calc.pi / 4
        let pos(n) = (
          { (calc.cos(base_angle + inc_angle * n), calc.sin(base_angle + inc_angle * n)) }
        )

        let nums = std.range(0, 8)
        let (s0, s1, s2, s3, s4, s5, s6, s7) = nums.map(pos)

        line(s0, s1, stroke: ccolor0 + 3pt)
        line(s1, s2, stroke: ccolor1 + 3pt)
        line(s2, s3, stroke: ccolor0 + 3pt)
        line(s3, s4, stroke: ccolor1 + 3pt)
        line(s4, s5, stroke: ccolor0 + 3pt)
        line(s5, s6, stroke: ccolor1 + 3pt)
        line(s6, s7, stroke: ccolor0 + 3pt)
        line(s7, s0, stroke: ccolor1 + 3pt)

        geom_pt(s0, $t s$, ccolor0, "west", filled: false)
        geom_pt(s1, $t$, ccolor0, "west", filled: false)
        geom_pt(s2, $e$, ccolor0, "south-west", filled: false)
        geom_pt(s3, $s$, ccolor0, "south-east", filled: false)
        geom_pt(s4, $s t$, ccolor0, "south-east", filled: false)
        geom_pt(s5, $s t s$, ccolor0, "east", filled: false)
        geom_pt(s6, $s t s t = t s t s$, ccolor0, "north", filled: false)
        geom_pt(s7, $t s t$, ccolor0, "west", filled: false)
      })
    )
  ]
}

#let realization_diagram = {
  align(center + horizon)[#grid(
    columns: (1fr, 1fr),
    row-gutter: 1cm,
    [#canvas(length: 2cm, {
      import draw: *

      let pos = (0, 0)
      let d = 1
      K_0(pos, label: $K$)

      let pos = (- d, - d)
      K_0(pos, refy: true, label: $s_0 K$)

      let pos = (d, - d)
      K_0(pos, refx: true, label: $s_1 K$)

      let pos = (d, d)
      K_0(pos, refy: true, label: $s_2 K$)

      let pos = (- d, d)
      K_0(pos, refx: true, label: $s_3 K$)

      let pos = (0, - 2 * d)
      K_0(pos, refx: true, refy: true, label: $s_0 s_1 K$)

      let pos = (2 * d, 0)
      K_0(pos, refx: true, refy: true, label: $s_1 s_2 K$)

      let pos = (2 * d, - 2 * d)
      K_0(pos, label: $s_1 s_3 K$)
    })],
    [#canvas(length: 2cm, {
      import draw: *

      let height = calc.sqrt(3)/2
      let rot = calc.pi/3
      let pos_finder(itr) = (calc.sin(itr * rot) * 4 * height, calc.cos(itr * rot) * 4 * height)

      let pos = (0, 0)
      K_1(pos, 0 * rot, label: $K$)
      K_1(pos, 1 * rot, reflect: true, label: $t K$)
      K_1(pos, 2 * rot, label: $t s K$)
      K_1(pos, 3 * rot, reflect: true, label: $t s t K$)
      K_1(pos, 4 * rot, label: $s t K$)
      K_1(pos, 5 * rot, reflect: true, label: $s K$)

      let pos = pos_finder(0)
      K_1(pos, 2 * rot)
      K_1(pos, 3 * rot, reflect: true, label: $u K$)
      K_1(pos, 4 * rot)

      let pos = pos_finder(1)
      K_1(pos, 2 * rot)

      let pos = pos_finder(2)
      K_1(pos, 1 * rot, reflect: true)

      let pos = pos_finder(3)
      K_1(pos, 5 * rot, reflect: true)
      K_1(pos, 0 * rot, label: $t s t u K$)
      K_1(pos, 1 * rot, reflect: true)

      let pos = pos_finder(4)
      K_1(pos, 5 * rot, reflect: true)

      let pos = pos_finder(5)
      K_1(pos, 4 * rot)
    })],
    [$cal(Sigma) (W^((0)), S^((0)))$],
    [$cal(Sigma) (W^((1)), S^((1)))$]
  )]
}

#let buildings_diagram = {
  align(left)[#canvas(length: 1.4cm, {
    import draw: *

    draw.on-layer(
      0, {
        line(
          (0, 0),
          (calc.cos(calc.pi / 3), calc.sin(calc.pi / 3)),
          stroke: interp0 + 0.15em
        )
        line(
          (0, 0),
          (calc.cos(calc.pi), calc.sin(calc.pi)),
          stroke: interp0 + 0.15em
        )
        line(
          (0, 0),
          (calc.cos(-calc.pi / 3), calc.sin(-calc.pi / 3)),
          stroke: interp0 + 0.15em
        )
      }
    )

    draw.on-layer(
      1,
      circle((0, 0), radius: (0.1, 0.1), fill: interp0, stroke: none)
    )

    threetree(1)
    threetree(2)
    threetree(3)
    threetree(4)
    })
  ]
}

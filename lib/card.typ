// One Necromunda fighter card, as a function so a single-card page and a
// tiled sheet can share it.
//
// The weapons table takes the slack, so the card adapts to whatever size it is
// given rather than assuming one.

#let ink = luma(35)
#let grey = luma(232)
#let hair = 0.5pt + luma(120)
#let sans = ("Fira Sans", "Helvetica Neue", "Helvetica", "Arial")

#let stat-a = ("M", "WS", "BS", "S", "T", "W", "I", "A", "Sv")
#let stat-b = ("Ld", "Cl", "Wil", "Int")
#let wpn-heads = ("name", "sr", "lr", "str", "ap", "l", "traits")

#let fighter-card(
  w: 5.5in,
  h: 4.25in,
  pad: 0.16in,
  frame: true,
  wpn-rows: 4,
  radius: 2pt,                      // corner rounding on every box
  space: 2.5pt,                     // gap between boxes
  frame-stroke: 1.4pt + luma(70),   // card edge, doubles as the cut line
) = {
  let gap = 5pt
  let top-h = 0.56in
  let hdr-h = 0.18in
  let box-h = 0.24in
  let line-h = 0.27in

  let stats-h = hdr-h + 2pt + box-h
  let footer-h = 3 * line-h + 2 * 3pt

  let lbl(s) = text(size: 5.5pt, tracking: 0.6pt, fill: luma(110), upper(s))

  // -------------------------------------------------------------- top row

  let name-type = grid(
    columns: 1fr,
    rows: (2fr, 1fr),
    row-gutter: space,
    block(width: 100%, height: 100%, stroke: hair, radius: radius),
    block(
      width: 100%, height: 100%,
      stroke: hair, radius: radius, inset: (x: 4pt),
    )[
      #set align(horizon)
      #lbl("type:")
    ],
  )

  let top-row = grid(
    columns: (1fr, top-h),
    column-gutter: 7pt,
    rows: top-h,
    name-type,
    circle(radius: top-h / 2, stroke: 0.9pt + ink)[
      #set align(center + horizon)
      #lbl("creds")
    ],
  )

  // -------------------------------------------------------------- stats

  let stat-hdr(s, shaded) = block(
    width: 100%, height: 100%,
    fill: if shaded { grey } else { white },
    stroke: hair, radius: radius,
  )[
    #set align(center + horizon)
    #text(size: 6.5pt, weight: "bold", tracking: 0.3pt, upper(s))
  ]

  let cell = block(width: 100%, height: 100%, stroke: hair, radius: radius)

  let stat-block = grid(
    columns: (..stat-a.map(_ => 1fr), 1.2pt, ..stat-b.map(_ => 1fr)),
    rows: (hdr-h, box-h),
    column-gutter: space,
    row-gutter: space,
    ..stat-a.map(s => stat-hdr(s, false)),
    grid.cell(rowspan: 2, fill: ink)[],
    ..stat-b.map(s => stat-hdr(s, true)),
    ..stat-a.map(_ => cell),
    ..stat-b.map(_ => cell),
  )

  // -------------------------------------------------------------- weapons

  // Numeric columns hold two digits and a possible minus sign.
  let num = 0.32in
  let wpn-cols = (1fr, num, num, num, num, num, 1fr)

  let wpn-hdr(s) = block(
    width: 100%, height: 100%,
    fill: grey, stroke: hair, radius: radius,
  )[
    #set align(center + horizon)
    #text(size: 6.5pt, weight: "bold", tracking: 0.3pt, upper(s))
  ]

  let weapons = grid(
    columns: wpn-cols,
    rows: (hdr-h, ..range(wpn-rows).map(_ => 1fr)),
    column-gutter: space,
    row-gutter: space,
    ..wpn-heads.map(wpn-hdr),
    ..range(wpn-rows * wpn-cols.len()).map(_ => cell),
  )

  // -------------------------------------------------------------- footer

  let labelled(name) = block(
    width: 100%, height: 100%,
    stroke: hair, radius: radius, inset: (x: 4pt),
  )[
    #set align(horizon)
    #lbl(name)
  ]

  let footer = grid(
    columns: 1fr,
    rows: (1fr, 1fr, 1fr),
    row-gutter: space,
    labelled("skills:"),
    labelled("wargear:"),
    labelled("current / target xp:"),
  )

  // -------------------------------------------------------------- assemble

  block(
    width: w, height: h, inset: pad,
    stroke: if frame { frame-stroke } else { none },
    radius: radius * 2,
  )[
    #set text(font: sans, stretch: 75%, size: 8pt, fill: ink)
    #set block(spacing: 0pt)
    #set par(spacing: 0pt, leading: 0.5em)
    #grid(
      columns: 1fr,
      rows: (top-h, stats-h, 1fr, footer-h),
      row-gutter: gap,
      top-row,
      stat-block,
      weapons,
      footer,
    )
  ]
}

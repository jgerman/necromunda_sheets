// Necromunda gang roster, sidebar layout.
// Left column holds the gang-level record; right side is the fighter list.

#let fighters = 20
#let side-w = 2.5in
#let row-h = 0.34in
#let fld-h = 0.30in
#let terr-h = 1.4in
#let stash-h = 1.4in
#let triumph-h = 0.7in
#let progress-h = 1.0in

#let ink = luma(35)
#let band = luma(246)
#let hair = 0.2pt
#let rule = 0.9pt

#let sans = ("Fira Sans", "Helvetica Neue", "Helvetica", "Arial")

#set page(paper: "us-letter", flipped: true, margin: 0.42in)
#set text(font: sans, stretch: 75%, size: 8pt, fill: ink)

#let lbl(s) = text(size: 5.5pt, tracking: 0.6pt, fill: luma(110), upper(s))

// Labelled write-in line, sized to whatever cell holds it.
#let field(name) = block(width: 100%)[
  #lbl(name)
  #v(-0.5em)
  #line(length: 100%, stroke: 0.5pt + luma(140))
]

// Two fields sharing one row.
#let pair(a, b) = grid(
  columns: (1fr, 1fr), column-gutter: 9pt,
  field(a), field(b),
)

#let pad-box(title, h) = block(
  width: 100%, height: h,
  stroke: 0.7pt + luma(120), inset: 5pt,
)[#lbl(title)]

// ---------------------------------------------------------------- title

#block(fill: ink, inset: (x: 8pt, y: 5pt), width: 100%)[
  #grid(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
    text(fill: white, size: 15pt, weight: "bold", tracking: 2pt)[GANG ROSTER],
    text(fill: luma(170), size: 6.5pt, tracking: 1.5pt)[NECROMUNDA],
  )
]

#v(7pt)

// ---------------------------------------------------------------- sidebar

// Two open boxes rather than ruled rows, stacked. Progress takes the taller slot.
#let triumph-tracker = block(width: 100%)[
  #lbl("triumph tracker")
  #v(3pt)
  #pad-box("triumph", triumph-h)
  #v(8pt)
  #pad-box("progress", progress-h)
]

#let sidebar = grid(
  columns: 1fr,
  rows: (fld-h, fld-h, fld-h, fld-h, terr-h, auto, stash-h),
  row-gutter: 10pt,
  field("gang name"),
  field("gang type"),
  pair("gang rating", "reputation"),
  pair("credits", "wealth"),
  pad-box("territories", terr-h),
  triumph-tracker,
  pad-box("stash", stash-h),
)

// ---------------------------------------------------------------- fighters

#let cols = (1fr, 0.8fr, 0.55in, 0.62in, 0.62in, 0.45in, 1.4fr)
#let ncols = cols.len()
#let nrows = 1 + fighters

#let head-cell(s) = table.cell(
  align: center + horizon,
  text(fill: white, size: 6.5pt, weight: "bold", tracking: 0.5pt, upper(s)),
)

#let roster = table(
  columns: cols,
  rows: (auto, ..range(fighters).map(_ => row-h)),
  align: center + horizon,
  inset: 4pt,

  stroke: (x, y) => (
    left:   if x == 0 { rule } else { hair },
    right:  if x == ncols - 1 { rule } else { 0pt },
    top:    if y <= 1 { rule } else { hair },
    bottom: if y == nrows - 1 { rule } else { 0pt },
  ),
  fill: (x, y) => if y == 0 { ink } else if calc.even(y) { band },

  table.header(
    head-cell("fighter / vehicle name"),
    head-cell("type"),
    head-cell("cost"),
    head-cell("current xp"),
    head-cell("next xp"),
    head-cell("rec"),
    head-cell("lasting injuries"),
  ),

  ..range(fighters * ncols).map(_ => table.cell([])),
)

// ---------------------------------------------------------------- layout

#grid(
  columns: (side-w, 1fr),
  column-gutter: 14pt,
  sidebar,
  roster,
)

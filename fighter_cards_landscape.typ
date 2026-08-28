// Four fighter cards on one letter landscape sheet, two by two.
//
// The margin is the printer's unprintable edge. Cards fill what is left, so
// each comes out slightly under a true quarter page.

#import "lib/card.typ": fighter-card

#let margin = 0.25in
#let gutter = 10pt     // cutting room, and the rounded corners need to breathe

#let sheet-w = 11in
#let sheet-h = 8.5in

#let card-w = (sheet-w - 2 * margin - gutter) / 2
#let card-h = (sheet-h - 2 * margin - gutter) / 2

#set page(width: sheet-w, height: sheet-h, margin: margin)

#grid(
  columns: (card-w, card-w),
  rows: (card-h, card-h),
  column-gutter: gutter,
  row-gutter: gutter,
  ..range(4).map(_ => fighter-card(w: card-w, h: card-h)),
)

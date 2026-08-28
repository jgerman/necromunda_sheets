// Fighter cards stacked in a single column on letter portrait.
//
// Set `cards` to how many you want down the page. The card adapts to whatever
// height it is given, so this is the only knob that matters.

#import "lib/card.typ": fighter-card

#let cards = 2
#let margin = 0.25in
#let gutter = 10pt

#let sheet-w = 8.5in
#let sheet-h = 11in

#let card-w = sheet-w - 2 * margin
#let card-h = (sheet-h - 2 * margin - (cards - 1) * gutter) / cards

#set page(width: sheet-w, height: sheet-h, margin: margin)

#grid(
  columns: card-w,
  rows: (..range(cards).map(_ => card-h)),
  row-gutter: gutter,
  ..range(cards).map(_ => fighter-card(w: card-w, h: card-h)),
)

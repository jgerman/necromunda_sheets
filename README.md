# necromunda_sheets

Printable gang roster sheets for Necromunda, written in [Typst](https://typst.app).

Ready-to-print PDFs live in [`pdfs/`](pdfs/). They are generated from the `.typ`
sources — edit the source, not the PDF.

## Building

```sh
typst compile --font-path fonts \
  gang_roster_core_book_clone.typ pdfs/gang_roster_core_book_clone.pdf
```

Install Typst with `brew install typst`. The `--font-path` flag is required: the
sheets use a font vendored in this repo rather than one from your system, so the
output is identical everywhere.

To check the sheet needs nothing from your system, add `--ignore-system-fonts`.

## Fonts

`fonts/` holds Fira Sans Condensed, Regular and Bold, from
[mozilla/Fira](https://mozilla.github.io/Fira/) version 4.202.

The sheets request the family `Fira Sans` and select the Condensed faces through
`stretch: 75%`. Typst folds the Condensed faces into the `Fira Sans` family, so
asking for `"Fira Sans Condensed"` by name finds nothing.

Fira Sans is copyright the Mozilla Foundation and Telefonica S.A., licensed under
the SIL Open Font License 1.1. The full licence is at
[`fonts/LICENSE`](fonts/LICENSE).

## Licence

Sheet layouts are mine to share. Necromunda is a Games Workshop property; this
repository carries no Games Workshop text or artwork.

# necromunda_sheets

Printable gang roster sheets for Necromunda, written in [Typst](https://typst.app).

Ready-to-print PDFs live in [`pdfs/`](pdfs/), and are attached to every
[release](../../releases). They are generated from the `.typ` sources — edit the
source, not the PDF.

## Generating the PDFs

Install Typst first:

```sh
brew install typst
```

Build one sheet:

```sh
typst compile --font-path fonts \
  gang_roster_core_book_clone.typ pdfs/gang_roster_core_book_clone.pdf
```

Build every sheet:

```sh
for src in *.typ; do
  typst compile --font-path fonts "$src" "pdfs/${src%.typ}.pdf"
done
```

Rebuild on every save while editing:

```sh
typst watch --font-path fonts \
  gang_roster_core_book_clone.typ pdfs/gang_roster_core_book_clone.pdf
```

`--font-path fonts` is required. The sheets use a font vendored in this repo
rather than one from your system, so the output is identical everywhere.

Add `--ignore-system-fonts` to prove a sheet needs nothing from your machine.
Typst then warns about the fallback families, which is expected, and errors if a
vendored font is missing.

**Commit the regenerated PDF alongside the source.** Nothing checks that the two
agree, so a source edit without a rebuild leaves a stale PDF in `pdfs/`.

## Cutting a release

Tag and push. The [release workflow](.github/workflows/release.yml) rebuilds
every sheet on a clean runner and attaches the PDFs.

```sh
git tag v1.0
git push origin v1.0
```

The workflow pins the Typst version, so a release built today matches one built
later.

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

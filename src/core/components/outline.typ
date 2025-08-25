#let graph-outline(..args) = {
  show outline: set heading(outlined: true)
  outline(..args)
}
#let create-page-number(it) = box(
  width: 2.5em,
  align(right, it.page()),
)

/// Inserts outline
/// - lang (string): language for the oultine, "en" or "nl" allowed
/// -> content
#let insert-outline(lang: "en") = {
  // Table of contents
  // Outline customization
  show outline.entry: it => {
    let weight = if it.element.level == 1 { 800 } else { 500 }
    let fill = if it.element.level != 1 {
      repeat(gap: 0.5em)[.]
    } else { [] }
    let rest = (
      text(red, weight: weight)[#it.body()]
        + h(1em)
        + box(width: 1fr, fill)
        + create-page-number(it)
    )
    // TOOD: fix indentation of numbered items
    link(
      it.element.location(),
      it.indented(text(red)[#it.prefix()], rest),
    )
  }
  show outline: set heading(numbering: none, outlined: false)
  show outline.entry.where(level: 1): set block(above: 1.1em)
  let title = if lang == "nl" {
    "Inhoudsopgave"
  } else {
    "Contents"
  }
  outline(title: title, depth: 2)
}

#let insert-figure-outline(lang: "en") = {
  // Table of contents
  // Outline customization
  show outline.entry: it => {
    // (it.element.numbering)(it.element.counter)
    // let rest = (
    //   text(red, weight: 800)[#it.element.caption.body]
    //     + h(1em)
    //     + box(width: 1fr, repeat(gap: 0.5em, [.]))
    //     + create-page-number(it)
    // )
    //TODO: fix long heading/figure names resulting in weird looking outlines
    //TODO: fix numbers being at the bottom when there are long names
    let fill = repeat(gap: 0.5em)[.]
    let rest = box(width: 100%)[
      #text(red)[#it.body()]
      #h(1em)
      #box(width: 1fr, fill)
      #create-page-number(it)
      // + [#it.element.fields()]
    ]
    let location = it.element.location()
    let number = context {
      let chapter-number = counter(heading).at(location).at(0)
      let figure-number = it.element.caption.counter.at(location).at(0)
      (
        numbering("1.1", chapter-number, figure-number)
      )
    }
    link(
      location,
      it.indented(
        text(red)[#number],
        rest,
      ),
    )
  }
  show outline: set heading(numbering: none, outlined: false)
  show outline.entry.where(level: 1): set block(above: 1.1em)
  graph-outline(
    title: if lang == "en" { "List of Figures" } else {
      "Lijst van Figuren"
    },
    target: figure,
  )
}
#let insert-abbrv-symbol-outline(
  lang: "en",
  abbreviations: none,
  symbols: none,
) = {
  let title = if lang == "en" {
    "List of Abbreviations and Symbols"
  } else {
    "Lijst van Afkortingen en Symbolen"
  }
  if abbreviations != none or symbols != none {
    heading(bookmarked: true, level: 1, title)
    if abbreviations != none {
      heading(
        bookmarked: false,
        level: 2,
        if lang == "en" {
          "List of Abbreviations and Symbols"
        } else {
          "Lijst van Afkortingen en Symbolen"
        },
      )
      abbreviations
    }

    if symbols != none {
      heading(
        bookmarked: false,
        level: 2,
        if lang == "en" {
          "List of Abbreviations and Symbols"
        } else {
          "Lijst van Afkortingen en Symbolen"
        },
      )
      abbreviations
    }
  }
}


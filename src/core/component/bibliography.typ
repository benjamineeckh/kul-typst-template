
#let insert-bibliography(bib, lang:"en") = {
  // let std-bibliography = bibliography
  // Bibliography
  if bib != none {
    // pagebreak(to: "odd")
    heading(
      level: 1,
      numbering: none,
      if lang == "en" {
        "Bibliography"
      } else {
        "Bibliografie"
      },
      outlined: true
    )
    show bibliography: set text(size: 0.9em)
    set bibliography(title: none)
    bib
  }
}

// Bibliography
#let insert-bibliography(bib, lang:"en") = {
  if bib != none {
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
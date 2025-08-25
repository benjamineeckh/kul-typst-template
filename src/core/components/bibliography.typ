
// Bibliography
#let insert-bibliography(bib, lang: "en") = {
  if bib != none {
    heading(
      level: 1,
      numbering: none,
      if lang == "en" {
        "Bibliography"
      } else {
        "Bibliografie"
      },
      outlined: true,
    )
    set bibliography(title: none)
    show bibliography: set text(size: 0.9em)
    bib
  }
}

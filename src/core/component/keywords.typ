#let insert-keywords(keywords, lang:"en") = {
  // Keywords
  if keywords != none {
    heading(
      level: 1,
      numbering: none,
      outlined: true,
      if lang == "en" {
        "Nomenclature"
      } else {
        "Lijst Van Symbolen"
      }
    )
    keywords
  }
}
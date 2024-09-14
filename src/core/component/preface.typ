#let insert-preface(preface, authors, lang:"en") = {
  // preface
  if preface != none {
    heading(
      level: 1,
      numbering: none,
      outlined: true,
      if lang == "en" {
        "Preface"
      } else {
        "Voorwoord"
      }
    )
    block[#sym.zws#label("start-of-preamble")]
    v(-1em)
    preface 

    align(right)[_ #authors.map(v=>v.name).join("\n") _]

    pagebreak(weak: true)
  }
}
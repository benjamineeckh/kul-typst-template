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
  }else{
    let t = if lang == "nl"{
      "PLAATSHOUDER VOOR VOORWOORD"
    }else{
      "PLACEHOLDER FOR PREFACE"
    }
    text(purple, size:3em)[#t]
    set text(red)
    lorem(200)
    pagebreak(weak: true)
  }
}
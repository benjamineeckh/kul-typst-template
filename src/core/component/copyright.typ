#let insert-copyright(copyright, lang:"nl") = {
  // set par(justify: true, first-line-indent: 1em, leading: 0.5em)
  // Copyright
  {
    set align(left + bottom)
    set page(numbering: none)
    par(first-line-indent: 0pt)[
      #if lang == "en"{
        text(size: 1em, )[#copyright.at(lang)]
      }else{
        text(size: 1em, )[#copyright.at("en")]
        v(1.5em)
        text(size: 1em, )[#copyright.at(lang)]
      }
    ]
  v(7%)
  }
  pagebreak(weak: true)
}
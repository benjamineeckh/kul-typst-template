/// inserts the copyright page, adds 
#let insert-copyright(copyright, english-master, lang) = {
  // set par(justify: true, first-line-indent: 1em, leading: 0.5em)
  // Copyright
  {
    set align(left + bottom)
    // set text(size:11pt)
    show link: it => [#text(font:"Nimbus Mono PS", weight: 300)[#it]]
    // set page(numbering: none)
    let copyright-text = copyright.at("tm") + v(1.5em)
    if lang == "en"{
      copyright-text += copyright.at("en") + v(1.5em)
    }
    if not english-master{
      copyright-text += copyright.at("nl")
    }

    par(first-line-indent: 0pt, leading: 5pt, justify: true)[
      #text(hyphenate: false, size: 10.5pt)[
        #copyright-text

      ]
    ]
  v(7%)
  }
}
#import "../../assets/text-blobs.typ": copyright
/// inserts the copyright page
/// -> content
#let insert-copyright(
  /// Whether the thesis is done during an English master
  /// -> bool
  english-master,
  /// The language of the thesis
  /// -> Str
  lang,
  /// the name(s) of the author.
  /// -> array
  authors,
) = {
  // Copyright
  set align(left + bottom)
  set par(justify: true, first-line-indent: 0pt)
  show link: it => [#text(font: "Nimbus Mono PS", weight: 300)[#it]]
  set text(hyphenate: false)

  let copyright-strings = copyright([#authors.join(" and ")])

  copyright-strings.tm + v(2em)
  if english-master or lang == "en" {
    copyright-strings.en + v(2em)
  }
  else {
    copyright-strings.nl
  }

  // par(first-line-indent: 0pt, leading: 5pt, justify: true)[
  // text(hyphenate: false, size: 10.5pt)[
  //   #copyright-text
  // ]
  // ]
  v(7%)
}

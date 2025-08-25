#import "assets/text-blobs.typ": copyright, submission-text
#import "core/component.typ"
// #import "core/page-utils.typ"
#import "@preview/tidy:0.4.1"

/// The function used to instantiate the template for the thesis
///
///.
/// -> content
#let template(
  /// The title of the thesis.
  /// -> content
  title: [Thesis bla],
  /// subtitle of the thesis.
  /// -> content
  subtitle: none,
  /// the starting year of the thesis or a tuple of years denoting the starting and ending years.
  /// -> int | (array, int)
  academic-year: 2023,
  /// the name(s) of the author .
  /// -> array
  authors: (),
  /// the name of the promotor(s), or a list of authors.
  /// -> array
  promotors: (),
  /// the name of the assessors(s).
  /// -> array
  assessors: (),
  /// the name of the supervisors(s) (aka mentors).
  /// -> array
  supervisors: (),
  /// your studies, should specify (master, elective and color (in hsv)).
  /// -> array
  degree: (),
  /// the language of the thesis, supported are "nl" and "en".
  /// -> string
  language: "en",
  /// whether to print the document as an electronic version or for printing.
  /// -> bool
  electronic-version: false,
  /// toggle to notify the template that you don't need any Dutch things.
  /// -> bool
  english-master: false,
  /// The preface (voorwoord).
  /// -> content
  preface: none,
  /// The abstract (samenvatting).
  /// -> content
  abstract: none,
  /// (optional) Summary needed if writing a English thesis for the Dutch master.
  /// -> content
  dutch-summary: none,
  /// Whether to automatically add a list of figures
  /// -> bool
  list-of-figures: false,
  /// Whether to automatically add a list of figures
  /// -> bool
  list-of-abbreviations-and-symbols: false,
  /// the size of the text, can choose between 10pt and 11pt.
  /// -> pt
  font-size: 11pt,
  /// the bibliography.
  /// -> content
  bibliography: none,
  /// The appendiceses
  /// -> (content, )
  appendices: none,
  /// automatically inserted content of the thesis.
  /// -> content
  body,
) = {
  // Set document matadata.
  set document(title: title, author: authors)

  set text(font: "New Computer Modern", lang: language, size: font-size)
  set par(first-line-indent: 1em, spacing: 0.65em, justify: true)

  /////////////////////////// Heading config
  // C`++`onfigure headings
  set heading(numbering: "1.1.1")
  show heading.where(level: 1): it => [
    #pagebreak(weak: true)
    #set text(1.2em, weight: "bold")
    #it
  ]

  /////////////////////////// figure numbering
  set figure(numbering: it => context {
    let count = counter(heading).get()
    numbering("1.1", count.at(0), it)
  })
  /////////////////////////// frontpage
  // Print cover page
  if not electronic-version {
    component.insert-cover-page(
      title,
      subtitle,
      authors,
      promotors,
      assessors,
      supervisors,
      academic-year,
      degree,
      english-master,
      cover: true,
      lang: language,
    )
  }
  // Actual cover page
  component.insert-cover-page(
    title,
    subtitle,
    authors,
    promotors,
    assessors,
    supervisors,
    academic-year,
    degree,
    english-master,
    cover: false,
    lang: language,
  )

  /////////////////////////// pre-body content
  // copyright
  component.insert-copyright(english-master, language)

  // numbering setup + header + footer
  set page(
    numbering: (num, ..) => {
      if num <= locate(<end-of-preamble>).page() {
        numbering("i", num - 2)
      } else {
        numbering("1", num - 3 + 2 - locate(<end-of-preamble>).page())
      }
    },
    margin: 28mm,
  )

  // header stuff
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    pad(top: 38mm, bottom: 19mm, {
      set text(1.45em, weight: "bold")
      it.body
    })
  }

  let spacing = 0.5em
  set par(first-line-indent: 0.5cm, leading: spacing, spacing: spacing)
  // preface
  component.insert-preface(preface, authors, lang: language)

  // outline
  component.insert-outline(lang: language)

  // abstract
  component.insert-abstract(abstract, lang: language)

  // Optional dutch abstract
  if (not english-master) and language == "en" {
    component.insert-abstract(dutch-summary, lang: "nl")
  }

  if list-of-figures { component.insert-figure-outline(lang: language) }
  if list-of-abbreviations-and-symbols {
    component.insert-abbrv-symbol-outline(lang: language)
  }

  [#metadata(none) <end-of-preamble>]

  let chapter-numbering = "1.1.1"
  set heading(supplement: "Chapter")
  set heading(numbering: chapter-numbering)
  show heading.where(level: 1): it => {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    (
      [#metadata(none) <heading-page>]
        + [

          #pagebreak(weak: true, to: "odd")
          #block[
            #pad(top: 35mm, text(
              size: 1.3em,
              weight: "semibold",
            )[
              #it.supplement #counter(heading).at(here()).at(0)
            ])
            #pad(top: 1em, bottom: 2em, text(size: 1.7em)[#it.body])

          ]
        ]
    )
    // + [
    //   #pagebreak(weak: true, to: "odd")
    //   #block[
    //     #pad(top: 25mm, text(
    //       size: 1.3em,
    //       weight: "semibold",
    //     )[#it.supplement #numbering(
    //     it.
    //         it.numbering,
    //         counter(heading).get().first(),
    //       )])
    //     #pad(top: 4mm, bottom: 17mm, {
    //       set text(1.5em, weight: "bold")
    //       it.body
    //     })
    //   ]
    // ]
  }

  show heading.where(level: 2): it => block(width: 100%)[
    #set text(1.1em, weight: "bold")
    #pad(top: 0.8em, bottom: 0.8em)[
      #numbering(chapter-numbering, ..counter(heading).get()) #it.body
    ]
  ]
  show heading.where(level: 3): it => block(width: 100%)[
    #set text(1em, weight: "bold")
    #pad(top: 0.8em, bottom: 0.8em)[
      #numbering(chapter-numbering, ..counter(heading).get()) #it.body
    ]
  ]

  // [#metadata(none) <start-of-preamble>]
  body

  if appendices != none {
    component.insert-appendices(appendices)
  }
  component.insert-bibliography(bibliography, lang: language)
}

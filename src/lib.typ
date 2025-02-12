// #import "external-functions.typ":*
#import "text-blobs.typ": copyright, submission-text
#import "@preview/hydra:0.5.1": hydra
#import "core/component.typ"
#import "core/page-utils.typ"



// This is a template adapted from:
// https://typst.app/universe/package/modern-unito-thesis
// Made by
// Eduard Antonovic Occhipinti


// FIXME: workaround for the lack of `std` scope
#let std-bibliography = bibliography


/// The function used to instantiate the template for the thesis
/// 
/// - title (content): The title of the thesis
/// - subtitle (content): 
/// - academic-year (array, int): the starting year of the thesis or a tuple of years denoting the starting and ending years
/// - authors (array): the name(s) of the author 
/// - promotors (array): the name of the promotor(s), or a list of authors
/// - assessors (array): the name of the assessors(s)
/// - supervisors (array): the name of the supervisors(s) (aka mentors)
/// - degree (array): your studies, should specify (master, elective and color (in hsv))
/// - language (string): the language of the thesis, supported are "nl" and "en"
/// - font-size (pt): the size of the text, can choose between 10pt and 11pt
/// - bibliography (content): the bibliography
/// - logo (image, string): the logo for the frontpage
/// - electronic-version (bool): whether to print the document as an electronic version or for printing
/// - preface (content): The preface (voorwoord)
/// - abstract (content): The abstract (samenvatting)
/// - dutch-summary (content): (optional) Summary needed if writing a English thesis for the Dutch master
/// - english-master (bool): toggle to notify the template that you don't need any Dutch things
/// - keywords (content): keywords
/// - pre-body-page (bool): if there should be a blank page before the body (to be manually checked), otherwise results in non-convergence (should be done if there are headers and footers on the page before the body)
/// - body (content): automatically inserted content of the thesis
/// 
/// -> content
#let template(
  title: [Thesis Title],
  subtitle: none,
  academic-year: 2023,
  authors: (),
  promotors: (),
  assessors: (),
  supervisors: (),
  degree: (),
  language: "en",
  font-size: 11pt,
  bibliography: none,

  // The university's logo, should be passed as a call to the `image`
  // function or `none` if you don't need to include a logo
  logo: none,
  electronic-version: false,
  preface: none,
  abstract: none,
  dutch-summary: none,
  english-master: false,
  keywords: none,

  body
) = {
  // Set document matadata.
  set document(title: title, author: authors)

  // Set the body font, "New Computer Modern" gives a LaTeX-like look
  set text(font: "New Computer Modern", lang: language, size: font-size)
  set par(first-line-indent: 1em, spacing:0.65em, justify: true)

  /////////////////////////// page chapter metadata
  context {
  let chapter-end-markers = query(<chapter-end-marker>)
  let chapter-start-markers = query(<chapter-start-marker>)
  let pairs = chapter-end-markers.enumerate().map(((index, chapter-end-marker)) => {
    let chapter-start-marker = chapter-start-markers.at(index)
    let end-page = chapter-end-marker.location().page()
    let start-page = chapter-start-marker.location().page()
    (end-page, start-page)
  })
  state("chapter-markers").update(pairs)
  }



  /////////////////////////// Heading config
  // Configure headings
  set heading(numbering: "1.1.1")
  show heading.where(level: 1): it => [
    #pagebreak(weak: true)
    #set text(1.2em, weight: "bold")
    #it
  ]




  /////////////////////////// frontpage
  // Print cover page
  if not electronic-version{
    
    component.insert-cover-page(title, subtitle, authors, promotors, assessors, supervisors, academic-year, submission-text, degree, english-master, logo:logo, cover:true, lang:language)
  }
  // Actual cover page
  component.insert-cover-page(title, subtitle, authors, promotors, assessors, supervisors, academic-year, submission-text, degree, english-master, logo:logo, cover:false, lang:language)

  // not bothering with it right now cause the way to fix this seems like absolute ass (https://forum.typst.app/t/how-to-get-differently-sized-header-or-footer-depending-on-page-number/322/3?u=benjamine)
  // let (foremargin, spinemargin) = page-utils.calc-page-margins(font-size)
  
  /////////////////////////// page setup
  // margin calculations
  let (inner-margin, outer-margin, margin-top, margin-bot) = page-utils.calc-page-margins(font-size, electronic-version)

  set page(
    margin: (inside: inner-margin, outside: inner-margin, bottom: margin-bot, top: margin-top)
  )

  /////////////////////////// pre-body content
  // copyright
  component.insert-copyright(copyright, english-master, language)

  // numbering setup + header + footer
  set page(numbering: (num, ..) => {
    numbering("i", num - 2)
  }, footer: context page-utils.custom-footer())

  // header stuff
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(38mm)
    block(width: 100%, height: 19mm)[
      #set text(1.45em, weight: "bold")
      #it.body
    ]

  }

  // preface
  component.insert-preface(preface, authors, lang:language)

  // outline
  component.insert-outline(lang:language)

  // abstract
  component.insert-abstract(abstract, lang:language)

  // Optional dutch abstract
  if (not english-master) and language == "en"{
    component.insert-abstract(dutch-summary, lang: "nl")
  }
  

  // Configure equation numbering and spacing.
  set math.equation(numbering: "(1)")

  // Configure headings

  let heading-number = "1.1.1."
  let heading-spacing = context h(measure(heading-number).width - measure(heading-number).width)


  show heading.where(level:1): it => block(width: 100%)[

  ]

  show heading.where(level: 2): it => block(width: 100%)[
    #set text(1.1em, weight: "bold")
    #let heading-number = counter(heading).get().map(str).join(".")
    #heading-number #heading-spacing #it.body
  ]
  show heading.where(level: 3): it => block(width: 100%)[
    #set text(1em, weight: "bold")
    #let heading-number = counter(heading).get().map(str).join(".")
    #heading-number #heading-spacing #it.body
  ]


  set heading(supplement: "Chapter")
  set heading(numbering: "1.1.1")
  show heading.where(level: 1): it => [
    #[] <chapter-end-marker>
    #pagebreak(weak: true, to: "odd")
    #block[
      #v(25mm)
      
      #text(size:1.3em, weight: "semibold")[#it.supplement #counter(heading).get().first()]
      #v(4mm)
    #block[
      #set text(1.5em, weight: "bold")
      #it.body
      #v(17mm)
    ]
    ]<chapter-start-marker>
  ]


//   // Main body
  [#[]<start-of-body>]

  // numbering setup + header + footer    for main body!!
  set page(numbering: (num, ..) => {
    let start-body = locate(<start-of-body>).page()
    numbering("1", num - start-body + 1)
  }, footer: context page-utils.custom-footer())

//   show link: underline
//   set page(numbering: "1", number-align: left, header: hydra-settings)
//   set align(top + left)
//   counter(page).update(1)
  // context locate(<start-of-body>).page()
  body
  

//   // Bibliography
//   if bibliography != none {
//     pagebreak(to: "odd")
//     heading(
//       level: 1,
//       numbering: none,
//       if lang == "en" {
//         "Bibliography"
//       } else {
//         "Bibliografie"
//       },
//       outlined: true
//     )
//     show std-bibliography: set text(size: 0.9em)
//     set std-bibliography(title: none)
//     bibliography
//   }
// 






}
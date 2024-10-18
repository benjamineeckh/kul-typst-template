// #import "external-functions.typ":*
#import "text-blobs.typ": declaration-of-originality, copyright, submission-text
#import "packages.typ"
#import "page-utils.typ"
#import "core/component.typ": *
#import "@preview/hydra:0.5.1": hydra


// This is a template adapted from:
// https://typst.app/universe/package/modern-unito-thesis
// Made by Eduard Antonovic Occhipinti
//
// Adaptation made by Benjamin Eeckhout


// FIXME: workaround for the lack of `std` scope
// #let std-bibliography = bibliography

/// The function used to instantiate the template for the thesis
/// 
/// - title (content): The title of the thesis
/// - subtitle (content): 
/// - academic-year (array, int): the starting year of the thesis or a tuple of years denoting the starting and ending years
/// - authors (string, array): the name of the author, or a list of authors
/// - promotors (array): the name of the promotor(s), or a list of authors
/// - evaluators (string, array): the name of the evaluators(s), or a list of authors
/// - supervisors (string, array): the name of the supervisors(s), or a list of authors
/// - affiliation (array): your studies, requires color (hsv from the pdf), degree and elective
/// - lang (string): the language of the thesis, supported are "nl" and "en"
/// - bibliography (content): the bibliography
/// - logo (image, string): the logo for the frontpage
/// - electronic-version (bool): whether to print the document as an electronic version or for printing
/// - abstract (content): The abstract
/// - preface (content): The preface
/// - keywords (content): keywords
/// - pre-body-page (bool): if there should be a blank page before the body (to be manually checked), otherwise results in non-convergence (should be done if there are headers and footers on the page before the body)
/// - body (content): automatically inserted
/// 
/// -> content
#let template(
  title: [Thesis Title],
  subtitle: none,
  academic-year: (2023, 2025),
  authors: (),
  promotors: none,
  evaluators: none,
  supervisors: none,
  affiliation: (
    color: (1,0,0,0), 
    degree: "bidenomics", 
    elective: "Trumpism"
  ),
  lang: "nl",
  bibliography: none,
  logo: none,
  electronic-version: true,
  abstract: none,
  preface: none,
  keywords: none,
  pre-body-page: false,
  body
) = {
  let non-odd-page-headers = ("Declaration of Originality", "Declaratie van originaliteit", "Preface", "Voorwoord", "Abstract", "Samenvatting", "Nomenclature", "Lijst Van Symbolen", "Contents","List of Abbreviations and Symbols", "List of Figures and Tables", "Bibliography", "Bibliografie")


  set page(margin: (top: 10em),  header: context page-utils.custom-header())
  
  // Set document matadata.
  // let parsed-authors = authors
  
  set document(title: title, author: authors)

  // Set the body font, "New Computer Modern" gives a LaTeX-like look
  set text(font: "New Computer Modern", lang: lang, size: 11pt)

  // Configure equation numbering and spacing.
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  // Configure figure's captions
  show figure.caption: set text(size: 0.8em)
  // Configure lists and enumerations.
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt, marker: ([•], [--]))


  /////////////////////////// Heading config
  // Configure headings
  set heading(numbering: "1.1.1")
  show heading.where(level: 1): it => [
    #pagebreak(weak: true)
    #set text(1.2em, weight: "bold")
    #it
  ]


  show heading.where(level: 2): it => block(width: 100%)[
    #set text(1.1em, weight: "bold")
    #let heading-number = counter(heading).get().map(str).join(".")
    #heading-number #h(measure([1.1.1.]).width - measure(heading-number).width)
    #it.body
  ]
  show heading.where(level: 3): it => block(width: 100%)[
    #set text(1em, weight: "bold")
    #let heading-number = counter(heading).get().map(str).join(".")
    #heading-number #h(measure([1.1.1.]).width - measure(heading-number).width)
    #it.body
  ]

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


  /////////////////////////// actual content
  // Print cover page
  if not electronic-version{
    insert-cover-page(title, authors, promotors, evaluators, supervisors, academic-year, submission-text, affiliation, logo:logo, cover:true, lang:lang)
  }
  // Actual cover page
  insert-cover-page(title, authors, promotors, evaluators, supervisors, academic-year, submission-text, affiliation, logo:logo, cover:false, lang:lang)

  // Copyright
  insert-copyright(copyright)

  // custom numbering because KUL
  set page(numbering: (num, ..) => {
    let body = locate(<start-of-body>).page()
    let preamble = locate(<start-of-preamble>).page()
    // let body = 7
    let pat = if num < body{ "i" } else { "1" }
    if num < body{
      numbering(pat, num - preamble + 1)
    }else{
      numbering(pat, num - body + 1)
    }
  })
  set page(footer: context page-utils.custom-footer())

  // // Declaration of originality, prints in English or Dutch
  // insert-dec-of-orig(declaration-of-originality)


  // Preface
  insert-preface(preface, authors, lang:lang)
  // Outline
  insert-outline(non-odd-page-headers)
  // Abstract
  insert-abstract(abstract, lang:lang)
  // Keywords
  insert-keywords(keywords, lang:lang)
  // context if calc.odd(page-utils.get-page-number()){
  //   page(footer: none, header: none, numbering: none)[]
  // }
  if pre-body-page{
  page(header: none, footer: none, numbering: none)[]
  }

  // Set markers for annoying transition between abstract and actual text
  // [<chapter-end-marker>] // marker positioned before the pagebreak
  // pagebreak(to: "odd", weak: true)
  // [<chapter-start-marker>]

  // set align(top + left)
  // context state("chapter-markers").get()
  // set headings to update correctly
  show heading.where(level: 1): it => [
    #[] <chapter-end-marker> // marker positioned before the pagebreak
    // #if not non-odd-page-headers.contains(it.body.text) and not counter(heading).get().first() == 1{
      #pagebreak(to: "odd", weak: true)
    // }
  
    #block[
    #v(15.55%) // kinda ass offset, but this is now the same as the latex one    Should really check the latex source code (I don't understand latex syntax it is arcane magic)
    // #if not non-odd-page-headers.contains(it.body.text){
      // This is correct because the level is 1
      Chapter #counter(heading).get().first()

    // }
    #v(6%)
    // Needed because we need to know where the actual body of the text begins
    #let lab = if counter(heading).get().first() == 1{
      <start-of-body>
    }
    #block(width: 100%, height: 7%)[
      #set text(1.45em, weight: "bold")
      #it.body
      
    ]#lab
    ]<chapter-start-marker>
  ]
  body
  pagebreak(weak: true)
  insert-bibliography(bibliography, lang:lang)
}
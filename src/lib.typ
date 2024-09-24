// #import "external-functions.typ":*
#import "text-blobs.typ":declaration-of-originality, copyright, submission-text
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

#let template(
  // Your thesis title
  title: [Thesis Title],

  // The academic year you're graduating in
  academic-year: (2023),

  // Your thesis subtitle, should be something along the lines of
  // "Bachelor's Thesis", "bachelorproef" etc.
  subtitle: [Master's Thesis],

  // The paper size, refer to https://typst.app/docs/reference/layout/page/#parameters-paper for all the available options
  paper-size: "a4",

  // authors's informations. You should specify a `name` key
  authors: (),

  // Array with the thesis' promotor(s)
  promotors: (),

  // An array of the thesis' evaluators.
  // Set to `none` if not needed
  evaluators: (),

  // An array of the thesis' supervisors
  // set to `none` if not needed
  supervisors: (),

  // An affiliation dictionary, you should specify a `university`
  // keyword, `school` keyword and a `degree` keyword
  affiliation: (
    color: (1,0,0,0), 
    faculty: "politics", 
    degree: "bidenomics", 
    elective: "Trumpism"
  ),

  // Set to "it" for the italian template
  lang: "en",

  // The thesis' bibliography, should be passed as a call to the
  // `bibliography` function or `none` if you don't need
  // to include a bibliography
  bibliography: none,

  // The university's logo, should be passed as a call to the `image`
  // function or `none` if you don't need to include a logo
  logo: none,

  // whether it is an electronic version or not
  // does not include front page if electronic
  electronic-version: false,

  // Abstract of the thesis, set to none if not needed
  abstract: none,

  // preface, set to none if not needed
  preface: none,

  // Will maybe be removed
  declaration-of-originality:none,

  // The thesis' keywords, can be left empty if not needed
  keywords: none,

  // The thesis' content
  body
) = {
  let non-odd-page-headers = ("Declaration of Originality", "Declaratie van originaliteit", "Preface", "Voorwoord", "Abstract", "Samenvatting", "Nomenclature", "Lijst Van Symbolen", "Contents","List of Abbreviations and Symbols", "List of Figures and Tables", "Bibliography", "Bibliografie")


  set page(paper: paper-size, margin: (top: 10em),  header: context page-utils.custom-header())
  
  // Set document matadata.
  set document(title: title, author: authors.map(v=>v.name))

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
    #[] <chapter-end-marker> // marker positioned before the pagebreak
    #if not non-odd-page-headers.contains(it.body.text) and not counter(heading).get().first() == 1{
      pagebreak(to: "odd", weak: true)
    }
  
    #block[
    #v(15.55%) // kinda ass offset, but this is now the same as the latex one    Should really check the latex source code
    #if not non-odd-page-headers.contains(it.body.text){
      // This works because the level is 1
      [Chapter #counter(heading).get().first()]

    }
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
    insert-cover-page(title,authors, promotors, evaluators, supervisors, academic-year, submission-text, affiliation, logo:logo,cover:true, lang:lang)
  }
  // Actual cover page
  insert-cover-page(title,authors, promotors, evaluators, supervisors, academic-year, submission-text, affiliation, logo:logo,cover:false, lang:lang)

  // Copyright
  insert-copyright(copyright)
  set page(footer: context page-utils.custom-footer())

  // Declaration of originality, prints in English or Dutch
  insert-dec-of-orig(declaration-of-originality)

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

  // set align(top + left)

  body
  pagebreak(weak: true)
  insert-bibliography(bibliography, lang:lang)
}
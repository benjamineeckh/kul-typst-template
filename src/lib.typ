// #import "external-functions.typ":*
#import "text-blobs.typ":declaration-of-originality, copyright, submission-text
#import "@preview/hydra:0.5.1": hydra



// This is a template adapted from:
// https://typst.app/universe/package/modern-unito-thesis
// Made by
// Eduard Antonovic Occhipinti


// FIXME: workaround for the lack of `std` scope
#let std-bibliography = bibliography

#let template(
  // Your thesis title
  title: [Thesis Title],

  // The academic year you're graduating in
  academic-year: [2023/2024],

  // Your thesis subtitle, should be something along the lines of
  // "Bachelor's Thesis", "Tesi di Laurea Triennale" etc.
  subtitle: [Master's Thesis],

  // The paper size, refer to https://typst.app/docs/reference/layout/page/#parameters-paper for all the available options
  paper-size: "a4",

  // Candidate's informations. You should specify a `name` key
  candidate: (),

  // The thesis' promotor
  promotors: (),

  // An array of the thesis' evaluators.
  // Set to `none` if not needed
  evaluators: (),

  // An array of the thesis' supervisors
  // set to `none` if not needed
  supervisors: (),

  // An affiliation dictionary, you should specify a `university`
  // keyword, `school` keyword and a `degree` keyword
  affiliation: (),

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

  declaration-of-originality:false,

  // The thesis' keywords, can be left empty if not needed
  keywords: none,

  //
  Summary: none,

  // The thesis' content
  body
) = {
  // Set document matadata.
  set document(title: title, author: candidate.name)

  // Set the body font, "New Computer Modern" gives a LaTeX-like look
  set text(font: "New Computer Modern", lang: lang, size: 11pt)

  // Parse the given logo
  if logo != none {
    let t = type(logo)
    if t == figure or t == content{
      logo = logo
    }else if t == str{
      logo = image(logo)
    }else{
      panic("check the typing of the logo, something is wrong with it")
    }
  }
  let hydra-settings = context {
  if calc.odd(here().page()) {
    let entry = hydra(skip-starting:true, 1)
    if entry != none{
      align(left, emph(entry))
      v(-0.8em)
      line(length: 100%)
    }
  } else {
    let entry = hydra(skip-starting:true, 2)
    if entry != none{
      align(right, emph(entry))
      v(-0.8em)
      line(length: 100%)
    }
  }
}

  // Configure the page and hydra settings
  set page(paper: paper-size, margin: (y: 10em), numbering: "1", header: hydra-settings)



  // Configure equation numbering and spacing.
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  // Configure raw text/code blocks
  show raw.where(block: true): set text(size: 0.8em, font: "Fira Code")
  show raw.where(block: true): set par(justify: false)
  show raw.where(block: true): block.with(
    fill: gradient.linear(luma(240), luma(245), angle: 270deg),
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )
  show raw.where(block: false): box.with(
    fill: gradient.linear(luma(240), luma(245), angle: 270deg),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )
  // Configure figure's captions
  show figure.caption: set text(size: 0.8em)

  // Configure lists and enumerations.
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt, marker: ([•], [--]))
  let non-odd-page-headers = ("Declaration of Originality", "Declaratie van originaliteit", "Preface", "Voorwoord", "Abstract", "Samenvatting", "Nomenclature", "Lijst Van Symbolen", "Bibliography", "Bibliografie", "Contents")
  // Configure headings
  set heading(numbering: "1.1.1")
  show heading.where(level: 1): it => {
    if not (lower(it.body.text) in non-odd-page-headers.map(lower)){
      pagebreak(weak: true, to: "odd")
    }
    v(15.55%) // kinda ass offset, but this is now the same as the latex one    Should really check the latex source code
  //   [#context query(
  //   selector(heading).before(here()),
  // ) ]
    text(1.5em, weight: "bold")[#it]
    v(6%)
    // block(width: 100%, height: 7%)[
    //   #set text(1.45em, weight: "bold")
    //   #it
    // ]
  }
  show heading.where(level: 2): it => block(width: 100%)[
    #set text(1.1em, weight: "bold")
    #smallcaps(it)
  ]
  show heading.where(level: 3): it => block(width: 100%)[
    #set text(1em, weight: "bold")
    #smallcaps(it)
  ]


let cover-page(cover: false) = { // diferent scope so logo and font don't get copied over to all the other pages
  set page(
    header:none,
    numbering: none,
    background: 
    place(
      top + left,
      dy: 3.5%,
      dx: 5%,
      logo
    ))
  set text(
    font: "Nimbus Sans"
  )
  v(25%)  
  text(2.3em, weight: 500, title)
  v(4%)
  text(1.5em, weight: 500, candidate.name)
  v(8%)
  set align(right)
  // promotors, evaluators, supervisors
  block(width: 40%)[
    #[
      #set text(size: 11pt)
      #submission-text(affiliation.degree, affiliation.elective).at(lang)
    ]

    #if promotors == none{
      panic("You probably need to have a promotor")
    }else{
      if lang == "en"{
        
        [*Promotors*: #linebreak()]
      }else{
        [*Promotoren*: #linebreak()]
      }
      promotors.join(linebreak())
      linebreak()
    }
    #if not cover{
      if evaluators == none{
        // []
      }else{
        if lang == "en"{
          [*Evaluators*: #linebreak()]
        }else{
          [*Evaluatoren*: #linebreak()]
        }
        evaluators.join(linebreak())
        linebreak()
      }

      if supervisors == none{
        // []
      }else{
        if lang == "en"{
          [*Supervisors*: #linebreak()]
        }else{
          [*Begeleider*: #linebreak()]
        }
        supervisors.join(linebreak())
      }
    }
  ]
  
  // let affiliation = (color:none)
  let heigth = if affiliation.color != none and cover{
    6%
  } else {
    3%  
  }  
  let title-page-footer = text(1.2em, weight: 500,[
      #if lang == "en" {
        "Academic Year "
      } else {
        "Academiejaar "
      }
      #academic-year
    ])
  title-page-footer += if affiliation.color != none and cover{
      v(1em)
      let col = cmyk(..affiliation.color.background-color.map(v => v*100%))
      rect(width: 110%, height: 3em, fill: col, stroke:none)[#align(center+horizon)[#text(fill:affiliation.color.text-color)[#affiliation.degree: #affiliation.elective]]]
  }
  place(
    center + bottom,
    dy: heigth,

    title-page-footer
  )
}

  // Title page
if not electronic-version{
  cover-page(cover:true)
}
cover-page(cover:false) 

  // pagebreak(to: "odd")
  set par(justify: true, first-line-indent: 1em, leading: 0.5em)
  // set align(center + horizon)

  // Copyright
  {
    set align(left + bottom)
    set page(numbering: none)
    par(first-line-indent: 0pt)[
      #text(size: 1em, )[#copyright]
    ]
  v(7%)
  }
  pagebreak(weak: true)
  set align(top+left)
  // Declaration of originality, prints in English or Dutch
  // depending on the `lang` parameter
  if declaration-of-originality{
  heading(
    level: 1,
    numbering: none,
    outlined: false,
    if lang == "en" {
      "Declaration of Originality"
    } else {
      "Declaratie van originaliteit"
    }
  )
  text(style: "italic", declaration-of-originality.at(lang))
  pagebreak(weak: true)
  }

  set page(numbering: "i")
  counter(page).update(1)
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
    preface

    align(right)[_ #candidate.name _]

    pagebreak(weak: true)
  }

  // Table of contents
  // Outline customization
  show outline.entry.where(level: 1): it => {
    v(12pt, weak: true)
    link(it.element.location(), strong({
      it.body
      h(1fr)
      it.page
    }))
  }
  outline(depth: 2, indent: true)
  pagebreak(weak: true)


  // Abstract
  if abstract != none {
    heading(
      level: 1,
      numbering: none,
      outlined: true,
      if lang == "en"{
        "Abstract"
      }else{
        "Samenvatting"
      }
    )
    abstract
  }

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

  pagebreak(weak: true, to: "odd")



  // Main body

  show link: underline
  set page(numbering: "1", number-align: left, header: hydra-settings)
  set align(top + left)
  counter(page).update(1)

  body
  

  // Bibliography
  if bibliography != none {
    pagebreak(to: "odd")
    heading(
      level: 1,
      numbering: none,
      if lang == "en" {
        "Bibliography"
      } else {
        "Bibliografie"
      },
      outlined: true
    )
    show std-bibliography: set text(size: 0.9em)
    set std-bibliography(title: none)
    bibliography
  }
}
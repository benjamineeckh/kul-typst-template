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
/// - authors (string, array): the name of the author, or a list of authors
/// - promotors (array): the name of the promotor(s), or a list of authors
/// - assessors (string, array): the name of the assessors(s), or a list of authors
/// - supervisors (string, array): the name of the supervisors(s), or a list of authors (aka mentors)
/// - degree (array): your studies, should specify (master, elective and color (in hsv))
/// - language (string): the language of the thesis, supported are "nl" and "en"
/// - font-size (pt): the size of the text, can choose between 10pt and 11pt
/// - bibliography (content): the bibliography
/// - logo (image, string): the logo for the frontpage
/// - electronic-version (bool): whether to print the document as an electronic version or for printing
/// - preface (content): The preface (voorwoord)
/// - abstract (content): The abstract (samenvatting)
/// - dutch-summary (content): Summary needed if writing a English thesis for the Dutch master
/// - english-master (bool): toggle to notify the template that you don't need any Dutch things
/// - keywords (content): keywords
/// - pre-body-page (bool): if there should be a blank page before the body (to be manually checked), otherwise results in non-convergence (should be done if there are headers and footers on the page before the body)
/// - body (content): automatically inserted content of the thesis
/// 
/// -> content
#let template(
  title: [Thesis Title],
  subtitle: [Master's Thesis],
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



  /////////////////////////// Heading config
  // Configure headings
  set heading(numbering: "1.1.1")
  show heading.where(level: 1): it => [
    #pagebreak(weak: true)
    #set text(1.2em, weight: "bold")
    #it
  ]

  let heading-spacing() = h(measure([1.1.1.]).width - measure(heading-number).width)

  show heading.where(level: 2): it => block(width: 100%)[
    #set text(1.1em, weight: "bold")
    #let heading-number = counter(heading).get().map(str).join(".")
    #heading-number #heading-spacing() #it.body
  ]
  show heading.where(level: 3): it => block(width: 100%)[
    #set text(1em, weight: "bold")
    #let heading-number = counter(heading).get().map(str).join(".")
    #heading-number #heading-spacing() #it.body
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
  
  let (inner-margin, outer-margin) = page-utils.calc-page-margins(font-size, electronic-version)

  set page(
    margin: (right: inner-margin, left: inner-margin, bottom: 28.5mm)
  )
  component.insert-copyright(copyright, english-master, language)

  // temp version because I don't want to think about changing margins
  set par(leading: if font-size == 11pt{2.5pt}else{2pt})
  
  

//   // Configure the page and hydra settings
//   set page(paper: paper-size, margin: (y: 10em), numbering: "1", header: hydra-settings)



//   // Configure equation numbering and spacing.
//   set math.equation(numbering: "(1)")
//   show math.equation: set block(spacing: 0.65em)

//   // Configure raw text/code blocks
//   show raw.where(block: true): set text(size: 0.8em, font: "Fira Code")
//   show raw.where(block: true): set par(justify: false)
//   show raw.where(block: true): block.with(
//     fill: gradient.linear(luma(240), luma(245), angle: 270deg),
//     inset: 10pt,
//     radius: 4pt,
//     width: 100%,
//   )
//   show raw.where(block: false): box.with(
//     fill: gradient.linear(luma(240), luma(245), angle: 270deg),
//     inset: (x: 3pt, y: 0pt),
//     outset: (y: 3pt),
//     radius: 2pt,
//   )
//   // Configure figure's captions
//   show figure.caption: set text(size: 0.8em)

//   // Configure lists and enumerations.
//   set enum(indent: 10pt, body-indent: 9pt)
//   set list(indent: 10pt, body-indent: 9pt, marker: ([•], [--]))
//   let non-odd-page-headers = ("Declaration of Originality", "Declaratie van originaliteit", "Preface", "Voorwoord", "Abstract", "Samenvatting", "Nomenclature", "Lijst Van Symbolen", "Bibliography", "Bibliografie", "Contents")
//   // Configure headings
//   set heading(numbering: "1.1.1")
//   show heading.where(level: 1): it => {
//     if not (lower(it.body.text) in non-odd-page-headers.map(lower)){
//       pagebreak(weak: true, to: "odd")
//     }
//     v(15.55%) // kinda ass offset, but this is now the same as the latex one    Should really check the latex source code
//   //   [#context query(
//   //   selector(heading).before(here()),
//   // ) ]
//     text(1.5em, weight: "bold")[#it]
//     v(6%)
//     // block(width: 100%, height: 7%)[
//     //   #set text(1.45em, weight: "bold")
//     //   #it
//     // ]
//   }
//   show heading.where(level: 2): it => block(width: 100%)[
//     #set text(1.1em, weight: "bold")
//     #smallcaps(it)
//   ]
//   show heading.where(level: 3): it => block(width: 100%)[
//     #set text(1em, weight: "bold")
//     #smallcaps(it)
//   ]


// let cover-page(cover: false) = { // diferent scope so logo and font don't get copied over to all the other pages
//   set page(
//     header:none,
//     numbering: none,
//     background: 
//     place(
//       top + left,
//       dy: 3.5%,
//       dx: 5%,
//       logo
//     ))
//   set text(
//     font: "Nimbus Sans"
//   )
//   v(25%)  
//   text(2.3em, weight: 500, title)
//   v(4%)
//   text(1.5em, weight: 500, candidate.name)
//   v(8%)
//   set align(right)
//   // promotors, evaluators, supervisors
//   block(width: 40%)[
//     #[
//       #set text(size: 11pt)
//       #submission-text(affiliation.degree, affiliation.elective).at(lang)
//     ]

//     #if promotors == none{
//       panic("You probably need to have a promotor")
//     }else{
//       if lang == "en"{
        
//         [*Promotors*: #linebreak()]
//       }else{
//         [*Promotoren*: #linebreak()]
//       }
//       promotors.join(linebreak())
//       linebreak()
//     }
//     #if not cover{
//       if evaluators == none{
//         // []
//       }else{
//         if lang == "en"{
//           [*Evaluators*: #linebreak()]
//         }else{
//           [*Evaluatoren*: #linebreak()]
//         }
//         evaluators.join(linebreak())
//         linebreak()
//       }

//       if supervisors == none{
//         // []
//       }else{
//         if lang == "en"{
//           [*Supervisors*: #linebreak()]
//         }else{
//           [*Begeleider*: #linebreak()]
//         }
//         supervisors.join(linebreak())
//       }
//     }
//   ]
  
//   // let affiliation = (color:none)
//   let heigth = if affiliation.color != none and cover{
//     6%
//   } else {
//     3%  
//   }  
//   let title-page-footer = text(1.2em, weight: 500,[
//       #if lang == "en" {
//         "Academic Year "
//       } else {
//         "Academiejaar "
//       }
//       #academic-year
//     ])
//   title-page-footer += if affiliation.color != none and cover{
//       v(1em)
//       let col = cmyk(..affiliation.color.background-color.map(v => v*100%))
//       rect(width: 110%, height: 3em, fill: col, stroke:none)[#align(center+horizon)[#text(fill:affiliation.color.text-color)[#affiliation.degree: #affiliation.elective]]]
//   }
//   place(
//     center + bottom,
//     dy: heigth,

//     title-page-footer
//   )
// }

//   // Title page
// if not electronic-version{
//   cover-page(cover:true)
// }
// cover-page(cover:false) 

//   // pagebreak(to: "odd")
//   set par(justify: true, first-line-indent: 1em, leading: 0.5em)
//   // set align(center + horizon)

//   // Copyright
//   {
//     set align(left + bottom)
//     set page(numbering: none)
//     par(first-line-indent: 0pt)[
//       #text(size: 1em, )[#copyright]
//     ]
//   v(7%)
//   }
//   pagebreak(weak: true)
//   set align(top+left)
//   // Declaration of originality, prints in English or Dutch
//   // depending on the `lang` parameter
//   if declaration-of-originality{
//   heading(
//     level: 1,
//     numbering: none,
//     outlined: false,
//     if lang == "en" {
//       "Declaration of Originality"
//     } else {
//       "Declaratie van originaliteit"
//     }
//   )
//   text(style: "italic", declaration-of-originality.at(lang))
//   pagebreak(weak: true)
//   }

//   set page(numbering: "i")
//   counter(page).update(1)
//   // preface
//   if preface != none {
//     heading(
//       level: 1,
//       numbering: none,
//       outlined: true,
//       if lang == "en" {
//         "Preface"
//       } else {
//         "Voorwoord"
//       }
//     )
//     preface

//     align(right)[_ #candidate.name _]

//     pagebreak(weak: true)
//   }

//   // Table of contents
//   // Outline customization
//   show outline.entry.where(level: 1): it => {
//     v(12pt, weak: true)
//     link(it.element.location(), strong({
//       it.body
//       h(1fr)
//       it.page
//     }))
//   }
//   outline(depth: 2, indent: true)
//   pagebreak(weak: true)


//   // Abstract
//   if abstract != none {
//     heading(
//       level: 1,
//       numbering: none,
//       outlined: true,
//       if lang == "en"{
//         "Abstract"
//       }else{
//         "Samenvatting"
//       }
//     )
//     abstract
//   }

//   // Keywords
//   if keywords != none {
//     heading(
//       level: 1,
//       numbering: none,
//       outlined: true,
//       if lang == "en" {
//         "Nomenclature"
//       } else {
//         "Lijst Van Symbolen"
//       }
//     )
//     keywords
//   }

//   pagebreak(weak: true, to: "odd")



//   // Main body

//   show link: underline
//   set page(numbering: "1", number-align: left, header: hydra-settings)
//   set align(top + left)
//   counter(page).update(1)

//   body
  

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



}
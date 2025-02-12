#import "@preview/hydra:0.5.1"

/// needs context, generates the headers for each page for the pre-body stuff
/// -> content
#let generate-i-page-header() = {
  if calc.even(here().page()){
    let header = align(left)[#smallcaps(hydra(1, skip-starting:true))]
    if header != none{
      header
      v(-0.8em)
      line(100%)
    }
  }else{
    let header = align(right)[#smallcaps(hydra(1, skip-starting:false))]
    if header != none{
      header
      v(-0.8em)
      line(100%)
    }
  }
}


/// needs context, generates the headers for each page for the body
/// -> content
#let generate-body-header() = {
  if calc.even(here().page()){
    let entry = align(left)[#smallcaps(hydra(1, skip-starting:true))]
    if header != none{
      entry.children.first() + [. ] + entry.children.last()
      v(-0.8em)
      line(100%)
    }
  }else{
    let entry = align(right)[#smallcaps(hydra(2, skip-starting:false))]
    if header != none{
      entry.children.first() + [. ] + entry.children.last()
      v(-0.8em)
      line(100%)
    }
  }
}

/// Needs context
/// 
/// Checks if a page was inserted
/// - loc (location): The location of the page
/// 
/// -> bool
#let page-is-inserted(loc) = {
  let pairs = state("chapter-markers").at(loc)
  if pairs == none { return false }
  // page is inserted if surrounded by end- and start-marker for any chapter
  return pairs.any(((end-page, start-page)) => {
    loc.page() > end-page and loc.page() < start-page
  })
}


/// calculates the page margins for the template margins are:
/// (foremargin, spinemargin, top-margin, bottom-margin)
/// - font-size (size): the font size used in the document (should be 11pt or 10pt)
/// -> (length, length, length, length)
#let calc-page-margins(font-size, electronic-version) = {
  let textwidth = if font-size == 11pt{
    140mm
  }else{
    130mm
  }
  let textheight = if font-size == 11pt{
    215mm
  }else{
    200mm
  }
  let mult = if electronic-version{
    0.5
  }else{
    0.6
  }
  // 210mm is page size for a4, 16mm is just a 
  let foremargin = (1-mult)*(210mm - textwidth)
  let spinemargin = (1-mult)*(210mm - textwidth - 16mm) + 16mm
  let margin = 28.5mm*1.5
  return (foremargin, spinemargin, margin - 1em, margin)
}

/// Needs context
/// creates a footer with the correct numbering, location and checks if it needs to be printed
/// 
/// -> content
#let custom-footer() = {
  if not page-is-inserted(here()){
    let dir = if calc.even(here().page()){
      left
    }else{
      right
    }
    let num = here().page-numbering()(counter(page).at(here()).first())
    v(-2.5em) // kinda ugly offset
    align(dir + top, num)
  }
}
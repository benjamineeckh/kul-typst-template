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

/// calculates the page margins for the template 
/// - font-size (size): the font size used in the document (should be 11pt or 10pt)
/// -> (length, length)
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
  return (foremargin, spinemargin)
}
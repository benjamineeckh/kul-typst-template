#import "packages.typ":hydra
// needs context
// Checks if a (level 1) heading is on the page
#let heading-on-page() = {
  let hs = query(selector(<chapter-start-marker>).after(here())).map(v => v.location().page())
  return hs.contains(here().page())
}

// needs context
// computes the actual page number for a page
// I don't really like it, but it works
#let get-page-number() = {
  let body = locate(<start-of-body>).page()
  let preamble = locate(<start-of-preamble>).page()
  let num = if here().page() < body{
    here().page() - preamble + 1
  }else{
    here().page() - body + 1
  }
  return int(num)
}

// Checks if a page was inserted
#let page-is-inserted(loc) = {
  let pairs = state("chapter-markers").at(loc)
  if pairs == none { return false }
  // page is inserted if surrounded by end- and start-marker for any chapter
  return pairs.any(((end-page, start-page)) => {
    loc.page() > end-page and loc.page() < start-page
  })
}


// needs context
// heading generation, depends on if the page is even or odd
#let hydra-settings = context {
  if calc.even(get-page-number()) {
    let entry = hydra(skip-starting:true, 1)
    if entry != none{
      // [#entry.fields()]
      entry = if entry.has("text"){
        entry.text
      }else{
        entry.children.first() + [. ] + entry.children.last()
      }
      // align(left)[#smallcaps()]
      align(left)[#smallcaps(entry)]
      v(-0.8em)
      line(length: 100%)
    }
  } else {
    if not heading-on-page(){
      let entry = hydra(2, skip-starting:false)
      if entry == none{
        entry = hydra(1)
      }
      if entry != none{
        entry = if entry.has("text"){
        entry.text
      }else{
        entry.children.first() + [. ] + entry.children.last()
      }
        align(right)[#smallcaps(entry)]
        v(-0.8em)
        line(length: 100%)
      }
    }
  }
    // [#query(<chapter-start-marker>).map(v => v.location().page())
    
    // #here().page()
    
    // #counter(page).get()]
}

// needs context
// custom header, used in `set page(header:...)`
#let custom-header = context {
  if not page-is-inserted(here()){
    [#hydra-settings]
  }
  // [#here().page()]
    
}
// needs context
// custom footer, used in `set page(footer:...)`
#let custom-footer = context {
  if not page-is-inserted(here()) {
    let num = get-page-number()
    let dir = if calc.odd(int(num)){
      right
    }else{
      left
    }
    let num = here().page-numbering()(here().page())
    align(dir, num)
  }
}
#import "packages.typ":hydra
#let heading-on-page() = {
  let hs = query(selector(<chapter-start-marker>).after(here())).map(v => v.location().page())
  return hs.contains(counter(page).get().first())
}

// Configure the page and hydra settings
#let page-is-inserted(loc) = {
  let pairs = state("chapter-markers").at(loc)
  if pairs == none { return false }
  // page is inserted if surrounded by end- and start-marker for any chapter
  return pairs.any(((end-page, start-page)) => {
    loc.page() > end-page and loc.page() < start-page
  })
}


// Inserts 
#let hydra-settings = context {
  if calc.even(counter(page).get().first()) {
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

#let custom-header = context {
  if not page-is-inserted(here()){
    [#hydra-settings]
  }
  // [#here().page()]
    
}
// needs context
// checks if the page is inserted, then adds numbering if not
#let custom-footer = context {
  if not page-is-inserted(here()) {

    let body = locate(<start-of-body>).page()
    let preamble = locate(<start-of-preamble>).page()
    let num = if here().page() < body{
      here().page() - preamble + 1
    }else{
      here().page() - body + 1
    }
    let dir = if calc.odd(int(num)){
      right
    }else{
      left
    }
    let num = here().page-numbering()(here().page())
    align(dir, num)
  }
}
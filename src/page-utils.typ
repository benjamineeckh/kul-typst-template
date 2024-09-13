#import "packages.typ":*
#let heading-on-page() = {
  let hs = query(selector(<chapter-start-marker>).after(here())).map(v => v.location().page())
  return hs.contains(here().page())
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



#let hydra-settings = context {
  if calc.even(here().page()) {
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
      let entry = hydra(2)
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
}

#let custom-header = context {
  if not page-is-inserted(here()){
    [#hydra-settings]
  }
  // [#here().page()]
    
}


#let custom-footer = context {
  if not page-is-inserted(here()) {
    let pat = if here().page() < locate(<start-of-doc>).page(){
      "i"
    }else{
      "1"
    }
    if calc.odd(counter(page).get().first()){
      align(right, counter(page).display(pat));
    }else{
      align(left, counter(page).display(pat));
    }
  }
}

#let custom-footer-num = context {
  if not page-is-inserted(here()) {
    if calc.odd(counter(page).get().first()){
      align(right, counter(page).display("1"));
    }else{
      align(left, counter(page).display("1"));
    }
  }
}
#let custom-footer-i = context {
  if not page-is-inserted(here()) {
    if calc.odd(counter(page).get().first()){
      align(right, counter(page).display("i"));
    }else{
      align(left, counter(page).display("i"));
    }
  }
}

  // queries markers and updates state with pairwise pages for each chapter
#let generate-markers = context {
  let chapter-end-markers = query(label("chapter-end-marker"))
  let chapter-start-markers = query(<chapter-start-marker>)
  let pairs = chapter-end-markers.enumerate().map(((index, chapter-end-marker)) => {
    let chapter-start-marker = chapter-start-markers.at(index)
    let end-page = chapter-end-marker.location().page()
    let start-page = chapter-start-marker.location().page()
    (end-page, start-page)
  })
  state("chapter-markers").update(pairs)
}

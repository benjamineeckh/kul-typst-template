#set heading(numbering: "1")
#let get-start-of-text() = {
  query(<start-of-doc>).first().location().page()
}
#import "@preview/hydra:0.5.1": hydra
#set page(paper:"a7")
#show heading.where(level:1): it => {
  pagebreak(weak: true, to: "odd")
  block[
  #v(2em)<chapter-start-marker>
  #it

  ]
}
#let heading-on-page() = {
  let hs = query(selector(<chapter-start-marker>).after(here())).map(v => v.location().page())
  return hs.contains(here().page())
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
    // [#heading-on-page()]
  }
}

#set page(header: context hydra-settings)
// #outline()
// = a
// #pagebreak()
// = b
// #pagebreak()
// #pagebreak()

// = c <start-of-doc>

// == test


#include "as.typ"
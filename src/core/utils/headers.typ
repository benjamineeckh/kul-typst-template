#import "@preview/hydra:0.6.2": hydra
// needs context
// Checks if a (level 1) heading is on the page
#let heading-on-page() = {
  let hs = query(selector(<chapter-start-marker>).after(here())).map(v => v
    .location()
    .page())
  return hs.contains(here().page())
}

// needs context
// heading generation, depends on if the page is even or odd
#let hydra-settings() = {
  if calc.even(counter(page).get().at(0)) {
    let entry = hydra(skip-starting: true, 1)
    if entry != none {
      // [#entry.fields()]
      entry = if entry.has("text") {
        entry.text
      } else {
        entry.children.first() + [. ] + entry.children.last()
      }
      // align(left)[#smallcaps()]
      align(left)[#smallcaps(entry)]
      line(length: 100%, stroke: (thickness: 0.1pt))
    }
  } else {
    let entry = hydra(2, skip-starting: false)
    if entry == none {
      entry = hydra(1)
    }
    if entry != none {
      entry = if entry.has("text") {
        entry.text
      } else {
        entry.children.first() + [. ] + entry.children.last()
      }
      align(right)[#smallcaps(entry)]
      line(length: 100%, stroke: (thickness: 0.1pt))
    }
  }
  // [#query(<chapter-start-marker>).map(v => v.location().page())

  // #here().page()

  // #get-page-number()]
}

// needs context
// custom header, used in `set page(header:...)`
#let custom-header() = {
  // if not page-is-inserted(here()) {
  [#hydra-settings()]
  // }
  // [#here().page()]
}

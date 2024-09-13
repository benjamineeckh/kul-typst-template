#import "@preview/hydra:0.5.1": hydra
#let hydra-settings = context {
if calc.odd(here().page()) {
  let headings = query(selector(heading).before(here()))
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

#set page(paper: "a7", margin: (top: 2em), numbering: "1", header: hydra-settings)

#show heading.where(level: 1): it => {
  pagebreak(weak: true, to: "odd")
  v(1em)
  it
}


= main header
#lorem(20)
== a subheader
#lorem(150)
= a NEW heading
aaa


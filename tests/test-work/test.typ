#import "@preview/hydra:0.5.1": hydra

#let hydra-settings = context {
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
#set page(paper: "a4", margin: (y: 10em), numbering: "1", header: hydra-settings)
#counter(page).update(1)

#context {
  
}
= headnig
== some subheadnig
#lorem(2000)
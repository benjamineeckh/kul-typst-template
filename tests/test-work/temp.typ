#let heading-on-page(loc, level) = context {
  let hs = query(selector(heading.where(level:level)).after(here())).map(v => v.location().page())
  return hs.contains(loc.page())
}

#set page(paper: "a7", margin: (top:10%), numbering: "1", header: none)

// NEEDS to be in a scope, otherwise the page query breaks if it's in 1 block (it => [...])
#show heading.where(level: 1): it => [
  #[]<chapter-end-marker> // marker positioned before the pagebreak
  #pagebreak(to: "odd", weak: true)
  #block[
  #v(15.55%) // kinda ass offset, but this is now the same as the latex one    Should really check the latex source code
  Chapter #counter(heading).get().first()
  #v(6%)
  #text(1.5em, weight: "bold")[#it.body]
  #v(6%)]<chapter-start-marker> // marker positioned after the pagebreak
]
#set heading(numbering: "1")

#context {
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

= hello
gkjasdhkahdkjhsd #lorem(120)
= h
gkjasdhkahdkjhsd
a
= test

== a
#context state("chapter-markers").display()

#block[#label("chapter-end-marker")]
aksdjhaksdjh
#block[#label("chapter-start-marker")]

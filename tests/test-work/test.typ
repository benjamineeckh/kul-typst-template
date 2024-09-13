#let page-is-inserted(loc) = {
  let pairs = state("chapter-markers").at(loc)
  if pairs == none { return false }
  // page is inserted if surrounded by end- and start-marker for any chapter
  return pairs.any(((end-page, start-page)) => {
    loc.page() > end-page and loc.page() < start-page
  })
}

#set heading(numbering: "1.")
#let c-b() = context{
  if page-is-inserted(here()){
    rotate(45deg)[#text(size: 4em, fill:red)[inserted]]
  }
}
#set page(paper: "a7", background: c-b(), numbering: "1")


#show heading.where(level: 1): it => [
  #[]<chapter-end-marker> // marker positioned before the pagebreak
  #pagebreak(to: "odd", weak: true)
  #block[
    #it
  #v(6%)]<chapter-start-marker> // marker positioned after the pagebreak
]

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




= Another header
asas


#context state("chapter-markers").display()
#set page(numbering: "i")
= asdjhasd
asdsd
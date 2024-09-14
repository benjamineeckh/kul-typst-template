#let insert-outline(non-odd-page-headers, lang: "en") = {
  // Table of contents
  // Outline customization
  let outline-color = red.darken(10%)
  // let outline-color = black
  
  show outline.entry: it => {
    link(it.element.location(), text(outline-color)[#it.body])
    [ ]
    box(width: 1fr, it.fill)
    [ ]
    box(
      width: measure[9999].width,
      align(right, it.page),
    )
  }

  show outline.entry.where(level: 1): it => {
    v(12pt, weak: true)
    let body = if it.element.numbering != none {
      numbering(it.element.numbering, ..counter(it.element.func()).at(it.element.location()))
      [ ]
      it.element.body
    } else {
      it.body
    }
    link(it.element.location(), strong(text(outline-color)[#body]))
    h(1fr)
    it.page
  }
  show outline: set heading(numbering:none, outlined: false)
  let title = if lang == "nl"{
    "Inhoudsopgave"
  }else{
    "Contents"
  }
  outline(title: title, depth: 2, indent: true, fill:repeat("  .  "))
  pagebreak(weak: true)
}
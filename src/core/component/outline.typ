#let insert-outline(non-odd-page-headers) = {
  // Table of contents
  // Outline customization
  let outline-color = red.darken(10%)
  
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
  outline(depth: 2, indent: true, fill:repeat("  .  "))
  pagebreak(weak: true)
}
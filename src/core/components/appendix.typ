#let insert-appendices(appendices) = {
  set heading(numbering: "A.1", supplement: "Appendix")
  let heading-number = "1.1.1."
  let heading-spacing = context h(measure(heading-number).width - measure(heading-number).width)
  // shoddy hack, but it works
  show heading: it => {
    if it.level == 1 {it}else{

    let size = if it.level == 2 {
        1.1em
    }else{1em}
    set text(size, weight: "bold")
    let first-number = numbering(it.numbering, counter(heading).get().first())

    let heading-number = (first-number, ..counter(heading).get().slice(1)).map(str).join(".")
    [#linebreak()#heading-number #heading-spacing #it.body#linebreak()]}
  }

  counter(heading).update(0)
  for app in appendices{
    app
  }
}
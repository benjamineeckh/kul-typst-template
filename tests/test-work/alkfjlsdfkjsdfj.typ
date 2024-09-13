#set heading(numbering: "1")
#let get-start-of-text() = {
  query(<start-of-doc>).first().location().page()
}
#let custom-numbering(number) = {
  return if int(number) < get-start-of-text(){
    numbering("i", int(number))
  }else{
    numbering("1", int(number))
  }
}

#set page(paper:"a7")
#show outline.entry.where(
  level: 1
): it => context {
  [#it.body] + box(width: 1fr)[#it.fill] + custom-numbering(it.page.text)
  }
#outline()
= a
#pagebreak()
= b
#pagebreak()
#pagebreak()

= c <start-of-doc>

== test
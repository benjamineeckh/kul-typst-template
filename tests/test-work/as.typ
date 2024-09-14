#set page(paper: "a7")

#show heading.where(level:1): it => [
#let non-odd-page-headers = ("Declaration of Originality", "Declaratie van originaliteit", "Preface", "Voorwoord", "Abstract", "Samenvatting", "Nomenclature", "Lijst Van Symbolen", "Contents","List of Abbreviations and Symbols", "List of Figures and Tables")
  
#if not non-odd-page-headers.contains(it.body.text) and not (counter(heading).get().first() == 1 and counter(heading).get().len() == 1){
      pagebreak(to: "odd", weak: true)
    }
  #block[
  #it

  ]<a>
]
#set heading(numbering: "1")

#let a = context{
  return here().page()
}

#heading(
    level: 1,
    numbering: none,
    outlined: true)[first]

= A heading
#lorem(20)
#pagebreak()
#a
#a.fields()

= t
#lorem(50)
// = t2
// // #context query(selector(<a>).after(here())).map(v => v.location().page())
// #lorem(50)
// #counter(page).update(1)
// = t33
// #lorem(50)

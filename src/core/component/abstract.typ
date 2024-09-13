#let insert-abstract(abstract, lang:"en") = context {
  if abstract != none {
  heading(
    level: 1,
    numbering: none,
    outlined: true,
    if lang == "en"{
      "Abstract"
    }else{
      "Samenvatting"
    }
  )
  abstract
  context if calc.odd(here().page()){
    page(header:none, footer:none, numbering:none)[]
  }
  }
}
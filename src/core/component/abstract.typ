#import "../../page-utils.typ"
#let insert-abstract(abstract, lang:"en") = context {
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
  if abstract != none {
  abstract
  if calc.odd(page-utils.get-page-number()){
    page(header:none, footer:none, numbering:none)[]
  }
  }else{
    let t = if lang == "nl"{
      "PLAATSHOUDER VOOR SAMENVATTING"
    }else{
      "PLACEHOLDER FOR ABSTRACT"
    }
    text(purple, size:3em)[#t]
    set text(red)
    lorem(200)
  }
}
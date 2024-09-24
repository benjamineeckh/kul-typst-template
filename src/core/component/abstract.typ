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
  pagebreak(weak: true)
  }else{
    let t = if lang == "nl"{
      "PLAATSHOUDER VOOR SAMENVATTING"
    }else{
      "PLACEHOLDER FOR ABSTRACT"
    }
    text(purple, size:3em)[#t]
    set text(red)
    lorem(200)
    pagebreak(weak: true)
  }
}
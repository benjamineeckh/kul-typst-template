/// Needs Context
/// 
/// Inserts outline for all the figures and tables
#let insert-figure-outline(lang:"en") = {
    heading(
    level: 1,
    numbering: none,
    outlined: true,
    if lang == "en"{
      "List of Figures and Tables"
    }else{
      "Lijst van Figuren en Tabellen"
    }
  )

  heading(
    level: 2,
    numbering: none,
    outlined: false,
    if lang == "en"{
      "List of Figures"
    }else{
      "Lijst van Figuren"
    }
  )
  outline(target: figure.where(kind: image))

  heading(
    level: 2,
    numbering: none,
    outlined: false,
    if lang == "en"{
      "List of Tables"
    }else{
      "Lijst van Tabelle"
    }
  )
  outline(target: figure.where(kind: table))


}
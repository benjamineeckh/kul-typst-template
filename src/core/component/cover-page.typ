// Currently borked, searches for file from core/component, instead of the directory where the main file is located which uses lib
#let parse-image(logo) = {
  if logo != none {
    let t = type(logo)
    if t == figure or t == content{
      logo = logo
    }else if t == str{
      logo = image(logo)
    }else{
      panic("check the typing of the logo, something is wrong with it")
    }
  }
  return logo
}


// TODO: fix error messages + add some standard values
#let insert-cover-page(
  title,
  authors,
  promotors,
  evaluators,
  supervisors,
  academic-year,
  submission-text,
  // An affiliation dictionary, you should specify a `university`
  // keyword, `school` keyword and a `degree` keyword
  affiliation,
  // can be an actual image, or just a path to an image
  logo:none,
  cover: false,
  lang:"en"
) = { // diferent scope so logo and font don't get copied over to all the other pages
  logo = parse-image(logo)
  page(
    margin: 20mm,
    header:none,
    numbering: none,
    footer: none,
    background: 
    place(
      top + left,
      dy: 3.5%,
      dx: 5%,
      box(width: 77mm, height: 35mm, logo)
    ))[
    #{
      set text(
        font: "Nimbus Sans"
      )

      v(30%)  
      text(2.3em, weight: 500, title)
      v(4%)
      text(1.5em, weight: 500, authors.map(v=>v.name).join("\n"))
      v(8%)
      set align(right)
      // promotors, evaluators, supervisors
      block(width: 40%)[
        #[
          #set text(size: 11pt)
          #submission-text(affiliation.degree, affiliation.elective).at(lang)
        ]

        #if promotors == none{
          panic("You probably need to have a promotor")
        }else{
          if lang == "en"{
            
            [*Supervisors*: #linebreak()]
          }else{
            [*Promotoren*: #linebreak()]
          }
          promotors.join(linebreak())
          linebreak()
        }
        #if not cover{
          if evaluators == none{
            // []
          }else{
            if lang == "en"{
              [*Assessors*: #linebreak()]
            }else{
              [*Evaluatoren*: #linebreak()]
            }
            evaluators.join(linebreak())
            linebreak()
          }

          if supervisors == none{
            // []
          }else{
            if lang == "en"{
              [*Assistant-supervisors*: #linebreak()]
            }else{
              [*Begeleider*: #linebreak()]
            }
            supervisors.join(linebreak())
          }
        }
      ]
      

      // let affiliation = (color:none)
      let height = if affiliation.color != none and cover{
        6%
      } else {
        2%  
      }  
      let year-marker = if type(academic-year) == array{
        [#academic-year.at(0) #sym.dash.en #academic-year.at(1)]
      }else{
        let next-year = academic-year+1
        [#academic-year #sym.dash.en #next-year]
      }
      let title-page-footer = text(1.2em, weight: 500,[
          #if lang == "en" {
            "Academic Year"
          } else {
            "Academiejaar"
          }
          #year-marker
        ])
      title-page-footer += if affiliation.color != none and cover{
          let clr = cmyk(..affiliation.color.map(v => v*100%))
          let (red, green, blue) = rgb(clr).components().slice(0, 3).map(v => int(v*255 / 100%))
          let text-clr = if (red*0.299 + green*0.587 + blue*0.114) > 186 {black} else {white}
          v(1em)
          rect(width: 110%, height: 3em, fill: clr, stroke:none)[#align(center+horizon)[#text(fill:text-clr)[#affiliation.degree: #affiliation.elective]]]
      }
      place(
        center + bottom,
        dy: height,
        title-page-footer
      )
    }
    ]
  
}
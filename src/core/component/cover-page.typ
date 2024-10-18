#let generate-year(academic-year) = [
  #if type(academic-year) == array{
    [#academic-year.at(0) #sym.dash.en #academic-year.at(1)]
  }else{
    let next-year = academic-year + 1
    [#academic-year #sym.dash.en #next-year]
  }
]

#let convert-cmyk(degree) = {
  let clr = cmyk(..degree.map(v => v*100%))
  let (red, green, blue) = rgb(clr).components().slice(0, 3).map(v => int(v*255 / 100%))
  let text-clr = if (red*0.299 + green*0.587 + blue*0.114) > 186 {black} else {white}
  return (clr, text-clr)
}

// TODO: fix error messages + add some standard values
#let insert-cover-page(
  title,
  subtitle,
  authors,
  promotors,
  evaluators,
  supervisors,
  academic-year,
  submission-text,
  // An degree dictionary, you should specify a `university`
  // keyword, `school` keyword and a `degree` keyword
  degree,
  english-master,
  // can be an actual image, or just a path to an image
  logo:none,
  cover: false,
  lang:"en"
) = { 
  // diferent scope so logo and font don't get copied over to all the other pages
  logo = image("logokuleng.svg")
  page(
    margin: (20mm),
    header:none,
    numbering: none,
    footer: none,
    background: 
    place(
      top + left,
      dy: 16mm,
      dx: 10mm,
      box(width: 77mm, height: 35mm, logo)
    ))[
    #{
      set text(
        font: "Nimbus Sans"
      )

      v(35mm+16mm+40pt)
      par(leading: 0.5em)[
        #text(2.25em, weight: 500, title)
        #if subtitle != none{
          v(1em)
          text(1.5em, weight: 300, subtitle)
        }
        #v(40pt)
        #text(1.4em)[#authors.join("\n")]
      ]
      
      v(30pt)
      set align(right)
      // promotors, evaluators, supervisors
      // width should be 50% of the text box, don't know how to do it in typst
      block(width: 40%)[
        #[
          #set text(size: 11pt)
          #submission-text(degree.master, degree.elective).at(lang)
        ]

        #if promotors == none{
          panic("You probably need to have a promotor")
        }else{
          if english-master{
            
            [*Supervisor*#if promotors.len() > 1 {[*s*]}: #linebreak()]
          }else{
            [*Promotor*#if promotors.len() > 1 {[*en*]}: #linebreak()]
          }
          promotors.join(linebreak())
          linebreak()
        }
        #if not cover{
          if evaluators == none{
            // []
          }else{
            if english-master{
              [*Assessor*#if evaluators.len() > 1 {[*s*]}: #linebreak()]
            }else{
              [*Evaluator*#if evaluators.len() > 1 {[*en*]}: #linebreak()]
            }
            evaluators.join(linebreak())
            linebreak()
          }

          if supervisors == none{
            // []
          }else{
            if english-master{
              [*Supervisor*#if supervisors.len() > 1 {[*s*]}: #linebreak()]
            }else{
              [*Begeleider*#if supervisors.len() > 1 {[*s*]}: #linebreak()]
            }
            supervisors.join(linebreak())
          }
        }
      ]
      

      // let degree = (color:none)
      let height = if degree.color != none and cover{
        30pt
      } else {
        15pt
      }  
      
      let title-page-footer = text(1.2em, weight: 500,[
          #if english-master {
            "Academic Year"
          } else {
            "Academiejaar"
          }
          #generate-year(academic-year)
        ])
      title-page-footer += if degree.color != none and cover{
          let (clr, text-clr) = convert-cmyk(degree.color)
          v(15pt)
          rect(width: 190mm, height: 15mm, fill: clr, stroke:none)[#align(center+horizon)[#text(fill:text-clr)[#degree.master: #degree.elective]]]
      }
      place(
        center + bottom,
        dy: height,
        title-page-footer
      )
    }
    ]
  
}
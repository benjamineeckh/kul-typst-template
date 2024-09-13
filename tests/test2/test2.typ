#import "../../src/lib.typ": template


#show: template.with(
  // Your title goes here
  title: "Doing some very fancy and complicated testing for some new and innovative thing",

  // Give or only the year you started in (eg: 2024), or a tuple with the start and end year (eg: (2024, 2040))
  academic-year: 2023,

  // Change to the correct subtitle, i.e. "Tesi di Laurea Triennale",
  // "Master's Thesis", "PhD Thesis", etc.
  subtitle: "Master's Thesis",

  // Change to your name and student number
  authors: (
    (name: "john doe",
    student_number: "r9808098"),
    (name: "some other guy",
    student_number: "r0485974395"),
  ),
  promotors: ("A first guy", "some other guy"),

  // Add as many co-supervisors as you need or remove the entry
  // if none are needed
  evaluators: ("idk", "someone else"),

  // Change to your supervisor's name
  supervisors: (
    "Some supervisor",
  ),

  // Customize with your own school and degree
  affiliation: (
    university: "KU Leuven",
    school: "Master in Engineering science",
    degree: "Computer science",
    elective: "Software engineering",
    color: (background-color:(0, 0, 1, 0), text-color:black)
  ),

  // Change to "it" for the Italian template
  lang: "en",

  // University logo
  logo: "../../../resources/logokuleng.svg",

  electronic-version:true,

  // Hayagriva bibliography is the default one, if you want to use a
  // BibTeX file, pass a .bib file instead (e.g. "works.bib")
  // bibliography: bibliography("bib.yml"),

  preface: lorem(200),
  abstract: lorem(500),

  // Add as many keywords as you need, or remove the entry if none
  // are needed
  keywords: none
)

#lorem(100)
= ty
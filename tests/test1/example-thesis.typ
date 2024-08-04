#import "../../src/lib.typ": template
// not needed, just nicer to split these text blobs into another file
#import "../../src/text-blobs.typ":preface, abstract


#show: template.with(
  // Your title goes here
  title: "Doing some very fancy and complicated testing for some new and innovative thing",

  // Change to the correct academic year, e.g. "2024/2025"
  academic-year: [2023 - 2024],

  // Change to the correct subtitle, i.e. "Tesi di Laurea Triennale",
  // "Master's Thesis", "PhD Thesis", etc.
  subtitle: "Master's Thesis",

  // Change to your name andstudent number
  candidate: (
    name: "john doe",
    student_number: 9808098
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
  logo: "logokuleng.svg",

  electronic-version:true,

  // Hayagriva bibliography is the default one, if you want to use a
  // BibTeX file, pass a .bib file instead (e.g. "works.bib")
  bibliography: bibliography("bib.yml"),

  // See the `acknowledgments` and `abstract` variables above
  preface: preface,
  abstract: abstract,

  // Add as many keywords as you need, or remove the entry if none
  // are needed
  keywords: none
)

// I suggest adding each chapter in a separate typst file under the
// `chapters` directory, and then importing them here.

#include("sections/chapter1.typ")
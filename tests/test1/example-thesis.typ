#import "../../src/lib.typ": template

#show: template.with(
  // Your title goes here
  title: "Doing some very fancy and complicated testing for some new and innovative thing",

  // Give or only the year you started in (eg: 2024), or a tuple with the start and end year (eg: (2024, 2040))
  academic-year: 2023,

  // Change to the correct subtitle, i.e. "Tesi di Laurea Triennale",
  // "Master's Thesis", "PhD Thesis", etc.
  subtitle: "Master's Thesis",

  // Change to the name(s) of the author(s)
  authors: (
    (name: "john doe"),
    (name: "some other guy"),
  ),

  // Change to the name(s) of the promotor(s)
  promotors: ("A first guy", "some other guy"),

  // Add as many co-supervisors as you needthe entry
  // if none are needed
  evaluators: ("idk", "someone else"),

  // Change to your supervisor's name
  // remove if none are needed
  supervisors: (
    "Some supervisor",
  ),

  // Customize with your own faculty and degree
  // affiliation: (
  //   faculty: "Master in Engineering science",
  //   degree: "Computer science",
  //   elective: "Software engineering",
  //   color: (0, 0, 1, 0)
  // ),

  // Change to "nl" for the Dutch template
  lang: "en",

  // University logo
  logo: "../../../resources/logokuleng.svg",

  // set to true to remove extra title-page and have normal margins
  electronic-version:false,

  // Hayagriva bibliography is the default one, if you want to use a
  // BibTeX file, pass a .bib file instead (e.g. "works.bib")
  bibliography: bibliography("bib.yml"),

  // Preface text
  preface: lorem(200),
  // Abstract text
  abstract: lorem(100),

  // Add as many keywords as you need, or remove the entry if none
  // are needed
  keywords: lorem(20)
)

// Insert an empty page if the preamble (pages with a "i" numbering) end on an uneven page.
// This does not currently work yet automatically (comment if not needed)
// #page(footer: none, header: none, numbering: none)[]
// I suggest adding each chapter in a separate typst file under the
// `chapters` directory, and then importing them here.

#include("sections/chapter1.typ")
#include "sections/chapter2.typ"
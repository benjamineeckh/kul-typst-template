// needs context
// computes the actual page number for a page
// I don't really like it, but it works
#let get-page-number() = {
  let preamble = locate(<start-of-preamble>).page()
  let num = if here().page() < body {
    here().page() - preamble + 1
  } else {
    here().page() - body + 1
  }
  return int(num)
}

// needs context
// Checks if a page was inserted
#let page-is-inserted(loc) = {
  let pairs = state("chapter-markers").at(loc)
  if pairs == none { return false }
  // page is inserted if surrounded by end- and start-marker for any chapter
  return pairs.any(((end-page, start-page)) => {
    loc.page() > end-page and loc.page() < start-page
  })
}

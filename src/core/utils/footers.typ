#import "page-utils.typ": page-is-inserted
// needs context
// custom footer, used in `set page(footer:...)`
#let custom-footer() = {
  if not page-is-inserted(here()) {
    let num = get-page-number()
    let dir = if calc.odd(int(num)) {
      right
    } else {
      left
    }
    let num = here().page-numbering()(here().page())
    align(dir, num)
  }
}

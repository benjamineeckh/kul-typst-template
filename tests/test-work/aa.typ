#set page(paper: "a7")

#let a() = {
  return here().page()
}

#context{ type(a())}

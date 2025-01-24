//書類ごとの一時的な設定用


#let TODO_red(body) = {
  show "TODO": highlight(fill: red, text("TODO"))
  body
}

#let temporary(body) = {
  show: TODO_red

  body
}

my.command {
  description = "search: find term and open results in quickfix",
  cmd = ":RgSearch "
}
my.command {
  description = "search: pick a color scheme",
  cmd = ":Colors<CR>"
}
my.command {
  description = "git: search in commits",
  cmd = ":Commits<CR>"
}
my.command {
  description = "git: search in buffer commits",
  cmd = ":BCommits<CR>"
}
my.command {
  description = "terminal: open at current buffer dir",
  cmd = ":lua require('my/terminal').openTerminalAtCurrentBufferLocation()<CR>"
}

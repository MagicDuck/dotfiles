my.command {
  description = "Search: find term and open results in quickfix",
  cmd = ":RgSearch "
}
my.command {
  description = "Search: pick a color scheme",
  cmd = ":Colors<CR>"
}
my.command {
  description = "Git: search in commits",
  cmd = ":Commits<CR>"
}
my.command {
  description = "Git: search in buffer commits",
  cmd = ":BCommits<CR>"
}
my.command {
  description = "Terminal: open at current buffer dir",
  cmd = ":lua require('my/terminal').openTerminalAtCurrentBufferLocation()<CR>"
}

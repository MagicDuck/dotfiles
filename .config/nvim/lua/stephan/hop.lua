require'hop'.setup {
  keys = 'asdghlqwertyuiopcvbnmfjk'
}

vim.api.nvim_set_keymap("n", "s", ":HopChar2<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "S", ":HopLine<CR>", {silent=true, noremap=true})

vim.api.nvim_buf_set_keymap(0, 'n', '<CR>', ":lua require('rest-nvim').run()<CR>", { silent = true, noremap = true })
-- preview
vim.api.nvim_buf_set_keymap(
  0,
  'n',
  '<S-CR>',
  ":lua require('rest-nvim').run(true)<CR>",
  { silent = true, noremap = true }
)

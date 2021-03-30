local saga = require 'lspsaga'
saga.init_lsp_saga({
  rename_action_keys = {
    quit = '<ESC>',
    exec = '<CR>'
  },
  code_action_keys = {
    quit = '<ESC>',
    exec = '<CR>'
  },
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "✘",
  dianostic_header_icon = '   ',
  code_action_icon = ' '
})

vim.api.nvim_set_keymap("n", "<leader>ac", ":Lspsaga code_action<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "gh", ":Lspsaga lsp_finder<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "K", ":Lspsaga hover_doc<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "gs", ":Lspsaga signature_help<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "gd", ":Lspsaga preview_definition<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>ar", ":lua require('lspsaga.rename').rename()<CR>", {silent=true, noremap=true})

vim.api.nvim_set_keymap("n", "<C-f>", ":lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<C-b>", ":lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "cc", ":lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "cd", ":lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", {silent=true, noremap=true})

vim.api.nvim_set_keymap("n", "<Up>f", ":lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<Down>f", ":lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", {silent=true, noremap=true})

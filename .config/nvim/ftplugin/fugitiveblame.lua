-- vim.api.nvim_buf_set_keymap(
--   "s",
--   "<CR>",
--   "compe#confirm('<CR>')",
--   {expr = true, silent = true, noremap = true}
-- )
vim.api.nvim_buf_del_keymap(0, "n", "s")

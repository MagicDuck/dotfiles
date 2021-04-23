vim.o.completeopt = "menuone,noselect"

require("compe").setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 3,
  preselect = "always",
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,
  source = {
    path = true,
    buffer = true,
    vsnip = false,
    nvim_lsp = true,
    nvim_lua = true,
    ultisnips = true,
    -- spell = true;
    tags = true,
    treesitter = false
  }
}

vim.api.nvim_set_keymap(
  "i",
  "<C-Space>",
  "compe#complete()",
  {expr = true, silent = true, noremap = true}
)
vim.api.nvim_set_keymap(
  "i",
  "<CR>",
  "compe#confirm('<CR>')",
  {expr = true, silent = true, noremap = true}
)

vim.api.nvim_exec(
  [[
  function! CloseCompeAndCR() 
    return compe#close('<M-CR>') . "\n"
  endfunction
]],
  false
)

vim.api.nvim_set_keymap(
  "i",
  "<M-CR>",
  "CloseCompeAndCR()",
  {expr = true, silent = true}
)

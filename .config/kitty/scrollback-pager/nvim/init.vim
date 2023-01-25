packadd hop.nvim
packadd leap.nvim
packadd nvim-treesitter

source ~/.config/nvim/base-config/base.vim
set mouse=a
set clipboard=unnamedplus
set virtualedit=all
set scrollback=100000
set laststatus=0
set noswapfile
set signcolumn=no
" set nonumber
set number

lua << EOF
require("nvim-treesitter.configs").setup({})
  require("hop").setup{
    keys = 'asdghlqwertyuiopzxcvbnmfj'
  }
  vim.api.nvim_set_keymap("n", "f", "<cmd>lua require('leap').leap { target_windows = { vim.fn.win_getid() } }<CR>", {})
  vim.api.nvim_set_keymap("n", "q", "<cmd>q!<cr>", {})
  vim.api.nvim_set_keymap("n", "<enter>", "<cmd>q!<cr>", {})
EOF

source ~/.config/nvim/base-config/colorscheme.vim
normal G

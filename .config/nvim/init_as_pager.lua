require('my/global/init')
require('my/config/options')
vim.cmd([[ source ~/.config/nvim/lua/my/config/base-keymaps.vim ]])
require('my/config/keys')
require('my/config/commands')
require('my/config/autocommands')

-- options override
vim.opt.clipboard = 'unnamedplus'
vim.opt.virtualedit = 'all'
vim.opt.scrollback = 100000
vim.opt.laststatus = 0
vim.opt.swapfile = false
vim.opt.signcolumn = 'no'
vim.opt.number = true
vim.cmd([[ set shortmess+=A ]])

-- keymap overrides
vim.keymap.set('n', 'q', '<cmd>q!<cr>', {})
vim.keymap.set('n', '<enter>', '<cmd>q!<cr>', {})

-- load plugins
require('my/config/lazy')
local lazy = require('my/config/lazy')
lazy.load({
  spec = {
    { import = 'my.plugins.treesitter' },
    { import = 'my.plugins.leap' },
    { import = 'my.plugins.mytheme' },
  },
})

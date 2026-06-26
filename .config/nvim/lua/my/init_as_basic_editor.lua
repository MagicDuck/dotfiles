require('my/global/init')
require('my/config/options')
require('my/config/keymaps')
require('my/config/commands')
require('my/config/autocommands')

-- options override
vim.opt.clipboard = 'unnamedplus'
vim.opt.virtualedit = 'all'
vim.opt.laststatus = 0
vim.opt.swapfile = false
vim.opt.signcolumn = 'no'
vim.opt.number = true
vim.cmd([[ set shortmess+=A ]])

-- load plugins
require('my/config/lazy')
local lazy = require('my/config/lazy')
lazy.load({
  spec = {
    { import = 'my.plugins.flash' },
    { import = 'my.plugins.mytheme' },
    { import = 'my.plugins.treesitter' },
    { import = 'my.plugins.base' },
    { import = 'my.plugins.git' },
  },
})

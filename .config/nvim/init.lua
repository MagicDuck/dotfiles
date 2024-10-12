require('my/global/init')
require('my/config/options')
vim.cmd([[ source ~/.config/nvim/lua/my/config/base-keymaps.vim ]])
require('my/config/keys')
require('my/config/commands')
require('my/config/autocommands')
local lazy = require('my/config/lazy')
lazy.load({
  spec = {
    { import = 'my.plugins' },
  },
})

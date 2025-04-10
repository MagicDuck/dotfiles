require('my/global/init')
require('my/config/options')
require('my/config/keymaps')
require('my/config/commands')
require('my/config/autocommands')
local lazy = require('my/config/lazy')
lazy.load({
  spec = {
    { import = 'my.plugins' },
  },
})

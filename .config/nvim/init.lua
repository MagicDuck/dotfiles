---@module 'snacks'
if vim.env.PROF then
  -- example for lazy.nvim
  -- change this to the correct path for your plugin manager
  local snacks = vim.fn.stdpath('data') .. '/lazy/snacks.nvim'
  vim.opt.rtp:append(snacks)
  require('snacks.profiler').startup({
    on_stop = {
      highlights = true, -- highlight entries after stopping the profiler
      pick = true, -- show a picker after stopping the profiler (uses the `on_stop` preset)
    },
    startup = {
      event = 'VimEnter', -- stop profiler on this event. Defaults to `VimEnter`
      -- event = "UIEnter",
      -- event = "VeryLazy",
    },
    presets = {
      startup = { min_time = 1, sort = true },
    },
  })
end

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

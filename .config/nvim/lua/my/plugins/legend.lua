return {
  {
    'folke/which-key.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
    dependencies = { { 'mrjones2014/legendary.nvim' } },
    config = function()
      local wk = require('which-key')
      vim.o.timeout = true
      vim.o.timeoutlen = 500

      wk.setup({
        plugins = {
          marks = true, -- shows a list of your marks on ' and `
          registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          spelling = {
            enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
          },
          -- the presets plugin, adds help for a bunch of default keybindings in Neovim
          -- No actual key bindings are created
          presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = false, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = false, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = false, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
          },
        },
        keys = {
          scroll_down = '<PageDown>', -- binding to scroll down inside the popup
          scroll_up = '<PageUp>', -- binding to scroll up inside the popup
        },
        disable = {
          -- ft = { 'grug-far' },
          bt = {},
        },
      })

      wk.add({
        mode = { 'n' },
        { '<leader>e', group = '+debugger' },
        { '<leader>g', group = '+git' },
        { '<leader>h', group = '+doc' },
        { '<leader>j', group = '+next' },
        { '<leader>k', group = '+prev' },
        { '<leader>l', group = '+lsp' },
        { '<leader>n', group = '+notes' },
        { '<leader>p', group = '+preview' },
        { '<leader>s', group = '+search' },
        { '<leader>t', group = '+tab' },
        { '<leader>u', group = '+misc' },
        { '<leader>v', group = '+split' },
        { '<leader>y', group = '+yank' },
        { '<leader>q', group = '+quickfix' },
      })
      wk.add({
        mode = { 'v' },
        { '<leader>e', group = '+debugger' },
        { '<leader>g', group = '+git' },
        { '<leader>s', group = '+search' },
      })
      wk.add({
        mode = { 'o', 'v' },
        { 's', desc = 'surround change' },
      })
    end,
  },
}

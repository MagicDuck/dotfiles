return {
  {
    'folke/which-key.nvim',
    lazy = true,
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    dependencies = { { 'mrjones2014/legendary.nvim' } },
    config = function()
      local wk = require("which-key")
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
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = false, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = false, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
          },
        },
        -- operators = { ys = "surround change" },
        popup_mappings = {
          scroll_down = '<PageDown>', -- binding to scroll down inside the popup
          scroll_up = '<PageUp>', -- binding to scroll up inside the popup
        },
        triggers = "auto"
        -- triggers = {} -- only manual opening
      })
    end
  }
}

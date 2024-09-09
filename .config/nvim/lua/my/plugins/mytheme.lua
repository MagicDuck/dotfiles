return {
  {
    'olimorris/onedarkpro.nvim',
    lazy = false, -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      local mycolors = require('my.plugins.theme.mycolors')
      local my = mycolors.my

      local overrides = vim.deepcopy(mycolors.highlights)
      require('onedarkpro').setup({
        -- colors = {
        --   red = '#FF0000',
        -- },
      })
      -- require('gruvbox').setup({
      --   contrast = 'hard',
      --   bold = true,
      --   invert_selection = false,
      --   overrides = overrides,
      --   palette_overrides = {
      --     light0 = my.background,
      --     light0_hard = my.background,
      --     light1 = my.background,
      --     light2 = my.background,
      --     light3 = my.selectionBg,
      --   },
      -- })
      vim.cmd.colorscheme('onedark_vivid')
      vim.opt.background = 'dark'
    end,
  },

  -- {
  --   'scottmckendry/cyberdream.nvim',
  --   lazy = false, -- make sure we load this during startup
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     local mycolors = require('my.plugins.theme.mycolors')
  --     local my = mycolors.my
  --
  --     local overrides = vim.deepcopy(mycolors.highlights)
  --     require('cyberdream').setup({
  --       transparent = false,
  --       italic_comments = false,
  --       borderless_telescope = false,
  --       terminal_colors = true,
  --       cache = false, -- turn on?
  --       theme = {
  --         variant = 'default', -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`
  --         -- highlights = overrides,
  --
  --         -- Override a color entirely
  --         colors = {
  --           -- For a list of colors see `lua/cyberdream/colours.lua`
  --           -- Example:
  --           bg = '#3B120A',
  --           -- green = '#00ff00',
  --           -- magenta = '#ff00ff',
  --         },
  --       },
  --
  --       -- see https://github.com/scottmckendry/cyberdream.nvim/blob/main/lua/cyberdream/colors.lua
  --       -- colors = {
  --       --   light0 = my.background,
  --       --   light0_hard = my.background,
  --       --   light1 = my.background,
  --       --   light2 = my.background,
  --       --   light3 = my.selectionBg,
  --       -- },
  --     })
  --     vim.cmd.colorscheme('cyberdream')
  --     vim.opt.background = 'dark'
  --   end,
  -- },
  -- {
  --   'ellisonleao/gruvbox.nvim',
  --   lazy = false, -- make sure we load this during startup
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     local mycolors = require('my.plugins.theme.mycolors')
  --     local my = mycolors.my
  --
  --     local overrides = vim.deepcopy(mycolors.highlights)
  --     require('gruvbox').setup({
  --       contrast = 'hard',
  --       bold = true,
  --       invert_selection = false,
  --       overrides = overrides,
  --       palette_overrides = {
  --         light0 = my.background,
  --         light0_hard = my.background,
  --         light1 = my.background,
  --         light2 = my.background,
  --         light3 = my.selectionBg,
  --       },
  --     })
  --     vim.cmd.colorscheme('gruvbox')
  --     vim.opt.background = 'light'
  --   end,
  -- },

  -- Other themes that were tried
  ------good
  -- {
  --   'EdenEast/nightfox.nvim',
  --   lazy = false, -- make sure we load this during startup
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require('my.plugins.theme.nightfox')
  --   end,
  -- },
  -- {
  --   'savq/melange-nvim',
  --   lazy = false, -- make sure we load this during startup
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     vim.cmd.colorscheme('melange')
  --     vim.opt.background = 'light'
  --   end,
  -- },
  --------meh
  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   lazy = false, -- make sure we load this during startup
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require('catppuccin').setup({
  --       flavour = 'mocha', -- latte, frappe, macchiato, mocha
  --       background = { -- :h background
  --         light = 'latte',
  --         dark = 'mocha',
  --       },
  --     })
  --     vim.cmd.colorscheme('catppuccin')
  --     vim.opt.background = 'dark'
  --   end,
  -- },
  -- {
  --   "olimorris/onedarkpro.nvim",
  --   lazy = false,    -- make sure we load this during startup
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     vim.cmd.colorscheme("onelight")
  --     vim.opt.background = "light"
  --   end,
  -- },
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,    -- make sure we load this during startup
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     vim.cmd.colorscheme("tokyonight-day")
  --     vim.opt.background = "light"
  --   end,
  -- }
  -- {
  --   'uloco/bluloco.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   dependencies = { 'rktjmp/lush.nvim' },
  --   config = function()
  --     vim.cmd.colorscheme("bluloco-light")
  --     vim.opt.background = "light"
  --   end,
  -- }
}

local mycolors = require('my.plugins.theme.mycolors')
local my = mycolors.my

return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,    -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      local overrides = vim.deepcopy(mycolors.highlights);
      require("gruvbox").setup({
        contrast = "hard",
        bold = false,
        overrides = overrides,
        palette_overrides = {
          light0 = my.background,
          light0_hard = my.background,
          light1 = my.background,
          light3 = my.selectionBg
        }
      })
      vim.cmd.colorscheme("gruvbox")
      vim.opt.background = "light"
    end,
  }

  -- Other themes that were tried
  ------good
  -- {
  --   "EdenEast/nightfox.nvim",
  --   lazy = false,    -- make sure we load this during startup
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require('my.plugins.theme.nightfox')
  --   end,
  -- },
  -- {
  --   "savq/melange-nvim",
  --   lazy = false,    -- make sure we load this during startup
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     vim.cmd.colorscheme("melange")
  --     vim.opt.background = "light"
  --   end,
  -- }
  --------meh
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   lazy = false,    -- make sure we load this during startup
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     vim.cmd.colorscheme("catppuccin-latte")
  --     vim.opt.background = "light"
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

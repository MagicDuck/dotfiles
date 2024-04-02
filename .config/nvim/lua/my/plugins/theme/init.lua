return {
  -- {
  --   "EdenEast/nightfox.nvim",
  --   lazy = false,    -- make sure we load this during startup
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require('my.plugins.theme.nightfox')
  --   end,
  -- },
  ------good
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,    -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      local my = {
        -- background = "#F6F2EE",
        background = "#FAFAF9",
        selectionBg = "#E7D2BE",
        commentBackground = "#F0F0ED",
        -- commentBackground = "#F0E4DA",
        commentFg = "#544D47",

        menubarBaseBg = "#D7CFC9",
        menubarBg1 = "#E4DCD4",
        menubarBg2 = "#65737e",
        menubarBg3 = "#a48c32",
        menubarBg4 = "#b4713d",

        menubarBaseFg = "#1b2b34",
        menubarFg1 = "#E8EBF0",
        menubarFg2 = "#F8FBF6",

        menubarInactiveAccent = "#65737e",
        menubarActiveAccent = "#896a98",

        -- debugLineBg = "#F8FBF6"
        debugLineBg = "#F0E0E0"
      }

      require("gruvbox").setup({
        contrast = "hard",
        bold = false,
        overrides = {
          Comment = { bg = my.commentBackground, fg = my.commentFg, italic = false },

          SpecialComment = { bg = my.commentBackground, fg = my.commentFg, italic = false },
          TSComment = { bg = my.commentBackground, fg = my.commentFg, italic = false },

          Todo = { bg = my.commentBackground, fg = "#4C9E90", bold = true },
          ["@text.todo"] = { bg = my.commentBackground, fg = "#4C9E90", bold = true },
          MyTodo = { bg = my.commentBackground, fg = "#BE7E05", bold = true },

          CursorLine = { bg = "#F0F0ED" },

          TelescopeMatching = { fg = "#d05858", bold = true },
          SignatureMarkText = { fg = "#B4703E", bold = true },
          MarkSignHL = { fg = "#B4703E", bold = true },

          BqfSign = { fg = "#F8FBF6", bg = "#896a98", bold = true },

          -- Base Menu Bar UI
          MyMenubarLine = { bg = my.menubarBaseBg, fg = my.menubarBaseFg },
          MyMenubarInactiveCap = { bg = my.menubarInactiveAccent, fg = my.menubarInactiveAccent },
          MyMenubarActiveCap = { bg = my.menubarActiveAccent, fg = my.menubarActiveAccent },

          -- Tab Bar UI
          TabLine = { fg = my.menubarBaseFg, bg = my.menubarBaseBg },
          TabLineFill = { bg = my.menubarBg1 },
          TabLineSel = { fg = my.menubarFg2, bg = my.menubarActiveAccent, italic = true },

          -- Status Bar UI
          MyStatusbarModeNormal = { fg = my.menubarFg1, bg = '#869235', bold = true },
          MyStatusbarModeVisual = { fg = my.menubarFg1, bg = '#5b9c90', bold = true },
          MyStatusbarModeVLine = { fg = my.menubarFg1, bg = '#5b9c90', bold = true },
          MyStatusbarModeVBlock = { fg = my.menubarFg1, bg = '#5b9c90', bold = true },
          MyStatusbarModeSelect = { fg = my.menubarFg1, bg = '#b4713d', bold = true },
          MyStatusbarModeSLine = { fg = my.menubarFg1, bg = '#b4713d', bold = true },
          MyStatusbarModeSBlock = { fg = my.menubarFg1, bg = '#b4713d', bold = true },
          MyStatusbarModeInsert = { fg = my.menubarFg1, bg = '#a48c32', bold = true },
          MyStatusbarModeReplace = { fg = my.menubarFg1, bg = '#b40b11', bold = true },
          MyStatusbarModeCommand = { fg = my.menubarFg1, bg = '#526f93', bold = true },
          MyStatusbarModePrompt = { fg = my.menubarFg1, bg = '#9a806d', bold = true },
          MyStatusbarModeExternal = { fg = my.menubarFg1, bg = '#896a98', bold = true },
          MyStatusbarModeTerminal = { fg = my.menubarFg1, bg = '#896a98', bold = true },

          MyStatusbarFiletype = { bg = my.menubarBg1, fg = my.menubarBaseFg, bold = true },
          MyStatusbarFilename = { bg = my.menubarBg1, fg = my.menubarBaseFg },
          MyStatusbarDiagnosticError = { bg = my.menubarBg4, fg = my.menubarFg1, bold = true },
          MyStatusbarDiagnosticWarn = { bg = my.menubarBg4, fg = my.menubarFg1, bold = true },
          MyStatusbarFileLocation = { bg = my.menubarBg2, fg = my.menubarFg1, bold = true },
          MyStatusbarFileProgress = { bg = my.menubarBg3, fg = my.menubarFg1, bold = true },
          MyStatusbarFileProgressCap = { bg = my.menubarBaseBg, fg = my.menubarBg3 },
          MyStatusbarLsp = { bg = my.menubarBg1, fg = my.menubarBaseFg },
          MyStatusbarDapStatus = { bg = my.menubarBg3, fg = my.menubarFg1 },
          MyStatusbarBranch = { bg = my.menubarBg1, fg = my.menubarBaseFg, bold = true },

          -- Win Bar UI
          MyWinbarFilename = { bg = my.menubarBaseBg, fg = my.menubarBaseFg },
          MyWinbarFiletype = { bg = my.menubarBaseBg, fg = my.menubarBaseFg, bold = true },

          -- DapUi/Dap
          DapUIPlayPause = { fg = my.menubarBaseFg },
          DapUIRestart = { fg = my.menubarBaseFg },
          DapUIStepOver = { fg = my.menubarBaseFg },
          DapUIStepInto = { fg = my.menubarBaseFg },
          DapUIStepBack = { fg = my.menubarBaseFg },
          DapUIStepOut = { fg = my.menubarBaseFg },
          DapUIStop = { fg = my.menubarBaseFg },
          DapStopped = { bg = my.debugLineBg },
          DapStoppedLine = { bg = my.debugLineBg },
          DapStoppedLineNumber = { bg = my.debugLineBg }
        },
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

require('nightfox').setup({
  options = {
    -- colorblind = {
    --   enable = true, -- Enable colorblind support
    --   -- simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
    --   severity = {
    --     protan = 0.4, -- Severity [0,1] for protan (red)
    --     deutan = 0.4, -- Severity [0,1] for deutan (green)
    --     tritan = 0.4, -- Severity [0,1] for tritan (blue)
    --   },
    -- },
    styles = { -- Style to be applied to different syntax groups
      -- comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
      -- conditionals = "NONE",
      -- constants = "NONE",
      -- functions = "NONE",
      -- keywords = "NONE",
      -- numbers = "NONE",
      -- operators = "NONE",
      -- strings = "NONE",
      -- types = "NONE",
      -- variables = "NONE",
    },
    inverse = { -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    module_default = true, -- Default enable value for modules
    -- modules = { -- List of various plugins and additional options
    --   ['dap-ui'] = { enable = true }
    -- },
  },
  palettes = {
    dayfox = {
      comment = '#544D47',
    },
  },
  -- for all specs, :lua = require('nightfox.spec').load("dayfox")
  specs = {
    dayfox = {
      my = {
        commentBackground = '#F0E4DA',

        menubarBaseBg = '#D7CFC9',
        menubarBg1 = '#E4DCD4',
        menubarBg2 = '#65737e',
        menubarBg3 = '#a48c32',
        menubarBg4 = '#b4713d',

        menubarBaseFg = '#1b2b34',
        menubarFg1 = '#E8EBF0',
        menubarFg2 = '#F8FBF6',

        menubarInactiveAccent = '#65737e',
        menubarActiveAccent = '#896a98',

        -- debugLineBg = "#F8FBF6"
        debugLineBg = '#F0E0E0',
      },
    },
  },
  groups = {
    -- Note: use :TSHighlightCapturesUnderCursor to figure out what what to change
    -- Note: use :NightfoxInteractive to get live preview
    dayfox = {
      Comment = { bg = 'my.commentBackground', fg = 'palette.comment' },
      SpecialComment = { bg = 'my.commentBackground', fg = 'palette.comment' },
      TSComment = { bg = 'my.commentBackground', fg = 'palette.comment' },

      Todo = { bg = 'my.commentBackground', fg = '#4C9E90', style = 'bold' },
      ['@text.todo'] = { bg = 'my.commentBackground', fg = '#4C9E90', style = 'bold' },
      MyTodo = { bg = 'my.commentBackground', fg = '#BE7E05', style = 'bold' },

      CursorLine = { bg = '#F0E4DA' },

      TelescopeMatching = { fg = '#d05858', style = 'bold' },
      SignatureMarkText = { fg = '#B4703E', style = 'bold' },
      MarkSignHL = { fg = '#B4703E', style = 'bold' },

      BqfSign = { fg = '#F8FBF6', bg = '#896a98', style = 'bold' },

      -- Base Menu Bar UI
      MyMenubarLine = { bg = 'my.menubarBaseBg', fg = 'my.menubarBaseFg' },
      MyMenubarInactiveCap = { bg = 'my.menubarInactiveAccent', fg = 'my.menubarInactiveAccent' },
      MyMenubarActiveCap = { bg = 'my.menubarActiveAccent', fg = 'my.menubarActiveAccent' },

      -- Tab Bar UI
      TabLine = { fg = 'my.menubarBaseFg', bg = 'my.menubarBaseBg' },
      TabLineFill = { bg = 'my.menubarBg1' },
      TabLineSel = { fg = 'my.menubarFg2', bg = 'my.menubarActiveAccent', style = 'italic' },

      -- Status Bar UI
      MyStatusbarModeNormal = { fg = 'my.menubarFg1', bg = '#869235', style = 'bold' },
      MyStatusbarModeVisual = { fg = 'my.menubarFg1', bg = '#5b9c90', style = 'bold' },
      MyStatusbarModeVLine = { fg = 'my.menubarFg1', bg = '#5b9c90', style = 'bold' },
      MyStatusbarModeVBlock = { fg = 'my.menubarFg1', bg = '#5b9c90', style = 'bold' },
      MyStatusbarModeSelect = { fg = 'my.menubarFg1', bg = '#b4713d', style = 'bold' },
      MyStatusbarModeSLine = { fg = 'my.menubarFg1', bg = '#b4713d', style = 'bold' },
      MyStatusbarModeSBlock = { fg = 'my.menubarFg1', bg = '#b4713d', style = 'bold' },
      MyStatusbarModeInsert = { fg = 'my.menubarFg1', bg = '#a48c32', style = 'bold' },
      MyStatusbarModeReplace = { fg = 'my.menubarFg1', bg = '#b40b11', style = 'bold' },
      MyStatusbarModeCommand = { fg = 'my.menubarFg1', bg = '#526f93', style = 'bold' },
      MyStatusbarModePrompt = { fg = 'my.menubarFg1', bg = '#9a806d', style = 'bold' },
      MyStatusbarModeExternal = { fg = 'my.menubarFg1', bg = '#896a98', style = 'bold' },
      MyStatusbarModeTerminal = { fg = 'my.menubarFg1', bg = '#896a98', style = 'bold' },

      MyStatusbarFiletype = { bg = 'my.menubarBg1', fg = 'my.menubarBaseFg', style = 'bold' },
      MyStatusbarFilename = { bg = 'my.menubarBg1', fg = 'my.menubarBaseFg' },
      MyStatusbarDiagnosticError = { bg = 'my.menubarBg4', fg = 'my.menubarFg1', style = 'bold' },
      MyStatusbarDiagnosticWarn = { bg = 'my.menubarBg4', fg = 'my.menubarFg1', style = 'bold' },
      MyStatusbarFileLocation = { bg = 'my.menubarBg2', fg = 'my.menubarFg1', style = 'bold' },
      MyStatusbarFileProgress = { bg = 'my.menubarBg3', fg = 'my.menubarFg1', style = 'bold' },
      MyStatusbarFileProgressCap = { bg = 'my.menubarBaseBg', fg = 'my.menubarBg3' },
      MyStatusbarLsp = { bg = 'my.menubarBg1', fg = 'my.menubarBaseFg' },
      MyStatusbarDapStatus = { bg = 'my.menubarBg3', fg = 'my.menubarFg1' },
      MyStatusbarBranch = { bg = 'my.menubarBg1', fg = 'my.menubarBaseFg', style = 'bold' },

      -- Win Bar UI
      MyWinbarFilename = { bg = 'my.menubarBaseBg', fg = 'my.menubarBaseFg' },
      MyWinbarFiletype = { bg = 'my.menubarBaseBg', fg = 'my.menubarBaseFg', style = 'bold' },

      -- DapUi/Dap
      DapUIPlayPause = { fg = 'my.menubarBaseFg' },
      DapUIRestart = { fg = 'my.menubarBaseFg' },
      DapUIStepOver = { fg = 'my.menubarBaseFg' },
      DapUIStepInto = { fg = 'my.menubarBaseFg' },
      DapUIStepBack = { fg = 'my.menubarBaseFg' },
      DapUIStepOut = { fg = 'my.menubarBaseFg' },
      DapUIStop = { fg = 'my.menubarBaseFg' },
      DapStopped = { bg = 'my.debugLineBg' },
      DapStoppedLine = { bg = 'my.debugLineBg' },
      DapStoppedLineNumber = { bg = 'my.debugLineBg' },
    },
  },
})
vim.cmd.colorscheme('dayfox')
vim.opt.background = 'light'

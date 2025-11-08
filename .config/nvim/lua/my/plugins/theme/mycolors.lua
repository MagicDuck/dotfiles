local M = {}

local my = {
  background = '#FAFAF9',

  selectionBg = '#DBEDED',

  commentBackground = '#F0F0ED',
  commentFg = '#544D47',

  menubarBaseBg = '#D1D4DE',

  menubarBg1 = '#E4E9E8',
  menubarBg2 = '#65737e',
  menubarBg3 = '#a48c32',
  menubarBg4 = '#b4713d',

  menubarBaseFg = '#1b2b34',
  menubarFg1 = '#E8EBF0',
  menubarFg2 = '#F8FBF6',

  menubarInactiveAccent = '#65737e',
  menubarActiveAccent = '#896a98',

  debugLineBg = '#F0E0E0',
  cursorLineBg = '#F0F0ED',
  searchBg = '#896a98',

  floatBg = '#F0F2F5',

  todoFg = '#BE7E05',

  diffAddBg = '#E1EBDC',
  diffRemoveBg = '#F0CDCE',
  -- diffChangeBg = '#E5D5B6',
  -- diffTextBg = '#E5CFA4',
  diffChangeBg = '#E5DED0',
  diffTextBg = '#E5D5B6',

  conflictSepFg = '#F8FBF6',
  conflictSepBg = '#65737E',
}
M.my = my

function M.set_base_colors(baseColors)
  for key, value in pairs(baseColors) do
    M.my[key] = value
  end
  return M.my
end

function M.get_override_highlights()
  return {
    Pmenu = { fg = '#000000', bg = my.floatBg },
    NormalFloat = { bg = my.floatBg },
    FloatBorder = { fg = '#000000', bg = my.floatBg },

    -- workaround for lsp hover window hightlight bug in markdown
    markdownError = { link = 'None' },

    Search = { bg = my.searchBg, fg = '#FAFAF9', reverse = false },

    Comment = { bg = my.commentBackground, fg = my.commentFg, italic = true },

    SpecialComment = { bg = my.commentBackground, fg = my.commentFg, italic = false },
    TSComment = { bg = my.commentBackground, fg = my.commentFg, italic = false },

    TreesitterContext = { bg = my.commentBackground },

    Todo = { bg = my.commentBackground, fg = '#4C9E90', bold = true },
    ['@text.todo'] = { bg = my.commentBackground, fg = '#4C9E90', bold = true },

    CursorLine = { bg = my.cursorLineBg },

    TelescopeMatching = { fg = '#d05858', bold = true },
    TelescopeSelection = { default = true, bg = my.cursorLineBg },
    SignatureMarkText = { fg = '#B4703E', bold = true },
    MarkSignHL = { fg = '#B4703E', bold = true },

    BqfSign = { fg = '#F8FBF6', bg = '#896a98', bold = true },

    ColorColumn = { bg = my.commentBackground },

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
    DapStoppedLineNumber = { bg = my.debugLineBg },

    -- diff / conflicts
    DiffAdd = { bg = my.diffAddBg },
    DiffDelete = { bg = my.diffRemoveBg },
    DiffChange = { bg = my.diffChangeBg },
    DiffText = { bg = my.diffTextBg },

    GitConflictCurrent = { bg = my.diffTextBg },
    GitConflictIncoming = { bg = my.diffAddBg },
    GitConflictAncestor = { bg = my.diffChangeBg },
    GitConflictCurrentLabel = { fg = my.conflictSepFg, bg = my.conflictSepBg },
    GitConflictIncomingLabel = { fg = my.conflictSepFg, bg = my.conflictSepBg },
    GitConflictAncestorLabel = { fg = my.conflictSepFg, bg = my.conflictSepBg },

    -- snacks
    -- SnacksPicker = { bg = 'NONE' },
    -- SnacksPicker = { link = 'None' },
  }
end

function M.apply_override_highlights(extra_hl_groups)
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('my-colorscheme-override-highlights', { clear = true }),
    callback = function()
      for k, v in pairs(M.get_override_highlights()) do
        vim.api.nvim_set_hl(0, k, v)
      end
      for k, v in pairs(extra_hl_groups or {}) do
        vim.api.nvim_set_hl(0, k, v)
      end
    end,
  })
end

-- use :Inspect or :Inspect! to check hl group under cursor
function M.get_my_highlights()
  return {
    Visual = { bg = my.selectionBg },

    -- flash
    MyFlashLabel = { italic = true, fg = '#AF2004' },
    MyFlashMatch = { italic = true, fg = '#AF2004' },

    -- my special todos
    MyTodo = { bg = my.commentBackground, fg = my.todoFg, bold = true },

    -- Base Menu Bar UI
    MyMenubarLine = { bg = my.menubarBaseBg, fg = my.menubarBaseFg },
    MyMenubarInactiveCap = { bg = my.menubarInactiveAccent, fg = my.menubarInactiveAccent },
    MyMenubarActiveCap = { bg = my.menubarActiveAccent, fg = my.menubarActiveAccent },

    -- Tab Bar UI
    MyTabLine = { fg = my.menubarBaseFg, bg = my.menubarBaseBg },
    MyTabLineJump = { fg = '#AE0004', bg = my.menubarBaseBg, bold = true },
    MyTabLineFill = { bg = my.menubarBg1 },
    MyTabLineSel = { fg = my.menubarFg2, bg = my.menubarActiveAccent, italic = true },
    MyTabLineJumpSel = { fg = '#FF9B9D', bg = my.menubarActiveAccent, italic = true, bold = true },

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
  }
end

function M.apply_my_highlights()
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('my-colorscheme-my-highlights', { clear = true }),
    callback = function()
      for k, v in pairs(M.get_my_highlights()) do
        vim.api.nvim_set_hl(0, k, v)
      end
    end,
  })
end

return M

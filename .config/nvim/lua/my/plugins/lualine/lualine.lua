local icons = require('my/plugins/lualine/icons')
local qfExtension = require('my/plugins/lualine/extensions/quickfix')
local dapuiExtension = require('my/plugins/lualine/extensions/dapui')
local utils = require('my/plugins/lualine/utils')

local my_theme = {
  -- note: these colors dictate separators colors
  -- but we typically do separator caps manually anyways so it gets ignored usually
  normal = {
    a = 'MyMenubarLine',
    b = 'MyMenubarLine',
    c = 'MyMenubarLine',
    x = 'MyMenubarLine',
    y = 'MyMenubarLine',
    z = 'MyMenubarLine',
  },
}

local modes = {
  n = { name = 'NORMAL', color = 'MyStatusbarModeNormal' },
  v = { name = 'VISUAL', color = 'MyStatusbarModeVisual' },
  V = { name = 'V-LINE', color = 'MyStatusbarModeVLine' },
  [''] = { name = 'V-BLOCK', color = 'MyStatusbarModeVBlock' },
  s = { name = 'SELECT', color = 'MyStatusbarModeSelect' },
  S = { name = 'S-LINE', color = 'MyStatusbarModeSLine' },
  [''] = { name = 'S-BLOCK', color = 'MyStatusbarModeSBlock' },
  i = { name = 'INSERT', color = 'MyStatusbarModeInsert' },
  R = { name = 'REPLACE', color = 'MyStatusbarModeReplace' },
  c = { name = 'COMMAND', color = 'MyStatusbarModeCommand' },
  r = { name = 'PROMPT', color = 'MyStatusbarModePrompt' },
  ['!'] = { name = 'EXTERNAL', color = 'MyStatusbarModeExternal' },
  t = { name = 'TERMINAL', color = 'MyStatusbarModeTerminal' },
}

local function get_vim_mode_color()
  local vim_mode = vim.fn.mode()
  return modes[vim_mode].color
end

local function getFiletypeComponent(color)
  return {
    'filetype',
    colored = false,
    color = color,
    icon_only = true,
    padding = { left = 1, right = 0 },
  }
end

local function getFilenameSymbols()
  return {
    modified = icons.modified, -- Text to show when the file is modified.
    readonly = icons.readonly, -- Text to show when the file is non-modifiable or readonly.
    unnamed = '[No Name]', -- Text to show for unnamed buffers.
    newfile = '[New]', -- Text to show for new created file before first writting
  }
end

require('lualine').setup({
  extensions = { qfExtension, dapuiExtension },
  options = {
    disabled_filetypes = { -- Filetypes to disable lualine for
      statusline = { 'alpha', 'fugitiveblame', 'fugitive' },
      winbar = { 'alpha', 'gitcommit', 'qf', 'dap-repl', 'kulala_ui' },
    },
    icons_enabled = true,
    theme = my_theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
    ignore_focus = {},
    always_divide_middle = false,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  -- global status line
  sections = {
    lualine_a = {
      utils.createSpaceComponent('MyMenubarInactiveCap'),
      {
        'mode',
        color = get_vim_mode_color,
        -- color = function()
        --   return { fg = "#E8EBF0", bg = get_vim_mode_style()[2], gui = "bold" }
        -- end
      },
      getFiletypeComponent('MyStatusbarFiletype'),
      {
        'filename',
        color = 'MyStatusbarFilename',
        file_status = true,
        newfile_status = false,
        -- path = 1, -- relative path
        path = 2, -- absolute path
        symbols = getFilenameSymbols(),
      },
      {
        'diagnostics',
        -- colors = { fg = colors.light01, bg = colors.orange, gui = "bold" },
        diagnostics_color = {
          error = 'MyStatusbarDiagnosticError',
          warn = 'MyStatusbarDiagnosticWarn',
          -- info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
          -- hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
        },
        sections = { 'error', 'warn' },
      },
      { 'location', color = 'MyStatusbarFileLocation' },
      { 'progress', color = 'MyStatusbarFileProgress' },
      utils.createRightCap('MyStatusbarFileProgressCap'),
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      -- {
      --   'lsp_progress',
      --   display_components = { 'spinner' },
      --   spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
      --   timer = { progress_enddelay = 500, spinner = 500, lsp_client_name_enddelay = 1000 },
      --   colors = {
      --     spinner = 'MyStatusbarLsp',
      --     -- use = true,
      --   },
      --   color = 'MyStatusbarLsp',
      --   padding = { left = 1, right = 0 },
      -- },
      -- lsp connected - does not work in 0.10
      -- { function() return "lsp " .. icons.lsp end, cond = function() return vim.lsp.buf.server_ready() end,
      --   padding = { left = 1, right = 1 },
      --   color = "MyStatusbarLsp",
      -- },
      -- grug-far
      -- {
      --   function()
      --     local text = ''
      --     local buf = vim.api.nvim_get_current_buf()
      --     local status = require('grug-far').get_instance(buf):get_status_info()
      --     local stats = status.stats
      --     if stats and stats.matches > 0 then
      --       text = text .. stats.matches .. ' matches in ' .. stats.files .. ' files'
      --     end
      --     if status.actionMessage then
      --       text = text .. ' - ' .. status.actionMessage
      --     end
      --
      --     return text
      --   end,
      --   cond = function()
      --     return vim.bo.filetype == 'grug-far'
      --   end,
      --   padding = { left = 1, right = 1 },
      -- },
      -- dap
      {
        function()
          return icons.debug .. ' ' .. require('dap').status()
        end,
        cond = function()
          return require('dap').status() ~= ''
        end,
        color = 'MyStatusbarDapStatus',
      },
      {
        'branch',
        color = 'MyStatusbarBranch',
        icon = { icons.git, color = 'MyStatusbarBranch' },
      },
      utils.createSpaceComponent('MyMenubarInactiveCap'),
    },
  },
  inactive_sections = {},
  -- tabline = {
  --   lualine_a = {},
  --   lualine_b = {
  --     { 'tabs',
  --       -- TODO: temporary hack until they fix it tho use showtabline always
  --       -- https://github.com/nvim-lualine/lualine.nvim/discussions/845
  --       cond = function()
  --         local lessThan2Tabs = #(vim.api.nvim_list_tabpages()) < 2
  --         if lessThan2Tabs then
  --           vim.o.showtabline = 1
  --         else
  --           vim.o.showtabline = 2
  --         end
  --         return not lessThan2Tabs
  --       end,
  --       mode = 2, -- show tab name and number
  --       tabs_color = {
  --         active = { bg = colors.yellow, fg = colors.light01 },
  --         inactive = { bg = colors.base04, fg = colors.light01 },
  --       },
  --       section_separators = { left = '' },
  --       component_separators = { left = '' },
  --     }
  --   },
  --   lualine_c = {},
  --   lualine_x = {},
  --   lualine_y = {},
  --   lualine_z = {}
  -- },

  -- bar for each window
  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      utils.createSpaceComponent('MyMenubarActiveCap'),

      getFiletypeComponent('MyWinbarFiletype'),
      { 'filename', color = 'MyWinbarFilename', symbols = getFilenameSymbols() },
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      utils.createSpaceComponent('MyMenubarActiveCap'),
    },
  },

  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      utils.createSpaceComponent('MyMenubarInactiveCap'),
      getFiletypeComponent('MyWinbarFiletype'),
      { 'filename', color = 'MyWinbarFilename', symbols = getFilenameSymbols() },
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      utils.createSpaceComponent('MyMenubarInactiveCap'),
    },
  },
})

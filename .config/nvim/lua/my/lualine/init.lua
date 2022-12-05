local colors = require("my/lualine/colors")
local icons = require("my/lualine/icons")

local my_theme = {
  -- note: these colors dictate separators colors
  normal = {
    a = { fg = colors.base07, bg = colors.yellow },
    b = { fg = colors.base07, bg = colors.base02 },
    c = { fg = colors.base07, bg = colors.base00 },
    z = { fg = colors.base07, bg = colors.base02 },
  },
}

local modes = {
  n = { "NORMAL", colors.green },
  v = { "VISUAL", colors.cyan },
  V = { "V-LINE", colors.cyan },
  [""] = { "V-BLOCK", colors.cyan },
  s = { "SELECT", colors.orange },
  S = { "S-LINE", colors.orange },
  [""] = { "S-BLOCK", colors.orange },
  i = { "INSERT", colors.yellow },
  R = { "REPLACE", colors.red },
  c = { "COMMAND", colors.blue },
  r = { "PROMPT", colors.brown },
  ["!"] = { "EXTERNAL", colors.purple },
  t = { "TERMINAL", colors.purple },
}

local function get_vim_mode_style()
  local vim_mode = vim.fn.mode()
  return modes[vim_mode]
end

local function createSpaceComponent(color)
  return { function() return " " end, padding = 0, color = { bg = color } }
end

local function getFiletypeComponent(fgColor, bgColor)
  return { 'filetype',
    colored = false,
    color = { fg = fgColor, bg = bgColor, gui = "bold" },
    icon_only = true,
    padding = { left = 1, right = 0 }
  }
end

require('lualine').setup {
  extensions = {},
  options = {
    disabled_filetypes = { -- Filetypes to disable lualine for
      statusline = { 'startify', 'fugitiveblame', 'fugitive' },
      winbar = { 'startify' },
      tabbar = { 'gitcommit' }
    },
    icons_enabled = true,
    theme = my_theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  -- global status line
  sections = {
    lualine_a = {
      createSpaceComponent(colors.base04),
      { 'mode',
        color = function()
          return { fg = colors.light01, bg = get_vim_mode_style()[2], gui = "bold" }
        end
      },
      getFiletypeComponent(colors.base07, colors.base02),
      { 'filename',
        color = { fg = colors.base07, bg = colors.base02 },
        file_status = true,
        newfile_status = false,
        path = 1, -- relative path
        symbols = {
          modified = icons.modified, -- Text to show when the file is modified.
          readonly = icons.readonly, -- Text to show when the file is non-modifiable or readonly.
          unnamed = '[No Name]', -- Text to show for unnamed buffers.
          newfile = '[New]', -- Text to show for new created file before first writting
        }
      },
      { 'diagnostics',
        -- colors = { fg = colors.light01, bg = colors.orange, gui = "bold" },
        diagnostics_color = {
          error = { fg = colors.light01, bg = colors.orange, gui = "bold" }, -- Changes diagnostics' error color.
          warn  = { fg = colors.light01, bg = colors.orange, gui = "bold" }, -- Changes diagnostics' warn color.
          -- info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
          -- hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
        },
        sections = { 'error', 'warn' },
      },
      { 'location',
        color = { fg = colors.light01, bg = colors.base04, gui = "bold" },
      },
      { 'progress',
        color = { fg = colors.light01, bg = colors.yellow, gui = "bold" },
      }
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      { 'branch',
        icon = { icons.git, color = { bg = colors.base02, gui = "bold" } }
      },
      { function() return icons.lsp end, cond = function() return vim.lsp.buf.server_ready() end },
      createSpaceComponent(colors.base04),
    },
  },
  inactive_sections = {},
  tabline = {
    lualine_a = {},
    lualine_b = {
      { 'tabs',
        mode = 2, -- show tab name and number
        tabs_color = {
          active = { bg = colors.yellow, fg = colors.light01 },
          inactive = { bg = colors.base04, fg = colors.light01 },
        },
        section_separators = { left = '' },
        component_separators = { left = '' },
      }
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },

  -- bar for each window
  winbar = {
    lualine_a = {},
    lualine_b = {
      createSpaceComponent(colors.base04),

      getFiletypeComponent(colors.base07, colors.base02),
      { 'filename',
        color = { fg = colors.base07, bg = colors.base02 },
      }
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      'location',
      createSpaceComponent(colors.base04),
    }
  },

  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      createSpaceComponent(colors.base02),
      getFiletypeComponent(colors.base07, colors.base00),
      'filename'
    },
    lualine_y = {},
    lualine_x = {
      'location',
      createSpaceComponent(colors.base02),
    },
    lualine_z = {},
  },
}

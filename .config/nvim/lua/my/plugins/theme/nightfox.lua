local mycolors = require('my.plugins.theme.mycolors')

return {
  'EdenEast/nightfox.nvim',
  lazy = false, -- make sure we load this during startup
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    local my = mycolors.set_base_colors({
      -- background = '#FAFAF9',
      background = '#F6F2EE',

      selectionBg = '#DBEDED',

      commentBackground = '#F0E4DA',
      commentFg = '#544D47',

      menubarBaseBg = '#D6DDDB',

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
      cursorLineBg = '#F0E4DA',
      searchBg = '#896a98',
    })
    mycolors.apply_my_highlights()
    mycolors.apply_override_highlights()

    require('nightfox').setup({
      options = {
        colorblind = {
          enable = true, -- Enable colorblind support
          -- simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
          severity = {
            protan = 0.4, -- Severity [0,1] for protan (red)
            deutan = 0.4, -- Severity [0,1] for deutan (green)
            tritan = 0.1, -- Severity [0,1] for tritan (blue)
          },
        },
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
      },
      palettes = {
        dayfox = { bg1 = '#EFF1F5' },
      },
    })
    vim.cmd.colorscheme('dayfox')
    vim.opt.background = 'light'
  end,
}

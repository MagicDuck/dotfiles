local mycolors = require('my.plugins.theme.mycolors')

return {
  'projekt0n/github-nvim-theme',
  lazy = false, -- make sure we load this during startup
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    local my = mycolors.set_base_colors({
      background = '#E0E2EA',

      selectionBg = '#DADCEB',

      commentBackground = '#D3D5DC',

      commentFg = '#111111',

      menubarBaseBg = '#C9CBD2',

      menubarBg1 = '#D4D6DB',
      menubarBg2 = '#65737e',
      menubarBg3 = '#a48c32',
      menubarBg4 = '#b4713d',

      menubarBaseFg = '#1b2b34',
      menubarFg1 = '#F6FAFF',
      menubarFg2 = '#FCFFFA',

      menubarInactiveAccent = '#65737e',
      menubarActiveAccent = '#896a98',

      debugLineBg = '#F0E0E0',
      cursorLineBg = '#D3D5DC',
      searchBg = '#896a98',

      floatBg = '#D3D5DC',

      todoFg = '#A80000',

      error = '#8B0E0E',
      errorBg = '#E1A19B',
      -- errorBg = '#F4D9D5',
    })
    mycolors.apply_my_highlights()
    mycolors.apply_override_highlights({
      PmenuSel = { bg = my.menubarBg2, fg = 'white' },
      PmenuKindSel = { link = 'PmenuSel' },
      PmenuExtraSel = { link = 'PmenuSel' },
      BlinkCmpMenuSelection = { link = 'PmenuSel' },
      IncSearch = { fg = '#F5F3F4', bg = '#B55252' },
      Changed = { bg = '#F0E0AA' },
      WinSeparator = { fg = '#1A2B34' },
      DiagnosticSignError = { fg = my.error },
      DiagnosticError = { fg = my.error },
      DiagnosticVirtualTextError = { fg = my.error },
    })

    require('github-theme').setup({
      inverse = { -- Inverse highlight for different types
        match_paren = false,
        visual = false,
        search = false,
      },
    })
    vim.cmd.colorscheme('github_light_high_contrast')
    vim.opt.background = 'light'
  end,
}

local mycolors = require('my.plugins.theme.mycolors')

return {
  'scottmckendry/cyberdream.nvim',
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
    })
    require('cyberdream').setup({
      variant = 'light',
      transparent = true,
      italic_comments = true,
    })
    mycolors.apply_my_highlights()
    mycolors.apply_override_highlights({
      PmenuSel = { bg = my.menubarBg2, fg = 'white' },
      PmenuKindSel = { link = 'PmenuSel' },
      PmenuExtraSel = { link = 'PmenuSel' },
      BlinkCmpMenuSelection = { link = 'PmenuSel' },
    })

    vim.cmd.colorscheme('cyberdream')
    vim.opt.background = 'light'
  end,
}

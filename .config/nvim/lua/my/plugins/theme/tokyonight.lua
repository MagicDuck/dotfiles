local mycolors = require('my.plugins.theme.mycolors')

return {
  'folke/tokyonight.nvim',
  lazy = false, -- make sure we load this during startup
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    local my = mycolors.set_base_colors({
      background = '#FAFAF9',

      selectionBg = '#DBEDED',

      commentBackground = '#F0F0ED',
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
      cursorLineBg = '#F0F0ED',
      searchBg = '#896a98',
    })
    mycolors.apply_my_highlights()
    -- mycolors.apply_override_highlights()

    require('tokyonight').setup({})
    vim.cmd.colorscheme('tokyonight-day')
    vim.opt.background = 'light'
  end,
}

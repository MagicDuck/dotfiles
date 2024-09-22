local mycolors = require('my.plugins.theme.mycolors')
local my = mycolors.set_base_colors({
  background = '#E0E2EA',

  selectionBg = '#9B9EA4',

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
mycolors.apply_my_highlights()
mycolors.apply_override_highlights()

vim.cmd.colorscheme('default')
vim.opt.background = 'light'

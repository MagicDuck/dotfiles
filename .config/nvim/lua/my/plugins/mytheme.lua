require('my.plugins.theme.default')
return {
  -- require('my.plugins.theme.tinted'),
  -- require('my.plugins.theme.gruvbox'),
  -- require('my.plugins.theme.nightfox'),
  -- require('my.plugins.theme.github'),
  -- require('my.plugins.theme.catpuccin'),
  -- require('my.plugins.theme.onedark'),
  -- require('my.plugins.theme.dracula'),
  -- require('my.plugins.theme.zenbones'),
  {
    'xiyaowong/transparent.nvim',
    lazy = false, -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('transparent').setup({
        extra_groups = {
          -- 'menubarBaseBg',
          -- 'menubarBg1',
          -- 'menubarBg2',
          -- 'menubarBg3',
          -- 'menubarBg4',
        },
        exclude_groups = { 'Comment', 'CursorLine', 'CursorLineNr' },
      })

      vim.cmd('TransparentEnable')
    end,
  },
}

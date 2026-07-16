-- require('my.plugins.theme.default')
return {
  require('my.plugins.theme.github'),

  {
    'xiyaowong/transparent.nvim',
    lazy = false, -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    enabled = not vim.env.PROF,
    config = function()
      require('transparent').setup({
        extra_groups = {
          -- 'menubarBaseBg',
          -- 'menubarBg1',
          -- 'menubarBg2',
          -- 'menubarBg3',
          -- 'menubarBg4',
          -- 'DiffChange'
        },
        exclude_groups = { 'Comment', 'CursorLine', 'CursorLineNr' },
      })

      vim.cmd('TransparentEnable')
    end,
  },
}

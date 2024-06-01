return {
  {
    'nvim-lualine/lualine.nvim',
    lazy = true,
    event = 'VeryLazy',
    dependencies = {
      -- using fidget instead
      -- { 'arkav/lualine-lsp-progress' },
    },
    config = function()
      require('my.plugins.lualine.lualine')
    end,
  },
}

return {
  {
    'nanozuki/tabby.nvim',
    lazy = true,
    event = 'VeryLazy',
    config = function()
      require('my.plugins.tabby.tabby')
    end,
  },
}

return {
  {
    'echasnovski/mini.test',
    version = '*',
    lazy = true,
    event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
    config = function()
      require('mini.test').setup({})
    end,
  },
}

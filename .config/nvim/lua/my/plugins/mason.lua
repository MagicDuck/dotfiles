return {
  {
    'williamboman/mason.nvim',
    name = 'mason',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
    config = function()
      require('mason').setup({ ensure_installed = 'stylua' })
    end,
  },
}

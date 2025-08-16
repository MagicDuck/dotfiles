return {
  {
    'williamboman/mason.nvim',
    name = 'mason',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
    tag = 'v1.11.0',
    config = function()
      require('mason').setup({
        ensure_installed = {
          'stylua',
          'java-debug-adapter',
          'java-test',
        },
      })
    end,
  },
}

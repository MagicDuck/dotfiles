return {
  {
    'hrsh7th/nvim-cmp',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'rcarriga/cmp-dap' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'onsails/lspkind-nvim' },
    },
    config = function()
      require('my.plugins.completion.cmp')
    end,
  },
}

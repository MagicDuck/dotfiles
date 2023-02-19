return {
  { "hrsh7th/nvim-cmp",
    lazy = true,
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      { "rcarriga/cmp-dap" },
      -- { "quangnguyen30192/cmp-nvim-ultisnips" },
      { 'saadparwaiz1/cmp_luasnip' },
      { "onsails/lspkind-nvim" },
    },
    config = function()
      require('my.plugins.completion.cmp')
    end
  },
}

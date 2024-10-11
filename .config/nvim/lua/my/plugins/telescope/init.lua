return {
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
    dependencies = {
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'benfowler/telescope-luasnip.nvim' },
      { 'nvim-telescope/telescope-fzf-writer.nvim' },
      -- { "nvim-telescope/telescope-ui-select.nvim" },
      { 'nvim-telescope/telescope-file-browser.nvim' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' },
      { 'nvim-telescope/telescope-dap.nvim' },
      { 'nvim-telescope/telescope-symbols.nvim' },
    },
    config = function()
      require('my.plugins.telescope.telescope')
    end,
  },
}

return {
  { "nvim-telescope/telescope.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim",    build = "make" },
      { "fhill2/telescope-ultisnips.nvim" },
      { "nvim-telescope/telescope-fzf-writer.nvim" },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" },
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      { "nvim-telescope/telescope-dap.nvim" },
    },
    config = function()
      require('my.plugins.telescope.telescope')
    end
  }
}

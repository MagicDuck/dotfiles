return {
  { "nvim-lualine/lualine.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      { "arkav/lualine-lsp-progress" },
    },
    config = function()
      require('my.plugins.lualine.lualine')
    end
  },
}


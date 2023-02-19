return {
  { "nvim-lualine/lualine.nvim",
    dependencies = {
      { "arkav/lualine-lsp-progress" },
    },
    config = function()
      require('my.plugins.lualine.lualine')
    end
  },
}


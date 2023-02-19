return {
  { "nvim-pack/nvim-spectre",
    lazy = true,
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    config = function()
      require('spectre').setup({})
    end
  },
}

return {
  {
    "nvim-pack/nvim-spectre",
    lazy = true,
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    config = function()
      require('spectre').setup({ replace_engine = { sed = { cmd = "sed" } } })
    end
  },
}

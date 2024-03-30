return {
  {
    "nvim-pack/nvim-spectre",
    lazy = true,
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    config = function()
      require('spectre').setup({ is_block_ui_break = true, replace_engine = { sed = { cmd = "sed" } } })
    end
  },
}

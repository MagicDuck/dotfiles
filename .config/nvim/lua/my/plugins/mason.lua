return {
  { "williamboman/mason.nvim",
    name = "mason",
    config = function()
      require("mason").setup({})
    end
  },
}

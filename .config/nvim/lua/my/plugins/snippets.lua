return {
  -- TODO (sbadragan): replace with luasnip
  { "sirver/UltiSnips",
    lazy = true,
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    config = function()
      vim.g.UltiSnipsExpandTrigger = "<tab>"
      vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"

      vim.g.UltiSnipsEditSplit = "vertical"

      vim.cmd([[
        augroup my_ultisnip
          autocmd!
          autocmd FileType javascriptreact UltiSnipsAddFiletypes javascriptreact.javascript.javascript-react
        augroup END
    ]])
    end,
  },
  { "honza/vim-snippets",
    lazy = true,
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  },
}

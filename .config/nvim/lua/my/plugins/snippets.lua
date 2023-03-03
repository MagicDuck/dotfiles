return {
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    -- follow latest release.
    -- version = "<CurrentMajor>.*",
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = {
      { "honza/vim-snippets" },
    },
    config = function()
      require("luasnip.loaders.from_snipmate").lazy_load()
      -- One peculiarity of honza/vim-snippets is that the file with the global snippets is _.snippets, so global snippets
      -- are stored in `ls.snippets._`.
      -- We need to tell luasnip that "_" contains global snippets:
      require('luasnip').filetype_extend("all", { "_" })
      require('luasnip').filetype_extend("javascriptreact", { "javascript" })

      vim.api.nvim_create_user_command('EditSnippets', function()
        require("luasnip.loaders").edit_snippet_files({
          edit = function(file)
            vim.cmd('vsplit ' .. file)
          end,
          -- allow creation of snippet file
          extend = function(ft, paths)
            if #paths == 0 then
              return {
                { "$CONFIG/" .. ft .. ".snippets",
                  string.format("%s/%s.snippets", vim.fn.stdpath("config") .. "/snippets", ft) }
              }
            end

            return {}
          end
        })
      end, {})
      -- The following is configured already through cmp
      -- vim.cmd([[
      --   " press <Tab> to expand or jump in a snippet. These can also be mapped separately
      --   " via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
      --   imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
      --   " -1 for jumping backwards.
      --   inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
      --
      --   snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
      --   snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
      --
      --   " For changing choices in choiceNodes (not strictly necessary for a basic setup).
      --   imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
      --   smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
      -- ]])
    end
  }
}

return {
  'L3MON4D3/LuaSnip',
  lazy = true,
  event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
  -- follow latest release.
  -- version = "<CurrentMajor>.*",
  -- install jsregexp (optional!).
  build = 'make install_jsregexp',
  dependencies = {
    { 'honza/vim-snippets' },
    { 'Neurarian/snacks-luasnip.nvim' },
  },
  config = function()
    local luasnip = require('luasnip')

    require('luasnip.loaders.from_snipmate').lazy_load()
    -- One peculiarity of honza/vim-snippets is that the file with the global snippets is _.snippets, so global snippets
    -- are stored in `ls.snippets._`.
    -- We need to tell luasnip that "_" contains global snippets:
    luasnip.filetype_extend('all', { '_' })
    luasnip.filetype_extend('javascriptreact', { 'javascript' })

    vim.api.nvim_create_user_command('EditSnippets', function()
      require('luasnip.loaders').edit_snippet_files({
        edit = function(file)
          vim.cmd('vsplit ' .. file)
        end,
        -- allow creation of snippet file
        extend = function(ft, paths)
          if #paths == 0 then
            return {
              {
                '$CONFIG/' .. ft .. '.snippets',
                string.format('%s/%s.snippets', vim.fn.stdpath('config') .. '/snippets', ft),
              },
            }
          end

          return {}
        end,
      })
    end, {})
  end,
}

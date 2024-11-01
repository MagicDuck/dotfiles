return {
  {
    'tpope/vim-fugitive',
    lazy = true,
    event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
    config = function()
      vim.cmd([[
        let g:nremap = {'s': 't'}
        let g:xremap = {'s': 't'}
        let g:oremap = {'s': 't'}
      ]])
    end,
  },
  {
    'shumphrey/fugitive-gitlab.vim',
    lazy = true,
    event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
    config = function()
      vim.g.fugitive_gitlab_domains = { 'https://gitlab.eb-tools.com' }
    end,
  },
  {
    'tpope/vim-rhubarb',
    lazy = true,
    event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
    config = function()
      -- if I ever need this:
      -- vim.g.github_enterprise_urls = {'https://example.com'}
    end,
  },
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    lazy = false,
    -- lazy = true,
    -- event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    config = function()
      local actions = require('diffview.actions')

      require('diffview').setup({
        keymaps = {
          -- disable_defaults = false, -- Disable the default keymaps
          view = {
            -- The `view` bindings are active in the diff buffers, only when the current
            -- tabpage is a Diffview.
            ['<C-j>'] = actions.select_next_entry, -- Open the diff for the next file
            ['<C-k>'] = actions.select_prev_entry, -- Open the diff for the previous file
          },
          file_panel = {
            ['<C-j>'] = actions.select_next_entry,
            ['<C-k>'] = actions.select_prev_entry,
            ['[x'] = actions.prev_conflict,
            [']x'] = actions.next_conflict,
            -- TODO: normal! ]cdo will put the next diff in the index buffer. Then use write! to write it out
          },
          file_history_panel = {
            ['<C-j>'] = actions.select_next_entry,
            ['<C-k>'] = actions.select_prev_entry,
          },
        },
      })
    end,
  },
}

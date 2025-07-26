local is_linux = vim.fn.has('linux') == 1

return {
  {
    'nvim-treesitter/nvim-treesitter',
    name = 'treesitter',
    version = false,
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      -- { 'JoosepAlviste/nvim-ts-context-commentstring' },
      { 'nvim-treesitter/playground' },
      -- { 'windwp/nvim-ts-autotag' },
    },
    config = function()
      local ts = require('nvim-treesitter.configs')

      ts.setup({
        -- ensure_installed = { "javascript", "lua", "c", "vim", "help", "query" },
        ensure_installed = 'all',
        -- auto_install = true,
        ignore_install = { 'comment' }, -- has some performance issues atm
        -- This stuff seems to be already better taken of by default
        highlight = {
          enable = true,
          custom_captures = {},
        },
        -- disable = function(lang, buf)
        --   local first_line = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1]
        --   if first_line ~= nil and string.len(first_line) > 500 then
        --     -- this is probably a minified file, don't attempt to highlight
        --     return true
        --   end
        --   local max_filesize = 200 * 1024 -- 200 KB
        --   local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        --   if ok and stats and stats.size > max_filesize then
        --     -- large file, don't attempt highlight
        --     return true
        --   end
        --
        --   return false
        -- end,
        playground = {
          enable = true,
          updatetime = 25,
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              -- Note: those are stored under query/<lang>/textobjects.scm
              -- for query lang docs: https://tree-sitter.github.io/tree-sitter/using-parsers#pattern-matching-with-queries
              -- example to do ranges: https://github.com/nvim-treesitter/nvim-treesitter-textobjects/blob/master/queries/lua/textobjects.scm#L24-L27
              -- ['af'] = '@my.function.outer',
              -- ['if'] = '@my.function.body',
              -- ['ac'] = '@call.outer',
              -- ['ab'] = '@my.block.outer',
              -- ['ib'] = '@my.block.inner',
              -- ['as'] = '@my.statement',
              -- ['ir'] = '@my.variable_decl.rhs',
              -- ['ia'] = '@my.args',
              -- ['am'] = '@my.comment',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@call.outer',
              ['ab'] = '@block.outer',
              ['ib'] = '@block.inner',
              ['as'] = '@statement.outer',
              ['ir'] = '@my.variable_decl.rhs',
              ['ia'] = '@parameter.outer',
              ['a='] = { query = '@assignment.outer', desc = 'Select outer part of an assignment' },
              ['i='] = { query = '@assignment.inner', desc = 'Select inner part of an assignment' },
              ['l='] = { query = '@assignment.lhs', desc = 'Select left hand side of an assignment' },
              ['r='] = { query = '@assignment.rhs', desc = 'Select right hand side of an assignment' },
              ['ax'] = '@attribute.outer',
              ['ix'] = '@attribute.inner',
            },
          },
          -- swap = {
          --   enable = true,
          --   swap_previous = {
          --     ["<Left>s"] = "@parameter.inner",
          --   },
          --   swap_next = {
          --     ["<Right>s"] = "@parameter.inner",
          --   },
          -- },
          move = {
            enable = true,
            goto_previous_start = {
              ['<leader>ka'] = '@function.outer',
            },
            goto_next_start = {
              ['<leader>ja'] = '@function.outer',
            },
            goto_previous_end = {
              ['<leader>kA'] = '@function.outer',
            },
            goto_next_end = {
              ['<leader>jA'] = '@function.outer',
            },
            goto_next = {
              ['<leader>jb'] = {
                query = { '@parameter.inner', '@conditional.inner', '@call.inner', '@block.inner', '@class.inner' },
              },
            },
            goto_previous = {
              ['<leader>kb'] = {
                query = { '@parameter.inner', '@conditional.inner', '@call.inner', '@block.inner', '@class.inner' },
              },
            },
          },
        },
        incremental_selection = {
          enable = true,
          lookahead = true,
          keymaps = {
            init_selection = '<bs>',
            node_incremental = '<bs>',
            node_decremental = '<del>',
            -- scope_incremental = is_linux and '<c-h>' or '<a-bs>', -- c-h is c-bs weirdly enough
          },
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'treesitter',
    },
    config = function()
      require('treesitter-context').setup({
        max_lines = 5,
      })
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    dependencies = {
      'treesitter',
    },
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
      })
    end,
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      'treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
}

local is_linux = vim.fn.has('linux') == 1

return {
  {
    'nvim-treesitter/nvim-treesitter',
    name = 'treesitter',
    -- version = false,
    branch = 'main',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        init = function()
          vim.g.no_plugin_maps = true
        end,
      },
      { 'nvim-treesitter/nvim-treesitter-context' },

      -- { 'JoosepAlviste/nvim-ts-context-commentstring' },
      -- { 'nvim-treesitter/playground' },
    },
    config = function()
      -- Fold settings
      -- vim.opt.foldmethod = 'expr'
      -- vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

      -- replicate `ensure_installed`, runs asynchronously, skips existing languages
      require('nvim-treesitter').install({})

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter.setup', {}),
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          local lang = vim.treesitter.language.get_lang(ft)

          if not vim.treesitter.language.add(lang) then
            local available = vim.g.ts_available or require('nvim-treesitter').get_available()
            if not vim.g.ts_available then
              vim.g.ts_available = available
            end
            if vim.tbl_contains(available, lang) then
              require('nvim-treesitter').install(lang)
            end
          else
            vim.treesitter.start(args.buf, lang)
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            -- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            -- vim.wo[0][0].foldmethod = "expr"
          end
        end,
      })

      -- textobjects plugin now uses its own setup + keymaps
      require('nvim-treesitter-textobjects').setup({
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
      })

      -- context
      require('treesitter-context').setup({
        max_lines = 5,
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

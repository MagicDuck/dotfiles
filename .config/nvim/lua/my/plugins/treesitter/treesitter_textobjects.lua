return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  init = function()
    vim.g.no_plugin_maps = true
  end,
  dependencies = {
    'treesitter',
  },
  setup = function()
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
  end,
}

return {
  {
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    lazy = true,
    opts = {
      options = {
        display = {
          mode = 'virtualtext',
          virtualtext = { position = 'before' },
        },
      },
      filetypes = {
        'lua',
        'javascript',
        'javascriptreact',
        'typescript',
        'css',
        'scss',
        'json',
      },
    },
  },

  {
    'folke/ts-comments.nvim',
    opts = {},
    event = 'VeryLazy',
    enabled = vim.fn.has('nvim-0.10.0') == 1,
  },

  {
    'echasnovski/mini.comment',
    version = '*',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
    config = function()
      require('mini.comment').setup({
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Toggle comment (like `gcip` - comment inner paragraph) for both
          -- Normal and Visual modes
          comment = '<leader>c',

          -- Toggle comment on current line
          comment_line = '<leader>c',
          comment_visual = '<leader>c',

          -- Define 'comment' textobject (like `dgc` - delete whole comment block)
          textobject = 'ic',
        },
      })
    end,
  },

  {
    'kmonad/kmonad-vim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
  },

  {
    'echasnovski/mini.surround',
    lazy = true,
    version = '*',
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
    config = function()
      require('mini.surround').setup({
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          add = 'gsa', -- Add surrounding in Normal and Visual modes
          delete = 'gsd', -- Delete surrounding
          find = 'gsf', -- Find surrounding (to the right)
          find_left = 'gsF', -- Find surrounding (to the left)
          highlight = 'gsh', -- Highlight surrounding
          replace = 'gsr', -- Replace surrounding

          suffix_last = 'l', -- Suffix to search with "prev" method
          suffix_next = 'n', -- Suffix to search with "next" method
        },
      })

      vim.keymap.set('x', 'sa', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })
      vim.keymap.set('x', 'sd', [[:<C-u>lua MiniSurround.delete()<CR>]], { silent = true })
    end,
  },

  {
    'rafcamlet/nvim-luapad',
    lazy = true,
    event = { 'VeryLazy' },
  },

  {
    'chentoast/marks.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
    config = function()
      require('marks').setup({})
    end,
  },

  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
    config = function()
      require('todo-comments').setup({
        merge_keywords = false,
        keywords = {
          TODO = { icon = ' ', color = 'todo' },
        },
        highlight = {
          -- highlights before the keyword (typically comment characters)
          before = '', -- "fg", "bg", or empty
          -- highlights of the keyword
          -- wide is the same as bg, but also highlights the colon
          keyword = 'fg', -- "fg", "bg", "wide", or empty
          -- highlights after the keyword (TODO text)
          after = '', -- "fg", "bg", or empty
          -- pattern can be a string, or a table of regexes that will be checked
          -- vim regex
          pattern = [[.*<(KEYWORDS) \(sbadragan\)\s*:]],
          comments_only = true, -- highlight only inside comments using treesitter
          max_line_len = 400, -- ignore lines longer than this
          exclude = {}, -- list of file types to exclude highlighting
        },
        -- list of named colors
        -- a list of hex colors or highlight groups, will use the first available one in the list on RHS
        colors = {
          todo = { 'MyTodo' },
          default = { 'Identifier', '#7C3AED' },
        },
        search = {
          -- don't replace the (KEYWORDS) placeholder
          pattern = [[\b(KEYWORDS) \(sbadragan\):]], -- ripgrep regex
        },
      })
    end,
  },

  {
    'nvim-mini/mini.cursorword',
    version = false,
    lazy = true,
    event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
    config = function()
      vim.api.nvim_create_autocmd('CursorMoved', {
        callback = function()
          local curword = vim.fn.expand('<cword>')
          local filetype = vim.bo.filetype

          -- Add any disabling global or filetype-specific logic here
          if filetype == 'lua' then
            vim.b.minicursorword_disable = vim.tbl_contains({ 'local', 'require', '--', '---' }, curword)
          elseif filetype == nil or filetype == '' then
            vim.b.minicursorword_disable = true
          end
        end,
      })

      require('mini.cursorword').setup()
    end,
  },

  {
    'windwp/nvim-autopairs',
    lazy = true,
    event = { 'VeryLazy' },
    config = function()
      require('nvim-autopairs').setup({})
    end,
  },

  {
    'danymat/neogen',
    lazy = true,
    event = { 'VeryLazy' },
    config = function()
      require('neogen').setup({ snippet_engine = 'luasnip' })
    end,
  },

  {
    'catgoose/bmessages.nvim',
    event = 'CmdlineEnter',
    opts = {},
  },

  {
    'mikavilpas/yazi.nvim',
    lazy = true,
    event = { 'VeryLazy' },
    -- for open_for_directories = true,
    init = function()
      -- Block netrw plugin load
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
      require('yazi').setup({
        -- if you want to open yazi instead of netrw
        -- open_for_directories = true,
        keymaps = {
          show_help = '<C-h>',
        },
        floating_window_scaling_factor = 0.8,
        yazi_floating_window_border = 'double',
      })
    end,
  },

  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup({
        shade_terminals = false,
      })
    end,
  },

  {
    'xb-bx/editable-term.nvim',
    config = true,
  },

  {
    'nmac427/guess-indent.nvim',
    lazy = true,
    event = { 'VeryLazy' },
    config = function()
      require('guess-indent').setup({
        auto_cmd = true, -- Set to false to disable automatic execution
        override_editorconfig = true, -- Set to true to override settings set by .editorconfig
        -- filetype_exclude = {
        --   'netrw',
        --   'tutor',
        --   'make',
        -- },
      })
      -- vim.cmd([[ autocmd BufReadPost * :silent GuessIndent ]])
    end,
  },

  {
    'Chaitanyabsprip/fastaction.nvim',
    opts = {
      register_ui_select = true,
      popup = {
        relative = 'cursor',
      },
    },
  },

  {
    'atusy/treemonkey.nvim',
    lazy = true,
    event = { 'VeryLazy' },
    config = function()
      vim.keymap.set({ 'x', 'o' }, 'm', function()
        require('treemonkey').select({
          ignore_injections = false,
          highlight = {
            -- backdrop = 'Comment',
            label = 'TelescopeMatching',
          },
        })
      end)
    end,
  },

  {
    'stevearc/oil.nvim',
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    -- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
      require('oil').setup({
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
        },
        keymaps = {
          ['<bs>'] = { 'actions.parent', mode = 'n' },
          ['<C-enter>'] = { 'actions.select', opts = { vertical = true } },
          ['<C-h>'] = { 'actions.select', opts = { horizontal = true } },
          ['<C-s>'] = false,
        },
      })
    end,
  },

  {
    'chrisgrieser/nvim-spider',
    lazy = true,
    event = { 'VeryLazy' },
    config = function()
      require('spider').setup({
        skipInsignificantPunctuation = false,
        consistentOperatorPending = false,
        subwordMovement = true,
        customPatterns = {},
      })

      vim.keymap.set({ 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<CR>")
      vim.keymap.set({ 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<CR>")
      vim.keymap.set({ 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<CR>")
    end,
  },

  {
    'aaronik/treewalker.nvim',

    -- The following options are the defaults.
    -- Treewalker aims for sane defaults, so these are each individually optional,
    -- and setup() does not need to be called, so the whole opts block is optional as well.
    opts = {
      -- Whether to briefly highlight the node after jumping to it
      highlight = false,

      -- How long should above highlight last (in ms)
      highlight_duration = 250,

      -- The color of the above highlight. Must be a valid vim highlight group.
      -- (see :h highlight-group for options)
      highlight_group = 'CursorLine',

      -- Whether the plugin adds movements to the jumplist -- true | false | 'left'
      --  true: All movements more than 1 line are added to the jumplist. This is the default,
      --        and is meant to cover most use cases. It's modeled on how { and } natively add
      --        to the jumplist.
      --  false: Treewalker does not add to the jumplist at all
      --  "left": Treewalker only adds :Treewalker Left to the jumplist. This is usually the most
      --          likely one to be confusing, so it has its own mode.
      jumplist = true,
    },
  },

  {
    'xzbdmw/clasp.nvim',
    config = function()
      require('clasp').setup({})
    end,
  },

  {
    dir = (vim.env.GHOSTTY_RESOURCES_DIR or '') .. '/../vim/vimfiles',
    lazy = false, -- Ensures it loads for Ghostty config detection
    name = 'ghostty', -- Avoids the name being "vimfiles"
    cond = vim.env.GHOSTTY_RESOURCES_DIR ~= nil, -- Only load if Ghostty is installed
  },

  {
    'mistweaverco/kulala.nvim',
    keys = {
      { '<leader>Rs', desc = 'Send request' },

      { '<leader>Ra', desc = 'Send all requests' },

      { '<leader>Rb', desc = 'Open scratchpad' },
    },
    ft = { 'http', 'rest' },
    opts = {
      global_keymaps = true,
      global_keymaps_prefix = '<localleader>',
      kulala_keymaps_prefix = '',
    },
  },

  {
    'stevearc/overseer.nvim',
    lazy = true,
    event = { 'VimEnter' },
    config = function()
      require('overseer').setup({
        templates = {
          'builtin',
          'my.tsc',
        },
      })
    end,
  },

  {
    'kevinhwang91/nvim-bqf',
    lazy = true,
    event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
    config = function()
      require('bqf').setup({
        auto_enable = true,
        magic_window = false, -- this creates issues when it's on and you have multiple splits
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { '┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█' },
          winblend = 0,
        },
        func_map = {
          vsplit = '',
          ptogglemode = 'z,',
          stoggleup = '',
        },
        filter = {
          fzf = {
            extra_opts = { '--bind', 'ctrl-o:toggle-all', '--prompt', '> ' },
          },
        },
      })
    end,
    dependencies = {
      {
        'junegunn/fzf',
        build = function()
          vim.fn['fzf#install']()
        end,
      },
      'treesitter',
    },
  },

  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
    event = { 'VimEnter' },
    config = function()
      require('nvim-web-devicons').setup({
        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = true,
      })
    end,
  },

  {
    'nvim-mini/mini.ai',
    version = '*',
    config = function()
      local ai = require('mini.ai')
      ai.setup({
        n_lines = 500,
        custom_textobjects = {
          s = ai.gen_spec.treesitter({
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          }, {}),
          d = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
        },
      })
    end,
  },
}

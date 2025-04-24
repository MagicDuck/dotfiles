return {
  {
    'brenoprata10/nvim-highlight-colors',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
    config = function()
      require('nvim-highlight-colors').setup({
        render = 'virtual',
        enable_named_colors = false,
        enable_tailwind = false,
      })
    end,
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
          add = 'S', -- Add surrounding in Normal and Visual modes
          delete = '', -- Delete surrounding
          find = '', -- Find surrounding (to the right)
          find_left = '', -- Find surrounding (to the left)
          highlight = '', -- Highlight surrounding
          replace = '', -- Replace surrounding
          update_n_lines = '', -- Update `n_lines`

          suffix_last = 'l', -- Suffix to search with "prev" method
          suffix_next = 'n', -- Suffix to search with "next" method
        },
      })
    end,
  },
  {
    'rafcamlet/nvim-luapad',
    lazy = true,
    event = { 'VeryLazy' },
  },
  {
    'tpope/vim-unimpaired',
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
  }, -- for marks to show in gutter
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
    'RRethy/vim-illuminate',
    lazy = true,
    event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
    config = function()
      require('illuminate').configure({
        -- providers: provider used to get references in the buffer, ordered by priority
        providers = {
          -- 'lsp',
          'treesitter',
          -- 'regex',
        },
        -- delay: delay in milliseconds
        delay = 100,
        -- filetype_overrides: filetype specific overrides.
        -- The keys are strings to represent the filetype while the values are tables that
        -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
        filetype_overrides = {},
        -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
        filetypes_denylist = {
          'dirvish',
          'fugitive',
        },
        -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
        filetypes_allowlist = {},
        -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
        -- See `:help mode()` for possible values
        modes_denylist = {},
        -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
        -- See `:help mode()` for possible values
        modes_allowlist = {},
        -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_denylist = {},
        -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_allowlist = {},
        -- under_cursor: whether or not to illuminate under the cursor
        under_cursor = true,
        -- large_file_cutoff: number of lines at which to use large_file_config
        -- The `under_cursor` option is disabled when this cutoff is hit
        large_file_cutoff = nil,
        -- large_file_config: config to use for large files (based on large_file_cutoff).
        -- Supports the same keys passed to .configure
        -- If nil, vim-illuminate will be disabled for large files.
        large_file_overrides = nil,
        -- min_count_to_highlight: minimum number of matches required to perform highlighting
        min_count_to_highlight = 2,
      })
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
  -- speed up loading large files
  -- {
  --   'pteroctopus/faster.nvim',
  --   lazy = false,
  --   config = function()
  --     require('faster').setup()
  --   end,
  -- },
  {
    'danymat/neogen',
    lazy = true,
    event = { 'VeryLazy' },
    config = function()
      require('neogen').setup({ snippet_engine = 'luasnip' })
    end,
  },
  {
    'ariel-frischer/bmessages.nvim',
    event = 'CmdlineEnter',
    opts = {},
  },
  {
    'mikavilpas/yazi.nvim',
    lazy = true,
    event = { 'VeryLazy' },
    init = function()
      -- Block netrw plugin load
      -- vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
      require('yazi').setup({
        -- if you want to open yazi instead of netrw
        open_for_directories = true,
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

      local function get_lazygit(dir)
        local Terminal = require('toggleterm.terminal').Terminal
        return Terminal:new({
          cmd = 'lazygit',
          direction = 'float',
          -- direction = 'tab',
          float_opts = {
            border = 'double',
          },
          start_in_insert = true,
          dir = dir,
          -- function to run on opening the terminal
          on_open = function(term)
            vim.schedule(function()
              vim.cmd('startinsert!')
            end)
            vim.api.nvim_buf_set_keymap(
              term.bufnr,
              't',
              '<C-g>',
              '<C-\\><C-n><cmd>close<cr>',
              { noremap = true, silent = true }
            )
            vim.api.nvim_buf_set_keymap(
              term.bufnr,
              't',
              '<C-h>',
              '<C-O><cmd>tabprev<cr>',
              { noremap = true, silent = true }
            )
            vim.api.nvim_buf_set_keymap(
              term.bufnr,
              't',
              '<C-l>',
              '<C-O><cmd>tabnext<cr>',
              { noremap = true, silent = true }
            )
          end,
        })
      end

      local lazygit_by_cwd = {}
      vim.keymap.set({ 'i', 'n', 'v', 't' }, '<C-g>', function()
        local cwd = vim.fn.getcwd()
        if not lazygit_by_cwd[cwd] then
          lazygit_by_cwd[cwd] = get_lazygit(cwd)
        end

        lazygit_by_cwd[cwd]:toggle()
      end)
    end,
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
    ---@type FastActionConfig
    opts = {
      priority = {
        -- dart = {
        --   { pattern = "organize import", key ="o", order = 1 },
        --   { pattern = "extract method", key ="x", order = 2 },
        --   { pattern = "extract widget", key ="e", order = 3 },
        -- },
      },
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
    'akinsho/git-conflict.nvim',
    version = '*',
    config = function()
      require('git-conflict').setup({
        default_mappings = {
          ours = 'co',
          theirs = 'ct',
          none = 'cn',
          both = 'cb',
          next = 'cj',
          prev = 'ck',
        },
      })
    end,
  },
  -- {
  --   'stevearc/oil.nvim',
  --   ---@module 'oil'
  --   ---@type oil.SetupOpts
  --   opts = {},
  --   -- Optional dependencies
  --   -- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  --   dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if you prefer nvim-web-devicons
  --   -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  --   lazy = false,
  --   config = function()
  --     require('oil').setup({
  --       -- skip_confirm_for_simple_edits = false
  --       keymaps = {
  --         ['<bs>'] = { 'actions.parent', mode = 'n' },
  --       },
  --     })
  --   end,
  -- },
}

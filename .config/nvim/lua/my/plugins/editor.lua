return {
  {
    "brenoprata10/nvim-highlight-colors",
    lazy = true,
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    config = function()
      require("nvim-highlight-colors").setup {
        render = 'background', -- 'background' or 'foreground' or 'first_column'
        enable_named_colors = false,
        enable_tailwind = false
      }
    end
  },
  {
    'echasnovski/mini.comment',
    version = '*',
    lazy = true,
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    config = function()
      require('mini.comment').setup(
        {
          -- Module mappings. Use `''` (empty string) to disable one.
          mappings = {
            -- Toggle comment (like `gcip` - comment inner paragraph) for both
            -- Normal and Visual modes
            comment = '<leader>c',

            -- Toggle comment on current line
            comment_line = '<leader>c',

            -- Define 'comment' textobject (like `dgc` - delete whole comment block)
            textobject = 'ic',
          },
        }
      )
    end
  },
  {
    "kmonad/kmonad-vim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
  },
  -- {
  --   "kylechui/nvim-surround",
  --   lazy = true,
  --   version = "*",
  --   event = { "BufReadPre", "BufNewFile", "VeryLazy" },
  --   config = function()
  --     require("nvim-surround").setup({})
  --   end
  -- },
  -- { "tpope/vim-surround",
  --   lazy = true,
  --   event = { "BufReadPre", "BufNewFile", "VeryLazy" },
  -- },
  {
    'echasnovski/mini.surround',
    lazy = true,
    version = "*",
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    config = function()
      require("mini.surround").setup({
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          add = 'S',           -- Add surrounding in Normal and Visual modes
          delete = '',         -- Delete surrounding
          find = '',           -- Find surrounding (to the right)
          find_left = '',      -- Find surrounding (to the left)
          highlight = '',      -- Highlight surrounding
          replace = '',        -- Replace surrounding
          update_n_lines = '', -- Update `n_lines`

          suffix_last = 'l',   -- Suffix to search with "prev" method
          suffix_next = 'n',   -- Suffix to search with "next" method
        },
      })
    end
  },
  {
    "rafcamlet/nvim-luapad",
    lazy = true,
    event = { "VeryLazy" },
  },
  {
    "tpope/vim-unimpaired",
    lazy = true,
    event = { "VeryLazy" },
  },
  {
    "chentoast/marks.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    config = function()
      require 'marks'.setup {}
    end
  }, -- for marks to show in gutter
  {
    "AmeerTaweel/todo.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    config = function()
      require("todo").setup({
        merge_keywords = false,
        keywords = {
          TODO = { icon = " ", color = "todo" },
        },
        highlight = {
          -- highlights before the keyword (typically comment characters)
          before = "", -- "fg", "bg", or empty
          -- highlights of the keyword
          -- wide is the same as bg, but also highlights the colon
          keyword = "fg", -- "fg", "bg", "wide", or empty
          -- highlights after the keyword (TODO text)
          after = "",     -- "fg", "bg", or empty
          -- pattern can be a string, or a table of regexes that will be checked
          -- vim regex
          pattern = [[.*<(KEYWORDS) \(sbadragan\)\s*:]],
          comments_only = true, -- highlight only inside comments using treesitter
          max_line_len = 400,   -- ignore lines longer than this
          exclude = {},         -- list of file types to exclude highlighting
        },
        -- list of named colors
        -- a list of hex colors or highlight groups, will use the first available one in the list on RHS
        colors = {
          todo = { "MyTodo" },
          default = { "Identifier", "#7C3AED" },
        },
        search = {
          -- don't replace the (KEYWORDS) placeholder
          pattern = [[\b(KEYWORDS) \(sbadragan\):]], -- ripgrep regex
        },
      })
    end
  },
  {
    "RRethy/vim-illuminate",
    lazy = true,
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    config = function()
      require('illuminate').configure({
        -- providers: provider used to get references in the buffer, ordered by priority
        providers = {
          'lsp',
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
    end
  },
  {
    "windwp/nvim-autopairs",
    lazy = true,
    event = { "VeryLazy" },
    config = function()
      require("nvim-autopairs").setup {}
    end
  },
  -- speed up loading large files
  {
    "pteroctopus/faster.nvim",
    lazy = false,
    config = function()
      require('faster').setup()
    end
  },
}

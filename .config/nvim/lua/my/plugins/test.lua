return {
  -- {
  --   'echasnovski/mini.test',
  --   version = '*',
  --   lazy = true,
  --   event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
  --   config = function()
  --     require('mini.test').setup({})
  --   end,
  -- },

  -- {
  --   'nvim-neotest/neotest',
  --   dependencies = {
  --     'nvim-neotest/nvim-nio',
  --     'nvim-lua/plenary.nvim',
  --     'antoinemadec/FixCursorHold.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --     'MisanthropicBit/neotest-busted',
  --   },
  --   lazy = true,
  --   event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
  --   config = function()
  --     require('neotest').setup({
  --       adapters = {
  --         require('neotest-busted')({
  --           -- Leave as nil to let neotest-busted automatically find busted
  --           busted_command = vim.env.HOME .. '/.luarocks/bin/busted',
  --
  --           -- Do not use nvim to run busted, but run busted directly
  --           -- no_nvim = false,
  --
  --           -- Extra arguments to busted
  --           -- busted_args = { '--shuffle-files' },
  --
  --           -- List of paths to add to lua path lookups before running
  --           -- busted, or a function returning a list of such paths
  --           -- busted_paths = { 'my/custom/path/?.lua' },
  --
  --           -- List of paths to add to lua cpath lookups before running
  --           -- busted, or a function returning a list of such paths
  --           -- busted_cpaths = { 'my/custom/path/?.so' },
  --
  --           -- Custom config to load via -u to set up testing.
  --           -- If nil, will look for a 'minimal_init.lua' file
  --           -- minimal_init = 'custom_init.lua',
  --
  --           -- Only use a luarocks installation in the project's directory. If
  --           -- true, installations in $HOME and global installations will be
  --           -- ignored. Useful for isolating the test environment
  --           -- local_luarocks_only = true,
  --
  --           -- Find parametric tests
  --           parametric_test_discovery = false,
  --         }),
  --       },
  --     })
  --   end,
  -- },

  {
    'klen/nvim-test',
    config = function()
      require('nvim-test').setup({
        run = true, -- run tests (using for debug)
        commands_create = true, -- create commands (TestFile, TestLast, ...)
        filename_modifier = ':.', -- modify filenames before tests run(:h filename-modifiers)
        silent = false, -- less notifications
        term = 'terminal', -- a terminal to run ("terminal"|"toggleterm")
        termOpts = {
          direction = 'vertical', -- terminal's direction ("horizontal"|"vertical"|"float")
          width = 96, -- terminal's width (for vertical|float)
          height = 24, -- terminal's height (for horizontal|float)
          go_back = false, -- return focus to original window after executing
          stopinsert = 'auto', -- exit from insert mode (true|false|"auto")
          keep_one = true, -- keep only one terminal for testing
        },
        runners = { -- setup tests runners
          -- cs = 'nvim-test.runners.dotnet',
          -- go = 'nvim-test.runners.go-test',
          -- haskell = 'nvim-test.runners.hspec',
          -- javascriptreact = 'nvim-test.runners.jest',
          -- javascript = 'nvim-test.runners.jest',
          lua = 'nvim-test.runners.busted',
          -- python = 'nvim-test.runners.pytest',
          -- ruby = 'nvim-test.runners.rspec',
          -- rust = 'nvim-test.runners.cargo-test',
          -- typescript = 'nvim-test.runners.jest',
          -- typescriptreact = 'nvim-test.runners.jest',
        },
      })

      require('nvim-test.runners.busted'):setup({
        -- command = '~/node_modules/.bin/jest', -- a command to run the test runner
        -- args = { '--collectCoverage=false' }, -- default arguments
        -- env = { CUSTOM_VAR = 'value' }, -- custom environment variables
        --
        -- file_pattern = '\\v(__tests__/.*|(spec|test))\\.(js|jsx|coffee|ts|tsx)$', -- determine whether a file is a testfile
        -- find_files = { '{name}.test.{ext}', '{name}.spec.{ext}' }, -- find testfile for a file
        --
        -- filename_modifier = nil, -- modify filename before tests run (:h filename-modifiers)
        -- working_directory = nil, -- set working directory (cwd by default)
      })
    end,
  },
}

-- LSP spec: https://microsoft.github.io/language-server-protocol/specification.html#initialize
-- prevent stupid node deprecation warnings
vim.env.NODE_OPTIONS = '--no-deprecation'

-- logging
-- vim.lsp.set_log_level("debug")

if vim.g.myLspDisabled then
  return {}
end

-- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
-- note worarkound for lua highlighting bracket
-- !curl -sS https://raw.githubusercontent.com/neovim/neovim/v0.7.2/runtime/syntax/lua.vim > $VIMRUNTIME/syntax/lua.vim
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
})

return {
  -- LSP status spinner, somewhat annoying
  {
    'j-hui/fidget.nvim',
    branch = 'legacy',
    lazy = true,
    event = { 'VeryLazy' },
    config = function()
      require('fidget').setup({ window = { winblend = 0 } })
    end,
  },

  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   lazy = true,
  --   event = { "BufReadPre", "BufNewFile", "VeryLazy" },
  --   dependencies = {
  --     {
  --       "jayp0521/mason-null-ls.nvim",
  --       dependencies = { "mason" },
  --       config = function()
  --         -- handles automatic installation of required tools based on stuff configured in null-ls
  --         require("mason-null-ls").setup({
  --           -- A list of sources to install if they're not already installed.
  --           -- This setting has no relation with the `automatic_installation` setting.
  --           ensure_installed = {},
  --           -- Run `require("null-ls").setup`.
  --           -- Will automatically install masons tools based on selected sources in `null-ls`.
  --           -- Can also be an exclusion list.
  --           -- Example: `automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }`
  --           automatic_installation = false,
  --           -- Whether sources that are installed in mason should be automatically set up in null-ls.
  --           -- Removes the need to set up null-ls manually.
  --           -- Can either be:
  --           -- 	- false: Null-ls is not automatically registered.
  --           -- 	- true: Null-ls is automatically registered.
  --           -- 	- { types = { SOURCE_NAME = {TYPES} } }. Allows overriding default configuration.
  --           -- 	Ex: { types = { eslint_d = {'formatting'} } }
  --           automatic_setup = false,
  --         })
  --       end
  --     },
  --   },
  --   config = function()
  --     require("my/plugins/lsp/null-ls")
  --   end
  -- },

  {
    'stevearc/conform.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
    config = function()
      require('conform').setup({
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
        formatters_by_ft = {
          lua = { 'stylua' },
          -- Use a sub-list to run only the first available formatter
          -- javascript = { { "prettier" } },
          -- javascriptreact = { { "prettier" } },
          -- typescript = { { "prettier" } },
          -- scss = { { "prettier" } },
          -- css = { { "prettier" } },
          -- markdown = { { "prettier" } },
          -- json = { { "prettier" } },

          javascript = { { 'prettierd', 'prettier' } },
          javascriptreact = { { 'prettierd', 'prettier' } },
          typescript = { { 'prettierd', 'prettier' } },
          typescriptreact = { { 'prettierd', 'prettier' } },

          json = { { 'prettierd', 'prettier' } },
          jsonc = { { 'prettierd', 'prettier' } },

          scss = { { 'prettierd', 'prettier' } },
          css = { { 'prettierd', 'prettier' } },

          -- javascript = { { "prettier" } },
          -- javascriptreact = { { "prettier" } },
          -- typescript = { { "prettier" } },
          -- typescriptreact = { { "prettier" } },
          --
          -- json = { { "prettier" } },
          -- jsonc = { { "prettier" } },
          --
          -- scss = { { "prettier" } },
          -- css = { { "prettier" } },

          --- if we enable biome
          -- javascript = { { "biome", "prettierd", "prettier" } },
          -- javascriptreact = { { "biome", "prettierd", "prettier" } },
          -- typescript = { { "biome", "prettierd", "prettier" } },
          -- typescriptreact = { { "biome", "prettierd", "prettier" } },
          --
          -- json = { { "biome", "prettierd", "prettier" } },
          -- jsonc = { { "biome", "prettierd", "prettier" } },

          c = { 'clang-format' },
          cpp = { 'clang-format' },
          cs = { 'clang-format' },
          cuda = { 'clang-format' },
        },
      })

      vim.api.nvim_create_user_command('Format', function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ['end'] = { args.line2, end_line:len() },
          }
        end
        require('conform').format({ async = true, lsp_fallback = true, range = range })
      end, { range = true })
    end,
  },

  {
    'neovim/nvim-lspconfig',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
    dependencies = {
      {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'mason' },
        config = function()
          require('mason-lspconfig').setup({
            -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
            -- This setting has no relation with the `automatic_installation` setting.
            ensure_installed = { 'jdtls' },
            -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
            -- This setting has no relation with the `ensure_installed` setting.
            -- Can either be:
            --   - false: Servers are not automatically installed.
            --   - true: All servers set up via lspconfig are automatically installed.
            --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
            --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
            automatic_installation = true,
          })
        end,
      },
      -- sets up for plugin dev /etc
      { 'folke/neodev.nvim' },
    },
    config = function()
      require('neodev').setup({
        override = function(root_dir, options)
          if vim.startswith(root_dir, '/opt/repos/') then
            options.plugins = { 'mini.test' }
            return options
          end
        end,
      })
      -- lsps
      require('my/plugins/lsp/lua-language-server')
      require('my/plugins/lsp/vimls')
      -- require("my/plugins/lsp/tsserver")
      require('my/plugins/lsp/vtsls')
      require('my/plugins/lsp/cssmodules')
      require('my/plugins/lsp/cssls')
      require('my/plugins/lsp/eslint')
      require('my/plugins/lsp/stylelint')
      require('my/plugins/lsp/rust_analyzer')
    end,
  },

  {
    'mfussenegger/nvim-jdtls', -- java support
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
  },

  {
    'onsails/lspkind-nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
    config = function()
      require('lspkind').init()
    end,
  },

  {
    'lvimuser/lsp-inlayhints.nvim',
    -- branch = 'anticonceal',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
    config = function()
      require('lsp-inlayhints').setup()
    end,
  },
}

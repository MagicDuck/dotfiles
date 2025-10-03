local handlers = require('my/plugins/lsp/handlers')
-- LSP spec: https://microsoft.github.io/language-server-protocol/specification.html#initialize
-- prevent stupid node deprecation warnings
vim.env.NODE_OPTIONS = '--no-deprecation'

-- logging
-- vim.lsp.set_log_level("debug")

if vim.g.myLspDisabled then
  return {}
end

return {
  -- LSP status spinner, somewhat annoying
  {
    'j-hui/fidget.nvim',
    -- branch = 'legacy',
    lazy = true,
    event = { 'VeryLazy' },
    config = function()
      require('fidget').setup({
        notification = {
          window = {
            winblend = 0,
          },
        },
      })
    end,
  },

  {
    'stevearc/conform.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
    config = function()
      local js_format = function(bufnr)
        if require('conform').get_formatter_info('biome-check', bufnr).available then
          return { 'biome-check', lsp_format = 'fallback' }
        else
          return { 'prettierd', 'prettier', lsp_format = 'fallback' }
        end
      end

      require('conform').setup({
        notify_on_error = false,
        format_on_save = { timeout_ms = 2000, lsp_fallback = true },
        stop_after_first = true,
        formatters_by_ft = {
          lua = { 'stylua' },

          javascript = js_format,
          javascriptreact = js_format,
          typescript = js_format,
          typescriptreact = js_format,
          -- html = { 'prettier', lsp_format = 'fallback' },

          json = js_format,
          jsonc = js_format,

          scss = { 'prettierd', 'prettier', lsp_format = 'fallback' },
          css = { 'prettierd', 'prettier', lsp_format = 'fallback' },

          c = { 'clang-format', lsp_format = 'fallback' },
          cpp = { 'clang-format', lsp_format = 'fallback' },
          cs = { 'clang-format', lsp_format = 'fallback' },
          cuda = { 'clang-format', lsp_format = 'fallback' },

          http = { 'kuala' },
        },
        formatters = {
          ['biome-check'] = {
            require_cwd = true,
          },
          kulala = {
            command = 'kulala-fmt',
            args = { 'format', '$FILENAME' },
            stdin = false,
          },
        },
      })

      vim.api.nvim_create_user_command('Format', function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ['end'] = { args.line2, #end_line },
          }
        end
        require('conform').format({ async = true, lsp_fallback = true, range = range })
      end, { range = true })
    end,
  },
  { 'https://github.com/DrKJeff16/wezterm-types', lazy = true, version = false },
  -- {
  --   'folke/lazydev.nvim',
  --   ft = 'lua', -- only load on lua files
  --   opts = {
  --     library = {
  --       -- Load luvit types when the `vim.uv` word is found
  --       { path = 'luvit-meta/library', words = { 'vim%.uv' } },
  --       { path = 'wezterm-types', mods = { 'wezterm' } },
  --     },
  --   },
  -- },
  {
    'neovim/nvim-lspconfig',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
    dependencies = {
      -- {
      --   'williamboman/mason-lspconfig.nvim',
      --   dependencies = { 'mason' },
      --   config = function()
      --     require('mason-lspconfig').setup({
      --       -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
      --       -- This setting has no relation with the `automatic_installation` setting.
      --       ensure_installed = { 'jdtls' },
      --       -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
      --       -- This setting has no relation with the `ensure_installed` setting.
      --       -- Can either be:
      --       --   - false: Servers are not automatically installed.
      --       --   - true: All servers set up via lspconfig are automatically installed.
      --       --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
      --       --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
      --       automatic_installation = true,
      --     })
      --   end,
      -- },
      -- { 'Bilal2453/luvit-meta', name = 'luvit-types', lazy = true }, -- optional `vim.uv` typings
      -- { 'LuaCATS/luassert', name = 'luassert-types', lazy = true },
      -- { 'LuaCATS/busted', name = 'busted-types', lazy = true },
      -- { 'justinsgithub/wezterm-types', lazy = true },
    },
    config = function()
      -- require('my/plugins/lsp/lua-language-server')
      require('my/plugins/lsp/emmylua_ls')
      require('my/plugins/lsp/vimls')
      -- require('my/plugins/lsp/vtsls')
      -- require('my/plugins/lsp/ts_ls')
      require('my/plugins/lsp/cssmodules')

      -- Note: this one has problems currently since it applies formatting, need to disable that somehow
      -- require('my/plugins/lsp/cssls')

      require('my/plugins/lsp/eslint')
      require('my/plugins/lsp/stylelint')
      require('my/plugins/lsp/rust_analyzer')
      require('my/plugins/lsp/biome')
      require('my/plugins/lsp/gopls')
    end,
  },

  {
    'davidosomething/format-ts-errors.nvim',
    config = function()
      require('format-ts-errors').setup({
        add_markdown = false, -- wrap output with markdown ```ts ``` markers
        start_indent_level = 0, -- initial indent
      })
    end,
  },

  -- typescript through lua LS
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      settings = {
        -- JSXCloseTag
        -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
        -- that maybe have a conflict if enable this feature. )
        jsx_close_tag = {
          enable = true,
          filetypes = { 'javascriptreact', 'typescriptreact' },
        },
      },
      handlers = {
        ['textDocument/publishDiagnostics'] = handlers.tsserverPublishDiagnostics,
      },
    },
  },

  require('my.plugins.lsp.jdtls'),

  {
    'onsails/lspkind-nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
    config = function()
      require('lspkind').init()
    end,
  },

  {
    'bassamsdata/namu.nvim',
    opts = {
      global = {},
      namu_symbols = { -- Specific Module options
        options = {},
      },
    },
  },
}

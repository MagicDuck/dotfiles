-- LSP spec: https://microsoft.github.io/language-server-protocol/specification.html#initialize
-- prevent stupid node deprecation warnings
vim.env.NODE_OPTIONS = "--no-deprecation"

-- logging
-- vim.lsp.set_log_level("debug")

if vim.g.myLspDisabled then
  return {}
end

return {
  -- LSP status spinner, somewhat annoying
  { "j-hui/fidget.nvim",
    name = "fidget",
    config = function()
      require("fidget").setup({ window = { winblend = 0 } })
    end
  },

  { "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "fidget",
      { "jayp0521/mason-null-ls.nvim",
        dependencies = { "mason" },
        config = function()
          -- handles automatic installation of required tools based on stuff configured in null-ls
          require("mason-null-ls").setup({
            -- A list of sources to install if they're not already installed.
            -- This setting has no relation with the `automatic_installation` setting.
            ensure_installed = { 'stylelint_d' },
            -- Run `require("null-ls").setup`.
            -- Will automatically install masons tools based on selected sources in `null-ls`.
            -- Can also be an exclusion list.
            -- Example: `automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }`
            automatic_installation = true,
            -- Whether sources that are installed in mason should be automatically set up in null-ls.
            -- Removes the need to set up null-ls manually.
            -- Can either be:
            -- 	- false: Null-ls is not automatically registered.
            -- 	- true: Null-ls is automatically registered.
            -- 	- { types = { SOURCE_NAME = {TYPES} } }. Allows overriding default configuration.
            -- 	Ex: { types = { eslint_d = {'formatting'} } }
            automatic_setup = false,
          })
        end
      },
    },
    config = function()
      require("my/plugins/lsp/null-ls")
    end
  },

  { "neovim/nvim-lspconfig",
    dependencies = {
      "fidget",
      { "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason" },
        config = function()
          require("mason-lspconfig").setup({
            -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
            -- This setting has no relation with the `automatic_installation` setting.
            ensure_installed = { "jdtls" },
            -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
            -- This setting has no relation with the `ensure_installed` setting.
            -- Can either be:
            --   - false: Servers are not automatically installed.
            --   - true: All servers set up via lspconfig are automatically installed.
            --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
            --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
            automatic_installation = true,
          })
        end
      },
    },
    config = function()
      -- lsps
      require("my/plugins/lsp/lua-language-server")
      require("my/plugins/lsp/vimls")
      -- require("my/lsp/tsserver")
      require("my/plugins/lsp/vtsls")
      require("my/plugins/lsp/cssmodules")
      require("my/plugins/lsp/cssls")
      require("my/plugins/lsp/eslint")
      require("my/plugins/lsp/rust_analyzer")
    end
  },

  { "mfussenegger/nvim-jdtls", dependencies = { "fidget" } }, -- java support

  { "onsails/lspkind-nvim",
    config = function()
      require('lspkind').init()
    end
  },
}

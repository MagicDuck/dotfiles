return {
  { "neovim/nvim-lspconfig",
    dependencies = {
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
      { "onsails/lspkind-nvim",
        config = function()
          require('lspkind').init()
        end
      },
      { "mfussenegger/nvim-jdtls" },
      { "jose-elias-alvarez/null-ls.nvim" },
    },
    config = function()
      require("my.lsp.init")
    end
  },
  -- LSP status spinner, somewhat annoying
  { "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({ window = { winblend = 0 } })
    end
  },
}

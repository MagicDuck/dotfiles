return {
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "mason" },
        config = function()
          require("mason-nvim-dap").setup({
            -- A list of adapters to install if they're not already installed.
            -- This setting has no relation with the `automatic_installation` setting.
            ensure_installed = { "javadbg", "node2", "codelldb" },
            -- NOTE: this is left here for future porting in case needed
            -- Whether adapters that are set up (via dap) should be automatically installed if they're not already installed.
            -- This setting has no relation with the `ensure_installed` setting.
            -- Can either be:
            --   - false: Servers are not automatically installed.
            --   - true: All servers set up via lspconfig are automatically installed.
            --   - { exclude: string[] }: All servers set up via mason-nvim-dap, except the ones provided in the list, are automatically installed.
            --       Example: automatic_installation = { exclude = { "python", "delve" } }
            automatic_installation = false,
            -- Whether adapters that are installed in mason should be automatically set up in dap.
            -- Removes the need to set up dap manually.
            -- See mappings.adapters and mappings.configurations for settings.
            -- Must invoke when set to true: `require 'mason-nvim-dap'.setup_handlers()`
            -- Can either be:
            -- 	- false: Dap is not automatically configured.
            -- 	- true: Dap is automatically configured.
            -- 	- {adapters: {ADAPTER: {}, }, configurations: {ADAPTER: {}, }}. Allows overriding default configuration.
            automatic_setup = false,
          })
        end
      },
    },
    config = function()
      require('my.plugins.dap.dap')
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require('my.plugins.dap.dapui')
    end
  },
}

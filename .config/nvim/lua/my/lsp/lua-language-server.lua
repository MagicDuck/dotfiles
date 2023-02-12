local lspconfig = require("lspconfig")
local attach = require("my/lsp/attach")

lspconfig.lua_ls.setup {
  capabilities = attach.global_capabilities,
  on_attach = attach.global_on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          "vim",
          "hs",
          "spoon",
          "P",
          "ReloadPackage",
          "ReloadFunc",
          "my",
          "use"
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}


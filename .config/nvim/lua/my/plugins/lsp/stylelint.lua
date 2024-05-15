local lspconfig = require("lspconfig")
local attach = require("my/plugins/lsp/attach")

lspconfig.stylelint_lsp.setup({
  capabilities = attach.global_capabilities,
  filetypes = {
    'css',
    'less',
    'scss',
  },
  settings = {
    validateOnSave = true,
    -- validateOnType = true
    run = "onSave", -- default is onType
  }
})

local lspconfig = require('lspconfig')
local attach = require('my/plugins/lsp/attach')

lspconfig.kulala_ls.setup({
  capabilities = attach.global_capabilities,
  on_attach = attach.global_on_attach,
})

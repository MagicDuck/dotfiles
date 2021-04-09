local lspconfig = require('lspconfig')
local attach = require('my/lsp/attach')

lspconfig["vimls"].setup {
  on_attach = attach.global_on_attach
}


local lspconfig = require('lspconfig')
local attach = require('stephan/lsp/attach')

lspconfig["vimls"].setup {
  on_attach = attach.global_on_attach
}


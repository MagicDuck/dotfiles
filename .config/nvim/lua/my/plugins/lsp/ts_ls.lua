local lspconfig = require('lspconfig')
local attach = require('my/plugins/lsp/attach')
local handlers = require('my/plugins/lsp/handlers')

-- potentially add https://github.com/yioneko/nvim-vtsls for more goodies
lspconfig.ts_ls.setup({
  init_options = {
    hostInfo = 'neovim',
  },
  on_init = function(client)
    -- This makes sure tsserver is not used for formatting (prefer prettier)
    client.server_capabilities.documentFormattingProvider = false
  end,
  capabilities = attach.global_capabilities,
  on_attach = attach.global_on_attach,
  handlers = {
    ['textDocument/publishDiagnostics'] = handlers.tsserverPublishDiagnostics,
    ['textDocument/definition'] = handlers.tsserverDefinition,
  },
})

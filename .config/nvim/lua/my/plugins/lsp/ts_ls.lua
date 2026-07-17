local lspconfig = require('lspconfig')
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
  handlers = {
    ['textDocument/publishDiagnostics'] = handlers.tsserverPublishDiagnostics,
    ['textDocument/definition'] = handlers.tsserverDefinition,
  },
})

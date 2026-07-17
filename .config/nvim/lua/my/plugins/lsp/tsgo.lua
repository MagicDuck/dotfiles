local handlers = require('my/plugins/lsp/handlers')

vim.lsp.config('tsgo', {
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
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = {
          enabled = 'literals',
          suppressWhenArgumentMatchesName = true,
        },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
      experimental = {
        useTsgo = true,
      },
    },
  },
})

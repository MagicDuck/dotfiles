local attach = require('my/plugins/lsp/attach')
local handlers = require('my/plugins/lsp/handlers')

vim.lsp.config('tsgo', {
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

local lspconfig = require('lspconfig')
local attach = require('my/plugins/lsp/attach')
local handlers = require('my/plugins/lsp/handlers')

-- potentially add https://github.com/yioneko/nvim-vtsls for more goodies
lspconfig.vtsls.setup({
  init_options = {
    hostInfo = 'neovim',
  },
  on_init = function(client)
    -- This makes sure tsserver is not used for formatting (prefer prettier)
    client.server_capabilities.documentFormattingProvider = false
  end,
  capabilities = attach.global_capabilities,
  -- TODO???: use goto_source_definition for gd?, so we don't navigate to types??? https://github.com/yioneko/nvim-vtsls
  on_attach = attach.global_on_attach,
  -- see https://github.com/yioneko/vtsls/blob/main/packages/service/configuration.schema.json
  settings = {
    servers = {
      vtsls = {
        settings = {
          vtsls = {
            autoUseWorkspaceTsdk = false,
          },
        },
      },
    },
    typescript = {
      tsserver = {
        maxTsServerMemory = 8192,
      },
      updateImportsOnFileMove = 'always',
      disableAutomaticTypeAcquisition = true,
      format = {
        enable = false,
      },
    },
    javascript = {
      updateImportsOnFileMove = 'always',
      disableAutomaticTypeAcquisition = true,
      implicitProjectConfig = {
        checkJs = true,
      },
      format = {
        enable = false,
      },
    },
  },
  handlers = {
    ['textDocument/publishDiagnostics'] = handlers.tsserverPublishDiagnostics,
    ['textDocument/definition'] = handlers.tsserverDefinition,
  },
})

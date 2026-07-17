local lspconfig = require('lspconfig')
local handlers = require('my/plugins/lsp/handlers')

-- custom commands
local function organize_imports()
  vim.lsp.buf.execute_command({
    command = '_typescript.organizeImports',
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = '',
  })
end

lspconfig.tsserver.setup({
  init_options = {
    hostInfo = 'neovim',
    -- maxTsServerMemory = 2048,
    -- disableAutomaticTypingAcquisition = true,
    -- preferences = {
    --   includeCompletionsForModuleExports = true,
    --   includeCompletionsWithSnippetText = false,
    --   includeCompletionsWithInsertText = false,
    --   includeCompletionsWithClassMemberSnippets = false,
    --   includeCompletionsWithObjectLiteralMethodSnippets = false,
    --   -- importModuleSpecifierPreference = "shortest",
    --   importModuleSpecifierEnding = "minimal",
    --   includeInlayParameterNameHints = "none",
    --   includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    --   includeInlayFunctionParameterTypeHints = false,
    --   includeInlayVariableTypeHints = false,
    --   includeInlayVariableTypeHintsWhenTypeMatchesName = false,
    --   includeInlayPropertyDeclarationTypeHints = false,
    --   includeInlayFunctionLikeReturnTypeHints = false,
    --   includeInlayEnumMemberValueHints = true,
    --   allowIncompleteCompletions = true,
    -- }
  },
  on_init = function(client)
    -- This makes sure tsserver is not used for formatting (prefer prettier)
    client.server_capabilities.documentFormattingProvider = false
  end,
  commands = {
    OrganizeImports = {
      organize_imports,
      description = 'Organize Imports',
    },
  },
  handlers = {
    ['textDocument/publishDiagnostics'] = handlers.tsserverPublishDiagnostics,
  },
})

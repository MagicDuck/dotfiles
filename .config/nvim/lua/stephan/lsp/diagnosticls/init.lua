local lspconfig = require('lspconfig')
local util = require('lspconfig/util')
local handlers = require('stephan/lsp/handlers')
local attach = require('stephan/lsp/attach')
local eslint_linter = require('stephan/lsp/diagnosticls/linters/eslint')
local stylelint_linter = require('stephan/lsp/diagnosticls/linters/stylelint')
local eslint_formatter = require('stephan/lsp/diagnosticls/formatters/eslint')
local prettier_formatter = require('stephan/lsp/diagnosticls/formatters/prettier')

lspconfig.diagnosticls.setup {
  -- cmd = {"diagnostic-languageserver", "--stdio", "--log-level", "4"},
  root_dir = util.root_pattern("package.json", "jsconfig.json", ".git"),
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "scss",
    "css",
    "sass",
  };
  init_options = {
    filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint',
      css = 'stylelint',
      scss = 'stylelint',
      sass = 'stylelint'
    },
    formatFiletypes = {
      javascript = {'prettier', 'eslint'},
      javascriptreact = {'prettier', 'eslint'},
    },
    linters = {
      eslint = eslint_linter,
      stylelint = stylelint_linter,
    },
    formatters = {
      prettier = prettier_formatter,
      eslint = eslint_formatter
    },
  };
  on_init = function(client)
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.code_action = true
    client.resolved_capabilities.execute_command = true
    client.request = handlers.client_request(client);
  end,
  on_attach = attach.global_on_attach,
  handlers = {
    ["textDocument/codeAction"] = {
      type = 'local_lsp',
      handler = handlers.lintCodeAction
    },
    ["workspace/executeCommand"] = {
      type = 'local_lsp',
      handler = handlers.workspaceExecuteCommand
    },
    ["textDocument/publishDiagnostics"] = handlers.diagnosticlsPublishDiagnostics
    -- ["textDocument/publishDiagnostics"] = ReloadFunc('stephan/lsp/handlers', 'diagnosticlsPublishDiagnostics')
  }
}


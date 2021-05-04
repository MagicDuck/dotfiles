local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local handlers = require("my/lsp/handlers")
local attach = require("my/lsp/attach")
local eslint_linter = require("my/lsp/diagnosticls/linters/eslint")
local stylelint_linter = require("my/lsp/diagnosticls/linters/stylelint")
local eslint_formatter = require("my/lsp/diagnosticls/formatters/eslint")
local prettier_formatter = require("my/lsp/diagnosticls/formatters/prettier")
local luafmt_formatter = require("my/lsp/diagnosticls/formatters/luafmt")

lspconfig.diagnosticls.setup {
  -- cmd = {"diagnostic-languageserver", "--stdio", "--log-level", "4"},
  -- root_dir =  util.root_pattern("package.json", "jsconfig.json", ".git"),
  root_dir = function(filepath)
    return vim.fn.expand("~")
  end,
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "scss",
    "css",
    "sass",
    "lua",
    "markdown",
    "vimwiki"
  },
  init_options = {
    filetypes = {
      javascript = "eslint",
      javascriptreact = "eslint",
      typescript = "eslint",
      typescriptreact = "eslint",
      css = "stylelint",
      scss = "stylelint",
      sass = "stylelint"
    },
    formatFiletypes = {
      javascript = {"prettier", "eslint"},
      javascriptreact = {"prettier", "eslint"},
      lua = {"luafmt"},
      markdown = {"prettier"},
      vimwiki = {"prettier"}
    },
    linters = {
      eslint = eslint_linter,
      stylelint = stylelint_linter
    },
    formatters = {
      prettier = prettier_formatter,
      eslint = eslint_formatter,
      luafmt = luafmt_formatter
    }
  },
  on_init = function(client)
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.code_action = true
    client.resolved_capabilities.execute_command = true
    client.request = handlers.client_request(client)

    -- make sure eslint server still works
    os.execute("eslint_d restart")
  end,
  on_attach = attach.global_on_attach,
  handlers = {
    ["textDocument/codeAction"] = {
      type = "local_lsp",
      handler = handlers.lintCodeAction
    },
    ["workspace/executeCommand"] = {
      type = "local_lsp",
      handler = handlers.workspaceExecuteCommand
    },
    ["textDocument/publishDiagnostics"] = handlers.diagnosticlsPublishDiagnostics
    -- ["textDocument/publishDiagnostics"] = ReloadFunc('my/lsp/handlers', 'diagnosticlsPublishDiagnostics')
  }
}

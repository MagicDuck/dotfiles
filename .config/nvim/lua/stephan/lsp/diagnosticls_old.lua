local lspconfig = require('lspconfig')
local handlers = require('stephan/lsp/handlers')
local attach = require('stephan/lsp/attach')

lspconfig.diagnosticls.setup {
  -- cmd = {"diagnostic-languageserver", "--stdio", "--log-level", "4"},
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "scss",
    "css",
    "sass"
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
      json = 'prettier'
    },
    linters = {
      eslint = {
      ------------------------------------------------------------------------------------
        command = 'eslint_d',
        rootPatterns = { '.eslintrc.js', '.eslintrc.json' },
        debounce = 100,
        args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json', '--no-color' },
        sourceName = 'eslint',
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '[eslint] ${message} [${ruleId}]',
          security = 'severity'
        },
        securities = {
          [2] = 'error',
          [1] = 'warning'
        }
      },
      stylelint = {
      ------------------------------------------------------------------------------------
        command = 'stylelint_d',
        rootPatterns = { '.stylelintrc' },
        debounce = 100,
        args = { '--stdin', '--stdin-filename', '%filepath', '--formatter', 'json', '--no-color' },
        sourceName = 'stylelint',
        parseJson = {
          errorsRoot = '[0].warnings',
          line = 'line',
          column = 'column',
          endLine = 'line',
          endColumn = 'column',
          message = '[stylelint] ${text}',
          security = 'severity'
        },
        securities = {
          [2] = 'error',
          [1] = 'warning'
        }
      }
    },
    formatters = {
      prettier = {
      ------------------------------------------------------------------------------------
        command = "prettier_d",
        args = { '--stdin-filepath', '%filepath' },
        isStdout = true,
        rootPatterns = { ".prettierrc" },
        requiredFiles = { ".prettierrc" }
      },
      eslint = {
      ------------------------------------------------------------------------------------
        command = 'eslint_d',
        debounce = 100,
        args = { '--fix-to-stdout', '--stdin', '--stdin-filename', '%filepath' },
        isStdout = true,
        rootPatterns = { '.eslintrc.js', '.eslintrc.json' },
      },
    },
    ------------------------------------------------------------------------------------
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
    }
  }
}


-- LSP config main

-- configure LSP servers
-- Pre-requisite for those working is to have servers installed.
-- Commands to install them:
-- yarn global add eslint_d prettier_d stylelint_d typescript typescript-language-server

-- global handler customization
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
 vim.lsp.diagnostic.on_publish_diagnostics, {
   -- Enable underline, use default values
   underline = false,
   -- Disable a feature
   -- update_in_insert = false,
 }
)


require('stephan/lsp/sumneko_lua')
require('stephan/lsp/vimls')
require('stephan/lsp/tsserver')
require('stephan/lsp/diagnosticls')
require('stephan/lsp/saga')

-- define signs to show in the sign column
vim.fn.sign_define("LspDiagnosticsSignHint", { text="", texthl="LspDiagnosticsSignHint" })
vim.fn.sign_define("LspDiagnosticsSignInformation", { text="", texthl="LspDiagnosticsSignHint" })
vim.fn.sign_define("LspDiagnosticsSignWarning", { text="", texthl="LspDiagnosticsSignWarning" })
vim.fn.sign_define("LspDiagnosticsSignError", { text="✘", texthl="LspDiagnosticsSignError" })

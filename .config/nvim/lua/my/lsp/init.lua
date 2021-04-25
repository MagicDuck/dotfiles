-- configure LSP servers
-- Pre-requisite for those working is to have servers installed.
-- Commands to install them:
-- yarn global add eslint_d @fsouza/prettierd stylelint_d lua-fmt diagnostic-languageserver typescript typescript-language-server ajv-keywords ajv

-- logging
-- vim.lsp.set_log_level("debug")
-- vim.cmd("e " .. vim.lsp.get_log_path())

require("my/lsp/sumneko_lua")
require("my/lsp/vimls")
require("my/lsp/tsserver")
require("my/lsp/diagnosticls")

-- define signs to show in the sign column
vim.fn.sign_define(
  "LspDiagnosticsSignHint",
  {text = "", texthl = "LspDiagnosticsSignHint"}
)
vim.fn.sign_define(
  "LspDiagnosticsSignInformation",
  {text = "", texthl = "LspDiagnosticsSignHint"}
)
vim.fn.sign_define(
  "LspDiagnosticsSignWarning",
  {text = "", texthl = "LspDiagnosticsSignWarning"}
)
vim.fn.sign_define(
  "LspDiagnosticsSignError",
  {text = "✘", texthl = "LspDiagnosticsSignError"}
)

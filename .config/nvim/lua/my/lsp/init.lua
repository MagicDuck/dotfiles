-- configure LSP servers
-- LSP spec: https://microsoft.github.io/language-server-protocol/specification.html#initialize
-- Pre-requisite for those working is to have servers installed.
-- Commands to install them:
-- yarn global add eslint_d @fsouza/prettierd stylelint_d lua-fmt diagnostic-languageserver typescript typescript-language-server ajv-keywords ajv vim-language-server cssmodules-language-server vscode-langservers-extracted
-- brew install stylua
-- NOTE: try to move those to "mason" instead

-- logging
-- vim.lsp.set_log_level("debug")
-- vim.cmd("e " .. vim.lsp.get_log_path())

-- environment vars
-- prevent stupid node deprecation warnings
vim.env.NODE_OPTIONS = "--no-deprecation"

if vim.g.myLspDisabled ~= true then
  -- note: mason needs to go first, to make sure tools are installed
  require("my/lsp/mason")

  require("my/lsp/null-ls")
  -- require("my/lsp/diagnosticls")

  -- lsps
  require("my/lsp/lua-language-server")
  require("my/lsp/vimls")
  -- require("my/lsp/tsserver")
  require("my/lsp/vtsls")
  require("my/lsp/cssmodules")
  require("my/lsp/cssls")
  require("my/lsp/eslint")
  require("my/lsp/rust_analyzer")
  -- require("my/lsp/jdtls")
end

-- define signs to show in the sign column
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignError", { text = "✘", texthl = "DiagnosticSignError" })

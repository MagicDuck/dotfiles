local lspconfig = require("lspconfig")
local attach = require("my/lsp/attach")

lspconfig.rust_analyzer.setup({
	capabilities = attach.global_capabilities,
	on_attach = attach.global_on_attach,
})
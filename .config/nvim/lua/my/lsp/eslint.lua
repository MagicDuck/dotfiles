local lspconfig = require("lspconfig")
local attach = require("my/lsp/attach")

lspconfig.eslint.setup({
	capabilities = attach.global_capabilities,
	on_attach = function(client, bufnr)
		vim.api.nvim_command("autocmd BufWritePre <buffer> EslintFixAll")
		attach.global_on_attach(client, bufnr)
	end,
	-- TODO (sbadragan): prevent eslint LSP for prompting us when there are errors
	handlers = {
		["window/showMessageRequest"] = function(_, result, params)
			return result
		end,
	},
})
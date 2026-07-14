local M = {}

M.global_on_attach = function(client, bufnr) end

M.global_capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())

return M

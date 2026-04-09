local M = {}

M.global_on_attach = function(client, bufnr) end

M.global_capabilities = vim.lsp.protocol.make_client_capabilities()
M.extend_global_capabilities = function(capabilities)
  M.global_capabilities = vim.tbl_deep_extend('force', M.global_capabilities, capabilities)
end

return M

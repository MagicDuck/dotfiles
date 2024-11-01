local M = {}

M.global_on_attach = function(client, bufnr) end

M.global_capabilities = vim.lsp.protocol.make_client_capabilities()
M.extend_global_capabilities = function(capabilities)
  M.global_capabilities = vim.tbl_deep_extend('force', M.global_capabilities, capabilities)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

if pcall(require, 'blink.cmp') then
  capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())
elseif pcall(require, 'cmp_nvim_lsp') then
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
end

return M

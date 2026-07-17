local M = {}

local capabilities
M.global_capabilities = function()
  if not capabilities then
    capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
  end

  return capabilities
end

return M

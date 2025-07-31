local attach = require('my/plugins/lsp/attach')

-- TODO (sbadragan): would be good to config every language server in one place
vim.lsp.config('emmylua_ls', {
  capabilities = attach.global_capabilities,
  on_attach = attach.global_on_attach,
})
vim.lsp.enable({ 'emmylua_ls' })

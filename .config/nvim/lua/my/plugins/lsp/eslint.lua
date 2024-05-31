local lspconfig = require('lspconfig')
local attach = require('my/plugins/lsp/attach')

lspconfig.eslint.setup({
  capabilities = attach.global_capabilities,
  on_attach = function(client, bufnr)
    -- vim.api.nvim_command("autocmd BufWritePre <buffer> EslintFixAll")
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      command = 'EslintFixAll',
    })
    attach.global_on_attach(client, bufnr)
  end,
  -- prevent eslint LSP for prompting us when there are errors
  -- handlers = {
  --   ["window/showMessageRequest"] = function(_, result, params)
  --     return result
  --   end,
  -- },
  settings = {
    -- useESLintClass = true,
    -- experimental = {
    --   useFlatConfig = true,
    -- },
    run = 'onSave', -- default is onType
    format = false,
    quiet = true,
  },
})

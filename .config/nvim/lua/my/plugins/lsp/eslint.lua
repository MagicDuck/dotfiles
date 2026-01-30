local attach = require('my/plugins/lsp/attach')

vim.lsp.config('eslint', {
  capabilities = attach.global_capabilities,
  on_attach = function(client, buffer)
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = buffer,
      callback = function(event)
        local namespace = vim.lsp.diagnostic.get_namespace(client.id, true)
        local diagnostics = vim.diagnostic.get(event.buf, { namespace = namespace })
        if #diagnostics > 0 then
          vim.lsp.buf.format({
            async = false,
            filter = function(formatter)
              return formatter.name == 'eslint'
            end,
          })
        end
      end,
    })
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
    -- format = false,
    format = { enable = true },
    quiet = true,
    codeActionOnSave = { enable = true, mode = 'problems' },
  },
})

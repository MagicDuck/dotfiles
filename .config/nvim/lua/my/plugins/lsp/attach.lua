local lspFormatBuffer = function(bufnr)
  -- local marks = {}
  -- local letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  -- for i = 1, #letters do
  --   local letter = letters:sub(i, i)
  --   local markLocation = vim.api.nvim_buf_get_mark(bufnr, letter)
  --   marks[letter] = markLocation
  -- end

  vim.lsp.buf.format({
    timeout_ms = 5000,
  })

  -- for i = 1, #letters do
  --   local letter = letters:sub(i, i)
  --   local markLocation = marks[letter]
  --   local linenr = markLocation[1]
  --   if linenr ~= 0 then
  --     vim.api.nvim_command("" .. linenr .. "mark " .. letter)
  --   end
  -- end
end

local global_on_attach = function(client, bufnr)
  -- Note: now using illuminate
  -- Set autocommands conditional on server_capabilities
  -- highlights for current symbol under cursor
  -- if client.server_capabilities.documentHighlightProvider then
  --   vim.api.nvim_exec(
  --     [[
  --     hi LspReferenceRead cterm=bold ctermbg=red guibg=#f0e2f9
  --     hi LspReferenceText cterm=bold ctermbg=red guibg=#f0e2f9
  --     hi LspReferenceWrite cterm=bold ctermbg=red guibg=#f0e2f9
  --     augroup lsp_document_highlight
  --       autocmd! * <buffer>
  --       autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  --       autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --     augroup END
  --   ]],
  --     false
  --   )
  -- end

  -- old version, just in case
  -- local formattingAttached = vim.fn.getbufvar(bufnr or 0, "my_lsp_formatting_attached")
  -- if formattingAttached ~= "yes" and client.server_capabilities.documentFormattingProvider then
  --   vim.fn.setbufvar(bufnr or 0, "my_lsp_formatting_attached", "yes")
  --   local bufnum = bufnr or 0
  --   -- vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync({}, 5000) ]]
  --   vim.api.nvim_command("autocmd BufWritePre <buffer> lua LspFormatBuffer(" .. bufnum .. ")")
  -- end

  -- TODO (sbadragan): handled by conform
  -- if client.supports_method('textDocument/formatting') and client.server_capabilities.documentFormattingProvider then
  --   vim.api.nvim_create_autocmd('BufWritePre', {
  --     group = vim.api.nvim_create_augroup('LspFormat.' .. bufnr, {}),
  --     buffer = bufnr,
  --     callback = function()
  --       lspFormatBuffer(bufnr)
  --     end,
  --   })
  -- end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

return {
  global_on_attach = global_on_attach,
  global_capabilities = global_capabilities,
}

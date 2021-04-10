LspFormatBuffer = function(bufnr)
  local marks = {}
  local letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  for i = 1, #letters do
    local letter = letters:sub(i, i)
    local markLocation = vim.api.nvim_buf_get_mark(bufnr, letter)
    marks[letter] = markLocation
  end

  vim.lsp.buf.formatting_sync({}, 5000)

  for i = 1, #letters do
    local letter = letters:sub(i, i)
    local markLocation = marks[letter]
    local linenr = markLocation[1]
    if (linenr ~= 0) then
      vim.api.nvim_command("" .. linenr .. "mark " .. letter)
    end
  end
end

local global_on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Set autocommands conditional on server_capabilities
  -- highlights for current symbol under cursor
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#f0e2f9
      hi LspReferenceText cterm=bold ctermbg=red guibg=#f0e2f9
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#f0e2f9
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end

  local formattingAttached =
    vim.fn.getbufvar(bufnr or 0, "my_lsp_formatting_attached")
  if
    formattingAttached ~= "yes" and
      client.resolved_capabilities.document_formatting
   then
    vim.fn.setbufvar(bufnr or 0, "my_lsp_formatting_attached", "yes")
    local bufnum = bufnr or 0
    -- vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync({}, 5000) ]]
    vim.api.nvim_command(
      "autocmd BufWritePre <buffer> lua LspFormatBuffer(" .. bufnum .. ")"
    )
  end
end

return {
  global_on_attach = global_on_attach
}

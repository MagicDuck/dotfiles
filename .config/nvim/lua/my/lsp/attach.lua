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

  -- Mappings.
  local opts = {noremap = true, silent = true}

  -- workspace
  ------------
  buf_set_keymap(
    "n",
    "<leader>awa",
    "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
    opts
  )
  buf_set_keymap(
    "n",
    "<leader>awr",
    "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
    opts
  )
  buf_set_keymap(
    "n",
    "<leader>awl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts
  )

  -- hover help
  -------------
  -- buf_set_keymap(
  --   "n",
  --   "K",
  --   ":Lspsaga hover_doc<CR>",
  --   {silent = true, noremap = true}
  -- )
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap(
    "n",
    "gs",
    ":Lspsaga signature_help<CR>",
    {silent = true, noremap = true}
  )
  buf_set_keymap(
    "n",
    "<C-k>",
    "<cmd>lua vim.lsp.buf.signature_help()<CR>",
    opts
  )

  -- navigation
  -------------
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "gm", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

  -- rename
  ---------
  buf_set_keymap(
    "n",
    "<leader>ar",
    ":lua require('lspsaga.rename').rename()<CR>",
    {silent = true, noremap = true}
  )
  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

  -- code action
  --------------
  -- buf_set_keymap(
  --   "n",
  --   "ck",
  --   ":Lspsaga code_action<CR>",
  --   {silent = true, noremap = true}
  -- )
  buf_set_keymap("n", "ck", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap(
    "n",
    "<C-f>",
    ":lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>",
    {silent = true, noremap = true}
  )
  buf_set_keymap(
    "n",
    "<C-b>",
    ":lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>",
    {silent = true, noremap = true}
  )

  -- diagnostics related
  ----------------------
  -- buf_set_keymap(
  --   "n",
  --   "cc",
  --   ":lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>",
  --   {silent = true, noremap = true}
  -- )
  -- buf_set_keymap(
  --   "n",
  --   "cl",
  --   ":lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>",
  --   {silent = true, noremap = true}
  -- )
  buf_set_keymap(
    "n",
    "cl",
    "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
    opts
  )
  buf_set_keymap(
    "n",
    "<Up>f",
    ":lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>",
    {silent = true, noremap = true}
  )
  buf_set_keymap(
    "n",
    "<Down>f",
    ":lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>",
    {silent = true, noremap = true}
  )
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap(
    "n",
    "<leader>ad",
    "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>",
    opts
  )

  -- Set autocommands conditional on server_capabilities
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
    -- read/write shada?
    -- vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync({}, 5000) ]]
    vim.api.nvim_command(
      "autocmd BufWritePre <buffer> lua LspFormatBuffer(" .. bufnum .. ")"
    )
    -- vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.schedule_wrap(function() vim.lsp.buf.formatting_sync({}, 5000); end) ]]
    buf_set_keymap(
      "n",
      "<leader>af",
      "<cmd>lua vim.lsp.buf.formatting()<CR>",
      {noremap = true, silent = true}
    )
  end
end

return {
  global_on_attach = global_on_attach
}

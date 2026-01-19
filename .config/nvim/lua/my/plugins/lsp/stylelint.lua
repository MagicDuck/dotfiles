vim.lsp.config('stylelint_lsp', {
  filetypes = {
    'css',
    'less',
    'scss',
  },
  settings = {
    validateOnSave = true,
    -- validateOnType = true
    run = 'onSave', -- default is onType
  },
})

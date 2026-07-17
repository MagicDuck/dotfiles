local lspconfig = require('lspconfig')

lspconfig.cssls.setup({
  settings = {
    css = {
      validate = true,
      editor = {
        colorDecorators = false,
      },
      format = {
        enable = false,
      },
    },
    scss = {
      validate = true,
      editor = {
        colorDecorators = false,
      },
      format = {
        enable = false,
      },
    },
  },
})

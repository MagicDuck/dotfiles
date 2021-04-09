local lspconfig = require('lspconfig')
local attach = require('my/lsp/attach')
local handlers = require('my/lsp/handlers')

-- custom commands
local function organize_imports()
  vim.lsp.buf.execute_command({
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  })
end

lspconfig.tsserver.setup {
  on_init = function(client)
    -- This makes sure tsserver is not used for formatting (prefer prettier)
    client.resolved_capabilities.document_formatting = false
  end,
  on_attach = attach.global_on_attach,
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports"
    }
  },
  handlers = {
    ["textDocument/publishDiagnostics"] = handlers.tsserverPublishDiagnostics
  }
}

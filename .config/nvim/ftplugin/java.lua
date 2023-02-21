local myJdtls = require("my/plugins/lsp/jdtls")

vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4

if vim.g.myLspDisabled ~= true then
  -- Start a new client & server,
  -- or attach to an existing client & server depending on the `config.root_dir`.
  require("jdtls").start_or_attach(myJdtls.getConfig())
end

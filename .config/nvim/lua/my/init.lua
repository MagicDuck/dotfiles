-- clear my packages, this is needed in order to be able to reload my changes
for k, _ in pairs(package.loaded) do
  if string.match(k, "^my%/") then
    package.loaded[k] = nil
  end
end

require('impatient')
require("my/global/init")
require("my/keys")
require("my/commands")
require("my/treesitter")
-- require("my/compe")
require("my/completion")
require("my/todo")
-- require("my/coq")
require("my/lspkind")
require("my/lsp/init")
require("my/dap")
require("my/telescope")
require("my/colorizer")
require("my/hop")
require("my/leap")
-- require("my/lightspeed")
require("my/quickfix-bfq")
require("my/devicons")
-- require("my/galaxyline")
require("my/lualine")
require("my/tabby")
-- require("my/neoscroll")
require("my/kommentary")
require("my/rest")
-- require("my/fidget")
require("my/diffview")
-- require("my/gitsigns")
-- require("my/neogit")
-- require("my/whichkey")

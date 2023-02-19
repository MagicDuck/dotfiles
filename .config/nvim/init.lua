-- TODO (sbadragan): work on this eventually
-- see https://github.com/LazyVim/LazyVim
-- see https://github.com/LazyVim/starter
-- see https://github.com/folke/lazy.nvim
-- see https://www.lazyvim.org/

require("my/global/init")
require("my/config/options")
vim.cmd([[ source ~/.config/nvim/lua/my/config/base-keymaps.vim ]])
require("my/config/keymaps")
require("my/config/commands")
require("my/config/autocommands")
require("my/config/lazy")

-- TODO (sbadragan): move these into the plugins dir
require("my/completion")
require("my/lspkind")
require("my/lsp/init")
require("my/dap")
require("my/telescope")

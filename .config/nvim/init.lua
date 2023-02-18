-- TODO (sbadragan): work on this eventually
-- see https://github.com/LazyVim/LazyVim
-- see https://github.com/LazyVim/starter
-- see https://github.com/folke/lazy.nvim
-- see https://www.lazyvim.org/

require("my.config.options")
require("my.config.keymaps")
require("my.config.autocommands")
require("my.config.lazy")

-- TODO (sbadragan): convert those to lua config where possible
-- TODO (sbadragan): move base.vim into options.lua
vim.cmd([[
source ~/.config/nvim/base-config/base.vim
source ~/.config/nvim/base-config/commands.vim
" source ~/.config/nvim/plugin-config/startify.vim
source ~/.config/nvim/plugin-config/fugitive.vim
source ~/.config/nvim/plugin-config/ranger.vim
source ~/.config/nvim/plugin-config/rooter.vim
source ~/.config/nvim/plugin-config/vimwiki.vim
source ~/.config/nvim/plugin-config/ultisnip.vim
source ~/.config/nvim/plugin-config/neoformat.vim
]])

-- TODO (sbadragan): move these into the plugins dir
require("my/global/init")
require("my/keys")
require("my/commands")
require("my/treesitter")
require("my/completion")
require("my/todo")
require("my/lspkind")
require("my/lsp/init")
require("my/dap")
require("my/telescope")
require("my/highlight-colors")
require("my/leap")
require("my/quickfix-bfq")
require("my/devicons")
require("my/lualine")
require("my/tabby")
require("my/kommentary")
require("my/rest")
require("my/diffview")
require("my/peek")

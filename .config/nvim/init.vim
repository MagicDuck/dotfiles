set rtp+=/usr/local/bin

" TODO (sbadragan): can this clear code just go into global?
luafile ~/.config/nvim/lua/stephan/clear_stephan_packages.lua
luafile ~/.config/nvim/lua/stephan/global/init.lua

source ~/.config/nvim/base-config/plugins.vim
source ~/.config/nvim/base-config/base.vim
source ~/.config/nvim/base-config/keys.vim

source ~/.config/nvim/plugin-config/airline.vim
source ~/.config/nvim/plugin-config/which-key.vim
source ~/.config/nvim/plugin-config/startify.vim
source ~/.config/nvim/plugin-config/nerdcommenter.vim
source ~/.config/nvim/plugin-config/quickscope.vim
source ~/.config/nvim/plugin-config/fzf.vim
source ~/.config/nvim/plugin-config/fugitive.vim
source ~/.config/nvim/plugin-config/ranger.vim
source ~/.config/nvim/plugin-config/rooter.vim
source ~/.config/nvim/plugin-config/easyalign.vim
source ~/.config/nvim/plugin-config/quickfix-bfq.vim
source ~/.config/nvim/plugin-config/floatterm.vim
source ~/.config/nvim/plugin-config/simple-todo.vim

" Lua config
luafile ~/.config/nvim/lua/stephan/treesitter.lua
luafile ~/.config/nvim/lua/stephan/compe.lua
luafile ~/.config/nvim/lua/stephan/lspkind.lua
luafile ~/.config/nvim/lua/stephan/lsp/init.lua
luafile ~/.config/nvim/lua/stephan/telescope.lua
luafile ~/.config/nvim/lua/stephan/colorizer.lua
luafile ~/.config/nvim/lua/stephan/hop.lua



source ~/.config/nvim/os-specific.vim
source ~/.config/nvim/base-config/notes.vim
" Note: colorscheme is at end so that autocmds targeting it are triggered propertly
source ~/.config/nvim/base-config/colorscheme.vim


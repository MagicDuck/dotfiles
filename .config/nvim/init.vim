set rtp+=/usr/local/bin

lua require('my/plugins')
source ~/.config/nvim/base-config/base.vim
source ~/.config/nvim/base-config/commands.vim
luafile ~/.config/nvim/lua/my/init.lua

source ~/.config/nvim/plugin-config/startify.vim
source ~/.config/nvim/plugin-config/quickscope.vim
source ~/.config/nvim/plugin-config/fugitive.vim
source ~/.config/nvim/plugin-config/ranger.vim
source ~/.config/nvim/plugin-config/rooter.vim
source ~/.config/nvim/plugin-config/fzf.vim
source ~/.config/nvim/plugin-config/vimwiki.vim
source ~/.config/nvim/plugin-config/ultisnip.vim
source ~/.config/nvim/plugin-config/vimspector.vim
source ~/.config/nvim/plugin-config/neoformat.vim

source ~/.config/nvim/os-specific.vim
" Note: colorscheme is at end so that autocmds targeting it are triggered propertly
source ~/.config/nvim/base-config/colorscheme.vim


set rtp+=/usr/local/bin

" TODO: plugins -> lua?
source ~/.config/nvim/base-config/plugins.vim
source ~/.config/nvim/base-config/base.vim
luafile ~/.config/nvim/lua/my/init.lua

source ~/.config/nvim/base-config/commands.vim

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

source ~/.config/nvim/os-specific.vim
source ~/.config/nvim/base-config/notes.vim
" Note: colorscheme is at end so that autocmds targeting it are triggered propertly
source ~/.config/nvim/base-config/colorscheme.vim


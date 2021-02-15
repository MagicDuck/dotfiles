" Config Help Links
" ==============================================================================
" - https://www.chrisatmachine.com/Neovim


source ~/.config/nvim/base-config/plugins.vim
source ~/.config/nvim/base-config/base.vim
source ~/.config/nvim/base-config/keys.vim

source ~/.config/nvim/plugin-config/which-key.vim
source ~/.config/nvim/plugin-config/startify.vim
source ~/.config/nvim/plugin-config/airline.vim
source ~/.config/nvim/plugin-config/nerdcommenter.vim
source ~/.config/nvim/plugin-config/treesitter.vim
source ~/.config/nvim/plugin-config/sneak.vim
source ~/.config/nvim/plugin-config/quickscope.vim
source ~/.config/nvim/plugin-config/fzf.vim
source ~/.config/nvim/plugin-config/nerdtree.vim
source ~/.config/nvim/plugin-config/fugitive.vim
"source ~/.config/nvim/plugin-config/coc.vim
"source ~/.config/nvim/plugin-config/lsp.vim

source ~/.config/nvim/os-specific.vim
" Note: colorscheme is at end so that autocmds targeting it are triggered propertly
source ~/.config/nvim/base-config/colorscheme.vim


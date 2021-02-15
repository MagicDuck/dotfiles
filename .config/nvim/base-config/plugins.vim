" VimPlug: https://github.com/junegunn/vim-plug - see for bootstrap command
" Install with :source ~/.config/nvim/init.vim | PlugInstall

" Specify a directory for plugins
call plug#begin('~/vimfiles/plugged')

" Colorscheme - must work with treesitter for best effect
Plug 'sainnhe/edge'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf.vim', { 'commit': '23dda8602f138a9d75dd03803a79733ee783e356'} " fix for Rg not opening up
Plug 'airblade/vim-rooter'

" Session handling
Plug 'mhinz/vim-startify'

" remember keys
Plug 'liuchengxu/vim-which-key'

Plug 'scrooloose/nerdcommenter'
Plug 'easymotion/vim-easymotion'
Plug 'ryanoasis/vim-devicons'
Plug 'jiangmiao/auto-pairs'
Plug 'maksimr/vim-jsbeautify'
Plug 'jremmen/vim-ripgrep'
Plug 'shougo/deoplete-lsp'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'justinmk/vim-sneak'
Plug 'unblevable/quick-scope'
Plug 'junegunn/vim-easy-align'
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" TODO: following not sure about

"Plug 'pelodelfuego/vim-swoop'
    " TODO: figure out how to use
Plug 'dyng/ctrlsf.vim'
    let g:ctrlsf_ackprg = 'rg'
Plug 'neovim/nvim-lspconfig'
Plug 'ojroques/nvim-lspfuzzy'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Initialize plugin system
call plug#end()


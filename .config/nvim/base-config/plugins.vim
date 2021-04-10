" VimPlug: https://github.com/junegunn/vim-plug - see for bootstrap command
" Install with :source ~/.config/nvim/init.vim | PlugInstall

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" Colorscheme - must work with treesitter for best effect
Plug 'sainnhe/edge'
Plug 'mhartington/oceanic-next'
Plug 'tjdevries/colorbuddy.vim'
Plug 'Th3Whit3Wolf/onebuddy'
Plug 'Th3Whit3Wolf/one-nvim'
Plug 'Th3Whit3Wolf/space-nvim'
Plug 'sainnhe/gruvbox-material'

" Other plugins
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'junegunn/fzf.vim', { 'commit': '23dda8602f138a9d75dd03803a79733ee783e356'} " fix for Rg not opening up
Plug 'airblade/vim-rooter'
Plug 'mhinz/vim-startify' 
Plug 'scrooloose/nerdcommenter' " alt: https://github.com/b3nj5m1n/kommentary
Plug 'easymotion/vim-easymotion'
Plug 'Raimondi/delimitMate'
Plug 'maksimr/vim-jsbeautify'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground', {'do': ':TSInstall query'}
Plug 'windwp/nvim-ts-autotag'
Plug 'p00f/nvim-ts-rainbow'
Plug 'unblevable/quick-scope'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-fubitive'
Plug 'kevinhwang91/rnvimr'    " ranger
Plug 'kevinhwang91/nvim-bqf'  " quickfix
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-fzf-writer.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'kshenoy/vim-signature'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
Plug 'norcalli/nvim-colorizer.lua'
Plug 'voldikss/vim-floaterm'
Plug 'tpope/vim-surround'
Plug 'phaazon/hop.nvim'
Plug 'rafcamlet/nvim-luapad'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
"Plug 'akinsho/nvim-bufferline.lua'
" Plug 'hrsh7th/vim-vsnip'
Plug 'onsails/lspkind-nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
Plug 'itchyny/vim-highlighturl'
Plug 'vitalk/vim-simple-todo'

" alternative plugins
" - auto-pairs, use instead of 'Raimondi/delimitMate'
" Plug 'windwp/nvim-autopairs'
" Plug 'cohama/lexima.vim'

" Initialize plugin system
call plug#end()


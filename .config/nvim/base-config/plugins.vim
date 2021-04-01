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

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'junegunn/fzf.vim', { 'commit': '23dda8602f138a9d75dd03803a79733ee783e356'} " fix for Rg not opening up
Plug 'airblade/vim-rooter'

" Session handling
Plug 'mhinz/vim-startify'

" remember keys
Plug 'liuchengxu/vim-which-key'

Plug 'scrooloose/nerdcommenter'
Plug 'easymotion/vim-easymotion'
Plug 'Raimondi/delimitMate'
Plug 'maksimr/vim-jsbeautify'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'windwp/nvim-ts-autotag'
Plug 'p00f/nvim-ts-rainbow'
Plug 'unblevable/quick-scope'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-fubitive'
Plug 'kevinhwang91/rnvimr'    " ranger
Plug 'kevinhwang91/nvim-bqf'  " quickfix
" Stable version of coc 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Keeping up to date with master
" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

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
Plug 'voldikss/vim-floaterm'
Plug 'tpope/vim-surround'
Plug 'phaazon/hop.nvim'
Plug 'rafcamlet/nvim-luapad'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
"Plug 'akinsho/nvim-bufferline.lua'

" built-in LSP related
" Plug 'hrsh7th/vim-vsnip'
" Plug 'ojroques/nvim-lspfuzzy'
" manual language server installer has a few
" Plug 'anott03/nvim-lspinstall'
Plug 'onsails/lspkind-nvim'
" auto language server installer - way of the future
" Plug 'alexaandru/nvim-lspupdate'
" Plug 'sbdchd/neoformat'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }

" TODO: figure out how to use
"Plug 'pelodelfuego/vim-swoop'
"Plug 'dyng/ctrlsf.vim'
"    let g:ctrlsf_ackprg = 'rg'

" alternative plugins
" - auto-pairs, use instead of 'Raimondi/delimitMate'
" Plug 'windwp/nvim-autopairs'
" Plug 'cohama/lexima.vim'

" Initialize plugin system
call plug#end()


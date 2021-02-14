" Config Help Links
" ==============================================================================
" - https://www.chrisatmachine.com/Neovim

" Plugins
" ==============================================================================
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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
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


" General settings
"===============================================================================
set nocompatible
set encoding=utf-8
syntax enable
"set guifont=Hack:h10:cANSI:qDRAFT
"set guifont=Droid_Sans_Mono_Dotted_for_Powe:h10:cANSI:qDRAFT
"set guifont=Fira_Mono_For_Powerline:h11:cANSI:qDRAFT
" set guifont=DejaVu_Sans_Mono_For_Powerline:h10:cANSI:qDRAFT
"set guifont=DroidSansMonoForPowerline_NF:h10:cANSI:qDRAFT
set guifont=Knack_NF:h10:cANSI:qDRAFT

"set background=dark
"colorscheme sonokai " tutticolor colorful lucius
"colorscheme zephyr
"colorscheme OceanicNext
set background=light
colorscheme edge

set hidden

filetype on
filetype indent on
filetype plugin on
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set hlsearch " highlight search
set incsearch " incremental search
set ignorecase
set smartcase
set infercase " better case handling for insert mode completion
set wrapscan

set smartindent
"set autoindent
set autoread " automatically reload files changed outside Vim
"set autowrite " automatically write files when doing things like :make

set cmdheight=2
set laststatus=2
set showcmd
set showfulltag
set shortmess+=ts

" make backspace work
set bs=2

set wildchar=<Tab> wildmenu wildmode=longest:full,full

set cursorline
set clipboard=unnamed " use system clipboard

set fileformats=unix,dos
set backupcopy=yes " make file change watchers happy
set number

" Plugin configs
"===============================================================================
source ~/.config/nvim/plugin-config/which-key.vim
source ~/.config/nvim/plugin-config/startify.vim
source ~/.config/nvim/plugin-config/airline.vim
source ~/.config/nvim/plugin-config/nerdcommenter.vim
source ~/.config/nvim/plugin-config/treesitter.vim
source ~/.config/nvim/plugin-config/sneak.vim
source ~/.config/nvim/plugin-config/quickscope.vim
source ~/.config/nvim/plugin-config/fzf.vim

source ~/.config/nvim/os-specific.vim


" Misc
"===============================================================================

" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
command! -nargs=0 -bar Update if &modified
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif


" window number in status line
if !exists("my_airline_number_setup")
  let my_airline_number_setup = 1

  function! WindowNumber(...)
      let builder = a:1
      let context = a:2
      call builder.add_section('airline_b', '%{tabpagewinnr(tabpagenr())}')
      return 0
  endfunction

  call airline#add_statusline_func('WindowNumber')
  call airline#add_inactive_statusline_func('WindowNumber')
endif



" Generic autocommands
"===============================================================================
augroup vimrc
  " Remove all vimrc autocommands
  autocmd!

  " vim reload
  autocmd BufWrite ~/.config/nvim/init.vim :source ~/.config/nvim/init.vim

  " diffing
  autocmd VimEnter * if &diff | execute 'windo set wrap' | endif
  
  " highlight on yank
  autocmd TextYankPost * lua vim.highlight.on_yank {on_visual = false}

  " line number
  autocmd InsertEnter * :set norelativenumber
  autocmd InsertLeave * :set relativenumber
augroup END


" TODO: merge with stuff that is in Chris@Machine
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

augroup mybaseconfig
  " Remove all mybaseconfig autocommands
  autocmd!

  " diffing
  autocmd VimEnter * if &diff | execute 'windo set wrap' | endif
  
  " highlight on yank
  autocmd TextYankPost * lua vim.highlight.on_yank {on_visual = false}

  " line number
  autocmd InsertEnter * :set norelativenumber
  autocmd InsertLeave * :set relativenumber
augroup END

" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
command! -nargs=0 -bar Update if &modified
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif


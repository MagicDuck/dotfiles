set nocompatible
set encoding=utf-8
syntax enable
"set guifont=Hack:h10:cANSI:qDRAFT
"set guifont=Droid_Sans_Mono_Dotted_for_Powe:h10:cANSI:qDRAFT
"set guifont=Fira_Mono_For_Powerline:h11:cANSI:qDRAFT
" set guifont=DejaVu_Sans_Mono_For_Powerline:h10:cANSI:qDRAFT
"set guifont=DroidSansMonoForPowerline_NF:h10:cANSI:qDRAFT
set guifont=Knack_NF:h10:cANSI:qDRAFT

set hidden

filetype on
filetype indent on
filetype plugin on
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set hlsearch           " highlight search
set incsearch          " incremental search
set ignorecase
set smartcase
set infercase          " better case handling for insert mode completion
set wrapscan
set smartindent
set autoindent
set autoread           " automatically reload files changed outside Vi
" set autowrite " automatically write files when doing things like :make
set cmdheight=2
set laststatus=2
set noshowcmd          " don't show command in status line as you type it
set showfulltag
set shortmess+=ts
set shortmess+=c      " Avoid showing message extra message when using completion
set bs=2               " make backspace work
set wildchar=<Tab> wildmenu wildmode=longest:full,full
set cursorline
set clipboard=unnamed  " use system clipboard
set fileformats=unix,dos
set backupcopy=yes     " make file change watchers happy
set number
set pumheight=10       " Makes popup menu smaller
set fileencoding=utf-8 " The encoding written to file
set ruler              " Show the cursor position all the time
set iskeyword+=-       " treat dash separated words as a word text object"
set mouse=a            " Enable your mouse
set splitbelow         " Horizontal splits will automatically be below
set splitright         " Vertical splits will automatically be to the right
set t_Co=256           " Support 256 colors
set conceallevel=0     " So that I can see `` in markdown files
set noshowmode         " We don't need to see things like -- INSERT -- anymore
set nobackup           " This is recommended by coc
set nowritebackup      " This is recommended by coc
set updatetime=300     " Faster completion
set formatoptions-=cro " Stop newline continution of comments

" set grep command
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
command! -nargs=+ Search execute 'silent grep! <args>' | copen 16

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

  " no annoying auto-comments
  autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
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



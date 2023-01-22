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
" set smartindent
" set nosmartindent
set autoindent
set autoread           " automatically reload files changed outside Vi
" set autowrite " automatically write files when doing things like :make
set cmdheight=2
set laststatus=2
set noshowcmd          " don't show command in status line as you type it
set showfulltag
set shortmess+=ts
set shortmess+=c       " Avoid showing message extra message when using completion
set shortmess+=A       " Avoid showing ATTENTION message when editing same file in multiple vims
set bs=2               " make backspace work
set wildchar=<Tab> wildmenu wildmode=longest:full,full wildignorecase
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
set signcolumn=yes     " always show sign column
set scrolloff=999      " keep cursor in the middle of the window
set scroll=5           " number of lines the scroll commands should scroll
set termguicolors      " true color
set notimeout        " don't time out on leader commands
set nofoldenable

" fix for kitty terminal background tearing
let &t_ut=''

" set grep command
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

augroup mybaseconfig
  " Remove all mybaseconfig autocommands
  autocmd!

  " packer recompile
  autocmd BufWritePost plugins.lua PackerCompile

  " diffing
  autocmd VimEnter * if &diff | execute 'windo set wrap' | endif
  
  " highlight on yank
  autocmd TextYankPost * lua vim.highlight.on_yank {on_visual = false}

  " line number
  set norelativenumber
  " autocmd InsertEnter * :set norelativenumber
  " autocmd InsertLeave * :set relativenumber

  " no annoying auto-comments
  autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

  " enable syntax highlighting in .conf files
  autocmd BufEnter,BufRead *conf setf dosini
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

command! -bar BufOnly execute '%bdelete|edit #|normal `"'

let g:markdown_fenced_languages = ['bash=sh', 'javascript', 'js=javascript', 'json=javascript', 'typescript', 'ts=typescript', 'html', 'css', 'java']

" wildmenu swap arrow keys and left right
set wildcharm=<C-Z>
cnoremap <expr> <up> wildmenumode() ? "\<left>" : "\<up>"
cnoremap <expr> <down> wildmenumode() ? "\<right>" : "\<down>"
cnoremap <expr> <left> wildmenumode() ? "\<up>" : "\<left>"
cnoremap <expr> <right> wildmenumode() ? " \<bs>\<C-Z>" : "\<right>"

" leader keys
noremap <Space> <Nop>
let mapleader = "\<Space>"
let maplocalleader = ","

" better completion
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" slightly easier :command
noremap ; :

" alt-based motions
inoremap <a-bs> <c-w>
inoremap <a-del> <c-o>de
inoremap <a-left> <c-o>b
inoremap <a-right> <c-o>w
inoremap <a-up> <c-o>^
inoremap <a-down> <c-o>$

cnoremap <a-bs> <c-w>
cnoremap <a-del> <del>
cnoremap <a-left> <s-left>
cnoremap <a-right> <s-right>
cnoremap <a-up> <home>
cnoremap <a-down> <end>

nnoremap <A-BS> a<C-W><esc>
nnoremap <A-Del> de
nnoremap <A-left> b
nnoremap <A-right> w
nnoremap <A-up> ^
nnoremap <A-down> $

tnoremap <a-bs> <c-w>
" note: might have to change some of those to exec only when ranger is on
tnoremap <a-Del> <a-d> 
tnoremap <a-left> <a-b>
tnoremap <a-right> <a-f>
tnoremap <a-up> <home>
tnoremap <a-down> <end>
 
tnoremap <Esc><Esc> <C-\><C-n>

" visual block select
nnoremap X <c-v>

" don't overwrite copied text when pasting in visual mode
" vnoremap p "0p
" vnoremap P "0P
xnoremap p pgvy

" performance json
" Change foldmethod for specific filetype
augroup Folding
  autocmd!
  autocmd! BufNewFile,BufRead *.json set foldmethod=indent
augroup END

" easier visual line select
nnoremap vv V

" Plugins
"=============================================================================
" VimPlug: https://github.com/junegunn/vim-plug
" Install with :source ~/.config/nvim/init.vim | PlugInstall

" Specify a directory for plugins
call plug#begin('~/vimfiles/plugged')

"Plug 'flazz/vim-colorschemes'
"Plug 'felixhummel/setcolors.vim'
"Plug 'altercation/vim-colors-solarized'
"Plug 'lifepillar/vim-solarized8'
Plug 'NLKNguyen/papercolor-theme'
"Plug 'jonathanfilip/vim-lucius'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1

    " unicode symbols
    set encoding=utf-8

    " if !exists('g:airline_symbols')
    "     let g:airline_symbols = {}
    " endif

    " unicode symbols
    " let g:airline_left_sep = '»'
    " let g:airline_left_sep = '▶'
    " let g:airline_right_sep = '«'
    " let g:airline_right_sep = '◀'
    " let g:airline_symbols.linenr = '␊'
    " let g:airline_symbols.linenr = '␤'
    " let g:airline_symbols.linenr = '¶'
    " let g:airline_symbols.branch = '⎇'
    " let g:airline_symbols.paste = 'ρ'
    " let g:airline_symbols.paste = 'Þ'
    " let g:airline_symbols.paste = '∥'
    " let g:airline_symbols.whitespace = 'Ξ'
    "
    " " airline symbols
    " let g:airline_left_sep = ''
    " let g:airline_left_alt_sep = ''
    " let g:airline_right_sep = ''
    " let g:airline_right_alt_sep = ''
    " let g:airline_symbols.branch = ''
    " let g:airline_symbols.readonly = ''
    " let g:airline_symbols.linenr = ''

"Plug 'jelera/vim-javascript-syntax'
"Plug 'vim-scripts/JavaScript-Indent'
Plug 'sheerun/vim-polyglot'

"Plug 'Shougo/unite.vim'

"Plug 'Shougo/vimproc.vim', {'do' : 'make'}
"Plug 'Shougo/vimproc.vim'
"    let g:vimproc#download_windows_dll = 1

Plug 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_working_path_mode = 'rw'
    "let g:ctrlp_user_command = '\bin\ag.exe --nocolor --hidden -g "" %s'
    "let g:ctrlp_user_command = 'pt --nogroup -S --ignore=node_modules --global-gitignore -g "" %s'
    let g:ctrlp_user_command ='rg -F --files --hidden %s'
    let g:ctrlp_by_filename = 0
    let g:ctrlp_mruf_case_sensitive = 0
    let g:ctrlp_max_files = 0 " no limit
    let g:ctrlp_show_hidden = 1

" Follow instructions on website to install this if ctrlp is slow:
" Plug 'JazzCore/ctrlp-cmatcher'
    " let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }

"Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
" Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'

Plug 'dyng/ctrlsf.vim'
    let g:ctrlsf_ackprg = 'rg'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
    let g:session_autosave = 'yes'
    let g:session_autoload = 'yes'

Plug 'vim-syntastic/syntastic'
    let g:syntastic_javascript_checkers = ['jshint']
    let g:syntastic_json_checkers = ['jshint']
    let g:syntastic_javascript_jshint_args =
        \ '--config C:/code/hana_epm_fpa/config/coding/jshintConfig.js'
    let g:syntastic_css_checkers = ['csslint']
    let g:syntastic_css_csslint_args =
        \ '--ignore=order-alphabetical,important,ids,adjoining-classes,zero-units'

Plug 'koron/nyancat-vim'

Plug 'pelodelfuego/vim-swoop'
    " TODO: figure out how to use

Plug 'scrooloose/nerdcommenter'
    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 1

    " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs = 1

    " Align line-wise comment delimiters flush left instead of following code indentation
    let g:NERDDefaultAlign = 'left'

    " Set a language to use its alternate delimiters by default
    let g:NERDAltDelims_java = 1

    " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDCommentEmptyLines = 1

    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace = 1

Plug 'easymotion/vim-easymotion'

"Plug 'lambdalisue/vim-gita'
Plug 'tpope/vim-fugitive'

Plug 'ryanoasis/vim-devicons'

Plug 'jiangmiao/auto-pairs'

Plug 'maksimr/vim-jsbeautify'

" Initialize plugin system
call plug#end()

" General settings
"===============================================================================
set nocompatible
syntax enable
"set guifont=Hack:h10:cANSI:qDRAFT
"set guifont=Droid_Sans_Mono_Dotted_for_Powe:h10:cANSI:qDRAFT
"set guifont=Fira_Mono_For_Powerline:h11:cANSI:qDRAFT
" set guifont=DejaVu_Sans_Mono_For_Powerline:h10:cANSI:qDRAFT
"set guifont=DroidSansMonoForPowerline_NF:h10:cANSI:qDRAFT
set guifont=Knack_NF:h10:cANSI:qDRAFT

set background=light
colorscheme PaperColor " tutticolor colorful lucius

set hidden

filetype on
filetype indent on
filetype plugin on
set tabstop=4
set shiftwidth=4
set softtabstop=4
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

if has("gui_running")
    set guioptions-=T
    au GUIEnter * simalt ~x  "maximize
endif

"set autowriteall
set wildchar=<Tab> wildmenu wildmode=longest:full,full

set cursorline
set clipboard=unnamed " use system clipboard

set fileformats=unix,dos
set backupcopy=yes " make file change watchers happy

" line numbering
set number
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
":au FocusLost * :set norelativenumber
":au FocusGained * :set relativenumber

"set shellslash " use forward slasheds

function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Key mappings
"===============================================================================
" note: you can see mapping with :map <key>   (ex: :map <C-d>)
let mapleader = ","
imap jk <Esc>
cmap jk <C-U><Esc>
set timeoutlen=1000
vnoremap <C-c> "*y
inoremap <C-v> <C-O>"*p

nnoremap ; :

"Note: command history is:  q:

" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
command! -nargs=0 -bar Update if &modified
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif
nnoremap <silent> <C-S> :<C-U>Update<CR>
nnoremap <Leader>w :<C-U>Update<CR>
vnoremap <silent> <C-S> <C-C>:Update<CR>
inoremap <silent> <C-S> <C-O>:Update<CR>

"splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-Q> <C-W><C-Q>
nnoremap <leader>q :bp\|bd #<CR>

"finding files
nnoremap <silent><leader>f :<C-U>CtrlPMixed<CR>
nnoremap <silent><C-p> :<C-U>CtrlPMixed<CR>
nnoremap <silent><leader>b :<C-U>CtrlPBuffer<CR>

"searching in files
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
"nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
nmap     <C-F>l <Plug>CtrlSFQuickfixPrompt
vmap     <C-F>l <Plug>CtrlSFQuickfixVwordPath
vmap     <C-F>L <Plug>CtrlSFQuickfixVwordExec

function! SearchWebpackNodeModulesFun( arg )
    let g:ctrlsf_extra_backend_args = {'rg': '--no-ignore-parent'}
    execute 'CtrlSF ' . a:arg . ' /code/hana_epm_fpa/webpack/node_modules'
    let g:ctrlsf_extra_backend_args = {}
endfunction

command! -nargs=* SearchWebpackNodeModules call SearchWebpackNodeModulesFun( '<args>' )
noremap <C-F>n :SearchWebpackNodeModules<space>

" commenting
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

"easymotion
" <Leader>f{char}{char} to move to {char}
map  <Leader>s <Plug>(easymotion-bd-f2)
"nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)

"vimdiff current vs git head (fugitive extension)
nnoremap <Leader>gd :Gdiff<cr>

"switch back to current file and closes fugitive buffer
nnoremap <Leader>gD <c-w>h<c-w>c

nnoremap <Leader>gs :Gstatus<cr>
autocmd BufReadPost fugitive://* set bufhidden=delete

autocmd FileType javascript vnoremap <buffer>  <leader>i :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <leader>i :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <leader>i :call RangeJsxBeautify()<cr>
autocmd FileType html vnoremap <buffer> <leader>i :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <leadedoner>i :call RangeCSSBeautify()<cr>

source ~/.config/nvim/os-specific.vim


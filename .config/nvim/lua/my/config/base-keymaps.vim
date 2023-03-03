" wildmenu swap arrow keys and left right
set wildcharm=<C-Z>
cnoremap <expr> <up> wildmenumode() ? "\<left>" : "\<up>"
cnoremap <expr> <down> wildmenumode() ? "\<right>" : "\<down>"
cnoremap <expr> <left> wildmenumode() ? "\<up>" : "\<left>"
cnoremap <expr> <right> wildmenumode() ? " \<bs>\<C-Z>" : "\<right>"

" better completion
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" inoremap <expr> <c-j> ("\<C-n>")
" inoremap <expr> <c-k> ("\<C-p>")

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

" easier visual line select
" nnoremap vv V

" line begin and end
nnoremap H ^
vnoremap H ^
onoremap H ^
nnoremap L $
vnoremap L $
onoremap L $

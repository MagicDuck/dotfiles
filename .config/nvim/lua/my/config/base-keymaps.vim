" wildmenu swap arrow keys and left right
set wildcharm=<C-Z>
cnoremap <expr> <up> wildmenumode() ? "\<left>" : "\<up>"
cnoremap <expr> <down> wildmenumode() ? "\<right>" : "\<down>"
cnoremap <expr> <left> wildmenumode() ? "\<up>" : "\<left>"
cnoremap <expr> <right> wildmenumode() ? " \<bs>\<C-Z>" : "\<right>"
set wildoptions=fuzzy,pum

" better completion
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" inoremap <expr> <c-j> ("\<C-n>")
" inoremap <expr> <c-k> ("\<C-p>")

" slightly easier :command
noremap ; :

if has("linux")
   " ctrl-based motions
   " c-h is c-bs
   inoremap <c-h> <c-w>
   inoremap <c-del> <c-o>de
   inoremap <c-left> <c-o>b
   inoremap <c-right> <c-o>w
   inoremap <c-up> <c-o>^
   inoremap <c-down> <c-o>$

   " cnoremap <c-bs> <c-w>
   cnoremap <c-del> <del>
   cnoremap <c-left> <s-left>
   cnoremap <c-right> <s-right>
   cnoremap <c-up> <home>
   cnoremap <c-down> <end>

   " tnoremap <c-bs> <c-w>
   tnoremap <c-Del> <a-d> 
   tnoremap <c-left> <a-b>
   tnoremap <c-right> <a-f>
   tnoremap <c-up> <home>
   tnoremap <c-down> <end>
else
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

   tnoremap <a-bs> <c-w>
   tnoremap <a-Del> <a-d> 
   tnoremap <a-left> <a-b>
   tnoremap <a-right> <a-f>
   tnoremap <a-up> <home>
   tnoremap <a-down> <end>
endif
 
tnoremap <s-esc> <C-\><C-n>

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

inoremap <Home> <Esc>^i
nnoremap <Home> ^
vnoremap <Home> ^
onoremap <Home> ^

" Quickfix list navigation that loops around
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry

cabbrev cnext Cnext
cabbrev cprev Cprev
cabbrev lnext Lnext
cabbrev lprev Lprev

xnoremap il 0o$h
onoremap il :normal vil<CR>

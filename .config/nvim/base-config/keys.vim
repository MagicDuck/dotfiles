" keys to remember

" - command history is:  q:
" - sneak is bound to "s"
" - quickscope is f, t, F, T  &  , and ;  to jump to next occurrence
" - closing other windows except current is "wincmd o"


" Create map to add which-key keys to for easy discovery
let g:which_key_map = {}

" reload vim config
let g:which_key_map['R'] = [ ':source ~/.config/nvim/init.vim' , 'reload vim config' ]

" esc mapping, not necessary on mac due to karabiner 
"imap jk <Esc>
"cmap jk <C-U><Esc>

" leader keys
noremap <Space> <Nop>
let mapleader = "\<Space>"
let maplocalleader = ","

"C-c / C-v copy-paste
vnoremap <C-c> "*y
inoremap <C-v> <C-O>"*p

" C-s saving
nnoremap <silent> <C-S> :<C-U>Update<CR>
nnoremap <Leader>w :<C-U>Update<CR>
vnoremap <silent> <C-S> <C-C>:Update<CR>
inoremap <silent> <C-S> <C-O>:Update<CR>

" enter window mode with backspace
noremap <BS> <C-W>

" moving around windows with control+hjkl
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

" window jumping with <Leader>N
let i = 1
while i <= 9
    execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
    let i = i + 1
endwhile
let g:which_key_map[1] = 'jump to window 1'
let g:which_key_map[2] = 'jump to window 2'
let g:which_key_map[3] = 'jump to window 3'
let i = 4
while i <= 9
    execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
    let g:which_key_map[i] = 'which_key_ignore'
    let i = i + 1
endwhile

" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Easy CAPS
inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<Esc>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Not needed now, but clears out auto-comment when opening new lines
"nnoremap <Leader>o o<Esc>^Da
"nnoremap <Leader>O O<Esc>^Da

" quickfix list navigation
nnoremap <Left>n :cprevious<CR>
nnoremap <Right>n :cnext<CR>

" tab navigtion
nnoremap <Right>m :tabnext<CR>
nnoremap <Left>m :tabprevious<CR>

" clear search highlight
let g:which_key_map['v'] = [ ':let @/ = ""'  , 'clear search' ]

" wildmenu swap arrow keys and left right
set wildcharm=<C-Z>
cnoremap <expr> <up> wildmenumode() ? "\<left>" : "\<up>"
cnoremap <expr> <down> wildmenumode() ? "\<right>" : "\<down>"
cnoremap <expr> <left> wildmenumode() ? "\<up>" : "\<left>"
cnoremap <expr> <right> wildmenumode() ? " \<bs>\<C-Z>" : "\<right>"

" marks - map all capital letter marks to lowercase as it's easier to type
nnoremap ma mA
nnoremap mb mB
nnoremap mc mC
nnoremap md mD
nnoremap me mE
nnoremap mf mF
nnoremap mg mG
nnoremap mh mH
nnoremap mi mI
nnoremap mj mJ
nnoremap mk mK
nnoremap ml mL
nnoremap mm mM
nnoremap mn mN
nnoremap mo mO
nnoremap mp mP
nnoremap mq mQ
nnoremap mr mR
nnoremap ms mS
nnoremap mt mT
nnoremap mu mU
nnoremap mv mV
nnoremap mw mW
nnoremap mx mX
nnoremap my mY
nnoremap mz mZ

nnoremap 'a 'A
nnoremap 'b 'B
nnoremap 'c 'C
nnoremap 'd 'D
nnoremap 'e 'E
nnoremap 'f 'F
nnoremap 'g 'G
nnoremap 'h 'H
nnoremap 'i 'I
nnoremap 'j 'J
nnoremap 'k 'K
nnoremap 'l 'L
nnoremap 'm 'M
nnoremap 'n 'N
nnoremap 'o 'O
nnoremap 'p 'P
nnoremap 'q 'Q
nnoremap 'r 'R
nnoremap 's 'S
nnoremap 't 'T
nnoremap 'u 'U
nnoremap 'v 'V
nnoremap 'w 'W
nnoremap 'x 'X
nnoremap 'y 'Y
nnoremap 'z 'Z

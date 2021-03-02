let g:which_key_sep = '→'
let g:which_key_hspace = 10
"let g:which_key_timeout = 100
set timeoutlen=300

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
 \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler


" Map leader to which_key
nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Register which key map
call which_key#register('<Space>', "g:which_key_map")

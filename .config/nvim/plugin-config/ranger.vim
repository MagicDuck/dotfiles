" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1

tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
nnoremap <silent> <M-o> :RnvimrToggle<CR>
tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>

let g:which_key_map['b'] = [ ':RnvimrToggle'              , 'ranger' ]
let g:which_key_map.n = {
      \ 'name' : '+notes' ,
      \ 'e' : [':e ~/notes/'     , 'open notes dir'],
      \ 'd' : [':MyFiles ~/notes/'     , 'search note files'],
      \ 'f' : ['SearchNotes'     , 'search notes text'],
      \ 'r' : [':e ~/notes/ | RnvimrToggle'     , 'open notes dir with ranger'],
      \ }

command! -nargs=* -bang SearchNotes
  \ call RipgrepFzf('~/notes/', <q-args>)

function! EditFileWithSpaces(bang, path, extension, filename) 
    :exe "e". a:bang. " " . fnameescape(a:path) . fnameescape(a:filename . a:extension) 
endfu 
command! -bang -nargs=* AddNote :call EditFileWithSpaces(<q-bang>, "~/notes/", ".md", <q-args>) 

nnoremap <leader>na :AddNote 
let g:which_key_map.n.a = 'add new note'


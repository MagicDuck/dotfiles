let g:which_key_map.n = {
      \ 'name' : '+notes' ,
      \ 'e' : [':cd ~/notes/ | Startify'        , 'open notes dir'],
      \ 'd' : [':MyFiles ~/notes/'              , 'search note files'],
      \ 'f' : ['SearchNotes'                    , 'search notes text'],
      \ 'r' : [':e ~/notes/ | RnvimrToggle'     , 'open notes dir with ranger'],
      \ 'g' : [':lvimgrep /\[ \]/ % | lopen'    , 'open todos in loclist'],
      \ 'c' : ['<Plug>(simple-todo-mark-switch)'   , 'toggle todo status'],
      \ 'O' : ['<Plug>(simple-todo-above)'         , 'add todo above'],
      \ 'o' : ['<Plug>(simple-todo-below)'         , 'add todo below'],
      \ }

command! -nargs=* -bang SearchNotes
  \ call RipgrepFzf('~/notes/', <q-args>)

function! EditFileWithSpaces(bang, path, extension, filename) 
    :exe "e". a:bang. " " . fnameescape(a:path) . trim(fnameescape(a:filename)) . a:extension 
    call append(0, ["# " . a:filename, "", ""])
    normal 3gg
    startinsert
endfunction

command! -bang -nargs=* AddNote :call EditFileWithSpaces(<q-bang>, "~/notes/", ".md", <q-args>) 

nnoremap <leader>na :AddNote 
let g:which_key_map.n.a = 'add new note'


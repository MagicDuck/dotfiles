let g:which_key_map.n = {
      \ 'name' : '+notes' ,
      \ 'e' : [':cd ~/notes/ | Startify'        , 'open notes dir'],
      \ 'd' : [':MyFiles ~/notes/'              , 'search note files'],
      \ 'f' : ['SearchNotes'                    , 'search notes text'],
      \ 'r' : [':e ~/notes/ | RnvimrToggle'     , 'open notes dir with ranger'],
      \ 'g' : [':lvimgrep /\[[o -]\]/ % | lopen'    , 'open todos in loclist'],
      \ 'c' : ['<Plug>(simple-todo-mark-switch)'   , 'toggle todo status'],
      \ 'O' : ['<Plug>(simple-todo-above)'         , 'add todo above'],
      \ 'o' : ['<Plug>(simple-todo-below)'         , 'add todo below'],
      \ }

command! -nargs=* -bang SearchNotes
  \ call RipgrepFzf('~/notes/', <q-args>)

function! EditFileWithSpaces(bang, path, extension, filename) 
    let file = expand(fnameescape(a:path) . trim(fnameescape(a:filename)) . a:extension) 
    let exists = filereadable(file)
    :exe "e". a:bang. " " . file
    if !exists
      call append(0, ["# " . a:filename, "", ""])
      normal 3gg
      startinsert
    endif
endfunction

command! -bang -nargs=* EditNote :call EditFileWithSpaces(<q-bang>, "~/notes/", ".md", <q-args>) 
command! -bang -nargs=* EditNoteForBranch :call EditFileWithSpaces(<q-bang>, "~/notes/", ".md",
  \ system("git branch | grep \\* | cut -d ' ' -f2")) 

nnoremap <leader>na :EditNote 
let g:which_key_map.n.a = 'edit note'

nnoremap <leader>nb :EditNoteForBranch<CR>
let g:which_key_map.n.b = 'edit branch note'

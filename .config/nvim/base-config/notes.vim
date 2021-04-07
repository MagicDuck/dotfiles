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

function! EditNoteFile(bang, path, extension, filename) 
    let file = expand(fnameescape(a:path) . trim(fnameescape(a:filename)) . a:extension) 
    let exists = filereadable(file)
    :exe "e". a:bang. " " . file
    if !exists
      call append(0, ["# " . a:filename, "", ""])
      normal 3gg
      startinsert
    endif
endfunction

function! EditBranchNoteFile(bang, path, extension) 
  let inGit = !system("git rev-parse --git-dir > /dev/null 2>&1; echo $?") 
  if inGit
    let branchName = system("git branch | grep \\* | cut -d ' ' -f2")
    call EditNoteFile(a:bang, a:path, a:extension, branchName)
  else
    echo "Not in a git repo!"
  endif
endfunction

command! -bang -nargs=* EditNote :call EditNoteFile(<q-bang>, "~/notes/", ".md", <q-args>) 
command! -bang -nargs=* EditNoteForBranch :call EditBranchNoteFile(<q-bang>, "~/notes/", ".md") 

nnoremap <leader>na :EditNote 
let g:which_key_map.n.a = 'edit note'

nnoremap <leader>nb :EditNoteForBranch<CR>
let g:which_key_map.n.b = 'edit branch note'

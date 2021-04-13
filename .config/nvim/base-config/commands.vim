" Quickfix list navigation that loops around
"-----------------------------------------------------------------------------------------------
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry

cabbrev cnext Cnext
cabbrev cprev Cprev
cabbrev lnext Lnext
cabbrev lprev LPREV

" Wipe all deleted (unloaded & unlisted) or all unloaded buffers
"-----------------------------------------------------------------------------------------------
function! MyBwipeout(listed) abort
  let l:buffers = filter(getbufinfo(), {_, v -> !v.loaded && (!v.listed || a:listed)})
  if !empty(l:buffers)
      execute 'bwipeout' join(map(l:buffers, {_, v -> v.bufnr}))
  endif
endfunction
command! -bar -bang BwipeoutAll call MyBwipeout(<bang>0)

" Grep with rg and open in quickfix
"-----------------------------------------------------------------------------------------------
command! -nargs=+ RgSearch execute 'silent grep! <args>' | copen 16

" Search in files
"-----------------------------------------------------------------------------------------------
command! -bang -nargs=? -complete=dir MyFiles
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

function! RipgrepFzf(path, initialQuery, rgArgs) 
  let command_fmt = "rg --column --line-number --no-heading --color=always --ignore-file %s --smart-case %s %s %s || true"
  let initial_command = printf(command_fmt, g:my_global_rg_ignore_file, shellescape(a:initialQuery), a:path, a:rgArgs)
  let reload_command = printf(command_fmt, g:my_global_rg_ignore_file, '{q}', a:path, a:rgArgs)
  let spec = {'options': ['--phony', '--query', a:initialQuery, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), 0)
endfunction

command! -nargs=* -bang Search
  \ call RipgrepFzf('', '', <q-args>)

" Search for current workd under cursor
"-----------------------------------------------------------------------------------------------
function! RipgrepFzfCurrentWord(path, rgArgs) 
  normal! "ayiw
  call RipgrepFzf(a:path, @a, a:rgArgs)
endfunction
command! -nargs=* -bang SearchCurrentWord
  \ call RipgrepFzfCurrentWord('', <q-args>)


" Marks with preview
"-----------------------------------------------------------------------------------------------
function! s:fzf_preview_p(bang, ...) abort
    let preview_args = get(g:, 'fzf_preview_window', ['up:50%', 'ctrl-/'])
    if empty(preview_args)
        return { 'options': ['--preview-window', 'hidden'] }
    endif

    " For backward-compatiblity
    if type(preview_args) == type('')
        let preview_args = [preview_args]
    endif
    return call('fzf#vim#with_preview', extend(copy(a:000), preview_args))
endfunction

command! -bar -bang MarksWithPreview
      \ call fzf#vim#marks(
      \     s:fzf_preview_p(<bang>0, {'placeholder': '$([ -r $(echo {4} | sed "s#^~#$HOME#") ] && echo {4} || echo ' . fzf#shellescape(expand('%')) . '):{2}',
      \               'options': '--preview-window +{2}-/2'}),
      \     <bang>0)

" Search notes
"-----------------------------------------------------------------------------------------------
command! -nargs=* -bang SearchNotes
  \ call RipgrepFzf('~/notes/', '', <q-args>)

" Search todo comments
"-----------------------------------------------------------------------------------------------
command! -nargs=* -bang SearchForTodoComments
  \ call RipgrepFzf('', 'TODO \(sbadragan\)', <q-args>)

" Edit/add note file
"-----------------------------------------------------------------------------------------------
function! EditNoteFile(bang, path, extension, filename) 
    let file = expand(fnameescape(a:path) . trim(fnameescape(a:filename)) . a:extension) 
    let exists = filereadable(file)
    :exe "e". a:bang. " " . file
    if !exists
      call append(0, ["# " . trim(a:filename), "", ""])
      normal 3gg
      startinsert
    endif
endfunction
command! -bang -nargs=* EditNote :call EditNoteFile(<q-bang>, "~/notes/", ".md", <q-args>) 

" Edit/add note file for git branch
"-----------------------------------------------------------------------------------------------
function! EditBranchNoteFile(bang, path, extension) 
  let inGit = !system("git rev-parse --git-dir > /dev/null 2>&1; echo $?") 
  if inGit
    let branchName = system("git branch | grep \\* | cut -d ' ' -f2")
    call EditNoteFile(a:bang, a:path, a:extension, branchName)
  else
    echo "Not in a git repo!"
  endif
endfunction

command! -bang -nargs=* EditNoteForBranch :call EditBranchNoteFile(<q-bang>, "~/notes/", ".md") 

augroup mynerdtree
  autocmd!

  " Start NERDTree, unless a file or session is specified, eg. vim -S session_file.vim.
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | Startify | NERDTree | wincmd w | endif

  " Exit Vim if NERDTree is the only window left.
  autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
      \ quit | endif

  " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
  autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
      \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

augroup END
    " autocmd VimEnter *
    "             \   if !argc()
    "             \ |   Startify
    "             \ |   NERDTree
    "             \ |   wincmd w
    "             \ | endif

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

augroup my_ultisnip
  autocmd!
  autocmd FileType javascriptreact UltiSnipsAddFiletypes javascriptreact.javascript.javascript-react
augroup END


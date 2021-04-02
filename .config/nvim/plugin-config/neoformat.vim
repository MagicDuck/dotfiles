" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

let g:neoformat_run_all_formatters = 1

let g:neoformat_enabled_javascript = ['eslint_d', 'prettier']
let g:neoformat_enabled_lua = ['lua-fmt']

augroup my_neoformat
  autocmd!
  autocmd BufWritePre *.js Neoformat
  autocmd BufWritePre *.jsx Neoformat
  autocmd BufWritePre *.lua Neoformat
augroup END

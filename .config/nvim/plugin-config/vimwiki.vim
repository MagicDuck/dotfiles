let wiki = {}
let wiki.path = '~/notes/'
let wiki.syntax = 'markdown'
let wiki.ext = '.md'
let wiki.nested_syntaxes = {
  \ 'js': 'javascript',
  \ 'c++': 'cpp'
  \ }
let g:vimwiki_list = [wiki]

let g:vimwiki_key_mappings = { 'links': 0 }
let g:vimwiki_conceal_pre = 1

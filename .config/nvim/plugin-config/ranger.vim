let g:rnvimr_enable_picker = 1
" let g:rnvimr_enable_ex = 1
let g:rnvimr_enable_bw = 1
"let g:rnvimr_ranger_cmd = 'ranger --confdir=/Users/stephanbadragan/.config/ranger'
let g:rnvimr_ranger_cmd = ['nice', '-n', '0', 'ranger', '--confdir=/Users/stephanbadragan/.config/ranger']

let g:rnvimr_action = {
  \ '<C-t>': 'NvimEdit tabedit',
  \ '<C-h>': 'NvimEdit split',
  \ '<C-l>': 'NvimEdit vsplit'
  \ }

lua << EOF
-- preload ranger in the background for a faster startup the first time around
vim.defer_fn(function ()
    vim.cmd('RnvimrStartBackground')
end, 1000)
EOF

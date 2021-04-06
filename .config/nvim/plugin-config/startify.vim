let g:startify_lists = [
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]

let g:startify_bookmarks = [
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'e': '~/notes' },
            \ { 'K': '~/.config/nvim/base-config/keys.vim' },
            \ { 't': '~/.config/kitty/kitty.conf' },
            \ { 'T': '~/.tmux.conf' },
            \ { 'z': '~/.zshrc' },
            \ { 'sc': '~/spark/src/common/scss/mixins/_colors.scss'},
            \ { 'sf': '~/spark/src/common/scss/mixins/_fonts.scss'},
            \ '~/frontend/reactUi',
            \ '~/spark',
            \ '~/xm-api',
            \ '~/xm-openapi-specs',
            \ '~/xm-database',
            \ '~/xm-ss-gen',
            \ '~/builtin-script-steps',
            \ '~/qa-automation-ui',
            \ '~/qa-automation',
            \ '~/qa-automation',
            \ ]

let g:startify_session_autoload = 1
let g:startify_session_delete_buffers = 1
let g:startify_change_to_vcs_root = 0
let g:startify_change_to_dir = 0
let g:startify_fortune_use_unicode = 1
let g:startify_session_persistence = 1
let g:startify_enable_special = 0

" Keybindings
let g:which_key_map['i'] = [ ':Startify'                  , 'start screen' ]

augroup my_startify
  autocmd!
  " open startify on new tabs
  autocmd TabNewEntered * Startify
augroup END

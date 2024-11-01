set clipboard=unnamed
set tabstop=2

" I like using H and L for beginning/end of line
nmap H ^
nmap L $
vmap H ^
vmap L $

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
nmap <C-o> :back<cr>
exmap forward obcommand app:go-forward
nmap <C-i> :forward<cr>

unmap <Space>

exmap liveGrep obcommand omnisearch:show-modal
nmap <Space>f :liveGrep<cr>

exmap openFile obcommand switcher:open
nmap <Space>d :openFile<cr>
nmap <Space>b :openFile<cr>

exmap renameFile obcommand editor:rename-heading
nmap <Space>r :renameFile

nunmap s 
exmap vsplit obcommand workspace:split-vertical
nmap sv :vsplit<cr>
exmap hsplit obcommand workspace:split-horizontal
nmap ss :hsplit<cr>
exmap closeTab obcommand workspace:close
nmap sc :closeTab<cr>
exmap closeOtherTab obcommand workspace:close-others
nmap so :closeOtherTab<cr>

exmap moveBot obcommand editor:focus-bottom
nmap sj :moveBot<cr>
exmap moveTop obcommand editor:focus-top
nmap sk :moveTop<cr>  
exmap moveLeft obcommand editor:focus-left
nmap sh :moveLeft<cr>  
exmap moveRight obcommand editor:focus-right
nmap sl :moveRight<cr> 

exmap prevTab obcommand workspace:previous-tab
nmap <C-Left> :prevTab<cr> 
exmap nextTab obcommand workspace:next-tab
nmap <C-Right> :nextTab<cr> 
exmap newTab obcommand workspace:new-tab
nmap <Space>tn :newTab<cr> 

exmap toggleComments obcommand editor:toggle-comments
nmap <Space>c :toggleComments<cr> 

" Quickly remove search highlights
nmap <Space>v :nohl<cr> 

exmap appReload obcommand app:reload
nmap <Space>R :appReload<cr> 

exmap toggleCheckbox obcommand editor:toggle-checklist-status
nmap <C-Space> :toggleCheckbox<cr> 
imap <C-Space> :toggleCheckbox<cr> 

" other potential commands, execute :obcommand with dev tools open to see them all
" editor:toggle-bullet-list
" editor:toggle-numbered-list
" editor:toggle-checklist-status
" command-palette:open
" omnisearch:show-modal-infile


" Available commands: editor:save-file
" editor:follow-link
" editor:open-link-in-new-leaf
" editor:open-link-in-new-split
" editor:open-link-in-new-window
" editor:focus-top
" editor:focus-bottom
" editor:focus-left
" editor:focus-right
" workspace:toggle-pin
" workspace:split-vertical
" workspace:split-horizontal
" workspace:toggle-stacked-tabs
" workspace:edit-file-title
" workspace:copy-path
" workspace:copy-url
" workspace:undo-close-pane
" workspace:export-pdf
" editor:rename-heading
" workspace:open-in-new-window
" workspace:move-to-new-window
" workspace:next-tab
" workspace:goto-tab-1
" workspace:goto-tab-2
" workspace:goto-tab-3
" workspace:goto-tab-4
" workspace:goto-tab-5
" workspace:goto-tab-6
" workspace:goto-tab-7
" workspace:goto-tab-8
" workspace:goto-last-tab
" workspace:previous-tab
" workspace:new-tab
" app:go-back
" app:go-forward
" app:open-vault
" theme:use-dark
" theme:use-light
" theme:switch
" app:open-settings
" app:show-release-notes
" markdown:toggle-preview
" workspace:close
" workspace:close-window
" workspace:close-others
" app:delete-file
" app:toggle-left-sidebar
" app:toggle-right-sidebar
" app:toggle-default-new-pane-mode
" app:open-help
" app:reload
" app:show-debug-info
" window:toggle-always-on-top
" window:zoom-in
" window:zoom-out
" window:reset-zoom
" file-explorer:new-file
" file-explorer:new-file-in-new-pane
" open-with-default-app:open
" file-explorer:move-file
" open-with-default-app:show
" editor:open-search
" editor:open-search-replace
" editor:focus
" editor:toggle-fold
" editor:fold-all
" editor:unfold-all
" editor:fold-less
" editor:fold-more
" editor:insert-wikilink
" editor:insert-embed
" editor:insert-link
" editor:insert-tag
" editor:set-heading
" editor:set-heading-0
" editor:set-heading-1
" editor:set-heading-2
" editor:set-heading-3
" editor:set-heading-4
" editor:set-heading-5
" editor:set-heading-6
" editor:toggle-bold
" editor:toggle-italics
" editor:toggle-strikethrough
" editor:toggle-highlight
" editor:toggle-code
" editor:toggle-blockquote
" editor:toggle-comments
" editor:toggle-bullet-list
" editor:toggle-numbered-list
" editor:toggle-checklist-status
" editor:cycle-list-checklist
" editor:insert-callout
" editor:swap-line-up
" editor:swap-line-down
" editor:attach-file
" editor:delete-paragraph
" editor:toggle-spellcheck
" editor:context-menu
" file-explorer:open
" file-explorer:reveal-active-file
" global-search:open
" switcher:open
" graph:open
" graph:open-local
" graph:animate
" backlink:open
" backlink:open-backlinks
" backlink:toggle-backlinks-in-document
" canvas:new-file
" canvas:export-as-image
" note-composer:merge-file
" note-composer:split-file
" note-composer:extract-heading
" command-palette:open
" markdown-importer:open
" file-recovery:open
" omnisearch:show-modal
" omnisearch:show-modal-infile
" editor:toggle-source


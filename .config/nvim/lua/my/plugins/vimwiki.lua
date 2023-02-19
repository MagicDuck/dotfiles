return {
  { "vimwiki/vimwiki",
    enabled = false, -- we are not really using it right now so no point in enabling it
    config = function()
      vim.cmd([[
        let wiki = {}
        let wiki.path = '~/notes/'
        let wiki.syntax = 'markdown'
        let wiki.ext = '.md'
        let wiki.nested_syntaxes = {
          \ 'js': 'javascript',
          \ 'sh': 'bash',
          \ 'shell': 'bash',
          \ 'json': 'javascript',
          \ }
        " TODO: enable this or switch to different wiki thing
        " let g:vimwiki_list = [wiki]

        let g:vimwiki_key_mappings = { 'links': 0 }
        let g:vimwiki_conceal_pre = 0
        let g:vimwiki_listsyms = ' .oOx'

        " don't use vimwiki filetype
        let g:vimwiki_global_ext = 0
      ]])
    end,
  },
}

return {
  {
    'toppair/peek.nvim',
    build = 'deno task --quiet build:fast',
    lazy = true,
    ft = 'markdown',
    config = function()
      require('peek').setup({
        auto_load = true, -- whether to automatically load preview when
        -- entering another markdown buffer
        close_on_bdelete = true, -- close preview window on buffer delete
        syntax = true, -- enable syntax highlighting, affects performance
        theme = 'light', -- 'dark' or 'light'
        update_on_change = true,
        app = 'webview', -- 'webview', 'browser', string or a table of strings
        -- relevant if update_on_change is true
        throttle_at = 200000, -- start throttling when file exceeds this
        -- amount of bytes in size
        throttle_time = 'auto', -- minimum amount of time in milliseconds
        -- that has to pass before starting new render
      })

      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end,
  },
  {
    'vimwiki/vimwiki',
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
  {
    'ekickx/clipboard-image.nvim',
    lazy = true,
    ft = 'markdown',
    enabled = false,
  },
}

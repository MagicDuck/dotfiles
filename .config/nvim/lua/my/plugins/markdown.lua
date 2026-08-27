return {
  {
    'toppair/peek.nvim',
    build = 'deno task --quiet build:fast',
    event = { 'VeryLazy' },
    lazy = true,
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
    'HakonHarnes/img-clip.nvim',
    ft = 'markdown',
    opts = {
      default = {
        process_cmd = 'convert - -set gamma 0.4545 -',
      },
    },
  },

  -- {
  --   'MeanderingProgrammer/render-markdown.nvim',
  --   dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  --   ---@module 'render-markdown'
  --   ---@type render.md.UserConfig
  --   opts = {
  --     render_modes = { 'n', 'c', 't', 'i' },
  --     code = {
  --       -- conceal_delimiters = false,
  --       -- language = false,
  --       -- border = 'none',
  --
  --       border = 'thin',
  --     },
  --   },
  -- },

  {
    'jakewvincent/mkdnflow.nvim',
    config = function()
      require('mkdnflow').setup({
        mappings = {
          MkdnEnter = { { 'n', 'v' }, '<CR>' },
          MkdnGoBack = { 'n', '<BS>' },
          MkdnGoForward = { 'n', '<Del>' },
          MkdnMoveSource = { 'n', '<F2>' },
          MkdnNextLink = { 'n', '<Tab>' },
          MkdnPrevLink = { 'n', '<S-Tab>' },
          MkdnFollowLink = false,
          MkdnDestroyLink = { 'n', '<M-CR>' },
          MkdnTagSpan = { 'v', '<M-CR>' },
          MkdnYankAnchorLink = { 'n', 'yaa' },
          MkdnYankFileAnchorLink = { 'n', 'yfa' },
          MkdnNextHeading = { 'n', ']]' },
          MkdnPrevHeading = { 'n', '[[' },
          MkdnNextHeadingSame = { 'n', '][' },
          MkdnPrevHeadingSame = { 'n', '[]' },
          MkdnIncreaseHeading = { { 'n', 'v' }, '+' },
          MkdnDecreaseHeading = { { 'n', 'v' }, '-' },
          MkdnIncreaseHeadingOp = { { 'n', 'v' }, 'g+' },
          MkdnDecreaseHeadingOp = { { 'n', 'v' }, 'g-' },
          MkdnToggleToDo = { { 'n', 'v' }, '<C-Space>' },
          MkdnNewListItem = false,
          MkdnNewListItemBelowInsert = { 'n', 'o' },
          MkdnNewListItemAboveInsert = { 'n', 'O' },
          MkdnExtendList = false,
          MkdnUpdateNumbering = { 'n', '<localleader>nn' },
          MkdnTableNextCell = { 'i', '<Tab>' },
          MkdnTablePrevCell = { 'i', '<S-Tab>' },
          MkdnTableNextRow = false,
          MkdnTablePrevRow = { 'i', '<M-CR>' },
          MkdnTableNewRowBelow = { 'n', '<localleader>ir' },
          MkdnTableNewRowAbove = { 'n', '<localleader>iR' },
          MkdnTableNewColAfter = { 'n', '<localleader>ic' },
          MkdnTableNewColBefore = { 'n', '<localleader>iC' },
          MkdnTableDeleteRow = { 'n', '<localleader>dr' },
          MkdnTableDeleteCol = { 'n', '<localleader>dc' },
          MkdnFoldSection = { 'n', '<localleader>f' },
          MkdnUnfoldSection = { 'n', '<localleader>F' },
          MkdnTab = false,
          MkdnSTab = false,
          MkdnIndentListItem = { 'i', '<C-t>' },
          MkdnDedentListItem = { 'i', '<C-d>' },
          MkdnCreateLink = false,
          MkdnCreateLinkFromClipboard = { { 'n', 'v' }, '<localleader>p' },
        },
        links = {
          style = 'markdown',
          compact = true,
          conceal = true,
          transform_on_create = function(text)
            text = text:gsub('[ /]', '_')
            -- text = text:lower()
            -- text = os.date('%Y-%m-%d_') .. text
            return text
          end,
        },
        to_do = {
          -- highlight = false,
          -- statuses = {
          --   not_started = { marker = ' '},
          --   -- in_progress = { marker = '-' },
          --   complete = { marker = { 'X', 'x' }},
          -- },
          -- status_order = { 'not_started', 'in_progress', 'complete' },
          status_order = { 'not_started', 'complete' },
          status_propagation = { up = true, down = true },
          sort = {
            on_status_change = true,
            recursive = false,
            cursor_behavior = { track = true },
          },
        },
      })
    end,
  },

  -- {
  --   'vimwiki/vimwiki',
  --   config = function()
  --     vim.cmd([[
  --       let wiki = {}
  --       let wiki.path = '~/notes/'
  --       let wiki.syntax = 'markdown'
  --       let wiki.ext = '.md'
  --       let wiki.nested_syntaxes = {
  --         \ 'js': 'javascript',
  --         \ 'sh': 'bash',
  --         \ 'shell': 'bash',
  --         \ 'json': 'javascript',
  --         \ }
  --       " TODO: enable this or switch to different wiki thing
  --       " let g:vimwiki_list = [wiki]
  --
  --       let g:vimwiki_key_mappings = { 'links': 0 }
  --       let g:vimwiki_conceal_pre = 0
  --       let g:vimwiki_listsyms = ' .oOx'
  --
  --       " don't use vimwiki filetype
  --       let g:vimwiki_global_ext = 0
  --     ]])
  --   end,
  -- },
  -- {
  --   'ekickx/clipboard-image.nvim',
  --   lazy = true,
  --   ft = 'markdown',
  -- },
}

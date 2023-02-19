return {
  { "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup {
        render = 'background', -- 'background' or 'foreground' or 'first_column'
        enable_named_colors = false,
        enable_tailwind = false
      }
    end
  },
  { "ggandor/leap.nvim" },
  { 'echasnovski/mini.comment',
    version = '*',
    config = function()
      require('mini.comment').setup(
        {
          -- Module mappings. Use `''` (empty string) to disable one.
          mappings = {
            -- Toggle comment (like `gcip` - comment inner paragraph) for both
            -- Normal and Visual modes
            comment = '<leader>c',

            -- Toggle comment on current line
            comment_line = '<leader>c',

            -- Define 'comment' textobject (like `dgc` - delete whole comment block)
            textobject = 'ic',
          },
        }
      )
    end
  },
}

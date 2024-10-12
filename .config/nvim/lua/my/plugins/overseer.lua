return {
  {
    'stevearc/overseer.nvim',
    lazy = true,
    event = { 'VimEnter' },
    config = function()
      require('overseer').setup({
        templates = {
          'builtin',
          'my.tsc',
        },
      })
    end,
  },
}

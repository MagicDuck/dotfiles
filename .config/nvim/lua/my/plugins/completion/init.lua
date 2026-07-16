local is_linux = vim.fn.has('linux') == 1

return {
  {
    'chrisgrieser/nvim-scissors',
    opts = {
      snippetDir = vim.fn.stdpath('config') .. '/snippets',
      editSnippetPopup = {
        keymaps = {
          deleteSnippet = is_linux and '<c-bs>' or '<a-bs>',
          showHelp = '?',
        },
      },
    },
  },
  require('my.plugins.completion.blink'),
}

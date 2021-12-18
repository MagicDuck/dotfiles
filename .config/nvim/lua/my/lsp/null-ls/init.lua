local null_ls = require("null-ls")
local attach = require("my/lsp/attach")
local h = require("null-ls.helpers")

local luafmt = {
  method = null_ls.methods.FORMATTING,
  filetypes = {"lua"},
  name = "luafmt",
  generator = require("null-ls.helpers").formatter_factory(
    {
      command = "luafmt",
      args = {"--stdin", "--line-width", "80", "--indent-count", "2"},
      format = "raw",
      to_stdin = true
    }
  )
}

null_ls.setup(
  {
    sources = {
      null_ls.builtins.diagnostics.stylelint.with {
        only_local = "node_modules/.bin"
      },
      null_ls.builtins.diagnostics.eslint_d.with {},
      null_ls.builtins.formatting.eslint_d.with {},
      null_ls.builtins.code_actions.eslint_d.with {},
      null_ls.builtins.formatting.prettier.with {
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "markdown",
          "vimwiki"
        },
        only_local = "node_modules/.bin"
      },
      luafmt
    },
    on_attach = attach.global_on_attach,
    on_init = function()
      -- make sure eslint server still works, sometimes it dies for no reason
      os.execute("eslint_d restart")
    end
  }
)

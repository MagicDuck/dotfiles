local lspconfig = require('lspconfig')
local attach = require('my/plugins/lsp/attach')

-- Directory prefix of all package directories
local package_prefix = vim.fn.expand((vim.env.XDG_DATA_HOME or '~/.local/share') .. '/nvim')

-- Predicate which is only true for paths that belong to a package and have Lua
-- modules.
local function is_package_path(path)
  if package_prefix ~= string.sub(path, 1, #package_prefix) then
    return false
  end
  return vim.fn.isdirectory(path .. '/lua') ~= 0
end

lspconfig.lua_ls.setup({
  capabilities = attach.global_capabilities,
  on_attach = attach.global_on_attach,
  settings = {
    Lua = {
      format = {
        enable = false,
        defaultConfig = {
          indent_style = 'space',
          indent_size = '2',
          -- see: https://github.com/LuaLS/lua-language-server/issues/1068
          continuation_indent = '2',
        },
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'hs',
          'spoon',
          'P',
          'ReloadPackage',
          'ReloadFunc',
          'my',
          'use',
          'describe',
          'it',
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
      completion = {
        callSnippet = 'Both',
      },
      -- neodev takes care of those
      -- runtime = {
      --   -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      --   version = 'LuaJIT',
      --   path = {
      --     'lua/?.lua',
      --     'lua/?/init.lua',
      --   },
      --   pathStrict = true,
      -- },
      -- workspace = {
      --   library = vim.fn.filter(vim.api.nvim_get_runtime_file('', true), is_package_path)
      --   -- Make the server aware of Neovim runtime files
      --   -- library = vim.api.nvim_get_runtime_file("", true),
      --   -- checkThirdParty = false,
      --   -- useGitIgnore = false,
      --   -- ignoreSubmodules = false
      -- },
    },
  },
})

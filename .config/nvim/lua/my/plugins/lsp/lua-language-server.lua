local attach = require('my/plugins/lsp/attach')

--- See `lua-language-server`'s [documentation](https://luals.github.io/wiki/settings/) for an explanation of the fields
--- * [Lua.runtime.path](https://luals.github.io/wiki/settings/#runtimepath)
--- * [Lua.workspace.library](https://luals.github.io/wiki/settings/#workspacelibrary)
vim.lsp.config('lua_ls', {
  capabilities = attach.global_capabilities,
  on_attach = attach.global_on_attach,
  on_init = function(client)
    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      format = {
        enable = false,
      },
      completion = {
        callSnippet = 'Both',
      },
    })

    -- config below only applies when there is no .luarc.json
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      local is_nvim_config = path == vim.fn.stdpath('config')
      if not is_nvim_config and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    })
  end,
})

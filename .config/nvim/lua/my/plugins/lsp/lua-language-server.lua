local lspconfig = require('lspconfig')
local attach = require('my/plugins/lsp/attach')

local plugins_dir = vim.fn.stdpath('data') .. '/lazy'

--- See `lua-language-server`'s [documentation](https://luals.github.io/wiki/settings/) for an explanation of the fields
--- * [Lua.runtime.path](https://luals.github.io/wiki/settings/#runtimepath)
--- * [Lua.workspace.library](https://luals.github.io/wiki/settings/#workspacelibrary)
lspconfig.lua_ls.setup({
  capabilities = attach.global_capabilities,
  on_attach = attach.global_on_attach,
  on_init = function(client)
    local is_nvim_config = false
    -- config below only applies when there is no .luarc.json
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      is_nvim_config = path == vim.fn.stdpath('config')
      if not is_nvim_config and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
        return
      end
    end

    -- TODO (sbadragan): might have to switch back to lazydev...
    -- loading workspace is very slow
    -- unless we can use the new language server
    local library = {
      vim.env.VIMRUNTIME,
      plugins_dir .. '/luvit-types/library', -- vim.uv.*
      -- plugins_dir .. '/busted-types/library',
      -- plugins_dir .. '/luassert-types/library',
      '${3rd}/luassert/library',
      '${3rd}/busted/library',
    }
    if is_nvim_config then
      for name, type in vim.fs.dir(plugins_dir) do
        local dir = plugins_dir .. '/' .. name
        if type == 'directory' and vim.uv.fs_stat(dir .. '/lua') then
          table.insert(library, dir)
        end
      end
      for name, type in vim.fs.dir('/opt/repos') do
        local dir = '/opt/repos/' .. name
        if type == 'directory' and vim.uv.fs_stat(name .. '/lua') then
          table.insert(library, dir)
        end
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = library,
      },
    })
  end,
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
        -- Get the language server to recognize some globals
        globals = {
          -- TODO (sbadragan): those should be defined in .luarc.json
          -- for the places that use them
          'hs',
          'spoon',
          'P',
          'ReloadPackage',
          'ReloadFunc',
          'my',
          'use',
          -- 'describe',
          -- 'it',
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
      completion = {
        callSnippet = 'Both',
      },
    },
  },
})

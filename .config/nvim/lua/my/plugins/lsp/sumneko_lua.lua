local lspconfig = require("lspconfig")
local attach = require("my/plugins/lsp/attach")

-- figure out which os we are on
-- local system_name
-- if vim.fn.has("mac") == 1 then
--   system_name = "macOS"
-- elseif vim.fn.has("unix") == 1 then
--   system_name = "Linux"
-- elseif vim.fn.has("win32") == 1 then
--   system_name = "Windows"
-- else
--   print("Unsupported system for sumneko")
-- end

-- set the path to the sumneko installation
-- local sumneko_root_path = vim.fn.expand("~/lua-language-server")
-- local sumneko_binary =
--   sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup {
  -- cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          "vim",
          "hs",
          "spoon",
          "P",
          "ReloadPackage",
          "ReloadFunc",
          "my",
          "use"
        }
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
      -- workspace = {
      --   -- Make the server aware of Neovim runtime files
      --   library = {
      --     [vim.fn.expand("$VIMRUNTIME/lua")] = true,
      --     [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
      --   }
      -- }

      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false
      }
    }
  },
  capabilities = attach.global_capabilities,
  on_attach = attach.global_on_attach,
  -- on_init = function(client)
  --   -- This makes sure it's not used for formatting (prefer standalone formatter)
  --   client.server_capabilities.documentFormattingProvider = false
  -- end,
}

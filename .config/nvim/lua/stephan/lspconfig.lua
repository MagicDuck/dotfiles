-- command for install
-- yarn global add eslint_d typescript typescript-language-server
-- brew install efm-langserver

-- define signs
vim.fn.sign_define("LspDiagnosticsSignHint", { text="", texthl="LspDiagnosticsSignHint" })
vim.fn.sign_define("LspDiagnosticsSignInformation", { text="", texthl="LspDiagnosticsSignHint" })
vim.fn.sign_define("LspDiagnosticsSignWarning", { text="", texthl="LspDiagnosticsSignWarning" })
vim.fn.sign_define("LspDiagnosticsSignError", { text="✘", texthl="LspDiagnosticsSignError" })

-- configure lsp servers
local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  -- TODO: mapping need some rethinking
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>dl', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>dc', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  -- if client.resolved_capabilities.document_formatting then
  --   buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  -- elseif client.resolved_capabilities.document_range_formatting then
  --   buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  -- end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#f0e2f9
      hi LspReferenceText cterm=bold ctermbg=red guibg=#f0e2f9
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#f0e2f9
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- vimls
lspconfig["vimls"].setup { on_attach = on_attach }

-- tsserver
-- Tsserver setup
lspconfig.tsserver.setup {
    root_dir = lspconfig.util.root_pattern("jsconfig.json", "tsconfig.json", "package.json", ".git"),
    on_attach = function(client, bufnr)
        -- This makes sure tsserver is not used for formatting (I prefer prettier)
        client.resolved_capabilities.document_formatting = false

        on_attach(client, bufnr)
    end,
    settings = {documentFormatting = false}
}

-- lua lsp
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation
local sumneko_root_path = vim.fn.expand('~/lua-language-server')
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
lspconfig.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim', 'hs', 'spoon'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
  on_attach = on_attach
}

-- linting
-- lspconfig.diagnosticls.setup {
--   filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact"},
--   init_options = {
--     filetypes = {
--       javascript = "eslint",
--       typescript = "eslint",
--       javascriptreact = "eslint",
--       typescriptreact = "eslint"
--     },
--     linters = {
--       eslint = {
--         sourceName = "eslint",
--         command = "./node_modules/.bin/eslint",
--         rootPatterns = {
--           ".eslitrc.js",
--           "package.json"
--         },
--         debounce = 100,
--         args = {
--           "--cache",
--           "--stdin",
--           "--stdin-filename",
--           "%filepath",
--           "--format",
--           "json"
--         },
--         parseJson = {
--           errorsRoot = "[0].messages",
--           line = "line",
--           column = "column",
--           endLine = "endLine",
--           endColumn = "endColumn",
--           message = "${message} [${ruleId}]",
--           security = "severity"
--         },
--         securities = {
--           [2] = "error",
--           [1] = "warning"
--         }
--       }
--     }
--   }
-- }


-- local eslint = {
--   lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
--   lintStdin = true,
--   lintFormats = {"%f:%l:%c: %m"},
--   lintIgnoreExitCode = true,
--   -- formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
--   -- formatStdin = true
--   formatCommand = "./node_modules/.bin/prettier"
-- }

-- local eslint = {
--   lintCommand = './node_modules/.bin/eslint -f compact --stdin',
--   lintStdin = true,
--   lintFormats = {'%f: line %l, col %c, %trror - %m', '%f: line %l, col %c, %tarning - %m'},
--   lintIgnoreExitCode = true,
--   -- formatCommand = './node_modules/.bin/prettier-eslint --stdin --single-quote --print-width 120',
--   -- formatStdin = true,
-- }


-- lspconfig.efm.setup {
--   on_attach = function(client)
--     client.resolved_capabilities.document_formatting = true
--     client.resolved_capabilities.goto_definition = false
--   end,
--   root_dir = lspconfig.util.root_pattern('.eslintrc.js', '.eslintrc.json'),
--   settings = {
--     languages = {
--       javascript = {eslint},
--       javascriptreact = {eslint},
--       ["javascript.jsx"] = {eslint},
--       typescript = {eslint},
--       ["typescript.tsx"] = {eslint},
--       typescriptreact = {eslint}
--     }
--   },
--   filetypes = {
--     "javascript",
--     "javascriptreact",
--     "javascript.jsx",
--     "typescript",
--     "typescript.tsx",
--     "typescriptreact"
--   },
-- }

-- Formatting via efm
local prettier = {
  formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}",
  formatStdin = true
}

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
}

-- TODO stylelint

local languages = {
    -- lua = {luafmt},
    typescript = {prettier, eslint},
    javascript = {prettier, eslint},
    typescriptreact = {prettier, eslint},
    javascriptreact = {prettier, eslint},
    yaml = {prettier},
    json = {prettier},
    html = {prettier},
    -- scss = {prettier},
    -- css = {prettier},
    markdown = {prettier}
}

lspconfig.efm.setup {
  root_dir = lspconfig.util.root_pattern('.eslintrc.js', '.eslintrc.json', '.prettierrc'),
    filetypes = vim.tbl_keys(languages),
    init_options = {documentFormatting = true, codeAction = true},
    settings = {languages = languages, log_level = 1, log_file = '~/efm.log'},
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = true
      client.resolved_capabilities.goto_definition = false

      if client.resolved_capabilities.document_formatting then
        vim.cmd [[augroup lsp_formatting]]
        vim.cmd [[autocmd!]]
        vim.cmd [[autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync({}, 1000)]]
        vim.cmd [[augroup END]]
      end
    end,
}

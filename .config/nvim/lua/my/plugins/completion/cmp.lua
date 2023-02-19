local cmp = require("cmp")
local lspkind = require("lspkind")
vim.o.completeopt = "menu,menuone,noselect"

-- Don't show the dumb matching stuff.
vim.opt.shortmess:append("c")

require("cmp_nvim_lsp").setup() -- not sure why this does not auto-exec
cmp.setup({
  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
      or require("cmp_dap").is_dap_buffer()
  end,
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = {
    -- ["<Down>"] = cmp.mapping.select_next_item(
    --   {behavior = cmp.SelectBehavior.Select}
    -- ),
    -- ["<Up>"] = cmp.mapping.select_prev_item(
    --   {behavior = cmp.SelectBehavior.Select}
    -- ),
    ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<PageDown>"] = cmp.mapping(cmp.mapping.scroll_docs( -4), { "i", "c" }),
    ["<PageUp>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "path" },
    {
      name = "buffer",
      option = {
        -- look for stuff in all buffers
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
        -- alternative: visible buffers only
        -- get_bufnrs = function()
        --   local bufs = {}
        --   for _, win in ipairs(vim.api.nvim_list_wins()) do
        --     bufs[vim.api.nvim_win_get_buf(win)] = true
        --   end
        --   return vim.tbl_keys(bufs)
        -- end
      },
    },
    { name = "luasnip" }, -- For luasnip users.
  }),
  formatting = {
    -- Youtube: How to set up nice formatting for your sources.
    format = lspkind.cmp_format({
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
      },
    }),
  },
  ["window.documentation"] = cmp.config.window.bordered(),
  preselect = cmp.PreselectMode.None,
  completion = {
    keyword_length = 3,
  },
})

-- show completion in dap
require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
  sources = {
    { name = "dap" },
  },
})

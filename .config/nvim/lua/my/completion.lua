local cmp = require("cmp")
local lspkind = require("lspkind")
vim.o.completeopt = "menu,menuone,noselect"

-- TODO (sbadragan): not sure if we need this?
-- Don't show the dumb matching stuff.
vim.opt.shortmess:append "c"

require("cmp_nvim_lsp").setup() -- not sure why this does not auto-exec
cmp.setup(
  {
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end
    },
    mapping = {
      ["<Down>"] = cmp.mapping.select_next_item(
        {behavior = cmp.SelectBehavior.Select}
      ),
      ["<Up>"] = cmp.mapping.select_prev_item(
        {behavior = cmp.SelectBehavior.Select}
      ),
      ["<C-j>"] = cmp.mapping.select_next_item(
        {behavior = cmp.SelectBehavior.Insert}
      ),
      ["<C-k>"] = cmp.mapping.select_prev_item(
        {behavior = cmp.SelectBehavior.Insert}
      ),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
      ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ["<C-e>"] = cmp.mapping(
        {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close()
        }
      ),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm({select = false})
    },
    sources = cmp.config.sources(
      {
        {name = "nvim_lua"},
        {name = "nvim_lsp"},
        {name = "path"},
        {
          name = "buffer",
          option = {
            -- look for stuff in all buffers
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end
            -- alternative: visible buffers only
            -- get_bufnrs = function()
            --   local bufs = {}
            --   for _, win in ipairs(vim.api.nvim_list_wins()) do
            --     bufs[vim.api.nvim_win_get_buf(win)] = true
            --   end
            --   return vim.tbl_keys(bufs)
            -- end
          }
        },
        {name = "ultisnips"} -- For ultisnips users.
      }
    ),
    formatting = {
      -- Youtube: How to set up nice formatting for your sources.
      format = lspkind.cmp_format {
        with_text = true,
        menu = {
          buffer = "[buf]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[api]",
          path = "[path]",
          ultisnips = "[snip]"
        }
      }
    },
    documentation = true,
    preselect = cmp.PreselectMode.None,
    completion = {
      keyword_length = 3
    }
  }
)
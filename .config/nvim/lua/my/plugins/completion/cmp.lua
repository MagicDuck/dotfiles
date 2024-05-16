local cmp = require("cmp")
local lspkind = require("lspkind")
-- vim.o.completeopt = "menu,menuone"
-- see https://github.com/hrsh7th/nvim-cmp/issues/598
vim.o.lazyredraw = false

-- Don't show the dumb matching stuff.
vim.opt.shortmess:append("c")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function doWhenCmpVisible(fn, timeout, poll_interval)
  if cmp.visible() and #cmp.get_entries() > 0 then
    fn()
    return
  end

  if timeout <= 0 then
    return
  end

  vim.defer_fn(function()
    doWhenCmpVisible(fn, timeout - poll_interval, poll_interval)
  end, poll_interval)
end

local function completeAndInsertFirstMatch()
  cmp.complete()
  -- cmp.select_next_item()
  doWhenCmpVisible(function()
    cmp.select_next_item()
  end, 1100, 10)
end

require("cmp_nvim_lsp").setup() -- not sure why this does not auto-exec
cmp.setup({
  enabled = function()
    return (not require("cmp_dap").is_dap_buffer()) and vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
    -- return not require("cmp_dap").is_dap_buffer() and not vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
  end,
  performance = {
    -- debounce = 500,
    -- throttle = 550,
    -- fetching_timeout = 1000, -- to account for slow tsserver
    fetching_timeout = 100,
    max_view_entries = 50,
  },
  view = {
    -- update this to change how menu displays
    -- entries = { name = 'wildmenu' }
  },
  confirmation = {
    -- disable commit characters
    -- get_commit_characters = function(commit_characters)
    --   return {}
    -- end
  },
  experimental = {
    ghost_text = true
  },
  -- changed recently
  preselect = cmp.PreselectMode.Item,
  completion = {
    keyword_length = 3,
    autocomplete = {
      cmp.TriggerEvent.TextChanged,
    },
    completeopt = 'menu,menuone',
  },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<tab>"] = cmp.mapping.confirm(),
    -- ["<c-y>"] = cmp.mapping.confirm({ select = true }),
    ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    -- ["<Tab>"] = cmp.mapping({
    --   c = function()
    --     if cmp.visible() then
    --       cmp.select_next_item()
    --     else
    --       completeAndInsertFirstMatch()
    --     end
    --   end,
    --   i = function(fallback)
    --     if cmp.visible() then
    --       cmp.select_next_item()
    --       -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
    --       -- they way you will only jump inside the snippet region
    --       -- elseif require('luasnip').expand_or_locally_jumpable() then
    --       --   require('luasnip').expand_or_jump()
    --     elseif has_words_before() then
    --       completeAndInsertFirstMatch()
    --     else
    --       fallback()
    --     end
    --   end,
    --   s = function(fallback)
    --     if cmp.visible() then
    --       cmp.select_next_item()
    --       -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
    --       -- they way you will only jump inside the snippet region
    --       -- elseif require('luasnip').expand_or_locally_jumpable() then
    --       --   require('luasnip').expand_or_jump()
    --     elseif has_words_before() then
    --       completeAndInsertFirstMatch()
    --     else
    --       fallback()
    --     end
    --   end
    -- }),
    --
    -- ["<S-Tab>"] = cmp.mapping({
    --   c = function(fallback)
    --     if cmp.visible() then
    --       cmp.select_prev_item()
    --     else
    --       fallback()
    --     end
    --   end,
    --   i = function(fallback)
    --     if cmp.visible() then
    --       cmp.select_prev_item()
    --       -- elseif require('luasnip').jumpable( -1) then
    --       --   require('luasnip').jump( -1)
    --     else
    --       fallback()
    --     end
    --   end,
    --   s = function(fallback)
    --     if cmp.visible() then
    --       cmp.select_prev_item()
    --       -- elseif require('luasnip').jumpable( -1) then
    --       --   require('luasnip').jump( -1)
    --     else
    --       fallback()
    --     end
    --   end
    -- }),

    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    -- ["<C-tab>"] = cmp.mapping.confirm({ select = true }),

    ["<C-space>"] = cmp.mapping.complete({
      config = {
        view = {
          entries = { name = 'custom' }
        },
      }
    }),
    ["<PageUp>"] = cmp.mapping.scroll_docs(-4),
    ["<PageDown>"] = cmp.mapping.scroll_docs(4),
    -- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping({
      i = cmp.abort(),
      c = cmp.close(),
    }),
  },
  sources = cmp.config.sources({
    -- { name = "nvim_lua" },
    {
      name = "nvim_lsp",
      -- priority = 100,
      max_item_count = 100,
      -- group_index = 1
    },
    { name = "path" },
    { name = "luasnip" }, -- For luasnip users.
    {
      name = "buffer",
      -- group_index = 2,
      max_item_count = 20,
      -- priority = 10,
      option = {
        -- look for stuff in all buffers
        -- get_bufnrs = function()
        --   return vim.api.nvim_list_bufs()
        -- end,
        -- alternative: visible buffers only
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
            if byte_size <= 1024 * 1024 then -- 1 Megabyte max
              bufs[buf] = true
            end
          end
          return vim.tbl_keys(bufs)
        end
      },
    },
  }),
  formatting = {
    -- Youtube: How to set up nice formatting for your sources.
    format = lspkind.cmp_format({
      with_text = true,
      menu = {
        path = "[path]",
        luasnip = "[snip]",
        buffer = "[buf]",
        nvim_lua = "[api]",
        nvim_lsp = "[LSP]",
      },
    }),
  },
  window = {
    completion = {
      border = "rounded",
      -- winhighlight = "Normal:CmpNormal",
    },
    documentation = {
      border = "rounded",
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None,Error:None",
    },
  },
})

-- show completion in dap
require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
  sources = {
    { name = "dap" },
  },
})

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
  -- completion = { autocomplete = false },
  sources = {
    { name = 'buffer' }
    -- { name = 'buffer', option = { keyword_pattern = [=[[^[:blank:]].*]=] } }
  }
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  -- completion = { autocomplete = false },
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- autopairs, does not seem to work atm
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- cmp.event:on(
--   'confirm_done',
--   cmp_autopairs.on_confirm_done()
-- )

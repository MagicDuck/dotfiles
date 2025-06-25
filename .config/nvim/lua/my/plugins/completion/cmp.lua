local cmp = require('cmp')
local lspkind = require('lspkind')
-- vim.o.completeopt = "menu,menuone"
-- see https://github.com/hrsh7th/nvim-cmp/issues/598
-- vim.o.lazyredraw = false

-- Don't show the dumb matching stuff.
vim.opt.shortmess:append('c')

require('cmp_nvim_lsp').setup() -- not sure why this does not auto-exec
cmp.setup({
  enabled = function()
    if require('cmp_dap').is_dap_buffer() then
      return false
    end

    if vim.bo.buftype == 'prompt' then
      return false
    end

    if vim.bo.filetype == 'namu_prompt' then
      return false
    end

    return true
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
  -- experimental = {
  --   ghost_text = true
  -- },
  -- changed recently
  -- preselect = cmp.PreselectMode.Item,
  preselect = cmp.PreselectMode.None,
  completion = {
    -- keyword_length = 3,
    autocomplete = {
      cmp.TriggerEvent.TextChanged,
    },
    -- change this and preselect if you want auto-selecting the first option to happen
    -- completeopt = 'menu,menuone',
    completeopt = 'menu,menuone,noselect',
  },
  -- Enable luasnip to handle snippet expansion
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<tab>'] = cmp.mapping.confirm({ behaviour = cmp.ConfirmBehavior.Insert, select = true }),
    -- ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    -- ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<PageUp>'] = cmp.mapping.scroll_docs(-4),
    ['<PageDown>'] = cmp.mapping.scroll_docs(4),
    -- ['<up>'] = { i = false },
    -- ['<down>'] = { i = false },
  }),
  sources = cmp.config.sources({
    {
      name = 'lazydev',
      group_index = 0, -- set group index to 0 to skip loading LuaLS completions
    },
    {
      name = 'nvim_lsp',
      -- priority = 100,
      max_item_count = 100,
      -- group_index = 1
    },
    { name = 'path' },
    { name = 'luasnip' }, -- For luasnip users.
    {
      name = 'buffer',
      -- group_index = 2,
      keyword_length = 3,
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
        end,
      },
    },
  }),
  formatting = {
    -- Youtube: How to set up nice formatting for your sources.
    format = lspkind.cmp_format({
      with_text = true,
      menu = {
        path = '[path]',
        luasnip = '[snip]',
        buffer = '[buf]',
        nvim_lua = '[api]',
        nvim_lsp = '[LSP]',
      },
    }),
  },
  window = {
    completion = {
      border = 'rounded',
      -- winhighlight = "Normal:CmpNormal",
    },
    documentation = {
      border = 'rounded',
      winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None,Error:None',
    },
  },
})

-- show completion in dap
require('cmp').setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
  sources = {
    { name = 'dap' },
  },
})

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
  completion = {
    autocomplete = false,
    completeopt = 'menu,menuone',
  },
  mapping = cmp.mapping.preset.cmdline({
    ['<tab>'] = {
      c = function()
        if cmp.visible() then
          cmp.confirm({ behaviour = cmp.ConfirmBehavior.Insert, select = true })
        else
          cmp.complete()
        end
      end,
    },
  }),
  sources = {
    { name = 'buffer' },
  },
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  completion = {
    autocomplete = false,
    completeopt = 'menu,menuone',
  },
  mapping = cmp.mapping.preset.cmdline({
    ['<tab>'] = {
      c = function()
        if cmp.visible() then
          cmp.confirm({ behaviour = cmp.ConfirmBehavior.Insert, select = true })
        else
          cmp.complete()
        end
      end,
    },
    ['<down>'] = {
      c = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
    },
    ['<up>'] = {
      c = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end,
    },
  }),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
  matching = { disallow_symbol_nonprefix_matching = false },
})

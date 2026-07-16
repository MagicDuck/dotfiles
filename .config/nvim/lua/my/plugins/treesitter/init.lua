return {
  {
    'nvim-treesitter/nvim-treesitter',
    name = 'treesitter',
    -- version = false,
    branch = 'main',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-context' },
    },
    config = function()
      -- replicate `ensure_installed`, runs asynchronously, skips existing languages
      require('nvim-treesitter').install({})

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter.setup', {}),
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          local lang = vim.treesitter.language.get_lang(ft)

          if not vim.treesitter.language.add(lang) then
            local available = vim.g.ts_available or require('nvim-treesitter').get_available()
            if not vim.g.ts_available then
              vim.g.ts_available = available
            end
            if vim.tbl_contains(available, lang) then
              require('nvim-treesitter').install(lang)
            end
          else
            vim.treesitter.start(args.buf, lang)
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            -- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            -- vim.wo[0][0].foldmethod = "expr"
          end
        end,
      })

      -- context
      require('treesitter-context').setup({
        max_lines = 5,
      })
    end,
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      'treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
}

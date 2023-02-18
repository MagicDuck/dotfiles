-- TODO (sbadragan): copied from packer plugins, gradually move those to separate files

return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false, -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      -- TODO (sbadragan): move this into config/theme or something?? or maybe plugins dir
      require('my/nightfox')
    end,
  },

  -- Other plugins
  -- TODO (sbadragan): add this as a dependency where necessary?
  { "nvim-lua/plenary.nvim" },

  { "b3nj5m1n/kommentary" },
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  { "nvim-treesitter/nvim-treesitter",             build = ":TSUpdate",             name = "treesitter" },
  { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "treesitter" } },
  { "nvim-treesitter/playground",                  dependencies = { "treesitter" }, build = ":TSInstall query" },
  { "windwp/nvim-ts-autotag" },
  { "p00f/nvim-ts-rainbow" },
  { "junegunn/vim-easy-align" },

  -- git
  -- TODO (sbadragan): might not be needed
  -- { "nvim-lua/popup.nvim" },
  { "nvim-telescope/telescope.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim",    build = "make" },
  { "fhill2/telescope-ultisnips.nvim" },
  { "nvim-telescope/telescope-fzf-writer.nvim" },
  { "nvim-telescope/telescope-ui-select.nvim" },
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  { "kshenoy/vim-signature" },
  { "brenoprata10/nvim-highlight-colors" },
  { "voldikss/vim-floaterm" },
  { "tpope/vim-surround" },
  { "ggandor/leap.nvim" },
  { "rafcamlet/nvim-luapad" },
  -- devicons
  { "nvim-tree/nvim-web-devicons" },

  { "onsails/lspkind-nvim" },
  { "neovim/nvim-lspconfig" },
  { "mfussenegger/nvim-jdtls" },

  -- completion (cmp) - seems to work well
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-nvim-lua" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/nvim-cmp" },
  { "rcarriga/cmp-dap" },
  { "quangnguyen30192/cmp-nvim-ultisnips" },

  { "jose-elias-alvarez/null-ls.nvim" },

  { "itchyny/vim-highlighturl" },
  { "moll/vim-bbye" },

  -- status line
  { "nvim-lualine/lualine.nvim" },
  { "arkav/lualine-lsp-progress" },
  { "nanozuki/tabby.nvim" },

  { "kmonad/kmonad-vim" },

  {
    "NTBBloodbath/rest.nvim",
    commit = "e5f68db73276c4d4d255f75a77bbe6eff7a476ef",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- LSP status spinner, somewhat annoying
  -- {"j-hui/fidget.nvim"},

  { "dstein64/vim-startuptime" },
  -- TODO (sbadragan): should we use folke's
  { "AmeerTaweel/todo.nvim" },

  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "jayp0521/mason-null-ls.nvim" },

  -- debugging
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui",             dependencies = { "mfussenegger/nvim-dap" } },
  { "nvim-telescope/telescope-dap.nvim" },
  { "jay-babu/mason-nvim-dap.nvim" },

  -- {"ibhagwan/fzf-lua"},
  -- {"kdheepak/lazygit.nvim"},
  { "ekickx/clipboard-image.nvim" },
  { 'toppair/peek.nvim',                run = 'deno task --quiet build:fast' }
}

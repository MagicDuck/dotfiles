-- TODO (sbadragan): copied from packer plugins, gradually move those to separate files

return {
  -- Other plugins
  -- TODO (sbadragan): add this as a dependency where necessary?
  { "nvim-lua/plenary.nvim" },

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
  { "voldikss/vim-floaterm" },
  { "tpope/vim-surround" },
  { "rafcamlet/nvim-luapad" },

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

  { "kmonad/kmonad-vim" },

  -- LSP status spinner, somewhat annoying
  -- {"j-hui/fidget.nvim"},


  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "jayp0521/mason-null-ls.nvim" },

  -- debugging
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui",                        dependencies = { "mfussenegger/nvim-dap" } },
  { "nvim-telescope/telescope-dap.nvim" },
  { "jay-babu/mason-nvim-dap.nvim" },

  -- {"ibhagwan/fzf-lua"},
  -- {"kdheepak/lazygit.nvim"},
}

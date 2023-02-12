-- bootstrap packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- configure packages
return require("packer").startup({
        function()
          -- Packer can manage itself
          use("wbthomason/packer.nvim")

          -- Colorscheme - must work with treesitter for best effect
          use("sainnhe/edge")
          use("mhartington/oceanic-next")
          use("tjdevries/colorbuddy.vim")
          use("Th3Whit3Wolf/onebuddy")
          use("Th3Whit3Wolf/one-nvim")
          use("Th3Whit3Wolf/space-nvim")
          use("sainnhe/gruvbox-material")
          use("rose-pine/neovim")
          use { "catppuccin/nvim", as = "catppuccin" }

          -- Other plugins
          use("nvim-lua/plenary.nvim")
          ---- Hmm airline is slow on large files...
          -- use "vim-airline/vim-airline"
          -- use "vim-airline/vim-airline-themes"
          use({
              "junegunn/fzf",
              run = function()
                vim.fn["fzf#install"]()
              end,
          })
          use("junegunn/fzf.vim")
          use("airblade/vim-rooter")
          use("mhinz/vim-startify")
          use("b3nj5m1n/kommentary")
          use("JoosepAlviste/nvim-ts-context-commentstring")
          -- use "easymotion/vim-easymotion"
          -- use("Raimondi/delimitMate") -- auto pair match
          -- use("maksimr/vim-jsbeautify")
          use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
          use("nvim-treesitter/nvim-treesitter-textobjects")
          use({ "nvim-treesitter/playground", run = ":TSInstall query" })
          use("windwp/nvim-ts-autotag")
          use("p00f/nvim-ts-rainbow")
          use("unblevable/quick-scope")
          use("junegunn/vim-easy-align")

          -- git
          use("tpope/vim-fugitive")
          use("shumphrey/fugitive-gitlab.vim")
          use("tommcdo/vim-fubitive")
          -- use("junkblocker/git-time-lapse") -- diffview has better functionality
          use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
          -- use("lewis6991/gitsigns.nvim") -- meh, did not really like it, does not work the gest with the diffview
          -- use("TimUntersberger/neogit") -- meh, only supports inline diffs

          use("kevinhwang91/rnvimr") -- ranger
          use("kevinhwang91/nvim-bqf") -- quickfix
          use("nvim-lua/popup.nvim")
          use("nvim-telescope/telescope.nvim")
          use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
          -- use "nvim-telescope/telescope-fzy-native.nvim" -- alternative to fzf-native
          use("fhill2/telescope-ultisnips.nvim")
          use("nvim-telescope/telescope-fzf-writer.nvim")
          use("nvim-telescope/telescope-ui-select.nvim")
          use("nvim-telescope/telescope-file-browser.nvim")
          use("nvim-telescope/telescope-live-grep-args.nvim")
          -- use("christoomey/vim-tmux-navigator")
          use("kshenoy/vim-signature")
          -- use("norcalli/nvim-colorizer.lua")
          use("brenoprata10/nvim-highlight-colors")
          use("voldikss/vim-floaterm")
          use("tpope/vim-surround")
          use("phaazon/hop.nvim") -- using leap instead
          use("ggandor/leap.nvim")
          -- use "ggandor/lightspeed.nvim"
          use("rafcamlet/nvim-luapad")
          -- devicons
          use("ryanoasis/vim-devicons")
          use("kyazdani42/nvim-web-devicons")

          -- use 'akinsho/nvim-bufferline.lua'
          -- use 'hrsh7th/vim-vsnip'
          use("onsails/lspkind-nvim")
          use("neovim/nvim-lspconfig")
          use("mfussenegger/nvim-jdtls")

          -- completion (coq) - tried and it was buggy
          -- use {"ms-jpq/coq_nvim", branch = "coq"}
          -- use {"ms-jpq/coq.artifacts", branch = "artifacts"} -- 9000 snippets
          -- use {"ms-jpq/coq.thirdparty", branch = "3p"}

          -- completion (cmp) - seems to work well
          use("hrsh7th/cmp-nvim-lsp")
          use("hrsh7th/cmp-nvim-lua")
          use("hrsh7th/cmp-buffer")
          use("hrsh7th/cmp-path")
          use("hrsh7th/cmp-cmdline")
          use("hrsh7th/nvim-cmp")
          use("rcarriga/cmp-dap")
          use("quangnguyen30192/cmp-nvim-ultisnips")

          -- alternative to diagnostic-ls: it has some issues with eslint freezing on syntax error
          use("jose-elias-alvarez/null-ls.nvim")

          -- use("glepnir/lspsaga.nvim")
          use("itchyny/vim-highlighturl")
          -- use "vitalk/vim-simple-todo"
          use("vimwiki/vimwiki")
          use("moll/vim-bbye")
          use("sirver/UltiSnips")
          use("honza/vim-snippets")
          use("tpope/vim-unimpaired")
          use("sbdchd/neoformat")

          -- status line
          -- use("NTBBloodbath/galaxyline.nvim") -- not used anymore in favor of lualine
          use("nvim-lualine/lualine.nvim")
          use("arkav/lualine-lsp-progress")
          -- use("mkitt/tabline.vim") -- simple tabs
          use("nanozuki/tabby.nvim")

          -- smooth scrolling, has some issues with screen tearing and perf
          -- use "karb94/neoscroll.nvim"

          -- use({ "puremourning/vimspector", run = ":VimspectorUpdate" })
          use("kmonad/kmonad-vim")
          -- use "wellle/targets.vim"

          -- alternative plugins
          -- auto-pairs, use instead of 'Raimondi/delimitMate'
          -- - use 'windwp/nvim-autopairs'
          -- - use 'cohama/lexima.vim'

          use({
              "NTBBloodbath/rest.nvim",
              commit = "e5f68db73276c4d4d255f75a77bbe6eff7a476ef",
              requires = { "nvim-lua/plenary.nvim" },
          })
          -- LSP status spinner, somewhat annoying
          -- use("j-hui/fidget.nvim")
          use("dstein64/vim-startuptime")
          use("AmeerTaweel/todo.nvim")

          use("williamboman/mason.nvim")
          use("williamboman/mason-lspconfig.nvim")
          use("jayp0521/mason-null-ls.nvim")

          -- debugging
          use("mfussenegger/nvim-dap")
          use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
          use("nvim-telescope/telescope-dap.nvim")
          use("jay-babu/mason-nvim-dap.nvim")

          -- use("folke/which-key.nvim")
          use("lewis6991/impatient.nvim")
          -- use("ibhagwan/fzf-lua")
          -- use("kdheepak/lazygit.nvim")

          -- Put this at the end after all plugins
          if packer_bootstrap then
            require('packer').sync()
          end
        end,
        config = {
            -- profile = {
            --   enable = true,
            --   threshold = 1, -- integer in milliseconds, plugins which load faster than this won't be shown in profile output
            -- }
        }
    })

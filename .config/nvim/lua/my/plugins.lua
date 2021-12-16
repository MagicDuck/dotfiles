-- bootstrap packer
local install_path =
  vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command(
    "!git clone https://github.com/wbthomason/packer.nvim " .. install_path
  )
  vim.api.nvim_command "packadd packer.nvim"
end

-- configure packages
return require("packer").startup(
  function()
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    -- Colorscheme - must work with treesitter for best effect
    use "sainnhe/edge"
    use "mhartington/oceanic-next"
    use "tjdevries/colorbuddy.vim"
    use "Th3Whit3Wolf/onebuddy"
    use "Th3Whit3Wolf/one-nvim"
    use "Th3Whit3Wolf/space-nvim"
    use "sainnhe/gruvbox-material"

    -- Other plugins
    ---- Hmm airline is slow on large files...
    -- use "vim-airline/vim-airline"
    -- use "vim-airline/vim-airline-themes"
    use {
      "junegunn/fzf",
      run = function()
        vim.fn["fzf#install"]()
      end
    }
    use "junegunn/fzf.vim"
    use "airblade/vim-rooter"
    use "mhinz/vim-startify"
    use "b3nj5m1n/kommentary"
    use "JoosepAlviste/nvim-ts-context-commentstring"
    -- use "easymotion/vim-easymotion"
    use "Raimondi/delimitMate"
    use "maksimr/vim-jsbeautify"
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use {"nvim-treesitter/playground", run = ":TSInstall query"}
    use "windwp/nvim-ts-autotag"
    use "p00f/nvim-ts-rainbow"
    use "unblevable/quick-scope"
    use "junegunn/vim-easy-align"
    use "tpope/vim-fugitive"
    use "tommcdo/vim-fubitive"
    use "kevinhwang91/rnvimr" -- ranger
    use "kevinhwang91/nvim-bqf" -- quickfix
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-fzy-native.nvim"
    use "nvim-telescope/telescope-fzf-writer.nvim"
    use "nvim-telescope/telescope-ui-select.nvim"
    use "christoomey/vim-tmux-navigator"
    use "kshenoy/vim-signature"
    use "norcalli/nvim-colorizer.lua"
    use "voldikss/vim-floaterm"
    use "tpope/vim-surround"
    use "phaazon/hop.nvim"
    use "rafcamlet/nvim-luapad"
    use "ryanoasis/vim-devicons"
    use "kyazdani42/nvim-web-devicons"
    -- use 'akinsho/nvim-bufferline.lua'
    -- use 'hrsh7th/vim-vsnip'
    use "onsails/lspkind-nvim"
    use "neovim/nvim-lspconfig"

    -- completion (coq) - tried and it was buggy
    -- use {"ms-jpq/coq_nvim", branch = "coq"}
    -- use {"ms-jpq/coq.artifacts", branch = "artifacts"} -- 9000 snippets
    -- use {"ms-jpq/coq.thirdparty", branch = "3p"}

    -- completion (old compe)
    -- use "hrsh7th/nvim-compe"

    -- completion (cmp) - seems to work well
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/nvim-cmp"
    use "quangnguyen30192/cmp-nvim-ultisnips"

    use "glepnir/lspsaga.nvim"
    use "itchyny/vim-highlighturl"
    -- use "vitalk/vim-simple-todo"
    use "vimwiki/vimwiki"
    use "moll/vim-bbye"
    use "sirver/UltiSnips"
    use "honza/vim-snippets"
    use "tpope/vim-unimpaired"
    use "sbdchd/neoformat"
    use {
      "glepnir/galaxyline.nvim",
      branch = "main"
    }
    use "karb94/neoscroll.nvim"

    use {"puremourning/vimspector", run = ":VimspectorUpdate"}
    use "junkblocker/git-time-lapse"
    use "mkitt/tabline.vim"
    use "kmonad/kmonad-vim"
    -- use "wellle/targets.vim"

    -- alternative plugins
    -- auto-pairs, use instead of 'Raimondi/delimitMate'
    -- - use 'windwp/nvim-autopairs'
    -- - use 'cohama/lexima.vim'
  end
)

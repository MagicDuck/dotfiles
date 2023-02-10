" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/Users/stephanbadragan/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/stephanbadragan/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/stephanbadragan/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/stephanbadragan/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/stephanbadragan/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  UltiSnips = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/UltiSnips"
  },
  ["colorbuddy.vim"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/colorbuddy.vim"
  },
  delimitMate = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/delimitMate"
  },
  edge = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/edge"
  },
  fzf = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["galaxyline.nvim"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["git-time-lapse"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/git-time-lapse"
  },
  ["gruvbox-material"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/gruvbox-material"
  },
  ["hop.nvim"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/hop.nvim"
  },
  kommentary = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  neoformat = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/neoformat"
  },
  ["neoscroll.nvim"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/neoscroll.nvim"
  },
  ["nvim-bqf"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/nvim-bqf"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-luapad"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/nvim-luapad"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["oceanic-next"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/oceanic-next"
  },
  ["one-nvim"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/one-nvim"
  },
  onebuddy = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/onebuddy"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["quick-scope"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/quick-scope"
  },
  rnvimr = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/rnvimr"
  },
  ["space-nvim"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/space-nvim"
  },
  ["tabline.vim"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/tabline.vim"
  },
  ["telescope-fzf-writer.nvim"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/telescope-fzf-writer.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-bbye"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/vim-bbye"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-floaterm"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/vim-floaterm"
  },
  ["vim-fubitive"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/vim-fubitive"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-highlighturl"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/vim-highlighturl"
  },
  ["vim-jsbeautify"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/vim-jsbeautify"
  },
  ["vim-rooter"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/vim-rooter"
  },
  ["vim-signature"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/vim-signature"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  vimspector = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/vimspector"
  },
  vimwiki = {
    loaded = true,
    path = "/Users/stephanbadragan/.local/share/nvim/site/pack/packer/start/vimwiki"
  }
}

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry

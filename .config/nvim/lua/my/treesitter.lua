local ts = require "nvim-treesitter.configs"

ts.setup {
  -- TODO swith to maintained when things don't break
  -- ensure_installed = 'maintained',
  ensure_installed = {"javascript", "typescript", "lua"},
  highlight = {
    enable = true,
    disable = {"json"},
    custom_captures = {}
  },
  playground = {
    enable = true,
    disable = {"json"},
    updatetime = 25
  },
  textobjects = {
    select = {
      enable = true,
      disable = {"json"},
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        -- Or you can define your own textobjects like this
        ["iF"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          java = "(method_declaration) @function"
        }
      }
    },
    swap = {
      enable = true,
      disable = {"json"},
      swap_previous = {
        ["<Left>s"] = "@parameter.inner"
      },
      swap_next = {
        ["<Right>s"] = "@parameter.inner"
      }
    },
    move = {
      enable = true,
      disable = {"json"},
      goto_previous_start = {
        ["<Left>j"] = "@function.outer"
      },
      goto_next_start = {
        ["<Right>j"] = "@function.outer"
      },
      goto_previous_end = {
        ["<Left>k"] = "@function.outer"
      },
      goto_next_end = {
        ["<Right>k"] = "@function.outer"
      }
    }
  },
  incremental_selection = {
    enable = true,
    disable = {"json"},
    keymaps = {
      init_selection = ",v",
      node_incremental = "<Up>",
      node_decremental = "<Down>"
      -- scope_incremental = "<Left>",
    }
  },
  indent = {
    enable = true,
    disable = {"json"}
  },
  rainbow = {
    enable = false
  },
  autotag = {
    enable = true,
    disable = {"json"}
  }
}

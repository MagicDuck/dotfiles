local ts = require "nvim-treesitter.configs"

ts.setup {
  -- TODO swith to maintained when things don't break
  -- ensure_installed = 'maintained',
  ensure_installed = {"javascript", "typescript", "lua"},
  highlight = {
    enable = true,
    custom_captures = {}
  },
  playground = {
    enable = true,
    updatetime = 25,
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>"
    }
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        -- Note: those are stored under query/<lang>/textobjects.scm
        ["af"] = "@my.function.outer",
        ["if"] = "@my.function.body",
        ["ac"] = "@call.outer",
        ["ab"] = "@my.block.outer",
        ["ib"] = "@my.block.inner",
        ["as"] = "@my.statement",
        ["ir"] = "@my.variable_decl.rhs",
        ["ia"] = "@my.args"
      }
    },
    swap = {
      enable = true,
      swap_previous = {
        ["<Left>s"] = "@parameter.inner"
      },
      swap_next = {
        ["<Right>s"] = "@parameter.inner"
      }
    },
    move = {
      enable = true,
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
    keymaps = {
      init_selection = ",v",
      node_incremental = "<Up>",
      node_decremental = "<Down>"
      -- scope_incremental = "<Left>",
    }
  },
  indent = {
    enable = true
  },
  rainbow = {
    enable = false
  },
  autotag = {
    enable = true
  },
  context_commentstring = {
    enable = true
  }
}

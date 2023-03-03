return {
  { "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    version = false,
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      { "nvim-treesitter/playground" },
      { "windwp/nvim-ts-autotag" },
    },
    config = function()
      local ts = require("nvim-treesitter.configs")

      ts.setup({
        -- ensure_installed = { "javascript", "lua", "c", "vim", "help", "query" },
        ensure_installed = "all",
        -- auto_install = true,
        ignore_install = { "comment" }, -- has some performance issues atm
        highlight = {
          enable = true,
          custom_captures = {},
        },
        disable = function(lang, buf)
          local first_line = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1]
          if first_line ~= nil and string.len(first_line) > 500 then
            -- this is probably a minified file, don't attempt to highlight
            return true
          end
          local max_filesize = 200 * 1024 -- 200 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            -- large file, don't attempt highlight
            return true
          end

          return false
        end,
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
            goto_node = "<cr>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              -- Note: those are stored under query/<lang>/textobjects.scm
              -- for query lang docs: https://tree-sitter.github.io/tree-sitter/using-parsers#pattern-matching-with-queries
              -- example to do ranges: https://github.com/nvim-treesitter/nvim-treesitter-textobjects/blob/master/queries/lua/textobjects.scm#L24-L27
              ["af"] = "@my.function.outer",
              ["if"] = "@my.function.body",
              ["ac"] = "@call.outer",
              ["ab"] = "@my.block.outer",
              ["ib"] = "@my.block.inner",
              ["as"] = "@my.statement",
              ["ir"] = "@my.variable_decl.rhs",
              ["ia"] = "@my.args",
              ["am"] = "@my.comment",
            },
          },
          swap = {
            enable = true,
            swap_previous = {
              ["<Left>s"] = "@parameter.inner",
            },
            swap_next = {
              ["<Right>s"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            goto_previous_start = {
              ["<Left>j"] = "@function.outer",
            },
            goto_next_start = {
              ["<Right>j"] = "@function.outer",
            },
            goto_previous_end = {
              ["<Left>k"] = "@function.outer",
            },
            goto_next_end = {
              ["<Right>k"] = "@function.outer",
            },
          },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "vv",
            node_incremental = "<Up>",
            node_decremental = "<Down>",
            -- scope_incremental = "<Left>",
          },
        },
        indent = {
          enable = true,
        },
        autotag = {
          enable = true,
        },
        context_commentstring = {
          enable = true,
          config = {
            javascript = {
              __default = "// %s",
              jsx_element = "{/* %s */}",
              jsx_fragment = "{/* %s */}",
              jsx_attribute = "// %s",
              comment = "// %s",
            },
          },
        },
      })
    end,
  },
}

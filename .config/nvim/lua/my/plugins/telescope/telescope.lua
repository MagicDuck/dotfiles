local telescope = require('telescope')
local actions = require('telescope.actions')
local lga_actions = require('telescope-live-grep-args.actions')
local fb_actions = require('telescope._extensions.file_browser.actions')
local is_linux = vim.fn.has('linux') == 1

local function ins_mod_special(key)
  return is_linux and '<c-' .. key .. '>' or '<a-' .. key .. '>'
end

telescope.setup({
  -- prompt_position = "top",
  defaults = {
    file_ignore_patterns = { 'node_modules', '__snapshots__' },
    shorten_path = true,
    sorting_strategy = 'ascending',
    layout_strategy = 'vertical',
    layout_config = {
      vertical = {
        preview_cutoff = 1, -- Preview should always show (unless previewer = false)
        prompt_position = 'top',
        -- loooks better without those
        -- width = function(_, max_columns, _)
        --   return max_columns - 16
        -- end,
        -- height = function(_, _, max_lines)
        --   return max_lines - 4
        -- end,
        -- preview_height = function(_, _, max_lines)
        --   return math.min(max_lines - 18, math.floor((max_lines - 8) / 2))
        -- end,
      },
    },
    border = true,
    color_devicons = false,
    prompt_prefix = '❯ ',
    selection_caret = '❯ ',
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<C-k>'] = actions.cycle_history_next,
        ['<C-j>'] = actions.cycle_history_prev,
        ['<C-q>'] = function(...)
          actions.select_all(...)
          actions.send_selected_to_qflist(...)
          vim.cmd('copen')
        end,
        -- ['<C-a>'] = actions.select_all,
        ['<PageUp>'] = actions.preview_scrolling_up,
        ['<PageDown>'] = actions.preview_scrolling_down,

        -- h is bs weirdly enough, maybe only on linux??
        [ins_mod_special('bs')] = function()
          vim.cmd('normal! db')
        end,
        [ins_mod_special('del')] = function()
          vim.cmd('normal! de')
        end,
        [ins_mod_special('left')] = function()
          vim.cmd('normal! b')
        end,
        [ins_mod_special('right')] = function()
          vim.cmd('normal! w')
        end,
        [ins_mod_special('up')] = function()
          vim.cmd('normal! ^')
        end,
        [ins_mod_special('down')] = function()
          vim.cmd('normal! $')
        end,
      },
      n = {
        ['<esc>'] = actions.close,
      },
    },
  },
  pickers = {
    live_grep = {
      results_title = false,
      layout_config = {
        prompt_position = 'top',
      },
      mappings = {
        i = { ['<c-f>'] = actions.to_fuzzy_refine },
      },
    },
    buffers = {
      -- only_cwd = true,
      sort_mru = true,
      ignore_current_buffer = true,
      -- sort_lastused = true
    },
  },
  extensions = {
    fzf_writer = {
      minimum_grep_characters = 2,
      minimum_files_characters = 2,

      -- Disabled by default.
      -- Will probably slow down some aspects of the sorter, but can make color highlights.
      -- I will work on this more later.
      -- use_highlighter = true,
    },
    file_browser = {
      initial_mode = 'normal',
      theme = 'ivy',
      prompt_path = true,
      git_status = false,
      quiet = true,
      mappings = {
        ['i'] = {
          ['<A-c>'] = fb_actions.create,
          ['<S-CR>'] = fb_actions.create_from_prompt,
          ['<A-r>'] = fb_actions.rename,
          ['<A-m>'] = fb_actions.move,
          ['<A-y>'] = fb_actions.copy,
          ['<A-d>'] = fb_actions.remove,
          ['<C-o>'] = fb_actions.open,
          ['<C-h>'] = fb_actions.goto_parent_dir,
          ['<C-e>'] = fb_actions.goto_home_dir,
          ['<C-w>'] = fb_actions.goto_cwd,
          ['<C-l>'] = fb_actions.change_cwd,
          ['<C-f>'] = fb_actions.toggle_browser,
          ['<C-.>'] = fb_actions.toggle_hidden,
          ['<C-s>'] = fb_actions.toggle_all,
          ['<bs>'] = fb_actions.backspace,
        },
        ['n'] = {
          ['c'] = fb_actions.create,
          ['r'] = fb_actions.rename,
          ['m'] = fb_actions.move,
          ['y'] = fb_actions.copy,
          ['d'] = fb_actions.remove,
          ['o'] = fb_actions.open,
          ['h'] = fb_actions.goto_parent_dir,
          ['e'] = fb_actions.goto_home_dir,
          ['w'] = fb_actions.goto_cwd,
          ['l'] = fb_actions.change_cwd,
          ['f'] = fb_actions.toggle_browser,
          ['.'] = fb_actions.toggle_hidden,
          ['s'] = fb_actions.toggle_all,
          ['<esc>'] = actions.close,
          ['q'] = actions.close,
        },
      },
    },
    -- live_grep_args = {
    --   auto_quoting = true, -- enable/disable auto-quoting
    --   mappings = {
    --     i = {
    --       ["<C-k>"] = lga_actions.quote_prompt(),
    --       ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
    --       ["<C-n>"] = lga_actions.quote_prompt({ postfix = " --type-add 'spec:*.spec.js' -T spec " }),
    --       ["<C-f>"] = actions.to_fuzzy_refine,
    --     },
    --   },
    --   results_title = false,
    --   layout_config = {
    --     prompt_position = "top",
    --   },
    -- },
  },
})

-- telescope.load_extension("fzy_native")
telescope.load_extension('fzf')
telescope.load_extension('fzf_writer')
-- telescope.load_extension('ui-select')
telescope.load_extension('luasnip')
telescope.load_extension('file_browser')
telescope.load_extension('dap')

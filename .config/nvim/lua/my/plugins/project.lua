return {
  { "ahmedkhalf/project.nvim",
    lazy = true,
    event = "VimEnter",
    config = function()
      require("project_nvim").setup {
        -- scope_chdir = 'tab',
        detection_methods = { "pattern", "lsp" },
        scope_chdir = 'win',
        patterns = {
          ".git",
          -- "package.json",
          "_darcs",
          ".hg",
          ".bzr",
          ".svn",
          "Makefile",
          '=nvim',
          '=ondemand',
          '!=webui',
          'gradlew',
          '=~/notes',
        },
      }
    end
  },
}

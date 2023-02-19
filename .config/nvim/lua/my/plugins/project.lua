return {
  { "ahmedkhalf/project.nvim",
    lazy = true,
    event = "VimEnter",
    config = function()
      require("project_nvim").setup {
        patterns = {
          "package.json",
          ".git",
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

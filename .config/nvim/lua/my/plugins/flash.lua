return {
  {
    'folke/flash.nvim',
    lazy = true,
    event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
    keys = {
      -- { "f", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      -- { ",", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      -- { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      -- { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-f>", mode = { "c" },           function() require("flash").toggle() end,     desc = "Toggle Flash Search" },
    },
    config = function()
      require('flash').setup({
        highlight = {
          -- show a backdrop with hl FlashBackdrop
          backdrop = false,
          groups = {
            label = 'MyFlashLabel',
          },
        },
        modes = {
          -- `f`, `F`, `t`, `T`, `;` and `,` motions
          char = {
            enabled = true,
            highlight = {
              backdrop = false,
              groups = {
                match = 'MyFlashMatch',
                label = 'MyFlashLabel',
              },
            },
            autohide = false,
          },
          -- / search
          search = {
            enabled = false,
          },
        },
      })
    end,
  },
}

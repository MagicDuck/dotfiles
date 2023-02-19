return {
  { "kevinhwang91/rnvimr",
    lazy = true,
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    config = function()
      vim.g.rnvimr_enable_picker = 1
      vim.g.rnvimr_enable_bw = 1
      vim.g.rnvimr_ranger_cmd = { 'ranger', '--confdir=/Users/stephanbadragan/.config/ranger' }

      vim.g.rnvimr_action = {
        ['<C-t>'] = 'NvimEdit tabedit',
        ['<C-h>'] = 'NvimEdit split',
        ['<C-l>'] = 'NvimEdit vsplit'
      }

      -- local lazyUtil = require("my.lazyUtil")
      -- lazyUtil.on_very_lazy(function()
      -- already on very lazy
      vim.cmd([[ RnvimrStartBackground ]])
      -- end)
    end
  },
}

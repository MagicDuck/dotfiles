return {
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    event = 'VeryLazy',
    config = function()
      require('my.plugins.dap.dap')
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    lazy = true,
    event = 'VeryLazy',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      require('my.plugins.dap.dapui')
    end,
  },
}

return {
  {
    'williamboman/mason.nvim',
    name = 'mason',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
    opts = {
      ensure_installed = {
        'stylua',
        'java-debug-adapter',
        'java-test',
        'codelldb',
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      mr:on('package:install:success', function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require('lazy.core.handler.event').trigger({
            event = 'FileType',
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
}

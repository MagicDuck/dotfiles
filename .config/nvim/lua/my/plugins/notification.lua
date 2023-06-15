return {
  "rcarriga/nvim-notify",
  keys = {
    {
      "<leader>un",
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      desc = "Delete all Notifications",
    },
  },
  opts = {
    timeout = 3000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
  },
  init = function()
    local lazyUtil = require("my.lazyUtil")
    -- when noice is not enabled, install notify on VeryLazy
    if not lazyUtil.has("noice.nvim") then
      lazyUtil.on_very_lazy(function()
        -- vim.notify = require("notify")
        local banned_messages = { "This is spam" }

        vim.notify = function(msg, ...)
          for _, banned in ipairs(banned_messages) do
            if msg == banned then
              return
            end
          end
          require("notify")(msg, ...)
        end
      end)
    end
  end,
}

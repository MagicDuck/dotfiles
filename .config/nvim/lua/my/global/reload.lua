if pcall(require, "plenary") then
  RELOAD = require("plenary.reload").reload_module

  my.reloadPackage = function(name)
    RELOAD(name)
    return require(name)
  end

  my.reloadFunc = function(pname, funcName)
    return function(...)
      local package = ReloadPackage(pname)
      return package[funcName](...)
    end
  end
end

my.reloadVim = function()
  local bufnr = vim.fn.bufnr("%")

  -- stop all LSP clients
  vim.lsp.stop_client(vim.lsp.get_active_clients())

  vim.cmd("source ~/.config/nvim/init.vim")

  -- re-edit all buffers
  vim.cmd("silent! bufdo e!")

  -- go back to original buffer
  vim.cmd("buffer " .. bufnr)
end

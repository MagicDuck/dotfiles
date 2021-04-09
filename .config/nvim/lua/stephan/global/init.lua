P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, "plenary") then
  RELOAD = require("plenary.reload").reload_module

  ReloadPackage = function(name)
    RELOAD(name)
    return require(name)
  end

  ReloadFunc = function(pname, funcName)
    return function(...)
      local package = ReloadPackage(pname)
      return package[funcName](...)
    end
  end
end

-- TODO (sbadragan): make this an actual thing
Mappings = {}

Keybind = function(mode, lhs, rhs, options)
  -- option defaults
  if (options.silent ~= nil) then
    options.silent = true
  end

  if (Mappings[mode] == nil) then
    Mappings[mode] = {}
  end

  Mappings[mode][lhs] = {
    rhs = rhs,
    description = options.description,
    options = options
  }
  options.description = nil

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

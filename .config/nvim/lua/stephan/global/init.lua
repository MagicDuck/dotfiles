P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module

  ReloadPackage = function(name)
    RELOAD(name)
    return require(name)
  end

  ReloadFunc = function(pname, funcName)
    return function(...)
      local package = ReloadPackage(pname);
      return package[funcName](...);
    end
  end
end

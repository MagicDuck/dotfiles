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

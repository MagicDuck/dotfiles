my.state.Mappings = {}

my.termcode = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

my.keybind = function(conf)
  if (conf.mode == nil) then
    conf.mode = "n"
  end

  if (conf.lhs == nil) then
    error("my.keybind: lhs is required!")
  end
  if (conf.rhs == nil) then
    error("my.keybind: rhs is required!")
  end
  if (conf.description == nil) then
    error("my.keybind: description is required!")
  end
  if (conf.options == nil) then
    conf.options = {}
  end

  -- option defaults
  if (conf.options.silent == nil) then
    conf.options.silent = true
  end

  if (my.state.Mappings[conf.mode] == nil) then
    my.state.Mappings[conf.mode] = {}
  end

  my.state.Mappings[conf.mode][conf.lhs] = conf

  vim.api.nvim_set_keymap(conf.mode, conf.lhs, conf.rhs, conf.options)
end

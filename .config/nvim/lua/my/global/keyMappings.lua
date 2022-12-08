my.state.keyMappings = {}

my.termcode = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

my.keybind = function(conf)
  if (conf.mode == nil) then
    conf.mode = "n"
  end

  if (conf.lhs == nil) then
    print("my.keybind: lhs is required!")
    return
  end
  if (conf.rhs == nil) then
    print("my.keybind: rhs is required!")
    return
  end
  if (conf.description == nil) then
    print("my.keybind: description is required!")
    return
  end
  if (conf.options == nil) then
    conf.options = {}
  end

  -- option defaults
  if (conf.options.silent == nil) then
    conf.options.silent = true
  end
  if (conf.options.desc == nil) then
    conf.options.desc = conf.description
  end

  for i = 1, #conf.mode do
    local single_mode = conf.mode:sub(i, i)
    if (my.state.keyMappings[single_mode] == nil) then
      my.state.keyMappings[single_mode] = {}
    end

    if my.state.keyMappings[single_mode][conf.lhs] ~= nil then
      P(conf)
      print("keybind: duplicate key mapping detected!")
    end
    my.state.keyMappings[single_mode][conf.lhs] = conf

    vim.api.nvim_set_keymap(single_mode, conf.lhs, conf.rhs, conf.options)
  end
end

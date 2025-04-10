my.state.keyMappings = {}

--- gets termcodes
---@param str string
---@return string
my.termcode = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

---@class my.kebind.opts : vim.keymap.set.Opts
---@field mode? string

--- adds keybind
---@param lhs string
---@param rhs string | fun()
---@param opts? my.kebind.opts
my.keybind = function(lhs, rhs, opts)
  local options = opts or {}
  local conf = { lhs = lhs, rhs = rhs, mode = options.mode or 'n', options = options, description = options.desc }
  options.mode = nil

  if not lhs then
    print('my.keybind: lhs is required!')
    return
  end
  if not rhs then
    print('my.keybind: rhs is required!')
    return
  end
  if options.desc == nil then
    print('my.keybind: description is required!')
    return
  end

  -- option defaults
  if conf.options.silent == nil then
    conf.options.silent = true
  end

  for i = 1, #conf.mode do
    local single_mode = conf.mode:sub(i, i)
    if my.state.keyMappings[single_mode] == nil then
      my.state.keyMappings[single_mode] = {}
    end

    if my.state.keyMappings[single_mode][lhs] ~= nil then
      P(conf)
      print('keybind: duplicate key mapping detected!')
    end
    my.state.keyMappings[single_mode][lhs] = conf

    vim.keymap.set(single_mode, lhs, rhs, conf.options)
  end
end

P = function(...)
  local params = vim.F.pack_len(...)
  local inspected = {}
  for _, p in ipairs(params) do
    table.insert(inspected, vim.inspect(p))
  end
  print(vim.F.unpack_len(inspected))
  return params
end

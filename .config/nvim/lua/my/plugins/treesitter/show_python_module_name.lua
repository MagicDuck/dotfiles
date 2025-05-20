local M = {}

local ns = vim.api.nvim_create_namespace('my.python.treesitter')

--- gets table of imported identifer name -> module_name mappings
---@param buf integer
---@return {[string]: string}
local function get_imports(buf)
  local parser = vim.treesitter.get_parser(buf)
  if not parser then
    return {}
  end

  local import_query = vim.treesitter.query.parse(
    'python',
    [[
      (import_from_statement
        module_name: (dotted_name) @import_from
        name: (dotted_name) @import_name
      )
    ]]
  )

  local imports = {}
  for _, tree in ipairs(parser:trees()) do
    for _, match, _ in import_query:iter_matches(tree:root(), buf, 0, -1) do
      local module_name
      for id, nodes in pairs(match) do
        local capture_name = import_query.captures[id]

        if nodes[1] then
          if capture_name == 'import_from' then
            module_name = vim.treesitter.get_node_text(nodes[1], buf)
          elseif capture_name == 'import_name' and module_name then
            local identifier_name = vim.treesitter.get_node_text(nodes[1], buf)
            imports[identifier_name] = module_name
          end
        end
      end
    end
  end

  return imports
end

--- updates import references, adding inline virtual text
--- showing the module name
---@param buf integer
local function update_references(buf)
  local parser = vim.treesitter.get_parser(buf)
  if not parser then
    return
  end

  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
  local imports = get_imports(buf)

  local reference_query = vim.treesitter.query.parse(
    'python',
    [[
      ((identifier) @ident 
        (#not-has-parent? @ident attribute parameters function_definition dotted_name))
    ]]
  )

  for _, tree in ipairs(parser:trees()) do
    for _, node in reference_query:iter_captures(tree:root(), buf, 0, -1) do
      local name = vim.treesitter.get_node_text(node, buf)
      if imports[name] then
        local row, col = node:end_()
        vim.api.nvim_buf_set_extmark(buf, ns, row, col, {
          end_row = row,
          end_col = col,
          virt_text = {
            {
              ' <' .. imports[name] .. '> ',
              'Comment',
            },
          },
          virt_text_pos = 'inline',
        })
      end
    end
  end
end

--- set it up
---@param options { initially_enabled: boolean }
function M.setup(options)
  local opts = vim.tbl_deep_extend('force', { initially_enabled = false }, options)

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('show-python-module-name', { clear = true }),
    pattern = { 'python' },
    callback = function(args)
      local buf = args.buf
      -- initial update
      if opts.initially_enabled then
        vim.schedule(function()
          update_references(buf)
        end)
      end
      -- update on every buffer change
      vim.api.nvim_buf_attach(buf, false, {
        on_bytes = vim.schedule_wrap(function()
          if vim.b[buf]['_show_python_modules_enabled'] then
            update_references(buf)
          end
        end),
      })
    end,
  })
end

--- enable for current buffer
function M.enable()
  local filetype = vim.api.nvim_get_option_value('filetype', { buf = 0 })
  if filetype ~= 'python' then
    return
  end
  vim.b['_show_python_modules_enabled'] = true
  update_references(0)
end

--- disable for current buffer
function M.disable()
  local filetype = vim.api.nvim_get_option_value('filetype', { buf = 0 })
  if filetype ~= 'python' then
    return
  end
  vim.b['_show_python_modules_enabled'] = false
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end

--- toggle enable for current buffer
function M.toggle()
  if vim.b['_show_python_modules_enabled'] then
    M.disable()
  else
    M.enable()
  end
end

return M

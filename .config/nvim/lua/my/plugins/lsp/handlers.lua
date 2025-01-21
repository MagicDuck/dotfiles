local exports = {}

local function resolve_handler(client, method)
  return client.handlers[method] or vim.lsp.handlers[method]
end

exports.client_request = function(client)
  local original_client_request = client.request
  if client._request_override_applied then
    return original_client_request
  end

  client._request_override_applied = true
  return function(method, params, handler, bufnr)
    local customHandler = client.handlers[method]
    -- print(
    --   "---invoking lsp handler",
    --   client.name,
    --   method,
    --   type(handler),
    --   type(customHandler)
    -- )
    if customHandler and type(customHandler) == 'table' and customHandler.type == 'local_lsp' then
      local context = {
        method = method,
        client_id = client.id,
        bufnr = bufnr,
        params = params,
      }
      local result = customHandler.handler(method, params, client.id, bufnr)
      local continuationHandler = handler or vim.lsp.handlers[method]
      if continuationHandler then
        -- first 1st arg is err
        continuationHandler(nil, result, context)
      end
      vim.api.nvim_command('doautocmd <nomodeline> User LspRequest')

      return true, 1
    else
      if not handler and not vim.lsp.handlers[method] then
        error(string.format('not found: %q request handler for client %q.', method, client.name))
      end
      return original_client_request(method, params, handler, bufnr, client.config)
    end
  end
end

-- local actionsPicker = nil
-- local actionsPickerActions = {}
-- local onActionPickerClose = function()
--   actionsPicker = nil
--   actionsPickerActions = {}
-- end
--
-- local code_action_picker = require("my/telescope/code_action_picker")
-- vim.lsp.handlers["textDocument/codeAction"] = function(
--   _, --err,
--   _, --method,
--   actions,
--   _, --client_id,
--   _, --bufnr,
--   _) -- config
--   for _, action in pairs(actions or {}) do
--     table.insert(actionsPickerActions, action)
--   end
--
--   if (actionsPicker == nil) then
--     actionsPicker =
--       code_action_picker.getCodeActionPicker(
--       {onActionPickerClose = onActionPickerClose}
--     )
--     actionsPicker:find()
--   end
--   local actionsFinder =
--     code_action_picker.getCodeActionFinder(actionsPickerActions)
--   actionsPicker:refresh(actionsFinder, {reset_prompt = false})
-- end

-- local original_vim_ui_select = vim.ui.select
-- vim.ui.select = function(items, opts, on_choice)
--   if opts.kind == "codeaction" then
--
--   end
--   return original_vim_ui_select(items, opts, on_choice)
-- end

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.handlers['textDocument/publishDiagnostics'],
  -- vim.lsp.diagnostic.on_publish_diagnostics,
  {
    -- Enable underline, use default values
    underline = false,
    -- Disable a feature
    -- update_in_insert = false,
  }
)

exports.tsserverPublishDiagnostics = function(_, result, ctx, config)
  if vim.endswith(vim.loop.cwd() or '', '/frontend') then
    result.diagnostics = vim.tbl_filter(function(diagnostic)
      return vim.tbl_contains({
        -- allow  name not found diagnostics
        2304,
        2552,
      }, diagnostic.code)
    end, result.diagnostics)
  end

  local format = require('format-ts-errors')
  result.diagnostics = vim
    .iter(result.diagnostics)
    :map(function(diagnostic)
      local formatter = format[diagnostic.code]
      diagnostic.message = formatter and formatter(diagnostic.message) or diagnostic.message
      return diagnostic
    end)
    :totable()
  return vim.lsp.handlers['textDocument/publishDiagnostics'](nil, result, ctx, config)
end

exports.tsserverDefinition = function(err, result, ctx, ...)
  local res = result
  if result and #result > 1 then
    -- shave off .d.ts references when they occur together with actual source location
    res = vim.tbl_filter(function(entry)
      return not vim.endswith(entry.targetUri, '.d.ts')
    end, result)
  end
  return vim.lsp.handlers['textDocument/definition'](err, res, ctx, ...)
end

exports.diagnosticlsPublishDiagnostics = function(_, result, ctx, config)
  result.diagnostics = vim.tbl_map(function(diagnostic)
    if diagnostic.source == 'eslint' then
      if diagnostic.message:match('^%[eslint%] Parsing error:') ~= nil then
        diagnostic.message = '[eslint] Parsing error'
      end
    end
    return diagnostic
  end, result.diagnostics)
  return vim.lsp.handlers['textDocument/publishDiagnostics'](nil, result, ctx, config)
end

exports.lintCodeAction = function(method, params, clientId, bufnr)
  local actions = {}
  for _, diagnostic in pairs(params.context.diagnostics) do
    if diagnostic.source == 'eslint' then
      local rule = string.match(diagnostic.message, '%[([^%]]*)%][ ]*$')
      table.insert(actions, {
        arguments = {
          newText = '// eslint-disable-next-line ' .. rule,
          lineNum = diagnostic.range.start.line,
        },
        command = 'add_indented_new_line',
        title = 'Suppress eslint rule ' .. rule,
      })
    end
    if diagnostic.source == 'stylelint' then
      local rule = string.match(diagnostic.message, '%(([^%]]*)%)[ ]*$')
      table.insert(actions, {
        arguments = {
          newText = '/* stylelint-disable-next-line ' .. rule .. ' */',
          lineNum = diagnostic.range.start.line,
        },
        command = 'add_indented_new_line',
        title = 'Suppress stylelint rule ' .. rule,
      })
    end
  end

  return actions
end

exports.workspaceExecuteCommand = function(method, params, client_id, bufnr)
  if params.command == 'add_indented_new_line' then
    local lineNum = params.arguments.lineNum
    local line = vim.fn.getbufline(bufnr, lineNum + 1)[1]
    local prefix = string.match(line, '^%s*')
    vim.fn.appendbufline(bufnr, lineNum, prefix .. params.arguments.newText)
  end
end

return exports

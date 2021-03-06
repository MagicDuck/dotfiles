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
    if not handler then
      handler =
        resolve_handler(client, method) or
        error(
          string.format(
            "not found: %q request handler for client %q.",
            method,
            client.name
          )
        )
    end

    if (type(handler) == "table" and handler.type == "local_lsp") then
      handler.handler(method, params, client.id, bufnr)
      return true, 1
    else
      return original_client_request(
        method,
        params,
        handler,
        bufnr,
        client.config
      )
    end
  end
end

local actionsPicker = nil
local actionsPickerActions = {}
local onActionPickerClose = function()
  actionsPicker = nil
  actionsPickerActions = {}
end

local code_action_picker = require("my/telescope/code_action_picker")
vim.lsp.handlers["textDocument/codeAction"] = function(
  _, --err,
  _, --method,
  actions,
  _, --client_id,
  _, --bufnr,
  _) -- config
  for _, action in pairs(actions or {}) do
    table.insert(actionsPickerActions, action)
  end

  if (actionsPicker == nil) then
    actionsPicker =
      code_action_picker.getCodeActionPicker(
      {onActionPickerClose = onActionPickerClose}
    )
    actionsPicker:find()
  end
  local actionsFinder =
    code_action_picker.getCodeActionFinder(actionsPickerActions)
  actionsPicker:refresh(actionsFinder, {reset_prompt = false})
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.handlers["textDocument/publishDiagnostics"],
  -- vim.lsp.diagnostic.on_publish_diagnostics,
  {
    -- Enable underline, use default values
    underline = false
    -- Disable a feature
    -- update_in_insert = false,
  }
)

exports.tsserverPublishDiagnostics = function(
  err,
  method,
  params,
  client_id,
  bufnr,
  config)
  params.diagnostics =
    vim.tbl_filter(
    function(diagnostic)
      return vim.tbl_contains(
        {
          -- allow  name not found diagnostics
          2304
        },
        diagnostic.code
      )
    end,
    params.diagnostics
  )
  return vim.lsp.handlers["textDocument/publishDiagnostics"](
    err,
    method,
    params,
    client_id,
    bufnr,
    config
  )
end

exports.diagnosticlsPublishDiagnostics = function(
  err,
  method,
  params,
  client_id,
  bufnr,
  config)
  params.diagnostics =
    vim.tbl_map(
    function(diagnostic)
      if diagnostic.source == "eslint" then
        if diagnostic.message:match("^%[eslint%] Parsing error:") ~= nil then
          diagnostic.message = "[eslint] Parsing error"
        end
      end
      return diagnostic
    end,
    params.diagnostics
  )
  return vim.lsp.handlers["textDocument/publishDiagnostics"](
    err,
    method,
    params,
    client_id,
    bufnr,
    config
  )
end

exports.lintCodeAction = function(method, params, client_id, bufnr, config)
  local actions = {}
  for _, diagnostic in pairs(params.context.diagnostics) do
    if (diagnostic.source == "eslint") then
      local rule = string.match(diagnostic.message, "%[([^%]]*)%][ ]*$")
      table.insert(
        actions,
        {
          arguments = {
            newText = "// eslint-disable-next-line " .. rule,
            lineNum = diagnostic.range.start.line
          },
          command = "add_indented_new_line",
          title = "Suppress eslint rule " .. rule
        }
      )
    end
    if (diagnostic.source == "stylelint") then
      local rule = string.match(diagnostic.message, "%(([^%]]*)%)[ ]*$")
      table.insert(
        actions,
        {
          arguments = {
            newText = "/* stylelint-disable-next-line " .. rule .. " */",
            lineNum = diagnostic.range.start.line
          },
          command = "add_indented_new_line",
          title = "Suppress stylelint rule " .. rule
        }
      )
    end
  end

  return vim.lsp.handlers["textDocument/codeAction"](
    nil,
    method,
    actions,
    client_id,
    bufnr,
    config
  )
end

exports.workspaceExecuteCommand = function(
  method,
  params,
  client_id,
  bufnr,
  config)
  if params.command == "add_indented_new_line" then
    local lineNum = params.arguments.lineNum
    local line = vim.fn.getbufline(bufnr, lineNum + 1)[1]
    local prefix = string.match(line, "^%s*")
    vim.fn.appendbufline(bufnr, lineNum, prefix .. params.arguments.newText)
  end
end

return exports

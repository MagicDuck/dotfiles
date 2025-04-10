my = { state = {} }
require('my/global/inspect')
require('my/global/keyMappings')
require('my/global/commands')

-- disable some annoying deprecation warnings
local deprecate = vim.deprecate
local ignore_deprecated = {
  ['Defining diagnostic signs with :sign-define or sign_define()'] = 'vim.diagnostic.config()',
  ['client.request'] = 'client:request',
  ['vim.highlight'] = 'vim.hl',
  ['vim.validate'] = 'vim.validate(name, value, validator, optional_or_msg)',
}
---@diagnostic disable-next-line: duplicate-set-field
vim.deprecate = function(name, alternative, version, plugin, backtrace)
  if ignore_deprecated[name] == alternative then
    return
  end
  deprecate(name, alternative, version, plugin, backtrace)
end

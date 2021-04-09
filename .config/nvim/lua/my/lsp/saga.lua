local saga = require 'lspsaga'
saga.init_lsp_saga({
  rename_action_keys = {
    quit = '<ESC>',
    exec = '<CR>'
  },
  code_action_keys = {
    quit = '<ESC>',
    exec = '<CR>'
  },
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 20,
    virtual_text = false,
  },
  use_saga_diagnostic_sign = false,
  -- error_sign = "",
  -- warn_sign = "",
  -- hint_sign = "",
  -- infor_sign = "✘",
  dianostic_header_icon = '   ',
  code_action_icon = ' '
})


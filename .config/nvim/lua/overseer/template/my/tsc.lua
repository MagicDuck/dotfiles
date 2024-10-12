return {
  name = 'tsc',
  builder = function()
    return {
      cmd = { 'npx', 'tsc' },
      env = {
        NO_COLOR = '1',
      },
      components = {
        { 'on_output_quickfix', open = true },
        'default',
      },
    }
  end,
  condition = {
    filetype = { 'typescript', 'typescriptreact' },
  },
}

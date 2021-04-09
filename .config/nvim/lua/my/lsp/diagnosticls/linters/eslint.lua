return {
  command = 'eslint_d',
  rootPatterns = { '.eslintrc.js', '.eslintrc.json' },
  debounce = 100,
  args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json', '--no-color' },
  sourceName = 'eslint',
  parseJson = {
    errorsRoot = '[0].messages',
    line = 'line',
    column = 'column',
    endLine = 'endLine',
    endColumn = 'endColumn',
    message = '[eslint] ${message} [${ruleId}]',
    security = 'severity'
  },
  securities = {
    [2] = 'error',
    [1] = 'warning'
  }
}

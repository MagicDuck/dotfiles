return {
  command = "stylelint_d",
  rootPatterns = {".stylelintrc"},
  debounce = 100,
  args = {
    "--stdin",
    "--stdin-filename",
    "%filepath",
    "--formatter",
    "json",
    "--no-color"
  },
  sourceName = "stylelint",
  parseJson = {
    errorsRoot = "[0].warnings",
    line = "line",
    column = "column",
    endLine = "line",
    endColumn = "column",
    message = "[stylelint] ${text}",
    security = "severity"
  },
  securities = {
    [2] = "error",
    [1] = "warning"
  }
}

return {
  command = 'eslint_d',
  debounce = 100,
  args = { '--fix-to-stdout', '--stdin', '--stdin-filename', '%filepath' },
  isStdout = true,
  rootPatterns = { '.eslintrc.js', '.eslintrc.json' },
}

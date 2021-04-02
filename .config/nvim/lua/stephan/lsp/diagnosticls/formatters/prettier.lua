return {
  -- command = "prettier_d", -- cuts off large files
  command = "./node_modules/.bin/prettier",
  args = {'--stdin', '--stdin-filepath', '%filepath' },
  isStdout = true,
  rootPatterns = { ".prettierrc" },
  requiredFiles = { ".prettierrc" }
}

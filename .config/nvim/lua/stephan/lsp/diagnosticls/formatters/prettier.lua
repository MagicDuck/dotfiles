return {
  command = "prettier_d",
  args = { '--stdin-filepath', '%filepath' },
  isStdout = true,
  rootPatterns = { ".prettierrc" },
  requiredFiles = { ".prettierrc" }
}

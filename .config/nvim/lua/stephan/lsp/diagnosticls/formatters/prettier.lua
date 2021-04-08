return {
  -- command = vim.fn.expand("~/prettier_d_slim/lib/bin/prettier_d_slim.js"),
  command = "prettier_d_slim_latest",
  -- command = "prettier_d", -- cuts off large files
  command = "./node_modules/.bin/prettier",
  args = {"--stdin", "--stdin-filepath", "%filepath"},
  isStdout = true,
  rootPatterns = {".prettierrc", ".prettierrc.json"}
}

return {
  -- command = vim.fn.expand("~/prettier_d_slim/lib/bin/prettier_d_slim.js"),
  -- command = "prettier_d", -- cuts off large files
  -- command = "./node_modules/.bin/prettier",

  -- daemonized prettier
  -- command = "prettier_d_slim",
  -- args = {"--stdin", "--stdin-filepath", "%filepath"},

  -- this one works well, but has a different version than the one we use...
  -- something to keep an eye on I guess
  -- command = "prettierd",
  -- args = {"%filepath"},

  -- standard prettier
  command = "./node_modules/.bin/prettier",
  args = {"--stdin", "--stdin-filepath", "%filepath"},
  isStdout = true,
  rootPatterns = {".prettierrc", ".prettierrc.json"}
}

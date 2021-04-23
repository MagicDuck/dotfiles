return {
  -- command = vim.fn.expand("~/prettier_d_slim/lib/bin/prettier_d_slim.js"),
  -- command = "prettier_d_slim",
  -- command = "prettier_d", -- cuts off large files
  -- command = "./node_modules/.bin/prettier",

  -- this one works well, but has a different version than the one we use...
  -- something to keep an eye on I guess
  -- command = "prettierd",
  -- args = {"%filepath"},

  command = "./node_modules/.bin/prettier",
  args = {"--stdin", "--stdin-filepath", "%filepath"},
  isStdout = true,
  rootPatterns = {".prettierrc", ".prettierrc.json"}
}

vim.o.completeopt = "menuone,noselect"

-- Note: all defaults are defined in https://github.com/ms-jpq/coq_nvim/blob/a1ab14bc461da8314be8a548ed605d91fa0265ef/config/defaults.yml
vim.g.coq_settings = {
  auto_start = true, -- use 'shut-up' to disable startup message
  limits = {
    index_cutoff = 500000
  },
  match = {
    max_results = 33
  },
  clients = {
    tree_sitter = {
      enabled = false
    },
    lsp = {
      resolve_timeout = 0.4
    }
  }
}

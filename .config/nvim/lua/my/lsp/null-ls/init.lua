local null_ls = require("null-ls")
local attach = require("my/lsp/attach")
local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local luafmt = {
  method = methods.internal.FORMATTING,
  filetypes = {"lua"},
  name = "luafmt",
  generator = h.formatter_factory(
    {
      command = "luafmt",
      args = {"--stdin", "--line-width", "80", "--indent-count", "2"},
      format = "raw",
      to_stdin = true
    }
  )
}

local checkstyle =
  h.make_builtin(
  {
    name = "checkstyle",
    -- method = methods.internal.DIAGNOSTICS,
    method = methods.internal.DIAGNOSTICS_ON_SAVE,
    filetypes = {"java"},
    generator_opts = {
      command = vim.fn.expand("~/.jenv/versions/11/bin/java"),
      args = function(params)
        local java_args = {}
        local extra_args = {}

        local base_args = {
          "-jar",
          vim.fn.expand("~/checkstyle/checkstyle-9.2.1-all.jar"),
          "-f",
          "sarif"
        }

        if (params.root:match("xm%-api")) then
          java_args = {
            "-Dconfig_loc=./config/checkstyle"
          }
          extra_args = {
            "-c",
            "./gradle/xMattersFormatAndImportChecks.xml"
          }
        end

        local args = {}
        for _, v in ipairs(java_args) do
          table.insert(args, v)
        end
        for _, v in ipairs(base_args) do
          table.insert(args, v)
        end
        for _, v in ipairs(extra_args) do
          table.insert(args, v)
        end
        table.insert(args, "$FILENAME")

        return args
      end,
      to_stdin = false,
      format = "json_raw",
      from_stderr = false,
      ignore_stderr = true,
      on_output = function(params)
        local output =
          params.output and params.output.runs and params.output.runs[1].results or
          {}

        -- json decode failure means it failed to run
        if params.err then
          table.insert(output, {text = params.output})
        end

        local parser =
          h.diagnostics.from_json(
          {
            attributes = {
              severity = "level",
              locations = "locations"
            },
            adapters = {
              {
                row = function(entries)
                  return entries.locations[1].physicalLocation.region.startLine
                end,
                col = function(entries)
                  return entries.locations[1].physicalLocation.region.startColumn
                end,
                end_row = function(entries)
                  return entries.locations[1].physicalLocation.region.startLine
                end,
                end_col = function(entries)
                  return entries.locations[1].physicalLocation.region.startColumn
                end,
                message = function(entries)
                  return entries.message.text
                end
              }
            },
            severities = {
              h.diagnostics.severities["warning"],
              h.diagnostics.severities["error"]
            }
          }
        )

        params.output = output
        return parser(params)
      end
    },
    factory = h.generator_factory
  }
)

null_ls.setup(
  {
    log = {
      enable = true,
      level = "trace",
      use_console = "async"
    },
    diagnostics_format = "[#{s}] #{m} (#{c})",
    sources = {
      -- null_ls.builtins.diagnostics.stylelint.with {
      --   only_local = "node_modules/.bin"
      -- },
      null_ls.builtins.diagnostics.stylelint.with {},
      null_ls.builtins.diagnostics.eslint_d.with {},
      null_ls.builtins.formatting.eslint_d.with {},
      null_ls.builtins.code_actions.eslint_d.with {},
      null_ls.builtins.formatting.prettierd.with {
        -- null_ls.builtins.formatting.prettierd.with {
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "markdown",
          "vimwiki"
        }
        -- only_local = "node_modules/.bin"
      },
      luafmt,
      checkstyle.with {
        condition = function(u)
          return u.root_matches("xm%-api")
        end
      }
    },
    on_attach = attach.global_on_attach,
    on_init = function()
      -- make sure eslint server still works, sometimes it dies for no reason
      -- os.execute("eslint_d restart")
    end
  }
)

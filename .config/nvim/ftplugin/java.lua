-- inspiration sources:
-- https://github.com/baobaoit/beande/blob/development/ftplugin/java.lua

local attach = require("my/lsp/attach")

local JAVA_LSP_DISABLED = false

vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4

local jdtlsPath = vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls")

-- figure out project
local projectRoot = require("jdtls.setup").find_root({ '.git', 'mvnw', 'gradlew' })
local projectName = vim.fn.fnamemodify(projectRoot or vim.fn.getcwd(), ":p:h:t")
local workspaceRoot = vim.fn.expand("~/jdtls-workspaces")
local projectWorkspaceDir = workspaceRoot .. "/" .. projectName

-- figure out java runtime path
local javaVersionsDir = vim.fn.expand("~/.jenv/versions")
local jdk8 = javaVersionsDir .. '/1.8'
local jdk11 = javaVersionsDir .. '/11'
local jdk17 = javaVersionsDir .. '/17'

local get_cmd = function()
  local cmd = {

    -- 💀
    'jdtls',

    '--jvm-arg=-javaagent:' .. jdtlsPath .. "/lombok.jar",
    '--jvm-arg=-Xms1g',
  }

  -- 💀
  -- See `data directory configuration` section in the README
  table.insert(cmd, '-data')
  table.insert(cmd, projectWorkspaceDir)

  return cmd
end


-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  cmd = get_cmd(),

  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = projectRoot,
  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      home = jdk17,
      import = {
        gradle = {
          enabled = true,
          wrapper = {
            enabled = true,
          },
        },
      },
      format = {
        enabled = false,
        comments = {
          enabled = false,
        },
        insertSpaces = false,
        settings = {
          url = vim.fn.expand("~/.config/nvim/ftplugin/eclipse_formatter_style.xml"),
        },
      },
      autobuild = {
        enabled = false
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-11",
            path = jdk11,
            default = true
          },
          {
            name = "JavaSE-1.8",
            path = jdk8,
          }
        }
      },
      saveActions = {
        organizeImports = true
      },
    },
  },
  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {},
    extendedClientCapabilities = {
      progressReportProvider = false,
    },
  },
  capabilities = attach.global_capabilities,
  on_attach = attach.global_on_attach,
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
if vim.g.myLspDisabled ~= true and not JAVA_LSP_DISABLED then
  require("jdtls").start_or_attach(config)
end

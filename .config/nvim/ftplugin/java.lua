local attach = require("my/lsp/attach")

vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4

local jdtlsPath = vim.fn.expand("~/jdt-language-server")
local launcherVersion = "1.6.400.v20210924-0641"

-- figure out which os we are on
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "mac"
elseif vim.fn.has("unix") == 1 then
  system_name = "linux"
elseif vim.fn.has("win32") == 1 then
  system_name = "win"
else
  print("Unsupported system for jdtls")
end

-- figure out project
local projectRoot = require("jdtls.setup").find_root({"gradlew"})
local projectName = vim.fn.fnamemodify(projectRoot or vim.fn.getcwd(), ":p:h:t")
local workspaceRoot = vim.fn.expand("~/jdtls-workspaces")
local projectWorkspaceDir = workspaceRoot .. "/" .. projectName

-- figure out java runtime path
local javaVersionsDir = vim.fn.expand("~/.jenv/versions")

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    javaVersionsDir .. "/11/bin/java", --"java", -- or '/path/to/java11_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    jdtlsPath ..
      "/plugins/org.eclipse.equinox.launcher_" .. launcherVersion .. ".jar",
    "-configuration",
    jdtlsPath .. "/config_" .. system_name,
    "-data",
    projectWorkspaceDir
  },
  cmd_cwd = projectRoot,
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = projectRoot,
  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      -- home = javaVersionsDir .. "/1.8",
      import = {
        gradle = {
          enabled = true,
          -- java = {
          --   home = javaVersionsDir .. "/1.8"
          -- },
          wrapper = {
            enabled = true
          }
        }
      },
      format = {
        enabled = true,
        comments = {
          enabled = false
        },
        insertSpaces = false
      },
      configuration = {
        runtimes = {
          {
            name = "JavaSE-11",
            path = javaVersionsDir .. "/11"
            -- default = projectName ~= "ondemand"
          }
          -- {
          --   name = "JavaSE_1_8",
          --   path = javaVersionsDir .. "/1.8",
          --   default = projectName == "ondemand"
          -- }
        }
      }
    }
  },
  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {}
  },
  capabilities = attach.global_capabilities,
  on_attach = attach.global_on_attach
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)
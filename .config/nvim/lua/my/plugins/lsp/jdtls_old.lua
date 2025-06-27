-- inspiration sources:
-- https://github.com/baobaoit/beande/blob/development/ftplugin/java.lua
-- requires:
-- - jdtls (installed through mason)

local exports = {}
local attach = require('my/plugins/lsp/attach')
local jdtlsSetup = require('jdtls.setup')

-- JDK paths
local javaVersionsDir = vim.fn.expand('~/.jenv/versions')
local jdk8 = javaVersionsDir .. '/1.8'
-- local jdk8 = '/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home'
local jdk11 = javaVersionsDir .. '/11.0'
local jdk17 = javaVersionsDir .. '/17.0'

-- other paths
local masonDir = vim.fn.expand('~/.local/share/nvim/mason/packages')
local jdtlsPath = masonDir .. '/jdtls'
local workspaceRoot = vim.fn.expand('~/jdtls-workspaces')
vim.fn.glob(masonDir .. '/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar', 1)

local getCmd = function(projectName)
  local projectWorkspaceDir = workspaceRoot .. '/' .. projectName

  local cmd = {
    'jdtls',
    '--jvm-arg=-javaagent:' .. jdtlsPath .. '/lombok.jar',
    '--jvm-arg=-Xms1g',
    -- See `data directory configuration` section in the README
    '-data',
    projectWorkspaceDir,
  }

  return cmd
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
exports.getConfig = function()
  local projectRoot = jdtlsSetup.find_root({ '.git', 'mvnw', 'gradlew' })
  local projectName = vim.fn.fnamemodify(projectRoot or vim.fn.getcwd(), ':p:h:t')

  return {
    cmd = getCmd(projectName),
    cmd_env = {
      JAVA_HOME = jdk17,
    },
    cmd_cwd = projectRoot,
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
            url = vim.fn.expand('~/.config/nvim/ftplugin/eclipse_formatter_style.xml'),
          },
        },
        autobuild = {
          enabled = false,
        },
        configuration = {
          updateBuildConfiguration = 'interactive',
          -- Note: This is what determines what java version to use to build each project
          runtimes = {
            {
              name = 'JavaSE-11',
              path = jdk11,
              -- default = true
            },
            {
              name = 'JavaSE-1.8',
              path = jdk8,
              -- default = true
            },
          },
        },
        saveActions = {
          organizeImports = false,
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
      bundles = {
        vim.fn.glob(masonDir .. '/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar', 1),
      },
      extendedClientCapabilities = {
        -- this allows correct progress reports
        progressReportProvider = false,
      },
    },
    capabilities = attach.global_capabilities,
    on_attach = function(client, bufnr)
      jdtlsSetup.add_commands()
      attach.global_on_attach(client, bufnr)

      -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
      -- you make during a debug session immediately.
      -- Remove the option if you do not want that.
      -- You can use the `JdtHotcodeReplace` command to trigger it manually
      require('jdtls').setup_dap({
        -- hotcodereplace = 'auto'
      })
    end,
  }
end

return exports

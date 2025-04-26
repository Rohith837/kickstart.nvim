-- This file will only load if the current file is a java file (because of the ft=java option in the plugin declaration and directory should be ftplugin)
-- https://medium.com/@chrisatmachine/lunarvim-as-a-java-ide-da65c4a77fb4

local user_profile = os.getenv 'USERPROFILE' .. '/AppData/Local/nvim-related-data'

local bundles = { vim.fn.glob(user_profile .. '/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.53.1.jar', true) }
vim.list_extend(bundles, vim.split(vim.fn.glob(user_profile .. '/vscode-java-test/server/*.jar', true), '\n'))

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local workspace_dir = user_profile .. '/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/' .. project_name

local terminal = require 'custom/utils/terminal'

vim.keymap.set('n', '<leader>jrtc', function()
  local filepath = vim.fn.expand '%:p' -- Get full file path
  local filename = vim.fn.expand '%:t:r' -- Get file name without extension
  local test_class_name = filename -- By default, assume we're in a test file

  -- Determine the test class name
  if not filepath:match 'Test' then
    -- If we are in a source file, convert it to the corresponding test file
    test_class_name = filename .. 'Test' -- Example: "UserService" -> "UserServiceTest"
  end

  -- Run the test
  local java_test_command = 'mvn -Dtest=' .. test_class_name .. ' surefire:test'

  terminal.stopJob()
  terminal.openExistingTerminal()
  vim.fn.chansend(terminal.job_id, { java_test_command })
end)

vim.keymap.set('n', '<leader>jrtm', function()
  local filepath = vim.fn.expand '%:p' -- Get full file path
  local filename = vim.fn.expand '%:t:r' -- Get file name without extension
  local method_name = vim.fn.expand '<cword>'

  if filepath:match 'Test' then
    local java_test_command = 'mvn -Dtest=' .. filename .. '\\#' .. method_name .. ' surefire:test'
    terminal.stopJob()
    terminal.openExistingTerminal()
    vim.fn.chansend(terminal.job_id, { java_test_command })
  end
end, { desc = '[R]un Java Test [M]ethod' })

-- vim.keymap.set('n', '<leader>jrtc', function()
--   local filepath = vim.fn.expand '%:p' -- Get full file path
--   local filename = vim.fn.expand '%:t:r' -- Get file name without extension
--   local test_class_name = filename -- By default, assume we're in a test file
--
--   -- Determine the test class name
--   if not filepath:match 'Test' then
--     -- If we are in a source file, convert it to the corresponding test file
--     test_class_name = filename .. 'Test' -- Example: "UserService" -> "UserServiceTest"
--   end
--
--   -- Run the test
--   local command = 'mvn -Dtest=' .. test_class_name .. ' surefire:test'
--   vim.cmd('!' .. command)
-- end, { desc = '[R]un Java Test [C]lass' })

-- vim.keymap.set('n', '<leader>jrtm', function()
--   local filepath = vim.fn.expand '%:p' -- Get full file path
--   local filename = vim.fn.expand '%:t:r' -- Get file name without extension
--   local method_name = vim.fn.expand '<cword>'
--
--   if filepath:match 'Test' then
--     local command = 'mvn -Dtest=' .. filename .. '\\#' .. method_name .. ' surefire:test'
--     vim.cmd('!' .. command)
--   end
-- end, { desc = '[R]un Java Test [M]ethod' })

vim.keymap.set('n', '<leader>jt', function()
  local file = vim.fn.expand '%:t' -- Get the current filename
  local dir = vim.fn.expand '%:p:h' -- Get the directory path
  -- print(file .. ' fileeeeeeee')
  -- print(dir .. ' dirrrrrrrrrr')

  if file:match 'Test%.java$' then
    -- If in a test file, switch to the corresponding source file
    local src_file = file:gsub('Test%.java$', '.java')
    local src_path = dir:gsub('\\test\\', '\\main\\') .. '/' .. src_file
    -- print(src_path .. ' src path')
    vim.cmd('edit ' .. src_path)
  else
    -- If in a source file, switch to the corresponding test file
    local test_file = file:gsub('%.java$', 'Test.java')
    local test_path = dir:gsub('\\main\\', '\\test\\') .. '/' .. test_file
    -- print(test_path .. ' test path')
    vim.cmd('edit ' .. test_path)
  end
end, { desc = 'Jump to corresponding test/source file' })

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.java',
  callback = function()
    -- Remove unused imports
    -- require('jdtls').organize_imports()
    local _, _ = pcall(vim.lsp.codelens.refresh)
    -- Format the file
    -- vim.defer_fn(function()
    --   vim.lsp.buf.clear_references() -- Clears any stale references
    --   vim.lsp.buf.execute_command { command = 'java.apply.workspaceEdit' } -- Applies necessary changes
    --   vim.lsp.buf.document_highlight() -- Refresh highlights if needed
    -- end, 500) -- Delay refresh slightly to allow imports to settle
  end,
})

local config = {
  'mfussenegger/nvim-jdtls',
  dependencies = {
    'brianrbrenner/springboot-nvim',
    'mfussenegger/nvim-dap',
    ft = 'java',
  },
  on_attach = function()
    local _, _ = pcall(vim.lsp.codelens.refresh)
  end,
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    -- 💀
    'C:/Program Files/Java/jdk-21/bin/java', -- or '/path/to/java21_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.
    '-javaagent:C:/softwares/lombok.jar',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms2g',
    '-Xmx4g',
    '-XX:+UseG1GC',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',

    -- 💀
    '-jar',
    user_profile .. '/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.6.1000.v20250131-0606.jar',
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- Must point to the                                                     Change this to
    -- eclipse.jdt.ls installation                                           the actual version

    -- 💀
    '-configuration',
    user_profile .. '/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_win',
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.

    -- 💀
    -- See `data directory configuration` section in the README
    '-data',
    workspace_dir,
    -- 'C:/Users/rohit.kamu/AppData/Local/nvim-data/mason/packages/jdtls/workspace',
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  --
  -- vim.fs.root requires Neovim 0.10.
  -- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  root_dir = vim.fs.root(0, { '.git', 'mvnw', 'gradlew' }),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      configuration = {
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- And search for `interface RuntimeOption`
        -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
        runtimes = {
          {
            name = 'JavaSE-21',
            path = 'C:/Program Files/Java/jdk-21',
          },
          {
            name = 'JavaSE-18',
            path = 'C:/Program Files/Java/jdk-18.0.2.1',
          },
        },
        jdt = {
          ls = {
            lombokSupport = {
              enabled = true,
            },
          },
        },
        annotationProcessing = {
          enabled = true,
        },
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
    bundles = bundles,
  },
}

print 'java loaded'
require('jdtls').start_or_attach(config)

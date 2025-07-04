-- references:
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    dapui.setup()
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, {})
    vim.keymap.set('n', '<leader>dc', dap.continue, {})

    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Step over
    map('n', '<leader>dov', dap.step_over, opts)

    -- Step into
    map('n', '<leader>di', dap.step_into, opts)

    -- Step out
    map('n', '<leader>dou', dap.step_out, opts)

    -- Evaluate expression (hover over variable)
    map('n', '<Leader>de', function()
      require('dap.ui.widgets').hover()
    end, opts)

    -- Open REPL
    map('n', '<Leader>dr', dap.repl.open, opts)

    -- Run last
    map('n', '<Leader>dl', dap.run_last, opts)

    -- Toggle DAP UI (if using nvim-dap-ui)
    map('n', '<Leader>du', function()
      require('dapui').toggle()
    end, opts)

    local user_profile = os.getenv 'USERPROFILE' .. '/AppData/Local/nvim-related-data'
    require('dap').adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        -- 💀 Make sure to update this path to point to your installation
        args = { user_profile .. '/js-debug/src/dapDebugServer.js', '${port}' },
      },
    }

    require('dap').configurations.javascript = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        cwd = '${workspaceFolder}',
        sourceMaps = true,
        smartStep = true,
        skipFiles = { '<node_internals>/**', '**/node_modules/**' },
      },
      {
        type = 'pwa-node',
        request = 'attach',
        name = 'Attach to running Node process',
        -- processId = require('dap.utils').pick_process,
        port = 9229,
        cwd = '${workspaceFolder}',
        sourceMaps = true,
        skipFiles = { '<node_internals>/**', '**/node_modules/**' },
      },
    }

    -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript-deno
    dap.configurations.typescript = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        runtimeExecutable = 'ts-node', -- deno
        runtimeArgs = {
          'run',
          '--inspect-wait',
          '--allow-all',
        },
        program = '${file}',
        cwd = '${workspaceFolder}',
        attachSimplePort = 9229,
        -- outFiles = { '${workspaceFolder}/dist/**/*.js' }, -- optional if no TypeScript
      },
      {
        type = 'pwa-node',
        request = 'attach',
        name = 'Attach to running Node process',
        -- processId = require('dap.utils').pick_process,
        port = 9229,
        cwd = '${workspaceFolder}',
        sourceMaps = true,
        skipFiles = { '<node_internals>/**', '**/node_modules/**' },
      },
    }
  end,
}

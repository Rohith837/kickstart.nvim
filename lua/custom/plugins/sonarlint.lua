return {
  {
    url = 'https://gitlab.com/schrieveslaach/sonarlint.nvim',
    config = function()
      -- require('sonarlint').setup {
      --   server = {
      --     cmd = {
      --       'sonarlint-language-server',
      --       '-stdio',
      --       '-analyzers',
      --       -- 'C:/Users/kamur/AppData/Local/nvim-data/mason/share/sonarlint-analyzers/sonarjava.jar',
      --       vim.fn.expand '$MASON/share/sonarlint-analyzers/sonarjava.jar',
      --       vim.fn.expand '$MASON/share/sonarlint-analyzers/sonargo.jar',
      --       vim.fn.expand '$MASON/share/sonarlint-analyzers/sonarhtml.jar',
      --       vim.fn.expand '$MASON/share/sonarlint-analyzers/sonarpython.jar',
      --       vim.fn.expand '$MASON/share/sonarlint-analyzers/sonarjs.jar',
      --     },
      --     settings = {
      --       sonarlint = {
      --         test = 'test',
      --         -- rules = {
      --         --   ['typescript:S101'] = { level = 'on', parameters = { format = '^[A-Z][a-zA-Z0-9]*$' } },
      --         --   ['typescript:S103'] = { level = 'on', parameters = { maximumLineLength = 180 } },
      --         --   ['typescript:S106'] = { level = 'on' },
      --         --   ['typescript:S107'] = { level = 'on', parameters = { maximumFunctionParameters = 7 } },
      --         -- },
      --       },
      --     },
      --   },
      --   filetypes = {
      --     'java',
      --     'go',
      --     'html',
      --     'python',
      --     'javascript',
      --     'typescript',
      --   },
      -- }
    end,
  },
}

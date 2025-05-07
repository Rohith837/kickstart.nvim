return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
  },
  -- config = function()
  --   local null_ls = require 'null-ls'
  --
  --   null_ls.setup {
  --     sources = {
  --       null_ls.builtins.formatting.stylua,
  --       null_ls.builtins.completion.spell,
  --       require 'none-ls.diagnostics.eslint_d', -- requires none-ls-extras.nvim
  --       require 'none-ls.code_actions.eslint_d',
  --       require 'none-ls.formatting.eslint_d',
  --     },
  --   }
  -- end,
  config = function()
    local null_ls = require 'null-ls'
    local utils = require 'null-ls.utils'

    -- Check if ESLint is configured in the project
    local function is_eslint_configured()
      local eslint_config_files = { '.eslintrc.js', '.eslintrc.json', '.eslintrc.yaml', '.eslintrc.yml', 'eslint.config.mjs' }
      for _, file in ipairs(eslint_config_files) do
        local path = vim.fn.findfile(file, vim.fn.getcwd() .. ';')
        if path ~= '' then
          return true
        end
      end
      return false
    end

    local sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.completion.spell,
    }

    -- Only add ESLint-related sources if ESLint is configured
    if is_eslint_configured() then
      table.insert(sources, require 'none-ls.diagnostics.eslint_d') -- requires none-ls-extras.nvim
      table.insert(sources, require 'none-ls.code_actions.eslint_d')
      table.insert(sources, require 'none-ls.formatting.eslint_d')
    end

    null_ls.setup {
      sources = sources,
    }
  end,
}

return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'neovim/nvim-lspconfig',
    'ThePrimeagen/refactoring.nvim',
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
      null_ls.builtins.formatting.nginx_beautifier, -- NOTE: npm install -g nginxbeautifier
      -- null_ls.builtins.formatting.prettier,
      -- null_ls.builtins.formatting.prettierd,
      -- null_ls.builtins.diagnostics.misspell, -- NOTE: pip install misspell
      -- null_ls.builtins.diagnostics.codespell, -- NOTE: pip install codespell
      -- null_ls.builtins.diagnostics.shellcheck, --NOTE: pip install spellcheck
      null_ls.builtins.code_actions.gitsigns,
      -- null_ls.builtins.code_actions.refactoring,
      null_ls.builtins.formatting.prettierd, -- NOTE: npm install -g @fsouza/prettierd
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

    -- NOTE: https://github.com/jose-elias-alvarez/null-ls.nvim/discussions/244
    -- in short this is required for formatting through lsp
    require('lspconfig')['null_ls'].setup {}
  end,
}

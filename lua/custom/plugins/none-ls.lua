return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'

    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.completion.spell,
        require 'none-ls.diagnostics.eslint_d', -- requires none-ls-extras.nvim
        require 'none-ls.code_actions.eslint_d',
        require 'none-ls.formatting.eslint_d',
      },
    }
  end,
}

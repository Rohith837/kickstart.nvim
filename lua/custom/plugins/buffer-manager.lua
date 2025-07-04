return {
  'j-morano/buffer_manager.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('buffer_manager').setup {
      short_file_names = true,
    }

    local buffer_manager_ui = require 'buffer_manager.ui'

    vim.keymap.set('n', '<leader>]b', buffer_manager_ui.nav_next, { desc = 'Go To [N]ext Buffer' })
    vim.keymap.set('n', '<leader>[b', buffer_manager_ui.nav_prev, { desc = 'Go To [P]revious Buffer' })
    -- vim.keymap.set('n', '<leader>bm', buffer_manager_ui.toggle_quick_menu, { desc = 'Toggle [B]uffer [M]enu' })
  end,
}

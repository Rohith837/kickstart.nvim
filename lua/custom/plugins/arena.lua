return {
  'dzfrias/arena.nvim',
  event = 'BufWinEnter',
  -- Calls `.setup()` automatically
  -- config = true,
  config = function()
    local arena = require 'arena'
    arena.setup {}
    -- vim.keymap.set('n', '<leader>]b', buffer_manager_ui.nav_next, { desc = 'Go To [N]ext Buffer' })
    -- vim.keymap.set('n', '<leader>[b', buffer_manager_ui.nav_prev, { desc = 'Go To [P]revious Buffer' })
    vim.keymap.set('n', '<leader>bm', arena.open, { desc = 'Toggle [B]uffer [M]enu' })
  end,
}

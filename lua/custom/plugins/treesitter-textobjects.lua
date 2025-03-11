return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  dependencies = {
    'lewis6991/gitsigns.nvim',
  },
  lazy = true,
  config = function()
    local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

    -- Repeat movement with ; and ,
    -- ensure ; goes forward and , goes backward regardless of the last direction
    vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

    local quickfixNavigation = require 'custom/utils/quickfix-navigation'
    -- Make the quickfix navigation repeatable
    local next_qf_repeat, prev_qf_repeat = ts_repeat_move.make_repeatable_move_pair(quickfixNavigation.quickfix_next, quickfixNavigation.quickfix_prev)
    vim.keymap.set('n', ']q', next_qf_repeat)
    vim.keymap.set('n', '[q', prev_qf_repeat)

    local diagnostics = require 'custom/utils/diagnostics'
    -- Make the diagnostic navigation repeatable
    local next_diag_repeat, prev_diag_repeat = ts_repeat_move.make_repeatable_move_pair(diagnostics.diagnostic_next, diagnostics.diagnostic_prev)
    -- Set keymaps for diagnostic navigation
    vim.keymap.set('n', ']d', next_diag_repeat)
    vim.keymap.set('n', '[d', prev_diag_repeat)

    -- Set keymaps for quickfix navigation
    local gitsigns = require 'gitsigns'
    -- local gs = require 'gitsigns'
    local next_git_change = function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end
    local prev_git_change = function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end
    -- local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
    local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(next_git_change, prev_git_change)
    -- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.

    vim.keymap.set('n', ']c', next_hunk_repeat)
    vim.keymap.set('n', '[c', prev_hunk_repeat)

    -- vim way: ; goes to the direction you were moving.
    -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
    -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

    -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
  end,
}

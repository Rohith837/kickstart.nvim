vim.keymap.set('n', '-', ':Ex<CR>')
vim.keymap.set('i', 'jj', '<Esc>')

vim.keymap.set('x', '<leader>p', '"_dp')
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('x', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show Diagnostic Error Message' })
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist, { desc = 'Open all diagnostic [Quickfix] list' })
-- to join next line
vim.keymap.set('n', 'J', 'mzJ`z')

-- Move line up
-- vim.keymap.set('n', 'K', ':m .-2<CR>==', { noremap = true, silent = true })
-- vim.keymap.set('i', 'K', '<Esc>:m .-2<CR>==gi', { noremap = true, silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Move line down
-- vim.keymap.set('n', 'J', ':m .+1<CR>==', { noremap = true, silent = true })
-- vim.keymap.set('i', 'J', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

local function move_to_first_non_whitespace_char()
  -- Save current cursor position
  local current_pos = vim.api.nvim_win_get_cursor(0)

  -- Get the current line
  local line = vim.api.nvim_get_current_line()

  -- Find the first non-space character
  local first_non_whitespace = string.find(line, '%S')

  if first_non_whitespace then
    -- Move the cursor to the first non-whitespace character
    vim.api.nvim_win_set_cursor(0, { current_pos[1], first_non_whitespace - 1 })
  end
end
vim.keymap.set('i', '<C-a>', '<END>', { desc = 'Move to end of line without exiting insert mode' })
vim.keymap.set('i', '<C-b>', move_to_first_non_whitespace_char, { desc = 'Move to beginning of line without exiting insert mode' })
vim.keymap.set('i', '<M-h>', '<Left>', { desc = 'Move left in insert mode', silent = true, noremap = true })
vim.keymap.set('i', '<M-j>', '<Down>', { desc = 'Move down in insert mode', silent = true, noremap = true })
vim.keymap.set('i', '<M-k>', '<Up>', { desc = 'Move up in insert mode', silent = true, noremap = true })
vim.keymap.set('i', '<M-l>', '<Right>', { desc = 'Move right in insert mode', silent = true, noremap = true })

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open current buffer diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist, { desc = 'Open all diagnostic [Quickfix] list' })

vim.keymap.set('t', 'jj', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

local terminal = require 'custom/utils/terminal'

vim.keymap.set('n', '<leader>t', function()
  terminal.openExistingTerminal()
end)

require 'custom.angular-keymaps'

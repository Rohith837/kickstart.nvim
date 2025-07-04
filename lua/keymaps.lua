-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })


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

vim.keymap.set('n', '<leader>\\', "<CMD>vsp<CR>", { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>-', "<CMD>sp<CR>", { desc = 'Split window horizontally' })

vim.keymap.set('n', '<leader>x', "<CMD>q<CR>", { desc = 'Close current window' })

local terminal = require 'custom/utils/terminal'

vim.keymap.set('n', '<leader>t', function()
  terminal.openExistingTerminal()
end)

-- marks
for c = string.byte("a"), string.byte("z") do
  local lower = string.char(c)
  local upper = string.upper(lower)

  vim.keymap.set("n", "<leader>m" .. lower, function()
    vim.cmd("normal! '" .. upper)
  end, { desc = "Jump to mark '" .. upper })
end


require 'custom.angular-keymaps'

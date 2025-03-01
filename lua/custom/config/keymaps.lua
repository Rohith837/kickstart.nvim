local angular_change_file = function(extension)
  local current_file = vim.fn.expand '%:p:r'
  current_file = string.gsub(current_file, '%.spec', '')
  local new_file = current_file .. extension
  vim.cmd('e ' .. new_file)
end

local angular_keymap_to_change_files = function(key, extension)
  vim.keymap.set('n', '<leader>a' .. key, function()
    angular_change_file(extension)
  end, { noremap = true, silent = true })
end

angular_keymap_to_change_files('c', '.ts')
angular_keymap_to_change_files('h', '.html')
angular_keymap_to_change_files('s', '.scss')
angular_keymap_to_change_files('t', '.spec.ts')

-- Move line up
-- vim.keymap.set('n', 'K', ':m .-2<CR>==', { noremap = true, silent = true })
-- vim.keymap.set('i', 'K', '<Esc>:m .-2<CR>==gi', { noremap = true, silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Move line down
-- vim.keymap.set('n', 'J', ':m .+1<CR>==', { noremap = true, silent = true })
-- vim.keymap.set('i', 'J', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- vim.keymap.set('n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })

vim.keymap.set('x', '<leader>p', '"_dp')

vim.keymap.set('n', '<leader>d', '"_d')

-- to join next line
vim.keymap.set('n', 'J', 'mzJ`z')

-- vim.keymap.set('n', ']q', '<cmd>cnext<CR>zz')
-- vim.keymap.set('n', '[q', '<cmd>cprev<CR>zz')
-- vim.keymap.set('n', '', '<cmd>lnext<CR>zz')  -- use builtin keybind '[d' and ']d' instead
-- vim.keymap.set('n', '', '<cmd>lprev<CR>zz')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show Diagnostic Error Message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open current buffer diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist, { desc = 'Open all diagnostic [Quickfix] list' })

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
vim.keymap.set('n', '<C-l>', '<leader><C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<leader><C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<leader><C-w><C-k>', { desc = 'Move focus to the upper window' })

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

vim.keymap.set('i', '<M-h>', '<Left>', { desc = 'Move left in insert mode', silent = true, noremap = true })
vim.keymap.set('i', '<M-j>', '<Down>', { desc = 'Move down in insert mode', silent = true, noremap = true })
vim.keymap.set('i', '<M-k>', '<Up>', { desc = 'Move up in insert mode', silent = true, noremap = true })
vim.keymap.set('i', '<M-l>', '<Right>', { desc = 'Move right in insert mode', silent = true, noremap = true })

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open current buffer diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist, { desc = 'Open all diagnostic [Quickfix] list' })

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

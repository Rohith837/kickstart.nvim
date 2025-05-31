local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- remap leader key
keymap('n', '<Space>', '', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.scrolloff = 20

-- yank to system clipboard
keymap({ 'n', 'v' }, '<leader>y', '"+y', opts)

-- paste from system clipboard
keymap({ 'n', 'v' }, '<leader>p', '"+p', opts)

-- better indent handling
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- move text up and down
keymap('v', 'J', ':m .+1<CR>==', opts)
keymap('v', 'K', ':m .-2<CR>==', opts)
keymap('x', 'J', ":move '>+1<CR>gv-gv", opts)
keymap('x', 'K', ":move '<-2<CR>gv-gv", opts)

-- paste preserves primal yanked piece
keymap('v', 'p', '"_dP', opts)

-- removes highlighting after escaping vim search
keymap('n', '<Esc>', '<Esc>:noh<CR>', opts)

keymap('i', 'jj', '<Esc>')

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

-- call vscode commands from neovim

-- general keymaps
keymap({ 'n', 'v' }, '<leader>t', "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>")
keymap({ 'n', 'v' }, '<leader>b', "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>")
keymap({ 'n', 'v' }, '<leader>e', "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
keymap({ 'n', 'v' }, '<leader>ca', "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>") -- code action
keymap({ 'n', 'v' }, '<leader>ee', "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>")
keymap({ 'n', 'v' }, '<leader>cn', "<cmd>lua require('vscode').action('notifications.clearAll')<CR>")
keymap({ 'n', 'v' }, '<leader>sf', "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
keymap({ 'n', 'v' }, '<leader>cp', "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>")
keymap({ 'n', 'v' }, '<leader>pr', "<cmd>lua require('vscode').action('code-runner.run')<CR>")
keymap({ 'n', 'v' }, '<leader>f', "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")

-- harpoon keymaps
keymap({ 'n', 'v' }, '<leader>ha', "<cmd>lua require('vscode').action('vscode-harpoon.addEditor')<CR>")
keymap({ 'n', 'v' }, '<leader>ho', "<cmd>lua require('vscode').action('vscode-harpoon.editorQuickPick')<CR>")
keymap({ 'n', 'v' }, '<leader>he', "<cmd>lua require('vscode').action('vscode-harpoon.editEditors')<CR>")
keymap({ 'n', 'v' }, '<leader>h1', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor1')<CR>")
keymap({ 'n', 'v' }, '<leader>h2', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor2')<CR>")
keymap({ 'n', 'v' }, '<leader>h3', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor3')<CR>")
keymap({ 'n', 'v' }, '<leader>h4', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor4')<CR>")
keymap({ 'n', 'v' }, '<leader>h5', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor5')<CR>")
keymap({ 'n', 'v' }, '<leader>h6', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor6')<CR>")
keymap({ 'n', 'v' }, '<leader>h7', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor7')<CR>")
keymap({ 'n', 'v' }, '<leader>h8', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor8')<CR>")
keymap({ 'n', 'v' }, '<leader>h9', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor9')<CR>")

-- project manager keymaps
keymap({ 'n', 'v' }, '<leader>pa', "<cmd>lua require('vscode').action('projectManager.saveProject')<CR>")
keymap({ 'n', 'v' }, '<leader>po', "<cmd>lua require('vscode').action('projectManager.listProjectsNewWindow')<CR>")
keymap({ 'n', 'v' }, '<leader>pe', "<cmd>lua require('vscode').action('projectManager.editProjects')<CR>")

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

local terminal = require 'custom/utils/terminal'

vim.keymap.set('n', '<leader>art', function()
  local file_name = vim.api.nvim_buf_get_name(0)
  file_name = vim.fn.fnamemodify(file_name, ':t')
  local ng_test_command = 'ng test --watch --code-coverage --include=**/' .. file_name .. '\r\n'

  terminal.stopJob()
  terminal.openExistingTerminal()
  vim.fn.chansend(terminal.job_id, { ng_test_command })
end)

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

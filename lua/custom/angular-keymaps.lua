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

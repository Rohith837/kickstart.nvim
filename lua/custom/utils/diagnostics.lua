local M = {}

function M.diagnostic_next()
  local current_pos = vim.api.nvim_win_get_cursor(0) -- Get current cursor position
  vim.diagnostic.goto_next { wrap = false, float = true } -- Try to go to the next diagnostic without wrapping

  local new_pos = vim.api.nvim_win_get_cursor(0) -- Get the new cursor position after navigation
  -- If the cursor position hasn't changed (meaning there are no more diagnostics), wrap around
  if current_pos[1] == new_pos[1] and current_pos[2] == new_pos[2] then
    -- Go to the first diagnostic manually
    vim.cmd 'normal! gg' -- Go to the top of the buffer
    vim.diagnostic.goto_next() -- Jump to the first diagnostic
  end

  vim.cmd 'normal! zz' -- Center the screen
end

-- Function to move to the previous diagnostic, or wrap around to the last if at the beginning
function M.diagnostic_prev()
  local current_pos = vim.api.nvim_win_get_cursor(0) -- Get current cursor position
  vim.diagnostic.goto_prev { wrap = false } -- Try to go to the previous diagnostic without wrapping

  local new_pos = vim.api.nvim_win_get_cursor(0) -- Get the new cursor position after navigation
  -- If the cursor position hasn't changed (meaning there are no more diagnostics), wrap around
  if current_pos[1] == new_pos[1] and current_pos[2] == new_pos[2] then
    -- Go to the last diagnostic manually
    vim.cmd 'normal! G' -- Go to the bottom of the buffer
    vim.diagnostic.goto_prev() -- Jump to the last diagnostic
  end

  vim.cmd 'normal! zz' -- Center the screen
end

return M

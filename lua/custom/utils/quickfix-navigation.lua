local M = {}

function M.quickfix_next()
  local current_idx = vim.fn.getqflist({ idx = 0 }).idx
  local total_items = vim.fn.getqflist({ size = 0 }).size

  if current_idx == total_items then
    vim.cmd 'cfirst' -- If at the last item, go to the previous
  else
    vim.cmd 'cnext' -- Otherwise, move to the next item
  end

  vim.cmd 'normal! zz' -- Center the screen
end

-- Function to move to the previous item, or go to the next if at the beginning
function M.quickfix_prev()
  local current_idx = vim.fn.getqflist({ idx = 0 }).idx

  if current_idx == 1 then
    vim.cmd 'clast' -- If at the first item, go to the next
  else
    vim.cmd 'cprev' -- Otherwise, move to the previous item
  end

  vim.cmd 'normal! zz' -- Center the screen
end

return M

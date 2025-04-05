local M = {}

M.job_id = 0
M.term_buf_id = 0

function M.openExistingTerminal()
  vim.cmd 'vnew'
  if M.term_buf_id ~= 0 and vim.api.nvim_buf_is_valid(M.term_buf_id) then
    vim.cmd('b' .. M.term_buf_id)
  else
    vim.cmd 'term'
  end
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 5)

  M.job_id = vim.bo.channel
  M.term_buf_id = vim.api.nvim_get_current_buf()
end

function M.stopJob()
  if M.job_id ~= 0 then
    vim.fn.jobstop(M.job_id)
    vim.api.nvim_buf_delete(M.term_buf_id, { force = true })
    M.job_id = 0
    M.term_buf_id = 0
  end
end

return M

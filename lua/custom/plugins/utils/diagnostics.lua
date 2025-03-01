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

-- change this code this is not correct
-- local function get_all_diagnostics()
--   local diagnostics = {}
--   local buffers = vim.api.nvim_list_bufs() -- Get all buffers
--   for _, buf in ipairs(buffers) do
--     -- Append diagnostics from each buffer to the diagnostics table
--     for _, diag in ipairs(vim.diagnostic.get(buf)) do
--       diag.bufnr = buf -- Save the buffer number for later navigation
--       table.insert(diagnostics, diag)
--     end
--   end
--   -- Sort diagnostics by position (line number, column number)
--   table.sort(diagnostics, function(a, b)
--     if a.lnum == b.lnum then
--       return a.col < b.col
--     else
--       return a.lnum < b.lnum
--     end
--   end)
--   return diagnostics
-- end
--
-- -- Function to navigate to the next diagnostic, wrapping around if necessary
-- local function diagnostic_next_global()
--   local diagnostics = get_all_diagnostics() -- Get all diagnostics
--   if #diagnostics == 0 then
--     return
--   end -- If there are no diagnostics, return early
--
--   local current_buf = vim.api.nvim_get_current_buf() -- Get current buffer number
--   local current_pos = vim.api.nvim_win_get_cursor(0) -- Get current cursor position
--
--   -- Find the next diagnostic
--   for _, diag in ipairs(diagnostics) do
--     if diag.bufnr == current_buf and (diag.lnum > current_pos[1] - 1 or (diag.lnum == current_pos[1] - 1 and diag.col > current_pos[2])) then
--       vim.api.nvim_set_current_buf(diag.bufnr)
--       vim.api.nvim_win_set_cursor(0, { diag.lnum + 1, diag.col })
--       vim.cmd 'normal! zz' -- Center the screen
--       return
--     end
--   end
--
--   -- If no next diagnostic was found, wrap around to the first diagnostic
--   local first_diag = diagnostics[1]
--   vim.api.nvim_set_current_buf(first_diag.bufnr)
--   vim.api.nvim_win_set_cursor(0, { first_diag.lnum + 1, first_diag.col })
--   vim.cmd 'normal! zz' -- Center the screen
-- end
--
-- -- Function to navigate to the previous diagnostic, wrapping around if necessary
-- local function diagnostic_prev_global()
--   local diagnostics = get_all_diagnostics() -- Get all diagnostics
--   if #diagnostics == 0 then
--     return
--   end -- If there are no diagnostics, return early
--
--   local current_buf = vim.api.nvim_get_current_buf() -- Get current buffer number
--   local current_pos = vim.api.nvim_win_get_cursor(0) -- Get current cursor position
--
--   -- Find the previous diagnostic
--   for i = #diagnostics, 1, -1 do
--     local diag = diagnostics[i]
--     if diag.bufnr == current_buf and (diag.lnum < current_pos[1] - 1 or (diag.lnum == current_pos[1] - 1 and diag.col < current_pos[2])) then
--       vim.api.nvim_set_current_buf(diag.bufnr)
--       vim.api.nvim_win_set_cursor(0, { diag.lnum + 1, diag.col })
--       vim.cmd 'normal! zz' -- Center the screen
--       return
--     end
--   end
--
--   -- If no previous diagnostic was found, wrap around to the last diagnostic
--   local last_diag = diagnostics[#diagnostics]
--   vim.api.nvim_set_current_buf(last_diag.bufnr)
--   vim.api.nvim_win_set_cursor(0, { last_diag.lnum + 1, last_diag.col })
--   vim.cmd 'normal! zz' -- Center the screen
-- end
--
-- -- Make the diagnostic navigation repeatable
-- local next_diag_repeat, prev_diag_repeat = ts_repeat_move.make_repeatable_move_pair(diagnostic_next_global, diagnostic_prev_global)
--
-- -- Set keymaps for global diagnostic navigation
-- vim.keymap.set({ 'n', 'x', 'o' }, ']d', next_diag_repeat)
-- vim.keymap.set({ 'n', 'x', 'o' }, '[d', prev_diag_repeat)

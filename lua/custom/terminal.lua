local terminals = {} -- store { win = ..., buf = ... }
local current_index = 1

local function open_floating_terminal()
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)

  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  vim.fn.termopen(vim.o.shell)
  -- vim.cmd 'startinsert'

  -- Track terminal
  table.insert(terminals, { buf = buf, win = win })
  current_index = #terminals
end

local function focus_terminal(index)
  if terminals[index] and vim.api.nvim_win_is_valid(terminals[index].win) then
    vim.api.nvim_set_current_win(terminals[index].win)
    current_index = index
  end
end

local function next_terminal()
  if #terminals == 0 then
    return
  end
  local start = current_index
  repeat
    current_index = (current_index % #terminals) + 1
    if vim.api.nvim_win_is_valid(terminals[current_index].win) then
      vim.api.nvim_set_current_win(terminals[current_index].win)
      break
    end
  until current_index == start
end

local function prev_terminal()
  if #terminals == 0 then
    return
  end
  local start = current_index
  repeat
    current_index = (current_index - 2 + #terminals) % #terminals + 1
    if vim.api.nvim_win_is_valid(terminals[current_index].win) then
      vim.api.nvim_set_current_win(terminals[current_index].win)
      break
    end
  until current_index == start
end

-- Optional: close current terminal and remove it from tracking
local function close_current_terminal()
  if terminals[current_index] then
    local win = terminals[current_index].win
    local buf = terminals[current_index].buf
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    if vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
    table.remove(terminals, current_index)
    if current_index > #terminals then
      current_index = #terminals
    end
  end
end

vim.keymap.set('n', '<leader>tt', open_floating_terminal, { desc = 'Open new floating terminal' })
vim.keymap.set('n', '<leader>tn', next_terminal, { desc = 'Next floating terminal' })
vim.keymap.set('n', '<leader>tp', prev_terminal, { desc = 'Previous floating terminal' })
vim.keymap.set('n', '<leader>tc', close_current_terminal, { desc = 'Close current floating terminal' })

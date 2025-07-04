vim.g.base46_cache = vim.fn.stdpath 'data' .. '\\base46_cache\\'

local function get_last_dirs(path, max_levels)
  path = path:gsub('\\', '/') -- normalize slashes
  local parts = {}

  for part in string.gmatch(path, '[^/]+') do
    table.insert(parts, part)
  end

  local result = {}
  local start = math.max(1, #parts - (max_levels - 1))
  for i = start, #parts do
    table.insert(result, parts[i])
  end

  return table.concat(result, '-')
end

local workspace_path = vim.fn.getcwd()

local cache_dir = vim.fn.stdpath 'data'

local project_name = vim.fn.fnamemodify(workspace_path, ':p')

project_name = get_last_dirs(project_name, 3)

local project_dir = cache_dir .. '/myshada/' .. project_name

if vim.fn.isdirectory(project_dir) == 0 then
  vim.fn.mkdir(project_dir, 'p')
end

local shadafile = project_dir .. '/' .. vim.fn.sha256(workspace_path):sub(1, 8) .. '.shada'

vim.opt.shadafile = shadafile

require 'options'


-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
require 'keymaps'

require 'auto-commands'


-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  { import = 'plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- put this after lazy setup
-- if vim.fn.isdirectory(vim.g.base46_cache) == 0 then
--   vim.fn.mkdir(vim.g.base46_cache, 'p')
-- end

-- (method 1, For heavy lazyloaders)
dofile(vim.g.base46_cache .. 'cmp')
-- dofile(vim.g.base46_cache .. 'defaults')
-- dofile(vim.g.base46_cache .. 'statusline')

-- for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
--   dofile(vim.g.base46_cache .. v)
-- end
-- this is
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

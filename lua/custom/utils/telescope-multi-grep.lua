local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local make_entry = require 'telescope.make_entry'
local conf = require 'telescope.config'.values
local M = {}

local search_live_multigrep = function(opts)
  opts = opts or {}
  local cwd = opts.cwd or vim.fn.getcwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == '' then
        return nil
      end

      local pieces = vim.split(prompt, '  ')
      local args = { 'rg' }
      if pieces[1] then
        table.insert(args, '--e')
        table.insert(args, pieces[1])
      end

      if pieces[2] then
        table.insert(args, '--g')
        table.insert(args, pieces[2])
      end

      return vim.tbl_flatten { args, { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' } }
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = cwd,
  }

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = 'Live Multi Grep',
      previewer = conf.grep_previewer(opts),
      finder = finder,
      sorter = require 'telescope.sorters'.empty()
    })
    :find()
end

M.setup = function(opts)
  search_live_multigrep(opts)
end

  -- search_live_multigrep()
return M;

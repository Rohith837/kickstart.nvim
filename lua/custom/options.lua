vim.opt.tabstop = 4 -- Number of spaces that a <Tab> counts for
vim.opt.shiftwidth = 4
vim.opt.expandtab = false -- Use tabs instead of spaces

vim.opt.fileformat = 'unix'
-- vim.opt.grepprg = 'rg --vimgrep -uu --pcre2'
vim.opt.grepprg = 'rg --vimgrep --hidden --glob "!.git/" --glob "!node_modules/" --pcre2'

vim.opt.relativenumber = true

vim.opt.wrap = false


vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

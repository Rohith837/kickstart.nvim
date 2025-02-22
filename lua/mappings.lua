require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>")


-- keymap for angular
map("n","<leader>ac",":e %:r.ts<CR>", {noremap = true, silent = true })
map("n","<leader>ah",":e %:r.html<CR>", {noremap = true, silent = true })
map("n","<leader>as",":e %:r.scss<CR>", {noremap = true, silent = true })
map("n","<leader>at",":e %:r.spec.ts<CR>", {noremap = true, silent = true })


-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

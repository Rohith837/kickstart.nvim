return {
  -- "Rohith837/first-plugin.nvim",
  dir = "C:/git/github/neovim/first-plugin",
  config = function()
    require("rohith").setup({
      log = true,
    })

    local bookmarks = require("bookmarks")
    vim.keymap.set("n", "<leader>ba", bookmarks.add_or_edit_bookmark, { desc = "[A]dd Bookmark" })
    vim.keymap.set("n", "<leader>bn", bookmarks.go_to_next_bookmark, { desc = "Go To [N]ext Bookmark" })
    vim.keymap.set("n", "<leader>bp", bookmarks.go_to_previous_bookmark, { desc = "Go To [P]revious Bookmark" })

    local recently_visited_files = require("utils.recently_visited_files")
    vim.keymap.set("n", "<leader>s.", recently_visited_files.create_telescope, { desc = "Open [F]ile" })
  end
}

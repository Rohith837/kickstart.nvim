local M = {}

-- M.base46 = {
--   theme = 'tundra',
--   transparent = true,
-- }

M.ui = {
  cmp = {
    icons_left = true, -- only for non-atom styles!
    style = 'default', -- default/flat_light/flat_dark/atom/atom_colored
    abbr_maxwidth = 100,
    format_colors = {
      tailwind = false, -- will work for css lsp too
      icon = '󱓻',
    },
  },
  telescope = { style = 'bordered' }, -- borderless / bordered
}

return M

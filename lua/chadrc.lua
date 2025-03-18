local M = {}

M.base46 = {
  -- theme = 'onedark',
  -- transparent = true,
}

M.ui = {
  cmp = {
    icons_left = true, -- only for non-atom styles!
    style = 'default', -- default/flat_light/flat_dark/atom/atom_colored
    abbr_maxwidth = 60,
    format_colors = {
      tailwind = true, -- will work for css lsp too
      icon = '󱓻',
    },
  },
  telescope = { style = 'bordered' }, -- borderless / bordered
}

return M

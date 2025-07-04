return {
  'nanotee/sqls.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
  },
  config = function()
    require('lspconfig').sqls.setup {
      cmd = { 'sqls', '-config', 'D:/programming/postgres/config.yml' },
      -- cmd = { 'go', 'run', 'github.com/lighttiger2505/sqls', '-config', 'D:/programming/postgres/config.yml' },
    }
  end,
}

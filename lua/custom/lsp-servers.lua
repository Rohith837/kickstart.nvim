local user_profile = os.getenv 'USERPROFILE'

local angular_cmd = {
  user_profile .. '/AppData/Roaming/npm/ngserver.CMD',
  '--stdio',
  '--tsProbeLocations',
  user_profile .. '/AppData/Roaming/npm/node_modules',
  '--ngProbeLocations',
  user_profile .. '/AppData/Roaming/npm/node_modules/@angular/language-server/node_modules',
}

return {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
  --
  -- Some languages (like typescript) have entire language plugins that can be useful:
  --    https://github.com/pmizio/typescript-tools.nvim
  --
  -- But for many setups, the LSP (`ts_ls`) will work just fine
  -- ts_ls = { filetypes = { 'javascript', 'typescript', 'typescriptreact' } },
  -- angularls = {
  --   cmd = angular_cmd,
  --   ---@diagnostic disable-next-line: unused-local
  --   on_new_config = function(new_config, new_root_dir)
  --     -- print(new_root_dir)
  --     new_config.cmd = angular_cmd
  --   end,
  --   -- filetypes = { 'typescript', 'typescriptreact', 'html' },
  -- },
  angularls = require 'custom.angular-lsp',
  html = {
    cmd = { 'vscode-html-language-server', '--stdio' },
    filetypes = { 'html', 'templ' },
    -- root_dir = util.root_pattern('package.json', '.git'),
    single_file_support = true,
    settings = {},
    init_options = {
      provideFormatter = true,
      embeddedLanguages = { css = true, javascript = true },
      configurationSection = { 'html', 'css', 'javascript' },
    },
  },
  -- npm i -g vscode-langservers-extracted
  -- run this command globally
  -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/cssls.lua
  -- NOTE: check the above link for more info
  cssls = {
    cmd = { 'vscode-css-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
    init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
    -- root_dir = util.root_pattern('package.json', '.git'),
    single_file_support = true,
    settings = {
      css = { validate = true },
      scss = { validate = true },
      less = { validate = true },
    },
  },
  css_variables = {
    cmd = { 'css-variables-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
    -- root_dir = util.root_pattern('package.json', '.git'),
    -- Same as inlined defaults that don't seem to work without hardcoding them in the lua config
    -- https://github.com/vunguyentuan/vscode-css-variables/blob/763a564df763f17aceb5f3d6070e0b444a2f47ff/packages/css-variables-language-server/src/CSSVariableManager.ts#L31-L50
    settings = {
      cssVariables = {
        lookupFiles = { '**/*.less', '**/*.scss', '**/*.sass', '**/*.css' },
        blacklistFolders = {
          '**/.cache',
          '**/.DS_Store',
          '**/.git',
          '**/.hg',
          '**/.next',
          '**/.svn',
          '**/bower_components',
          '**/CVS',
          '**/dist',
          '**/node_modules',
          '**/tests',
          '**/tmp',
        },
      },
    },
  },
  -- npm i -g vscode-langservers-extracted
  -- install the above package
  jsonls = {
    cmd = { 'vscode-json-language-server', '--stdio' },
    filetypes = { 'json', 'jsonc' },
    init_options = {
      provideFormatter = true,
    },
    -- root_dir = function(fname)
    --   return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
    -- end,
    single_file_support = true,
  },
  -- emmet_ls = {
  --   filetypes = { 'html', 'css', 'javascriptreact', 'typescriptreact' },
  -- },
  lua_ls = {
    -- cmd = { ... },
    -- filetypes = { ... },
    -- capabilities = {},
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },

  -- NOTE: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/nginx_language_server.lua
  -- npm install -g @nginxinc/nginx-language-server this is not working
  -- pip install -U nginx-language-server
  -- nginx-language-server --version
  nginx_language_server = {
    cmd = { 'nginx-language-server' },
    filetypes = { 'nginx' },
    root_markers = { 'nginx.conf', '.git' },
  },

  pylsp = {
    cmd = { 'pylsp' },
    filetypes = { 'python' },
    root_markers = {
      'pyproject.toml',
      'setup.py',
      'setup.cfg',
      'requirements.txt',
      'Pipfile',
      '.git',
    },
  },

  --NOTE: npm install -g  @postgrestools/postgrestools
  postgres_lsp = {
    cmd = { 'postgrestools', 'lsp-proxy' },
    filetypes = {
      'sql',
    },
    root_markers = { 'postgrestools.jsonc' },
  },

  -- sqls = {
  --   -- on_attach = function(client, bufnr)
  --   --   require('sqls').on_attach(client, bufnr) -- require sqls.nvim
  --   -- end,
  --   cmd = { 'go', 'run', '~/go/src/github.com/lighttiger2505/sqls', '-config', 'D:/programming/postgres/config.yml' },
  --   -- cmd = { 'sqls', '-config', 'D:/programming/postgres/config.yml' },
  --   filetypes = { 'sql', 'mysql' },
  --   -- root_markers = { 'config.yml' },
  --   settings = {
  --     -- sqls = {
  --     --   connections = {
  --     --     -- {
  --     --     --   driver = 'mysql',
  --     --     --   dataSourceName = 'root:root@tcp(127.0.0.1:13306)/world',
  --     --     -- },
  --     --     {
  --     --       driver = 'postgresql',
  --     --       -- dataSourceName = 'host=127.0.0.1 port=5432 user=postgres password=Kamurohith%40123 dbname=dummy_shop sslmode=disable',
  --     --       -- Choose ONE of these formats:
  --     --       -- dataSourceName = 'host=127.0.0.1 port=5432 user=postgres password=Kamurohith%40123 dbname=dummy_shop sslmode=disable',
  --     --       -- OR
  --     --       dataSourceName = 'postgres://postgres:Kamurohith%40123@127.0.0.1:5432/dummy_shop?sslmode=disable',
  --     --     },
  --     --   },
  --     -- },
  --   },
  -- },
}

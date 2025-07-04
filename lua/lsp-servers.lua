local user_profile = os.getenv 'USERPROFILE'

return {
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
    single_file_support = true,
  },
  lua_ls = {
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
}

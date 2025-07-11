---@brief
---
--- https://github.com/angular/vscode-ng-language-service
--- `angular-language-server` can be installed via npm `npm install -g @angular/language-server`.
---
--- ```lua
--- local project_library_path = "/path/to/project/lib"
--- local cmd = {"ngserver", "--stdio", "--tsProbeLocations", project_library_path , "--ngProbeLocations", project_library_path}
---
--- vim.lsp.config('angularls', {
---   cmd = cmd,
--- })
--- ```

-- Angular requires a node_modules directory to probe for @angular/language-service and typescript
-- in order to use your projects configured versions.
local root_dir = vim.fn.getcwd()
local node_modules_dir = vim.fs.find('node_modules', { path = root_dir, upward = true })[1]
local project_root = node_modules_dir and vim.fs.dirname(node_modules_dir) or '?'

local function get_probe_dir()
  return project_root and (project_root .. '/node_modules') or ''
end

local function get_angular_core_version()
  if not project_root then
    return ''
  end

  local package_json = project_root .. '/package.json'
  if not vim.uv.fs_stat(package_json) then
    return ''
  end

  local contents = io.open(package_json):read '*a'
  local json = vim.json.decode(contents)
  if not json.dependencies then
    return ''
  end

  local angular_core_version = json.dependencies['@angular/core']

  angular_core_version = angular_core_version and angular_core_version:match '%d+%.%d+%.%d+'

  return angular_core_version
end

local default_probe_dir = get_probe_dir()
local default_angular_core_version = get_angular_core_version()

-- structure should be like
-- - $EXTENSION_PATH
--   - @angular
--     - language-server
--       - bin
--         - ngserver
--   - typescript
-- local ngserver_exe = vim.fn.exepath 'ngserver'
-- local ngserver_path = #(ngserver_exe or '') > 0 and vim.fs.dirname(vim.uv.fs_realpath(ngserver_exe)) or '?'
-- local extension_path = vim.fs.normalize(vim.fs.joinpath(ngserver_path, '../../../'))

local default_node_modules = 'C:/git/EWDS/EWDSApp/node_modules'

-- angularls will get module by `require.resolve(PROBE_PATH, MODULE_NAME)` of nodejs
local ts_probe_dirs = vim.iter({ default_node_modules, default_probe_dir }):join ','
local ng_probe_dirs = vim.iter({ default_node_modules, default_probe_dir }):join ','

-- print(ts_probe_dirs)
-- print(ng_probe_dirs)

local cmd = {
  'ngserver',
  '--stdio',
  '--tsProbeLocations',
  ts_probe_dirs,
  '--ngProbeLocations',
  ng_probe_dirs,
  '--angularCoreVersion',
  default_angular_core_version,
  '--forceStrictTemplates',
  'true',
  '--includeAutomaticOptionalChainCompletions',
  'true',
  '--includeCompletionsWithSnippetText',
  'true',
}

-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/angularls.lua
return {
  cmd = cmd,
  filetypes = { 'typescript', 'html', 'typescriptreact', 'typescript.tsx', 'htmlangular' },
  root_markers = { 'angular.json', 'nx.json' },
  on_new_config = function(new_config, new_root_dir)
    new_config.cmd = cmd
  end,
}

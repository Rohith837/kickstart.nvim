require 'custom.llm-code-action'
local lspconfig = require 'lspconfig'

return {
  default_config = {
    cmd = { 'node', 'C:/git/github/node.js/auto-completion-lsp-server/out/server.js', '--stdio' },
    filetypes = { 'javascript', 'typescript' }, -- adjust as needed
    root_dir = lspconfig.util.root_pattern('.git', '.'),
    handlers = {
      -- ['window/logMessage'] = function(err, method, params, client_id)
      --   print('LSP LOG:', vim.inspect(params), vim.inspect(method))
      -- end,
      ['custom/getClientDiagnostics'] = function(_, params, ctx, _)
        local uri = params.uri
        local bufnr = vim.uri_to_bufnr(uri)

        if not vim.api.nvim_buf_is_loaded(bufnr) then
          vim.fn.bufload(bufnr)
        end

        local diagnostics = vim.diagnostic.get(bufnr)

        -- Narrow it down to the one under the cursor (or selection)
        local start_line = params.range.start.line
        local end_line = params.range['end'].line
        local filtered = {}

        for _, diag in ipairs(diagnostics) do
          if diag and diag.lnum >= start_line and diag.lnum <= end_line then
            diag['uri'] = uri
            table.insert(filtered, diag)
          end
        end

        return filtered
      end,
      ['custom/getTextLines'] = function(_, params, ctx, _)
        local uri = params.fileUri
        local start_line = params.range.startLine
        local end_line = params.range.endLine

        -- vim.notify(string.format('start_line: %d, end_line: %d', start_line, end_line))

        local bufnr = vim.uri_to_bufnr(uri)

        -- Ensure buffer is loaded
        if not vim.api.nvim_buf_is_loaded(bufnr) then
          vim.fn.bufload(bufnr)
        end

        -- Fetch the lines from startLine to endLine (exclusive)
        local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line, false)

        -- vim.notify(string.format('lines: %s', table.concat(lines, '\n')))

        return table.concat(lines, '\n')
      end,
    },
  },
}

local function get_visual_range()
  local mode = vim.fn.mode()
  if mode ~= 'v' and mode ~= 'V' and mode ~= '' then
    return nil
  end

  local start_pos = vim.fn.getpos 'v'
  local end_pos = vim.fn.getpos '.'

  local start_line = math.min(start_pos[2], end_pos[2]) - 1
  local start_char = math.min(start_pos[3], end_pos[3]) - 1
  local end_line = math.max(start_pos[2], end_pos[2]) - 1
  local end_char = math.max(start_pos[3], end_pos[3]) - 1

  return {
    start = { line = start_line, character = start_char },
    ['end'] = { line = end_line, character = end_char },
  }
end

local function llm_code_action()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr }

  local llm_client = vim.tbl_filter(function(client)
    return client.name == 'auto_completion_lsp_server'
  end, clients)[1]

  if not llm_client then
    vim.notify 'LLM server not found'
    return
  end

  local range = get_visual_range()
  local params = vim.lsp.util.make_range_params(0, 'utf-8')

  if range then
    params.range = range
  end

  vim.lsp.buf_request(bufnr, 'custom/llmCodeActions', params, function(err, result)
    if err then
      vim.notify('LLM Error: ' .. err.message)
      return
    end

    if result and #result > 0 then
      vim.ui.select(result, {
        prompt = 'LLM Code Actions',
        format_item = function(item)
          return item.title
        end,
      }, function(choice)
        if not choice then
          return
        end
        vim.lsp.util.apply_workspace_edit(choice.edit, llm_client.offset_encoding)
      end)
    else
      vim.notify 'No LLM actions available'
    end
  end, function()
    vim.notify 'LLM Error: no response'
  end)
end

vim.keymap.set({ 'n', 'v' }, '<leader>cl', llm_code_action, { desc = 'LLM Code Actions' })

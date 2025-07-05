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

  local params = vim.lsp.util.make_range_params(0, 'utf-8')

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
  end, function(err)
    vim.notify 'LLM Error: no response'
  end)
end

vim.keymap.set('n', '<leader>cl', llm_code_action, { desc = 'LLM Code Actions' })

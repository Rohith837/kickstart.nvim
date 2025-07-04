return { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground',
    },
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to text objects
          keymaps = {
            -- Define text objects based on the structure
            ['am'] = '@function.outer', -- Select the entire function (around function)
            ['im'] = '@function.inner', -- Select the inner part of the function
            ['af'] = '@call.outer', -- Select the entire function call
            ['if'] = '@call.inner', -- Select the inner part of the function arguments
            ['aa'] = '@parameter.outer', -- Select the entire argument
            ['ia'] = '@parameter.inner', -- Select the inner part of the argument
            ['ac'] = '@class.outer', -- Select the entire class (around class)
            ['ic'] = '@class.inner', -- Select the inner part of the class
            ['all'] = '@loop.outer', -- Select the entire loop (around loop)
            ['ill'] = '@loop.inner', -- Select the inner part of the loop
            ['ag'] = '@comment.outer', -- Select the entire comment (around comment)
            ['ig'] = '@comment.inner', -- Select the inner part of the comment // javascript and typescript won't support this
            ['a='] = '@assignment.outer', -- Select the entire comment (around comment)
            ['i='] = '@assingment.inner', -- Select the inner part of the comment
            ['ae'] = '@binaryexpression', -- Select the entire binary expression
            ['ie'] = '@binaryexpression', -- Select the inner part of the binary expression
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- Allows jumping back with `<C-o>`
          -- capital is for moving to the end and lowercase is for moving to the start
          -- ] is for outer and ) is for inner
          goto_next = {
            [']m'] = { query = { '@function.outer' }, desc = 'Next function' },
            [']a'] = { query = { '@parameter.outer', '@attribute.outer' }, desc = 'Next parameter' },
            [']i'] = { query = { '@conditional.*' }, desc = 'Next conditional' },
            [']l'] = { query = { '@loop.inner' }, desc = 'Next loop' },
            [']r'] = { query = { '@return.*' }, desc = 'Next return' },
            [']p'] = { query = { '@property.*' }, desc = 'Next property' },
            [']e'] = { query = { '@binaryexpression' }, desc = 'Next binary expression' },
          },
          goto_previous = {
            ['[m'] = { query = { '@function.outer' }, desc = 'Previous function' },
            ['[a'] = { query = { '@parameter.outer', '@attribute.outer' }, desc = 'Previous parameter' },
            ['[i'] = { query = { '@conditional.*' }, desc = 'Previous conditional' },
            ['[l'] = { query = { '@loop.inner' }, desc = 'Previous loop' },
            ['[r'] = { query = { '@return.*' }, desc = 'Previous return' },
            ['[p'] = { query = { '@property.*' }, desc = 'Previous property' },
            ['[e'] = { query = { '@binaryexpression' }, desc = 'Previous binary expression' },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>na'] = '@parameter.inner',
            ['<leader>nm'] = '@function.outer',
          },
          swap_previous = {
            ['<leader>pa'] = '@parameter.inner',
            ['<leader>pm'] = '@function.outer',
          },
        },
      },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  }

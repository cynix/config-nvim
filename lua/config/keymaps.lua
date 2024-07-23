local add = require('which-key').add
local api = vim.api
local del = vim.keymap.del

-- remove unwanted LazyVim keymaps
del({'n', 'i', 'v'}, '<A-j>')
del({'n', 'i', 'v'}, '<A-k>')

-- add blank line above/below
add({
  {'-', "<Cmd>put=''<CR>", desc='Empty line below'},
  {'+', "<Cmd>put!=''<CR>", desc='Empty line above'},
})

-- visual indent/unindent
add({
  {'<Tab>', '>gv', desc='Indent', mode='x'},
  {'<S-Tab>', '<gv', desc='Undent', mode='x'},
})

-- use regex search by default
add({
  {'/', '/\\v', desc='Search forward', mode={'n', 'x'}},
  {'?', '?\\v', desc='Search backward', mode={'n', 'x'}},
})

-- window
add({
  {'\\', '<C-w>', desc='Window commands'},
  {'\\w',
    function()
      local current = api.nvim_get_current_win()
      local windows = api.nvim_tabpage_list_wins(0)
      local n = 0

      for i, w in ipairs(windows) do
        if w == current then
          n = i
          break
        end
      end

      for i = 1, #windows do
        local w = windows[(n + i - 1) % #windows + 1]
        if w == current then
          break
        end
        if api.nvim_win_get_config(w).relative == '' then
          api.nvim_set_current_win(w)
          break
        end
      end
    end,
    desc='Cycle windows',
  },
})

-- folding
add({
  {'<Leader>=', 'za', desc='Toggle fold'},
})

-- navigation
add({
  {'<BS>', '<C-o>', desc='Go to previous jump position'},
})

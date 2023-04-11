local register = require('which-key').register
local api = vim.api

-- add blank line above/below
register({
  ['-'] = { "<Cmd>put=''<CR>", 'Empty line below' },
  ['+'] = { "<Cmd>put!=''<CR>", 'Empty line above' },
})

-- visual indent/unindent
register({
  ['<Tab>'] = { '>gv', 'Indent' },
  ['<S-Tab>'] = { '<gv', 'Undent' },
}, {
  mode = 'x',
})

-- use regex search by default
register({
  ['/'] = { '/\\v', 'Search forward' },
  ['?'] = { '?\\v', 'Search backward' },
}, {
  mode = {'n', 'x'},
})

-- window
register({
  ['\\'] = { '<C-w>', 'Window commands' },
  ['\\w'] = {
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
    'Cycle windows',
  }
})

-- folding
register({
  ['<Leader>='] = { 'za', 'Toggle fold' },
})

-- navigation
register({
  ['<BS>'] = { '<C-o>', 'Go to previous jump position' },
})

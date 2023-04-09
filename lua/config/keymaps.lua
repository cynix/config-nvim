local map = vim.keymap.set
local api = vim.api

-- add blank line above/below
map('n', '-', "<Cmd>put=''<CR>", {noremap=true})
map('n', '+', "<Cmd>put!=''<CR>", {noremap=true})

-- visual indent/unindent
map('x', '<Tab>', '>gv', {noremap=true})
map('x', '<S-Tab>', '<gv', {noremap=true})

-- use regex search by default
map({'n', 'x'}, '/', '/\\v', {noremap=true})
map({'n', 'x'}, '?', '?\\v', {noremap=true})

-- window
map('n', '\\', '<C-w>', {noremap=true})

map('n', '\\w', function()
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
end)

-- folding
map('n', '=', 'za', {noremap=true})

-- navigation
map('n', '<BS>', '<C-o>', {noremap=true})

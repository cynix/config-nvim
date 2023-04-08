local map = vim.keymap.set

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
map('n', '\\d', ':bd<CR>', {noremap=true})

-- folding
map('n', '=', 'za', {noremap=true})

-- navigation
map('n', '<BS>', '<C-o>', {noremap=true})

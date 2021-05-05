local map = vim.api.nvim_set_keymap

map('n', '<Leader>c', '<cmd>Conflict3ResolveAll | Conflict3Shrink!<CR>', {noremap=true})
map('n', '<Leader>x', '<cmd>Conflict3TakeThis<CR>', {noremap=true})

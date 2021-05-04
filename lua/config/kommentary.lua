local map = vim.api.nvim_set_keymap

map('n', '<leader>//', '<Plug>kommentary_line_default', {silent=true})
map('x', '//', '<Plug>kommentary_visual_default', {silent=true})

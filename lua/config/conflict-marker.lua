vim.api.nvim_exec([[
  nnoremap <Leader>x< <cmd>:ConflictMarkerOurselves<CR>
  nnoremap <Leader>x> <cmd>:ConflictMarkerThemselves<CR>
]], false)

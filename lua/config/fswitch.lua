vim.api.nvim_exec([[
  nnoremap <C-o> <cmd>FSHere<CR>

  augroup FSwitch
    autocmd!
    autocmd BufEnter *.cc let b:fswitchdst='h,hh,hpp'
    autocmd BufEnter *.h let b:fswitchdst='cc,cpp,c,mm,m'
  augroup END
]], false)

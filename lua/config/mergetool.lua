vim.api.nvim_exec([[
  let g:mergetool_layout = 'lmr'
  let g:mergetool_prefer_revision = 'base'

  nmap <expr> <C-Left> &diff ? '<Plug>(MergetoolDiffExchangeLeft)' : '<C-Left>'
  nmap <expr> <C-Right> &diff ? '<Plug>(MergetoolDiffExchangeRight)' : '<C-Right>'
  nmap <expr> <Up> &diff ? '[c' : '<Up>'
  nmap <expr> <Down> &diff ? ']c' : '<Down>'
]], false)

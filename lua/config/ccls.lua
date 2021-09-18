local g = vim.g
g.ccls_levels = 2
g.ccls_float_width = 80
g.ccls_float_height = 25
g.yggdrasil_no_default_maps = 1

-- TODO: use line continuation
vim.api.nvim_exec([[
  nmap <silent> <Leader>cb :CclsBaseHierarchy -float<CR>
  nmap <silent> <Leader>cc :CclsCallHierarchy -float<CR>
  nmap <silent> <Leader>cd :CclsDerivedHierarchy -float<CR>
  nmap <silent> <Leader>cf :CclsCalleeHierarchy -float<CR>
  nmap <silent> <Leader>cm :CclsMemberHierarchy -float<CR>

  augroup VimCcls
    autocmd!
    autocmd FileType yggdrasil nmap <silent><buffer> <Space> <Plug>(yggdrasil-toggle-node)
    autocmd FileType yggdrasil nmap <silent><buffer> <CR> <Plug>(yggdrasil-execute-node)
    autocmd FileType yggdrasil nmap <silent><buffer> q :q<CR>
  augroup END
]], false)

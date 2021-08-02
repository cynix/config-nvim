vim.api.nvim_exec([[
  set background=dark
  let g:gruvbox_plugin_hi_groups=1
  colorscheme gruvbox8
  highlight LspReferenceText guifg=#fbf1c7 guibg=#005f87
  highlight link LspReferenceRead LspReferenceText
  highlight link LspReferenceWrite LspReferenceText
]], false)

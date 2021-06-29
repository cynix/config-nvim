vim.api.nvim_exec([[
  set background=dark
  let g:gruvbox_italic=1
  let g:gruvbox_vert_split='bg2'
  colorscheme gruvbox
  highlight LspReferenceText guifg=#fbf1c7 guibg=#005f87
  highlight link LspReferenceRead LspReferenceText
  highlight link LspReferenceWrite LspReferenceText
]], false)

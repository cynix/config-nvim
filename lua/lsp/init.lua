local exec = vim.api.nvim_exec
local lsp_status = require('lsp-status').on_attach

local function on_attach(client, bufnr)
  exec([[
    nmap <silent><C-h> <cmd>lua vim.lsp.buf.hover()<CR>
    nmap <silent><C-i> <cmd>lua vim.lsp.buf.implementation()<CR>
    nmap <silent><C-j> <cmd>lua vim.lsp.buf.definition()<CR>
    nmap <silent><C-k> <cmd>lua vim.lsp.buf.references()<CR>
    nmap <silent><C-l> <cmd>lua vim.lsp.buf.code_action()<CR>
    nmap <silent><F2>  <cmd>lua vim.lsp.buf.rename()<CR>

    augroup LspHighlighting
      autocmd!
      autocmd CursorHold * lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved * lua vim.lsp.buf.clear_references()
    augroup END
  ]], false)

  lsp_status(client)
end

return {
  on_attach=on_attach,
}

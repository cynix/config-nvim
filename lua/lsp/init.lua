local exec = vim.api.nvim_exec
local map = vim.keymap.set
local lsp_status = require('lsp-status').on_attach

local function on_attach(client, bufnr)
  local buf = vim.lsp.buf
  local opts = {buffer=bufnr, noremap=true, silent=true}

  map('n', '<C-h>', buf.hover, opts)
  map('n', '<C-n>', buf.implementation, opts)
  map('n', '<C-j>', buf.definition, opts)
  map('n', '<C-k>', buf.references, opts)
  map('n', '<C-l>', buf.code_action, opts)
  map('n', '<F2>', buf.rename, opts)

  exec([[
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

local lsp_status = require('lsp-status')

lsp_status.config({
  kind_labels = require('lspkind').presets.default,
  status_symbol = '',
})

lsp_status.register_progress()

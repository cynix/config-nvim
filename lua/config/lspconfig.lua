local u = require('utils.text').u

local lspconfig = require('lspconfig')
local on_attach = require('lsp').on_attach

local cmp = require('cmp_nvim_lsp')
cmp.setup()

local caps = cmp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.clangd.setup({
  on_attach = on_attach,
  capabilities = caps,
})

lspconfig.gopls.setup({
  cmd = {'gopls', 'serve'},
  init_options = {
    completeUnimported = true,
    deepCompletion = true,
    usePlaceholders = true,
  },
  on_attach = on_attach,
  capabilities = caps,
})

lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = caps,
})

local signs = {
  LspDiagnosticsSignHint = u'f0eb',
  LspDiagnosticsSignInformation = u'f129',
  LspDiagnosticsSignWarning = u'f071',
  LspDiagnosticsSignError = u'f65b',
}

local def = vim.fn.sign_define

for sign, text in pairs(signs) do
  def(sign, {text=text, texthl=sign})
end

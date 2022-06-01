local path = require('utils.path')
local u = require('utils.text').u

local lspconfig = require('lspconfig')
local on_attach = require('lsp').on_attach

local cmp = require('cmp_nvim_lsp')
cmp.setup()

local caps = cmp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('clangd_extensions').setup({
  server = {
    cmd = {
      'clangd',
      '--background-index',
      '--completion-style=bundled',
      '--inlay-hints',
    },
    on_attach = on_attach,
    capabilities = caps,
  },
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
  before_init = function(_, config)
    local p
    if vim.env.VIRTUAL_ENV then
      p = path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
    else
      p = path.find_cmd('python', '.venv/bin', config.root_dir)
    end
    config.settings.python.pythonPath = p
  end,
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

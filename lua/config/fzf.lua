local M = {}

local fzf = require('fzf-lua')
local path = require('fzf-lua.path')

M.files = function()
  if path.is_git_repo(nil, true) then
    fzf.git_files()
  else
    fzf.files()
  end
end

fzf.setup({
  buffers = {
    actions = {
      ['ctrl-p'] = M.files,
    },
  },
  files = {
    actions = {
      ['ctrl-p'] = fzf.buffers,
    },
  },
  git = {
    files = {
      cmd = 'git ls-files --cached --others --exclude-standard',
      actions = {
        ['ctrl-p'] = fzf.buffers,
      },
    },
  },
})

vim.api.nvim_set_keymap('n', '<C-p>', [[<cmd>lua require('config.fzf').files()<CR>]], {noremap=true, silent=true})

fzf.register_ui_select()

local function select_one(fn)
  return function()
    return fn({fzf_opts={['--select-1']=''}})
  end
end

local handlers = vim.lsp.handlers
handlers['callHierarchy/incomingCalls'] = select_one(fzf.lsp_incoming_calls)
handlers['callHierarchy/outgoingCalls'] = select_one(fzf.lsp_outgoing_calls)
handlers['textDocument/codeAction'] = fzf.lsp_code_actions
handlers['textDocument/declaration'] = select_one(fzf.lsp_declarations)
handlers['textDocument/definition'] = select_one(fzf.lsp_definitions)
handlers['textDocument/documentSymbol'] = fzf.lsp_document_symbols
handlers['textDocument/implementation'] = select_one(fzf.lsp_implementations)
handlers['textDocument/references'] = select_one(fzf.lsp_references)
handlers['textDocument/typeDefinition'] = fzf.lsp_typedefs
handlers['workspace/symbol'] = fzf.lsp_workspace_symbols

return M

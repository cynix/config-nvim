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

local handlers = vim.lsp.handlers
handlers['textDocument/codeAction'] = fzf.lsp_code_actions
handlers['textDocument/definition'] = fzf.lsp_definitions
handlers['textDocument/implementation'] = fzf.lsp_implementations
handlers['textDocument/references'] = fzf.lsp_references

return M

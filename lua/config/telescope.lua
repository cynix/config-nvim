local builtin = require('telescope.builtin')
local buffers = builtin.buffers
local git_files = builtin.git_files
local git_status = builtin.git_status

local current = require('telescope.actions.state').get_current_picker
local close = require('telescope.actions')._close

local function telescope_picker(bufnr)
  local picker = (current(bufnr) or {}).prompt_title
  local opts = {}

  if picker ~= nil then
    close(bufnr, true)
  end

  if picker == 'Git Files' then
    picker = buffers
    opts.show_all_buffers = true
  elseif picker == 'Buffers' then
    picker = git_status
  else
    picker = git_files
  end

  picker(opts)
end
_G.telescope_picker = telescope_picker

require('telescope').setup({
  layout_strategy = 'flex',
  scroll_strategy = 'cycle',
  defaults = {
    mappings = {
      n = {
        ['<C-p>'] = telescope_picker,
      },
      i = {
        ['<C-p>'] = telescope_picker,
      },
    },
  },
})

vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>lua telescope_picker()<CR>', {noremap=true, silent=true})

local handlers = vim.lsp.handlers
handlers['textDocument/codeAction'] = builtin.lsp_code_actions
handlers['textDocument/definition'] = builtin.lsp_definitions
handlers['textDocument/implementation'] = builtin.lsp_implementations
handlers['textDocument/references'] = builtin.lsp_references

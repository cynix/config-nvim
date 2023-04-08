local M = {}

local autocmd = vim.api.nvim_create_autocmd

M.augroup = function(name, fn)
  local g = vim.api.nvim_create_augroup(name, {clear=true})
  fn(function(event, pattern, callback)
    autocmd(event, { group=g, pattern=pattern, callback=callback })
  end)
end

return M

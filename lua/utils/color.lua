local M = {}

local get_hl = vim.api.nvim_get_hl_by_name
local set_hl = vim.api.nvim_set_hl

M.hl = function(name, info)
  if info == nil then
    return get_hl(name, true)
  else
    return set_hl(0, name, info)
  end
end

M.hex = function(rgb)
  if type(rgb) == 'number' then
    return '#' .. string.format('%06x', rgb)
  else
    return rgb
  end
end

return M

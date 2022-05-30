local executable = vim.fn.executable
local path = require('lspconfig/util').path

local M = {}

M.join = path.join

M.find_cmd = function(cmd, prefixes, start)
  if type(prefixes) == 'string' then
    prefixes = {prefixes}
  end

  local found = nil
  for _, prefix in ipairs(prefixes) do
    local full_cmd = prefix and path.join(prefix, cmd) or cmd

    if start and path.is_dir(start) then
      local abs = path.join(start, full_cmd)
      if executable(abs) > 0 then
        found = abs
        break
      end
    end

    path.traverse_parents(start, function(dir)
      local abs = path.join(dir, full_cmd)
      if executable(abs) > 0 then
        found = abs
        return true
      end
    end)

    if found ~= nil then
      break
    end
  end

  return found or cmd
end

return M

local function hl_by_name(name)
  local hl = vim.api.nvim_get_hl_by_name(name, true)
  local sprintf = string.format
  if hl.foreground ~= nil then hl.fg = sprintf('#%x', hl.foreground) end
  if hl.background ~= nil then hl.bg = sprintf('#%x', hl.background) end
  if hl.special ~= nil then hl.sp = sprintf('#%x', hl.special) end
  return hl
end

local function hl(def)
  local cmd = 'highlight'
  if def.bang == true then cmd = cmd .. '!' end

  if #def == 2 and type(def[1]) == 'string' and type(def[2]) == 'string' then
    vim.cmd(cmd .. ' link ' .. def[1] .. ' ' .. def[2])
    return
  end

  local guifg = def.fg or def.guifg or def[2]
  local guibg = def.bg or def.guibg or def[3]
  local gui = def.gui or def[4]
  local guisp = def.guisp or def[5]

  if type(def.override) == 'string' then
    local existing = hl_by_name(def.override)

    if existing.fg ~= nil then guifg = existing.fg end
    if existing.bg ~= nil then guibg = existing.bg end
    if existing.sp ~= nil then guisp = existing.sp end

    if existing.undercurl == true then
        gui = 'undercurl'
    elseif existing.underline == true then
      gui = 'underline'
    end
  end

  cmd = cmd .. ' ' .. def[1]
  if guifg ~= nil then cmd = cmd .. ' guifg=' .. guifg end
  if guibg ~= nil then cmd = cmd .. ' guibg=' .. guibg end
  if gui ~= nil then cmd = cmd .. ' gui=' .. gui end
  if guisp ~= nil then cmd = cmd .. ' guisp=' .. guisp end

  vim.cmd(cmd)
end

return {
  hl_by_name=hl_by_name,
  hl=hl,
}
